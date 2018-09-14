import os
from datetime import timedelta
from django.test import TestCase
from django.core.files.uploadedfile import SimpleUploadedFile
from django.utils.timezone import now
from django.core.urlresolvers import reverse
from django.conf import settings
from myhpom.tests.factories import UserFactory
from myhpom.models import AdvanceDirective, DocumentUrl


class DocumentUrlViewTestCase(TestCase):
    def setUp(self):
        """create an AdvanceDirective that is available to all tests.
        """
        user = UserFactory()
        pdf_filename = os.path.join(os.path.dirname(__file__), 'fixtures', 'afile.pdf')
        with open(pdf_filename, 'rb') as f:
            document = SimpleUploadedFile(os.path.basename(pdf_filename), f.read())
        self.advancedirective = AdvanceDirective.objects.create(
            user=user, share_with_ehs=False, document=document, valid_date=now()
        )

    def test_get_document_url_succeeds(self):
        """
        * accessing a DocumentUrl with future expiration returns 200 & the document
        * accessing a DocumentUrl with no expiration returns 200 & the document
        """
        # no expiration
        advancedirective = self.advancedirective
        document_content = advancedirective.document.file.read()
        doc_url = DocumentUrl.objects.create(advancedirective=advancedirective)

        # future expiration
        current_timestamp = now()
        self.assertGreater(doc_url.expiration, current_timestamp)
        response = self.client.get(doc_url.url)
        self.assertEqual(200, response.status_code)

        # -- response content should match document_content
        response_content = b''.join(response.streaming_content)
        self.assertEqual(document_content, response_content)

        # null expiration
        doc_url.expiration = None
        doc_url.save()
        doc_url = DocumentUrl.objects.get(id=doc_url.id)
        self.assertIsNone(doc_url.expiration)
        response = self.client.get(doc_url.url)
        self.assertEqual(200, response.status_code)

        # response content should match document_content
        response_content = b''.join(response.streaming_content)
        self.assertEqual(document_content, response_content)

    def test_document_url_404(self):
        """
        * accessing a DocumentUrl with past expiration returns 404
        * accessing a non-existent DocumentURL returns 404
        """
        doc_url = DocumentUrl.objects.create(advancedirective=self.advancedirective)
        # wrong key
        wrong_key = 'W' * len(doc_url.key)  # right length, totally wrong value
        response = self.client.get(
            reverse('myhpom:document_url', kwargs={'key': wrong_key})
        )
        self.assertEqual(404, response.status_code)

        # past expiration
        doc_url.expiration = now() - timedelta(seconds=1)
        doc_url.save()
        response = self.client.get(doc_url.url)
        self.assertEqual(404, response.status_code)

    def test_document_url_not_authorized_ip(self):
        """
        * accessing a DocumentURL not from authorized_client_ip returns 404
        """
        doc_url = DocumentUrl.objects.create(advancedirective=self.advancedirective)
        
        # save the settings before changing them
        save_settings = settings.DOCUMENT_URL_IP_RANGES

        settings.DOCUMENT_URL_IP_RANGES = ["255.255.255.255"]  # pretty much no one, anywhere
        response = self.client.get(doc_url.url)
        self.assertLess(now(), doc_url.expiration)
        self.assertEqual(404, response.status_code)

        # restore settings
        settings.DOCUMENT_URL_IP_RANGES = save_settings

