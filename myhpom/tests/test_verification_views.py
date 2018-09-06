from django.core.urlresolvers import reverse
from django.test import TestCase
from django.utils.timezone import now
from django.contrib.messages import get_messages, INFO, SUCCESS, ERROR

from myhpom.models.user import User
from myhpom.tests.factories import UserFactory


class SendVerificationViewTestCase(TestCase):
    """
    + Verified user: 
        + message.info = "Your email address is already verified."
        + returns redirect to myhpom:dashboard
    + Unverified user: 
        + message.info = "Please check your email to verify your address."
        + user's verification code has changed because UserDetails.reset_verification() is done.
        + returns redirect to myhpom:dashboard
    """

    def setUp(self):
        self.url = reverse('myhpom:send_account_verification')
        self.user = UserFactory()
        self.user.set_password('password')
        self.user.save()
        self.assertTrue(self.client.login(username=self.user.email, password='password'))

    def test_verified_user(self):
        self.user.userdetails.reset_verification()
        self.user.userdetails.verification_completed = now()  # voila, verified
        self.user.userdetails.save()
        response = self.client.get(self.url)
        messages = [msg for msg in get_messages(response.wsgi_request) if msg.level == INFO]
        self.assertIn('already verified', ''.join([msg.message for msg in messages]))
        self.assertRedirects(response, reverse('myhpom:dashboard'))

    def test_unverified_user(self):
        old_verification_code = self.user.userdetails.verification_code
        response = self.client.get(self.url)
        messages = [msg for msg in get_messages(response.wsgi_request) if msg.level == INFO]
        self.assertIn('check your email', ''.join([msg.message for msg in messages]).lower())
        self.assertRedirects(response, reverse('myhpom:dashboard'))

        # also check to verify that the verification_code has been changed by the request.
        user = User.objects.get(username=self.user.username)
        self.assertNotEqual(user.userdetails.verification_code, old_verification_code)


class VerifyAccountViewTestCase(TestCase):
    """
    + Already verified user: message.info = "Your email address is already verified."
    + Unverified user, correct code (matches UserDetails.verification_code):
        + message.success = "Your email address is now verified."
        + UserDetails.verification_completed is not None 
    + Unverified user, incorrect code (does not match UserDetails.verification_code):
        + message.error = "The verification code is invalid."
    """

    def setUp(self):
        self.user = UserFactory()
        self.user.set_password('password')
        self.user.save()
        self.user.userdetails.reset_verification()
        self.user.userdetails.save()
        self.url = reverse(
            'myhpom:verify_account', kwargs={'code': self.user.userdetails.verification_code}
        )
        self.assertTrue(self.client.login(username=self.user.email, password='password'))

    def test_verified_user(self):
        self.user.userdetails.verification_completed = now()  # voila, verified
        self.user.userdetails.save()
        response = self.client.get(self.url)
        messages = [msg for msg in get_messages(response.wsgi_request) if msg.level == INFO]
        self.assertIn('already verified', ''.join([msg.message for msg in messages]))
        self.assertRedirects(response, reverse('myhpom:dashboard'))

    def test_unverified_user_correct_code(self):
        self.assertIn(self.user.userdetails.verification_code, self.url)
        response = self.client.get(self.url)
        messages = [msg for msg in get_messages(response.wsgi_request) if msg.level == SUCCESS]
        self.assertRedirects(response, reverse('myhpom:dashboard'))

    def test_unverified_user_incorrect_code(self):
        self.user.userdetails.reset_verification()
        self.user.userdetails.save()
        self.assertNotIn(self.user.userdetails.verification_code, self.url)
        response = self.client.get(self.url)
        messages = [msg for msg in get_messages(response.wsgi_request) if msg.level == ERROR]
        self.assertRedirects(response, reverse('myhpom:dashboard'))
