from django.test import TestCase
from django.core.exceptions import ValidationError
from myhpom.tests.factories import UserFactory
from myhpom.forms.profile import EditUserDetailsForm
from myhpom.models import State
from myhpom.models.user_details import GENDER_CHOICES
from datetime import date


class EditProfileUserDetailsFormTestCase(TestCase):
    """
    * nothing is required except state
    * form.is_valid()==False when values are not valid for model (e.g., gender not in choices)
    * when a State object is given to data, the cleaned_data has State.name
    * on save, cleaned_data.state must match an existing State object else ValueError    
    """

    def setUp(self):
        state = self.state = State.objects.first()
        self.valid_data = [
            {'state': state},
            {'state': state.name},
            {'state': state, 'gender': GENDER_CHOICES[0][0]},
            {'state': state, 'birthdate': date.today()},  # date object ok
            {'state': state, 'birthdate': date.today().strftime('%Y-%m-%d')},  # ISO format ok
            {'state': state, 'zip_code': '8' * 10},  # length ok
            {'state': state, 'phone': '8' * 32},  # length ok
        ]
        self.invalid_data = [
            {},  # state is required
            {'state': 'UU'},  # state must exist
            {'state': state, 'gender': 'NON_CONFORMING_TO_GENDER_CHOICES'},  # invalid gender
            {'state': state, 'birthdate': 'today'},  # not a date
            {'state': state, 'zip_code': '8' * 20},  # too long
            {'state': state, 'phone': '8' * 40},  # too long
        ]

    def test__without_instance(self):
        for data in self.valid_data:
            form = EditUserDetailsForm(data=data)
            self.assertTrue(form.is_valid())
            self.assertEqual(form.cleaned_data['state'], self.state.name)
        for data in self.invalid_data:
            form = EditUserDetailsForm(data=data)
            self.assertFalse(form.is_valid())
            for key in [key for key in data.keys() if key != 'state']:
                self.assertIn(key, form.errors)

    def test__with_instance(self):
        user = UserFactory()
        userdetails = user.userdetails
        for data in self.valid_data:
            form = EditUserDetailsForm(data=data, instance=userdetails)
            self.assertTrue(form.is_valid())
            form.save() # ok
        for data in self.invalid_data:
            form = EditUserDetailsForm(data=data, instance=userdetails)
            self.assertFalse(form.is_valid())
            for key in [key for key in data.keys() if key != 'state']:
                self.assertIn(key, form.errors)
            with self.assertRaises(ValueError):
                form.save()
