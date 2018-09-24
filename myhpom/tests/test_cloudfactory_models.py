import os
from django.test import TestCase
from django.conf import settings
from django.core.files.uploadedfile import SimpleUploadedFile
from django.utils.timezone import now
from django.utils.dateparse import parse_datetime
from myhpom.models import CloudFactoryDocumentRun, AdvanceDirective, DocumentUrl
from myhpom.tests.factories import UserFactory
from myhpom.models import cloudfactory

PDF_FILENAME = os.path.join(os.path.dirname(__file__), 'fixtures', 'afile.pdf')


class CloudFactoryDocumentRunModelTestCase(TestCase):
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

    def test_create_default_run(self):
        """
        * run can be created with no arguments: 
            * .run_id is null.
            * .create_post_data() raises AttributeError because it requires document_url
        """
        run = CloudFactoryDocumentRun.objects.create()
        self.assertIsNone(run.run_id)
        self.assertIsNone(run.document_url)
        with self.assertRaises(AttributeError):
            run.create_post_data()

    def test_create_run_with_document_url(self):
        """
        * run created with .document_url returns post_data with expected keys
        """
        run = CloudFactoryDocumentRun.objects.create(document_url=self.document_url)
        self.assertEqual(run.document_url.id, self.document_url.id)
        post_data = run.create_post_data()
        for key in ['line_id', 'callback_url', 'units']:
            self.assertIn(key, post_data)
        for key in ['full_name', 'state', 'pdf_url', 'date_signed']:
            self.assertIn(key, post_data['units'][0])

    def test_run_save_response_content_created(self):
        """
        * the .save_response_content(content) method:
            * puts the value of content in the run .response_content attribute, no matter what.
            * throws a ValueError if the response_content is not json-parsable 
            * puts any 'status', 'created_at', or 'processed_at' keys into those fields       
        """
        run = CloudFactoryDocumentRun.objects.create(document_url=self.document_url)

        # this represents a typical "201 Created" response
        response_content = r'{"id":"SOME_RUN_ID","line_id":"SOME_LINE_ID","status":"Processing","created_at":"2018-09-24T22:27:53.000Z"}'
        run.save_response_content(response_content)
        self.assertEqual(run.run_id, "SOME_RUN_ID")
        self.assertEqual(run.status, "Processing")
        self.assertEqual(run.created_at, parse_datetime("2018-09-24T22:27:53.000Z"))

    def test_run_save_response_content_unprocessable(self):
        run = CloudFactoryDocumentRun.objects.create(document_url=self.document_url)

        # this represents a "422 Unprocessable Entity" response
        response_content = r'{"message":"Invalid request. \"state\" is missing in the request."}'
        run.save_response_content(response_content)
        self.assertIsNone(run.run_id)
        self.assertEqual(run.status, cloudfactory.STATUS_NEW)
        self.assertIsNone(run.created_at)
        self.assertEqual(run.response_content, response_content)
