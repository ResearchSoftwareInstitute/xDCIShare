
from django.test import TestCase
from myhpom.forms.signup import SignupForm


class SignupFormTestCase(TestCase):
    """
    * is_valid()==True with minimal valid data
    """

    def setUp(self):
        self.form_data = {
            'first_name': 'A',
            'last_name': 'B',
            'email': 'ab@example.com',
            'password': 'Abbbbbbb1@',
            'password_confirm': 'Abbbbbbb1@',
            'state': 'NC',
            'accept_tos': True,
        }

    def test_minimal_valid_data(self):
        form = SignupForm(self.form_data)
        self.assertTrue(form.is_valid())
        self.assertEqual({}, form.errors)

    def test_passwords_dont_match(self):
        data = self.form_data
        data['password_confirm'] += '1' # still valid on its own, but doesn't match
        form = SignupForm(data)
        self.assertFalse(form.is_valid())
        self.assertGreaterEqual(len(form.errors['password_confirm']), 1)
