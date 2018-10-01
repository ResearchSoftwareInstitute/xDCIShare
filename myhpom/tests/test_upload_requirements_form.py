import os
from datetime import date, timedelta
from os.path import basename

from django.core.files.uploadedfile import SimpleUploadedFile
from django.test import TestCase, override_settings
from myhpom.forms.upload_requirements import UploadRequirementsForm
from myhpom.models import AdvanceDirective
from myhpom.tests.factories import UserFactory

PDF_FILENAME = os.path.join(os.path.dirname(__file__), 'fixtures', 'afile.pdf')


class UploadRequirementsFormTestCase(TestCase):
    """
    * not valid:
        + no valid_date
        + valid_date in future
        + valid_date not a date
    * valid:
        + valid_date is a date in the past
        + valid_date is today
    """

    def setUp(self):
        user = UserFactory()
        self.directive = AdvanceDirective(user=user, share_with_ehs=False)
        with open(PDF_FILENAME, 'rb') as f:
            self.pdf_data = f.read()

    def test_not_valid_dates(self):
        invalid_dates = [
            {},
            {'valid_date': ''},
            {'valid_date': 'not-a-date'},
            {'valid_date': (date.today() + timedelta(1)).strftime("%Y-%m-%d")},  # tomorrow!
        ]
        for data in invalid_dates:
            document = SimpleUploadedFile(os.path.basename(PDF_FILENAME), self.pdf_data)
            form = UploadRequirementsForm(data, files={'document': document})
            self.assertFalse(form.is_valid())

    def test_not_valid_files(self):
        valid_data = {'valid_date': date.today().strftime("%Y-%m-%d")}
        invalid_files_list = [
            {'document': SimpleUploadedFile("afile.txt", "not-binary-pdf-data")},
            {'document': SimpleUploadedFile("afile.pdf", "also-not-binary-pdf-data")},
        ]
        for invalid_files in invalid_files_list:
            form = UploadRequirementsForm(data=valid_data, files=invalid_files)
            self.assertFalse(form.is_valid())

    @override_settings(MAX_AD_SIZE=10)
    def test_document_too_big(self):
        # we can test the MAX_AD_SIZE setting by overriding it with a very small value
        # everything else is valid
        valid_date = (date.today() - timedelta(1)).strftime("%Y-%m-%d")
        toobig_valid_file = SimpleUploadedFile('toobig.pdf', self.pdf_data)
        form = UploadRequirementsForm(
            data={'valid_date': valid_date}, files={'document': toobig_valid_file}
        )
        self.assertFalse(form.is_valid())

    def test_valid(self):
        valid_data = [
            {'valid_date': date.today().strftime("%Y-%m-%d")},  # today!
            {'valid_date': (date.today() - timedelta(1)).strftime("%Y-%m-%d")},  # yesterday!
        ]
        for data in valid_data:
            document = SimpleUploadedFile(os.path.basename(PDF_FILENAME), self.pdf_data)
            form = UploadRequirementsForm(
                data, instance=self.directive, files={'document': document}
            )
            self.assertTrue(form.is_valid(), msg=data)
            form.save()

    def test_clean(self):
        # When a file is cleaned and saved, the filename is modified to prevent
        # clashing and guessing from would-be attackers.
        form = UploadRequirementsForm(
            {'valid_date': date.today().strftime("%Y-%m-%d")},
            instance=self.directive,
            files={'document': SimpleUploadedFile(os.path.basename(PDF_FILENAME), self.pdf_data)},
        )
        self.assertTrue(form.is_valid())
        form.save()
        self.assertNotEqual('afile.pdf', basename(self.directive.document.name))
        self.assertTrue(basename(self.directive.document.name).startswith('afile'))
        self.assertTrue(self.directive.document.name.endswith('.pdf'))
