from django.test import TestCase
from django.core.exceptions import ValidationError
from django.contrib.auth.models import User


class UserModelTestCase(TestCase):
    """
    * can't save a User with invalid first_name, last_name, or email.
    * can save a new User without username, which results in username = email
    """

    def setUp(self):
        self.user_data = {
            'first_name': 'A',
            'last_name': 'B',
            'email': 'Ab@example.com'
        }

    def test_save_user_without_username(self):
        """saving User without username results in username = email"""
        user = User(**self.user_data)
        user.save()
        self.assertEqual(user.email, user.username)
        user.delete()   # tear-down needed for reuse/keep db

    def test_save_invalid_user_fails(self):
        """first_name and last_name are not only required, but they have to be alphanumeric,
        and email has to be a valid email address
        """
        # last name
        user_data = self.user_data
        user_data.update(first_name='@')
        user = User(**user_data)
        self.assertRaises(ValidationError, user.save)

        # first name
        user_data.update(first_name='A', last_name='@')
        user = User(**user_data)
        self.assertRaises(ValidationError, user.save)

        # email
        user_data.update(first_name='A', last_name='b', email='Ab@')
        user = User(**user_data)
        self.assertRaises(ValidationError, user.save)
                
