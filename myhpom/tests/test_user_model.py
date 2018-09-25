from django.test import TestCase
from django.core.exceptions import ValidationError
from django.contrib.auth.models import User
from .factories import UserFactory


class UserModelTestCase(TestCase):
    """
    * can't save a User with invalid first_name, last_name, or email.
    * can save a new User without username, which results in username = email
    """

    def setUp(self):
        self.user_data = {'first_name': 'A', 'last_name': 'B', 'email': 'Ab@example.com'}

    def test_save_user_without_username(self):
        """saving User without username results in username not null"""
        user = User(**self.user_data)
        user.save()
        self.assertIsNotNone(user.username)
        self.assertNotIn('=', user.username)  # MH-276 fixed this

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

    def test_get_full_name(self):
        """User.get_full_name() includes first, middle, last name"""
        user = UserFactory(first_name='first', last_name='last')
        user.userdetails.middle_name = ''
        self.assertEqual(user.get_full_name(), 'first last')

        user.userdetails.middle_name = 'middle'
        self.assertEqual(user.get_full_name(), 'first middle last')

        user.last_name = ''
        self.assertEqual(user.get_full_name(), 'first middle')
        
        user.first_name = ''
        self.assertEqual(user.get_full_name(), 'middle')

        user.userdetails.middle_name = ''
        self.assertEqual(user.get_full_name(), '')

        user.last_name = 'last'
        self.assertEqual(user.get_full_name(), 'last')
