from lxml import etree
from django.core.urlresolvers import reverse
from django.test import TestCase
from django.utils.timezone import now
from django.contrib.messages import get_messages, WARNING

from myhpom.models import AdvanceDirective
from myhpom.tests.factories import UserFactory


class DashboardTestCase(TestCase):
    def setUp(self):
        self.url = reverse('myhpom:dashboard')

    def test_not_logged_in(self):
        # A user must be logged in to see their dashboard:
        response = self.client.get(self.url)
        self.assertEqual(302, response.status_code)

    def test_basic_get(self):
        user = UserFactory()
        user.set_password('password')
        user.save()
        self.assertTrue(self.client.login(username=user.email, password='password'))
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/dashboard.html')
        self.assertTemplateUsed('myhpom/upload/index.html')
        self.assertIsNone(response.context['advancedirective'])

    def test_user_with_ad(self):
        # A user with an AD should use the current_ad template and have the
        # advancedirective in its context
        user = UserFactory()
        user.set_password('password')
        user.save()
        advancedirective = AdvanceDirective(user=user, valid_date=now(), share_with_ehs=False)
        advancedirective.save()
        self.assertTrue(self.client.login(username=user.email, password='password'))
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/dashboard.html')
        self.assertTemplateUsed('myhpom/upload/current_ad.html')
        self.assertIsNotNone(response.context['advancedirective'])

    def test_user_is_organ_donor(self):
        """
        + A user who is an organ donor should see "I am an organ donor" and no link
        + A user who is not an organ donor should see "I am not an organ donor" and a link
        """
        user = UserFactory()
        user.set_password('password')
        user.save()
        self.assertTrue(self.client.login(username=user.email, password='password'))

        user.userdetails.is_organ_donor = False
        user.userdetails.save()
        response = self.client.get(self.url)
        self.assertIn('I am not an organ donor', response.content)
        self.assertIn('Learn how you can be a donor.', response.content)

        user.userdetails.is_organ_donor = True
        user.userdetails.save()
        response = self.client.get(self.url)
        self.assertIn('I am an organ donor', response.content)
        self.assertNotIn('Learn how you can be a donor.', response.content)

    def test_user_verification(self):
        """
        + Unverified user
            + sees a warning message on the dashboard (alert-warning)
            + has "Upload your File" button disabled
        + Verified user
            + sees no warning message on the dashboard
            + has "Upload your File" button enabled
        """
        user = UserFactory()
        user.set_password('password')
        user.save()
        self.assertTrue(self.client.login(username=user.email, password='password'))

        # unverified user
        user.userdetails.reset_verification()
        user.userdetails.save()
        self.assertIsNotNone(user.userdetails.verification_code)
        self.assertIsNone(user.userdetails.verification_completed)
        response = self.client.get(self.url)
        messages = [msg for msg in get_messages(response.wsgi_request) if msg.level == WARNING]
        self.assertGreater(len(messages), 0)
        html = etree.fromstring(response.content.decode('utf-8'), etree.HTMLParser())
        a_classes = html.xpath(
            '//a[contains(@class, "advance-directive-widget__button--primary")]/@class'
        )
        self.assertGreater(len(a_classes), 0)
        self.assertIn('disabled', a_classes[0])

        # verified user
        user.userdetails.verification_completed = now()  # voila, verified
        user.userdetails.save()
        response = self.client.get(self.url)
        messages = [msg for msg in get_messages(response.wsgi_request) if msg.level == WARNING]
        self.assertEqual(len(messages), 0)
        html = etree.fromstring(response.content.decode('utf-8'), etree.HTMLParser())
        a_classes = html.xpath(
            '//a[contains(@class, "advance-directive-widget__button--primary")]/@class'
        )
        self.assertGreater(len(a_classes), 0)
        self.assertNotIn('disabled', a_classes[0])
