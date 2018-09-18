import os
import iptools
from django.test import TestCase, override_settings
from django.core.files.uploadedfile import SimpleUploadedFile
from django.utils.timezone import now
from django.conf import settings
from django.db import IntegrityError
from myhpom.tests.factories import UserFactory
from myhpom.models import DocumentUrl, AdvanceDirective


class DocumentUrlModelTestCase(TestCase):
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

    def test_document_url_create(self):
        """
        Using the DocumentUrl.objects.create() results in correct default values.
        * new DocumentUrls are created with unique key and default expiration now + 48 hrs
        """
        ad = self.advancedirective
        doc_url = DocumentUrl.objects.create(advancedirective=ad)
        current_timestamp = now()  # created after doc_url.expiration

        self.assertIsNotNone(doc_url.key)
        self.assertGreater(doc_url.expiration, current_timestamp)
        self.assertLessEqual(
            doc_url.expiration, current_timestamp + settings.DOCUMENT_URL_EXPIRES_IN
        )

    def test_document_url_save(self):
        """Using DocumentUrl(...).save() results in correct default values.
        * new DocumentUrls are created with unique key and default expiration now + 48 hrs
        """
        ad = self.advancedirective
        doc_url = DocumentUrl(advancedirective=ad)
        doc_url.save()
        current_timestamp = now()  # created after doc_url.expiration

        self.assertIsNotNone(doc_url.key)
        self.assertGreater(doc_url.expiration, current_timestamp)
        self.assertLessEqual(
            doc_url.expiration, current_timestamp + settings.DOCUMENT_URL_EXPIRES_IN
        )

    @override_settings(
        DOCUMENT_URL_IP_RANGES=[
            iptools.IpRange(ip) for ip in ['127.0.0.1', '192.168.1.1/24', '70.62.97.168/29']
        ]
    )
    def test_document_url_authorized_client_ip(self):
        """
        * DocumentUrl.authorized_client_ip(ip_address) returns True if
            ip_address is "in" the allowed ip ranges (in settings)
        """
        ad = self.advancedirective
        doc_url = DocumentUrl(advancedirective=ad)
        authorized_ips = [
            "127.0.0.1",  # local host
            "192.168.1.100",  # local subnet
            "70.62.97.168",  # caktus office
        ]
        unauthorized_ips = ["93.184.217.34"]  # somewhere else

        for ip in authorized_ips:
            self.assertTrue(doc_url.authorized_client_ip(ip))
        for ip in unauthorized_ips:
            self.assertFalse(doc_url.authorized_client_ip(ip))

    def test_document_url_required_and_optional_fields(self):
        """
        * Nullable attributes: ip, expiration
        * Required attributes: advancedirective, key
        * When a DocumentUrl is changed, the key is unchanged, 
            and expiration is changed only if explicitly.
        """
        ad = self.advancedirective
        doc_url = DocumentUrl.objects.create(advancedirective=ad)
        key = doc_url.key
        expiration = doc_url.expiration
        # -- expiration: nullable
        doc_url.expiration = None
        doc_url.save()
        self.assertIsNone(doc_url.expiration)
        self.assertEqual(key, doc_url.key)
        # -- advancedirective: required
        with self.assertRaises(ValueError):
            doc_url.advancedirective = None
        # -- key: required
        doc_url.key = None
        self.assertRaises(IntegrityError, doc_url.save)
