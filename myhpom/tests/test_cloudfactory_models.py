import json
import os

from django.core.files.uploadedfile import SimpleUploadedFile
from django.test import TestCase
from django.test import override_settings
from django.utils.dateparse import parse_datetime
from django.utils.timezone import now

from myhpom.models import (AdvanceDirective, CloudFactoryDocumentRun, DocumentUrl)
from myhpom.tests.factories import UserFactory

PDF_FILENAME = os.path.join(os.path.dirname(__file__), 'fixtures', 'afile.pdf')

SUCCESS_DATA = open(os.path.join(
    os.path.dirname(__file__), 'fixtures/cloudfactory/callback_success.json')).read()


class DocumentRunModelTestCase(TestCase):
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
        self.run = CloudFactoryDocumentRun.objects.create(
            document_host='testserver',
            document_url=self.document_url)

    def test_create_default_run(self):
        """
        * run can be created with no arguments:
            * .run_id is null.
            * .create_post_data() raises AttributeError because it requires document_url
        """
        self.run.document_url = None
        self.run.save()

        self.assertIsNone(self.run.run_id)
        self.assertIsNone(self.run.document_url)
        with self.assertRaises(AttributeError):
            self.run.create_post_data()

    @override_settings(CLOUDFACTORY_CALLBACK_AUTH='user:pass')
    def test_callback_basic_auth(self):
        self.assertTrue('user:pass@testserver' in self.run.create_post_data()['callback_url'])

    def test_create_run_with_document_url(self):
        """
        * run created with .document_url returns post_data with expected keys
        """
        self.assertEqual(self.run.document_url.id, self.document_url.id)
        post_data = self.run.create_post_data()
        for key in ['line_id', 'callback_url', 'units']:
            self.assertIn(key, post_data)
        for key in ['full_name', 'state', 'pdf_url', 'date_signed']:
            self.assertIn(key, post_data['units'][0])

    def test_save_response_data_created(self):
        """
        * the .save_response_data(content) method:
            * puts the value of content in the run .response_content attribute, no matter what.
            * throws a ValueError if the response_content is not json-parsable
            * puts any 'status', 'created_at', or 'processed_at' keys into those fields
        """
        # this represents a typical "201 Created" response
        response_content = (
            r'{"id":"SOME_RUN_ID","line_id":"SOME_LINE_ID","status":"Processing",' +
            r'"created_at":"2018-09-24T22:27:53.000Z"}'
        )
        self.run.save_response_data(response_content)
        self.assertEqual(self.run.run_id, "SOME_RUN_ID")
        self.assertEqual(self.run.status, CloudFactoryDocumentRun.STATUS_PROCESSING)
        self.assertEqual(self.run.created_at, parse_datetime('2018-09-24T22:27:53.000Z'))

    def test_save_response_data_unprocessable(self):
        # this represents a "422 Unprocessable Entity" response
        response_content = r'{"message":"Invalid request. \"state\" is missing in the request."}'
        self.run.save_response_data(response_content)
        self.assertIsNone(self.run.run_id)
        self.assertEqual(self.run.status, CloudFactoryDocumentRun.STATUS_NEW)
        self.assertIsNone(self.run.created_at)
        self.assertEqual(self.run.response_content, response_content)

    def test_save_response_data_not_json(self):
        # this represents a response in which the content is not json-parsable
        response_content = 'This content is not json, so not parsable'
        self.assertRaises(ValueError, self.run.save_response_data, response_content)
        self.assertEqual(self.run.status, CloudFactoryDocumentRun.STATUS_ERROR)
        self.assertEqual(self.run.response_content, response_content)

    def test_save_response_data_from_callback(self):
        # When a callback has occurred, the fields of the run will be updated to
        # reflect the results.
        self.run.save_response_data(SUCCESS_DATA)
        self.assertEqual(self.run.response_content, SUCCESS_DATA)
        self.assertEqual(self.run.status, CloudFactoryDocumentRun.STATUS_PROCESSED)
        self.assertEqual(self.run.run_id, 'SUCCESS_ID')
        self.assertEqual(self.run.created_at, parse_datetime('2015-09-03T09:18:38Z'))
        self.assertEqual(self.run.processed_at, parse_datetime('2015-09-03T09:39:21Z'))

        # When the json doesn't contain familiar dates, an error is thrown
        bad_data = json.loads(SUCCESS_DATA)
        bad_data['created_at'] = 'bad-date'
        self.assertRaises(ValueError, self.run.save_response_data, json.dumps(bad_data))
        self.assertEqual(self.run.response_content, json.dumps(bad_data))
        self.assertEqual(self.run.status, CloudFactoryDocumentRun.STATUS_ERROR)

        # When the json output doesn't have all the verification keys, that is
        # an error
        bad_data = json.loads(SUCCESS_DATA)
        bad_data['units'][0]['output'] = {}
        self.assertRaises(ValueError, self.run.save_response_data, json.dumps(bad_data))
        self.assertEqual(self.run.response_content, json.dumps(bad_data))
        self.assertEqual(self.run.status, CloudFactoryDocumentRun.STATUS_ERROR)

        # When the json units don't have any outputs, that is an error
        bad_data = json.loads(SUCCESS_DATA)
        bad_data['units'] = []
        self.assertRaises(ValueError, self.run.save_response_data, json.dumps(bad_data))
        self.assertEqual(self.run.response_content, json.dumps(bad_data))
        self.assertEqual(self.run.status, CloudFactoryDocumentRun.STATUS_ERROR)

        # When the json has no units, that is an error
        bad_data = json.loads(SUCCESS_DATA)
        del bad_data['units']
        self.assertRaises(ValueError, self.run.save_response_data, json.dumps(bad_data))
        self.assertEqual(self.run.response_content, json.dumps(bad_data))
        self.assertEqual(self.run.status, CloudFactoryDocumentRun.STATUS_ERROR)
