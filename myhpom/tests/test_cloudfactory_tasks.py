import os
import json
import requests
import requests_mock
from django.test import TestCase, override_settings
from django.conf import settings
from django.utils.dateparse import parse_datetime
from myhpom.tests.factories import AdvanceDirectiveFactory
from myhpom.models import DocumentUrl, CloudFactoryDocumentRun
from myhpom.tasks import (
    CloudFactorySubmitDocumentRun,
    CloudFactoryAbortDocumentRun,
    CloudFactoryUpdateDocumentRun,
)

FIXTURE_PATH = os.path.join(os.path.dirname(__file__), 'fixtures')
PDF_FILENAME = os.path.join(FIXTURE_PATH, 'afile.pdf')


@requests_mock.Mocker()
@override_settings(CLOUDFACTORY_API_URL='https://TEST.NIL')
class CloudFactorySubmitDocumentRunTestCase(TestCase):
    """In the task:
    * submitting a run with valid data to CloudFactory returns 201 and run object with expected vals
    * various situations that raise exceptions in the task:
        * the AdvanceDirective id that was submitted to celery no longer exists
            (deleted by user while task in queue).
        * submitting a run with invalid data returns 422 (Unprocessable Entity)
    * raising an exception in a task causes error mail to be created
    """

    def setUp(self):
        self.document_url = DocumentUrl.objects.create(advancedirective=AdvanceDirectiveFactory())
        self.task = CloudFactorySubmitDocumentRun

    def test_201_created(self, reqmock):
        response_data = json.load(
            open(os.path.join(FIXTURE_PATH, 'cloudfactory', 'post_response_201.json'), 'rb')
        )
        reqmock.post(settings.CLOUDFACTORY_API_URL + '/runs', **response_data)
        id = self.task(self.document_url.id)
        cf_run = CloudFactoryDocumentRun.objects.get(id=id)
        self.assertTrue(reqmock.called)
        self.assertIsNotNone(cf_run)
        self.assertEqual(cf_run.status, response_data['json']['status'])
        self.assertEqual(cf_run.run_id, response_data['json']['id'])
        self.assertEqual(cf_run.created_at, parse_datetime(response_data['json']['created_at']))

    def test_422_unprocessable(self, reqmock):
        response_data_set = json.load(
            open(os.path.join(FIXTURE_PATH, 'cloudfactory', 'post_responses_422.json'), 'rb')
        )
        for response_data in response_data_set.values():
            reqmock.post(settings.CLOUDFACTORY_API_URL + '/runs', **response_data)
            self.assertRaises(ValueError, self.task, self.document_url.id)
            cf_run = self.document_url.cloudfactorydocumentrun_set.last()
            self.assertIsNotNone(cf_run)
            self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_UNPROCESSABLE)
            self.assertIsNone(cf_run.run_id)
            self.assertIsNone(cf_run.created_at)

    def test_404_notfound(self, reqmock):
        response_data = json.load(
            open(os.path.join(FIXTURE_PATH, 'cloudfactory', 'post_response_404.json'), 'rb')
        )
        reqmock.post(settings.CLOUDFACTORY_API_URL + '/runs', **response_data)
        self.assertRaises(ValueError, self.task, self.document_url.id)
        cf_run = self.document_url.cloudfactorydocumentrun_set.last()
        self.assertIsNotNone(cf_run)
        self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_NOTFOUND)

    def test_non_json_response(self, reqmock):
        response_data = json.load(
            open(os.path.join(FIXTURE_PATH, 'cloudfactory', 'post_invalid_response_201.json'), 'rb')
        )
        reqmock.post(settings.CLOUDFACTORY_API_URL + '/runs', **response_data)
        self.assertRaises(ValueError, self.task, self.document_url.id)
        cf_run = self.document_url.cloudfactorydocumentrun_set.last()
        self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_ERROR)

    def test_connection_timeout(self, reqmock):
        reqmock.post(
            settings.CLOUDFACTORY_API_URL + '/runs', exc=requests.exceptions.ConnectTimeout
        )
        self.assertRaises(requests.exceptions.ConnectTimeout, self.task, self.document_url.id)
        cf_run = self.document_url.cloudfactorydocumentrun_set.last()
        self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_REQ_ERROR)

    def test_deleted_document_url_before_run_created(self, reqmock):
        du_id = self.document_url.id
        self.document_url.delete()
        run_id = CloudFactorySubmitDocumentRun(du_id)
        cf_run = CloudFactoryDocumentRun.objects.get(id=run_id)
        self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_DELETED)
        self.assertFalse(reqmock.called)

    def test_deleted_document_url_after_run_created(self, reqmock):
        """
        * A run associated with a DocumentUrl is auto-aborted after the DocumentURL is deleted.
        """
        response_data = json.load(
            open(os.path.join(FIXTURE_PATH, 'cloudfactory', 'post_response_201.json'), 'rb')
        )
        reqmock.post(settings.CLOUDFACTORY_API_URL + '/runs', **response_data)
        id = self.task(self.document_url.id)
        cf_run = CloudFactoryDocumentRun.objects.get(id=id)
        reqmock.post(
            settings.CLOUDFACTORY_API_URL + '/runs/' + cf_run.run_id + '/abort',
            status_code=202,
            json={},
        )
        cf_runs = self.document_url.cloudfactorydocumentrun_set.all()
        self.document_url.delete()
        for cf_run in cf_runs:
            self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_ABORTED)


@override_settings(CLOUDFACTORY_API_URL='https://TEST.NIL')
class CloudFactoryUpdateDocumentRunTestCase(TestCase):
    """
    * if run.status in [STATUS_PROCESSING, STATUS_REQ_ERROR, STATUS_ABORTED], check w/CF and update.
        * if 200 => update run from response.content
        * if 404 => run.status = STATUS.NOTFOUND, update response.content
        * if otherwise => raise ValueError
    * otherwise, nothing is done.
    """

    def setUp(self):
        self.task = CloudFactoryUpdateDocumentRun

    def test_200_successful(self):
        for status in [
            CloudFactoryDocumentRun.STATUS_PROCESSING,
            CloudFactoryDocumentRun.STATUS_REQ_ERROR,
            CloudFactoryDocumentRun.STATUS_ABORTED,
        ]:
            cf_run = CloudFactoryDocumentRun.objects.create(status=status, run_id="SOME_RUN")
            with requests_mock.Mocker() as reqmock:
                reqmock.get(
                    settings.CLOUDFACTORY_API_URL + '/runs/' + cf_run.run_id,
                    status_code=200,
                    text='{"status": "Processing"}',
                )
                self.task(cf_run.id)
                self.assertTrue(reqmock.called)
            cf_run.refresh_from_db()
            self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_PROCESSING)
            cf_run.delete()

    def test_200_invalid(self):
        for status in [
            CloudFactoryDocumentRun.STATUS_PROCESSING,
            CloudFactoryDocumentRun.STATUS_REQ_ERROR,
            CloudFactoryDocumentRun.STATUS_ABORTED,
        ]:
            cf_run = CloudFactoryDocumentRun.objects.create(status=status, run_id="SOME_RUN")
            with requests_mock.Mocker() as reqmock:
                reqmock.get(
                    settings.CLOUDFACTORY_API_URL + '/runs/' + cf_run.run_id,
                    status_code=200,
                    text='This is some invalid, non-json-parsable response content.',
                )
                self.assertRaises(ValueError, self.task, cf_run.id)
                self.assertTrue(reqmock.called)
            cf_run.refresh_from_db()
            self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_ERROR)
            cf_run.delete()

    def test_404_notfound(self):
        for status in [
            CloudFactoryDocumentRun.STATUS_PROCESSING,
            CloudFactoryDocumentRun.STATUS_REQ_ERROR,
            CloudFactoryDocumentRun.STATUS_ABORTED,
        ]:
            cf_run = CloudFactoryDocumentRun.objects.create(status=status, run_id="SOME_RUN")
            with requests_mock.Mocker() as reqmock:
                reqmock.get(
                    settings.CLOUDFACTORY_API_URL + '/runs/' + cf_run.run_id,
                    status_code=404,
                    text='{}',
                )
                self.task(cf_run.id)
                self.assertTrue(reqmock.called)
            cf_run.refresh_from_db()
            self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_NOTFOUND)
            cf_run.delete()

    def test_other_response_status_code(self):
        initial_status = CloudFactoryDocumentRun.STATUS_PROCESSING
        for status_code in [201, 202, 302, 400, 422, 500]:  # some common response statuses
            cf_run = CloudFactoryDocumentRun.objects.create(
                status=initial_status, run_id="SOME_RUN"
            )
            with requests_mock.Mocker() as reqmock:
                reqmock.get(
                    settings.CLOUDFACTORY_API_URL + '/runs/' + cf_run.run_id,
                    status_code=status_code,
                    text='{}',
                )
                with self.assertRaises(ValueError):
                    self.task(cf_run.id)
                self.assertTrue(reqmock.called)
            cf_run.refresh_from_db()
            self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_ERROR)
            cf_run.delete()

    def test_no_change(self):
        status_choices = [
            status
            for status in [status[0] for status in CloudFactoryDocumentRun.STATUS_CHOICES]
            if status
            not in [
                CloudFactoryDocumentRun.STATUS_PROCESSING,
                CloudFactoryDocumentRun.STATUS_REQ_ERROR,
                CloudFactoryDocumentRun.STATUS_ABORTED,
            ]
        ]
        for initial_status in status_choices:
            cf_run = CloudFactoryDocumentRun.objects.create(
                status=initial_status, run_id="SOME_RUN"
            )
            with requests_mock.Mocker() as reqmock:
                reqmock.get(
                    settings.CLOUDFACTORY_API_URL + '/runs/' + cf_run.run_id,
                    status_code=200,  # doesn't matter, not called
                    text='{}',
                )
                self.task(cf_run.id)
                self.assertFalse(reqmock.called)
            cf_run.refresh_from_db()
            self.assertEqual(cf_run.status, initial_status)
            cf_run.delete()


@override_settings(CLOUDFACTORY_API_URL='https://TEST.NIL')
class CloudFactoryAbortDocumentRunTestCase(TestCase):
    """
    * if run.status in [STATUS_PROCESSING, STATUS_REQ_ERROR], abort the process.
        * 202 => STATUS_ABORTED
        * 404 => STATUS_NOTFOUND
        * 405 => STATUS_PROCESSED
        * otherwise => ValueError
    * otherwise, nothing is done.
    """

    def setUp(self):
        self.task = CloudFactoryAbortDocumentRun

    def test_202_successful(self):
        for status in [
            CloudFactoryDocumentRun.STATUS_PROCESSING,
            CloudFactoryDocumentRun.STATUS_REQ_ERROR,
        ]:
            cf_run = CloudFactoryDocumentRun.objects.create(status=status, run_id="SOME_RUN")
            with requests_mock.Mocker() as reqmock:
                reqmock.post(
                    settings.CLOUDFACTORY_API_URL + '/runs/' + cf_run.run_id + '/abort',
                    status_code=202,
                    text='{}',
                )
                self.task(cf_run.id)
                self.assertTrue(reqmock.called)
            cf_run.refresh_from_db()
            self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_ABORTED)
            cf_run.delete()

    def test_404_notfound(self):
        for status in [
            CloudFactoryDocumentRun.STATUS_PROCESSING,
            CloudFactoryDocumentRun.STATUS_REQ_ERROR,
        ]:
            cf_run = CloudFactoryDocumentRun.objects.create(status=status, run_id="SOME_RUN")
            with requests_mock.Mocker() as reqmock:
                reqmock.post(
                    settings.CLOUDFACTORY_API_URL + '/runs/' + cf_run.run_id + '/abort',
                    status_code=404,
                    text='{}',
                )
                self.task(cf_run.id)
                self.assertTrue(reqmock.called)
            cf_run.refresh_from_db()
            self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_NOTFOUND)
            cf_run.delete()

    def test_405_completed(self):
        for status in [
            CloudFactoryDocumentRun.STATUS_PROCESSING,
            CloudFactoryDocumentRun.STATUS_REQ_ERROR,
        ]:
            cf_run = CloudFactoryDocumentRun.objects.create(status=status, run_id="SOME_RUN")
            with requests_mock.Mocker() as reqmock:
                reqmock.post(
                    settings.CLOUDFACTORY_API_URL + '/runs/' + cf_run.run_id + '/abort',
                    status_code=405,
                    text='{}',
                )
                self.task(cf_run.id)
                self.assertTrue(reqmock.called)
            cf_run.refresh_from_db()
            self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_PROCESSED)
            cf_run.delete()

    def test_other_response_status_code(self):
        initial_status = CloudFactoryDocumentRun.STATUS_PROCESSING
        for status_code in [200, 201, 302, 400, 422, 500]:  # some common response statuses
            cf_run = CloudFactoryDocumentRun.objects.create(
                status=initial_status, run_id="SOME_RUN"
            )
            with requests_mock.Mocker() as reqmock:
                reqmock.post(
                    settings.CLOUDFACTORY_API_URL + '/runs/' + cf_run.run_id + '/abort',
                    status_code=status_code,
                    text='{}',
                )
                self.assertRaises(ValueError, self.task, cf_run.id)
                self.assertTrue(reqmock.called)
            cf_run.refresh_from_db()
            self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_ERROR)
            cf_run.delete()

    def test_no_change(self):
        status_choices = [
            status
            for status in [status[0] for status in CloudFactoryDocumentRun.STATUS_CHOICES]
            if status
            not in [
                CloudFactoryDocumentRun.STATUS_PROCESSING,
                CloudFactoryDocumentRun.STATUS_REQ_ERROR,
            ]
        ]
        for initial_status in status_choices:
            cf_run = CloudFactoryDocumentRun.objects.create(
                status=initial_status, run_id="SOME_RUN"
            )
            with requests_mock.Mocker() as reqmock:
                reqmock.post(
                    settings.CLOUDFACTORY_API_URL + '/runs/' + cf_run.run_id + '/abort',
                    status_code=202,  # doesn't matter
                    text='{}',
                )
                self.task(cf_run.id)
                self.assertFalse(reqmock.called)
            cf_run.refresh_from_db()
            self.assertEqual(cf_run.status, initial_status)
            cf_run.delete()
