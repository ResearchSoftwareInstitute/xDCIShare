from django.test import TestCase
from django.core.exceptions import ValidationError
from myhpom.models.user import User
from myhpom.models.user_details import UserDetails


class UserDetailsModelTestCase(TestCase):
    """
    * 
    """

    def setUp(self):
        user_data = {'first_name': 'A', 'last_name': 'B', 'email': 'Ab@example.com'}
        self.user = User.objects.create(**user_data)
        user_details = {'user': self.user}
        UserDetails.objects.create(**user_details)
