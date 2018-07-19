from django.core.urlresolvers import reverse
from django.test import TestCase
from django.utils.timezone import now

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
        self.assertTrue(self.client.login(username=user.username, password='password'))
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
        self.assertTrue(self.client.login(username=user.username, password='password'))
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/dashboard.html')
        self.assertTemplateUsed('myhpom/upload/current_ad.html')
        self.assertIsNotNone(response.context['advancedirective'])
