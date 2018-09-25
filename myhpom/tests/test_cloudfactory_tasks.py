import os
import json
import requests
import requests_mock
from glob import glob
from django.test import TestCase, override_settings
from django.conf import settings
from django.core.files.uploadedfile import SimpleUploadedFile
from django.utils.timezone import now
from django.utils.dateparse import parse_datetime
from myhpom.tests.factories import UserFactory
from myhpom.models import AdvanceDirective, DocumentUrl, CloudFactoryDocumentRun
from myhpom.tasks import CloudFactorySubmitDocumentRun
import myhpom

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
        self.document_url = DocumentUrl.objects.create(
            advancedirective=AdvanceDirective.objects.create(
                user=UserFactory(),
                share_with_ehs=False,
                document=SimpleUploadedFile(
                    os.path.basename(PDF_FILENAME), open(PDF_FILENAME, 'rb').read()
                ),
                valid_date=now(),
            )
        )
        self.task = CloudFactorySubmitDocumentRun

    def test_201_created(self, reqmock):
        response_data = json.load(
            open(os.path.join(FIXTURE_PATH, 'cloudfactory', 'post_response_201.json'), 'rb')
        )
        reqmock.post(settings.CLOUDFACTORY_API_URL + '/runs', **response_data)
        run_id = self.task(self.document_url.id)
        self.assertTrue(reqmock.called)
        self.assertEqual(type(run_id), int)  # self.task() returns the id of the run object
        cf_run = self.document_url.cloudfactorydocumentrun_set.last()
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
            self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_NEW)
            self.assertIn("Invalid request.", cf_run.response_content)
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
        self.assertEqual(cf_run.response_content, response_data['text'])

    def test_deleted_document_url(self, reqmock):
        du_id = self.document_url.id
        self.document_url.delete()
        run_id = CloudFactorySubmitDocumentRun(du_id)
        cf_run = CloudFactoryDocumentRun.objects.get(id=run_id)
        self.assertEqual(cf_run.status, CloudFactoryDocumentRun.STATUS_DELETED)
        self.assertFalse(reqmock.called)
