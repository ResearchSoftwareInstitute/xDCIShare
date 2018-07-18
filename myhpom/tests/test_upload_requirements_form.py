
from django.test import TestCase
from myhpom.forms.upload_requirements import UploadRequirementsForm
from datetime import date, timedelta


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

    def test__not_valid(self):
        invalid_data = [
            {},
            {'valid_date': ''},
            {'valid_date': 'not-a-date'},
            {'valid_date': (date.today() + timedelta(1)).strftime("%Y-%m-%d")},  # tomorrow!
        ]
        for data in invalid_data:
            form = UploadRequirementsForm(data)
            self.assertFalse(form.is_valid())

    def test__valid(self):
        valid_data = [
            {'valid_date': date.today().strftime("%Y-%m-%d")},  # today!
            {'valid_date': (date.today() - timedelta(1)).strftime("%Y-%m-%d")},  # yesterday!
        ]
        for data in valid_data:
            form = UploadRequirementsForm(data)
            self.assertTrue(form.is_valid())
