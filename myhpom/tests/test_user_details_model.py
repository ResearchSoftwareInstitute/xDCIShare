from django.test import TestCase
from django.core.exceptions import ValidationError
from django.db import DataError
from django.utils import timezone
from myhpom.tests.factories import UserFactory
from myhpom import models
from myhpom.models.user_details import GENDER_CHOICES
from datetime import date


class UserDetailsModelTestCase(TestCase):
    """
    * create with no parameters: is_organ_donor = False, health_network_updated = now
    * state must be an existing state
    * health_network must be an existing health network
    * custom_provider must be no longer than 1024 characters
    * gender must be one of GENDER_CHOICES
    * birthdate must be a date
    * zip_code must be no longer than 10 characters
    * phone must be no longer than 32 characters
    """

    def setUp(self):
        self.userdetails = UserFactory().userdetails

    def test__create_no_params(self):
        self.assertFalse(self.userdetails.is_organ_donor)
        self.assertIsInstance(self.userdetails.health_network_updated, date)

    def test__state_not_existing(self):
        self.userdetails.state = models.State.objects.first()  # ok
        self.userdetails.save()
        self.userdetails.state = models.State(name='UU')  # UU is not a state
        self.assertRaises(ValueError, self.userdetails.save)

    def test__health_network_not_existing(self):
        self.userdetails.health_network = models.HealthNetwork.objects.first()  # ok
        self.userdetails.save()
        self.userdetails.health_network = models.HealthNetwork(
            state=models.State.objects.first(), name='', priority=0
        )
        self.assertRaises(ValueError, self.userdetails.save)

    def test__custom_provider(self):
        self.userdetails.custom_provider = "A" * 1024  # just right
        self.userdetails.save()
        self.userdetails.custom_provider = "A" * 1025  # too long
        self.assertRaises(DataError, self.userdetails.save)

    def test__gender(self):
        self.userdetails.gender = GENDER_CHOICES[0][0]  # ok
        self.userdetails.save()
        self.userdetails.gender = "NON_CONFORMING_TO_GENDER_CHOICES"
        self.assertRaises(ValueError, self.userdetails.save)

    def test__birthdate(self):
        self.userdetails.birthdate = date.today()  # ok
        self.userdetails.save()
        self.userdetails.birthdate = 'today'  # not ok
        self.assertRaises(ValidationError, self.userdetails.save)

    def test__zip_code(self):
        self.userdetails.zip_code = '12345-6789'  # zip+4 ok
        self.userdetails.save()
        self.userdetails.zip_code = '12345-67890'  # zip+5 too long
        self.assertRaises(DataError, self.userdetails.save)

    def test__phone(self):
        self.userdetails.phone = '8' * 32  # ok
        self.userdetails.save()
        self.userdetails.phone = '8' * 33  # too long
        self.assertRaises(DataError, self.userdetails.save)

    def test__reset_verification(self):
        """* instance.reset_verification() results in:
            * instance.verification_completed = None
            * instance.verification_code not None, != previous one, 32 <= len <= 64
        """
        self.assertIsNone(self.userdetails.verification_code)
        self.userdetails.verification_completed = timezone.now()
        self.assertIsNotNone(self.userdetails.verification_completed)
        self.userdetails.reset_verification()
        self.assertIsNotNone(self.userdetails.verification_code)
        self.assertIsNone(self.userdetails.verification_completed)
        self.assertGreaterEqual(len(self.userdetails.verification_code), 32)  # >= len md5 hexdigest
        self.assertLessEqual(len(self.userdetails.verification_code), 64)  # <= len sha256 hexdigest

    def test__change_user_email(self):
        """
        * saving change to user email results in reset to verification state (see UserDetails)
        """
        userdetails = self.userdetails
        user = userdetails.user
        userdetails.reset_verification()
        userdetails.verification_completed = timezone.now()
        userdetails.save()
        self.assertIsNotNone(userdetails.verification_completed)
        self.assertIsNotNone(userdetails.verification_code)
        old_verification_code = userdetails.verification_code
        user.email = user.email.replace('@', 'zzz@')  # add some characters to the email
        user.save()
        self.assertIsNone(userdetails.verification_completed)
        self.assertIsNotNone(userdetails.verification_code)
        self.assertNotEqual(userdetails.verification_code, old_verification_code)
