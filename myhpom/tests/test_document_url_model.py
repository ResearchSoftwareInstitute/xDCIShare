import os
from django.test import TestCase
from django.core.files.uploadedfile import SimpleUploadedFile
from django.utils.timezone import now
from django.conf import settings
from django.db import IntegrityError
from myhpom.tests.factories import UserFactory
from myhpom.models import DocumentUrl, AdvanceDirective

PDF_FILENAME = os.path.join(os.path.dirname(__file__), 'fixtures', 'afile.pdf')


class DocumentUrlModelTestCase(TestCase):
    @classmethod
    def setUpClass(Class):
        """create an AdvanceDirective that is available to all tests.
        """
        user = UserFactory()
        with open(PDF_FILENAME, 'rb') as f:
            document = SimpleUploadedFile(os.path.basename(PDF_FILENAME), f.read())
        Class.advancedirective = AdvanceDirective(
            user=user, share_with_ehs=False, document=document, valid_date=now()
        )
        Class.advancedirective.save()

    @classmethod
    def tearDownClass(Class):
        Class.advancedirective.delete()

    def test_document_url_create(self):
        """
        Using the DocumentUrl.objects.create() results in correct default values.
        * new DocumentUrls are created with unique key and default expiration now + 48 hrs
        """
        ad = self.__class__.advancedirective
        doc_url = DocumentUrl.objects.create(advancedirective=ad)
        current_timestamp = now()  # created after doc_url.expiration

        self.assertIsNotNone(doc_url.key)
        self.assertIsNone(doc_url.ip)
        self.assertGreater(doc_url.expiration, current_timestamp)
        self.assertLessEqual(
            doc_url.expiration, current_timestamp + settings.DOCUMENT_URLS_EXPIRE_IN
        )

    def test_document_url_save(self):
        """Using DocumentUrl(...).save() results in correct default values.
        * new DocumentUrls are created with unique key and default expiration now + 48 hrs
        """
        ad = self.__class__.advancedirective
        doc_url = DocumentUrl(advancedirective=ad)
        doc_url.save()
        current_timestamp = now()  # created after doc_url.expiration

        self.assertIsNotNone(doc_url.key)
        self.assertIsNone(doc_url.ip)
        self.assertGreater(doc_url.expiration, current_timestamp)
        self.assertLessEqual(
            doc_url.expiration, current_timestamp + settings.DOCUMENT_URLS_EXPIRE_IN
        )

    def test_document_url_authorized_client_ip(self):
        """
        * DocumentUrl.authorized_client_ip(ip_address) returns True if
            ip_address is "in" DocumentUrl.ip_range (per iptools) 
        """
        ad = self.__class__.advancedirective
        doc_url = DocumentUrl(advancedirective=ad)
        ips = [
            "93.184.216.34",  # single address
            "93.184.216.34, 93.184.216.37",  # comma-delimited range
            "93.184.216.34/24",  # ip with subnet mask
        ]
        authorized_ip = "93.184.216.34"
        unauthorized_ip = "93.184.217.34"

        for ip in ips:
            doc_url.ip = ip
            self.assertTrue(doc_url.authorized_client_ip(authorized_ip))
            self.assertFalse(doc_url.authorized_client_ip(unauthorized_ip))

    def test_document_url_required_and_optional_fields(self):
        """
        * Nullable attributes: ip, expiration
        * Required attributes: advancedirective, key
        * When a DocumentUrl is changed, the key is unchanged, 
            and expiration is changed only if explicitly.
        """
        ad = self.__class__.advancedirective
        doc_url = DocumentUrl.objects.create(advancedirective=ad)
        key = doc_url.key
        expiration = doc_url.expiration
        # -- ip: nullable
        doc_url.ip = None
        doc_url.save()
        self.assertIsNone(doc_url.ip)
        self.assertEqual(key, doc_url.key)
        self.assertEqual(expiration, doc_url.expiration)
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
