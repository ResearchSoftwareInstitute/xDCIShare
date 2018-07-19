from datetime import date, timedelta

from django.core.files.uploadedfile import SimpleUploadedFile
from django.test import TestCase, override_settings
from myhpom.forms.upload_requirements import UploadRequirementsForm


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

    @override_settings(MAX_AD_SIZE=10)
    def test__not_valid(self):
        valid_file = SimpleUploadedFile('afile.pdf', 'binary')
        invalid_data = [
            {},
            {'valid_date': ''},
            {'valid_date': 'not-a-date'},
            {'valid_date': (date.today() + timedelta(1)).strftime("%Y-%m-%d")},  # tomorrow!
        ]
        for data in invalid_data:
            form = UploadRequirementsForm(data, files={'document': valid_file})
            self.assertFalse(form.is_valid())

        # If the date is valid, but the file isn't
        valid_date = (date.today() - timedelta(1)).strftime("%Y-%m-%d")
        toobig_valid_file = SimpleUploadedFile('toobig.pdf', 'binary_contents')
        invalid_file = SimpleUploadedFile('afile.txt', 'binary_contents')
        for some_file in [toobig_valid_file, invalid_file]:
            form = UploadRequirementsForm(data={'valid_date': valid_date}, files={'document': some_file})
            self.assertFalse(form.is_valid())

    def test__valid(self):
        valid_file = SimpleUploadedFile('afile.pdf', 'binary_contents')
        valid_data = [
            {'valid_date': date.today().strftime("%Y-%m-%d")},  # today!
            {'valid_date': (date.today() - timedelta(1)).strftime("%Y-%m-%d")},  # yesterday!
        ]
        for data in valid_data:
            form = UploadRequirementsForm(data, files={'document': valid_file})
            form.is_valid()
            self.assertTrue(form.is_valid(), msg=data)
