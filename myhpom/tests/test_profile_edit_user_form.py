from django.test import TestCase
from myhpom.tests.factories import UserFactory
from myhpom.forms.profile import EditUserForm


class EditProfileUserFormTestCase(TestCase):
    """
    * form without first_name, last_name, valid email is not valid
    * form with these values has them in cleaned_data after is_valid()
    """

    def test__without_instance(self):
        valid_data = [{'first_name': 'A', 'last_name': 'B', 'email': 'AB@here.com'}]
        for data in valid_data:
            form = EditUserForm(data=data)
            self.assertTrue(form.is_valid())
            for key in data.keys():
                self.assertEqual(form.cleaned_data[key], form.data[key])
        invalid_data = [
            {},
            {'first_name': '', 'last_name': '', 'email': ''},
            {'first_name': 'A', 'last_name': 'B', 'email': 'AB'},
        ]
        for data in invalid_data:
            form = EditUserForm(data=data)
            self.assertFalse(form.is_valid())

    def test__with_instance(self):
        user = UserFactory()
        form = EditUserForm(instance=user)
        self.assertFalse(form.is_valid())
        with self.assertRaises(AttributeError):
            form.save()
        data = {key: user.__getattribute__(key) for key in EditUserForm().fields.keys()}
        form = EditUserForm(data=data, instance=user)
        self.assertTrue(form.is_valid())
        form.save()  # ok
