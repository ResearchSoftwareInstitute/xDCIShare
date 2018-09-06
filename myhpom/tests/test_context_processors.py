from django.core.urlresolvers import reverse
from django.test import TestCase
from django.conf import settings
from myhpom.tests.factories import UserFactory
from myhpom.urls import static_views


class SettingsProcessorTestCase(TestCase):
    def test_email_is_available_on_home(self):
        for example_email in ('foo@example.com', 'bar@example.com', ):
            response = self.client.get(reverse('myhpom:home'))
            self.assertEqual(response.context['settings'].CONTACT_EMAIL, settings.CONTACT_EMAIL)
            with self.settings(CONTACT_EMAIL=example_email):
                response = self.client.get(reverse('myhpom:home'))
                self.assertEqual(example_email, response.context['settings'].CONTACT_EMAIL)

    def test_email_is_available_on_dashboard(self):
        user = UserFactory()
        user.set_password('password')
        user.save()
        self.assertTrue(self.client.login(username=user.email, password='password'))
        for example_email in ('foo@example.com', 'bar@example.com', ):
            response = self.client.get(reverse('myhpom:dashboard'))
            self.assertEqual(response.context['settings'].CONTACT_EMAIL, settings.CONTACT_EMAIL)
            with self.settings(CONTACT_EMAIL=example_email):
                response = self.client.get(reverse('myhpom:dashboard'))
                self.assertEqual(example_email, response.context['settings'].CONTACT_EMAIL)

    def test_email_is_availab_on_static_views(self):
        for pattern, name, template in static_views:
            response = self.client.get(reverse('myhpom:%s' % name))
            self.assertEqual(response.context['settings'].CONTACT_EMAIL, settings.CONTACT_EMAIL)
            for example_email in ('foo@example.com', 'bar@example.com', ):
                with self.settings(CONTACT_EMAIL=example_email):
                    response = self.client.get(reverse('myhpom:%s' % name))
                    self.assertEqual(example_email, response.context['settings'].CONTACT_EMAIL)
