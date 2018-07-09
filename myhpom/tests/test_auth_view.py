from django.contrib import auth
from django.core.urlresolvers import reverse
from django.test import TestCase

from myhpom.tests.factories import UserFactory


class LogoutTest(TestCase):
    def test_not_logged_in(self):
        response = self.client.get(reverse('myhpom:logout'))
        # TODO currently this redirects to a nonexistent login URL, but since we
        # don't have one yet, that is okay?
        self.assertTrue(302, response.status_code)
        self.assertTrue('login' in response.url)

    def test_logged_in(self):
        u = UserFactory()
        u.set_password('password')
        u.save()
        self.assertTrue(self.client.login(username=u.email, password='password'))
        response = self.client.get(reverse('myhpom:logout'))
        self.assertRedirects(response, reverse('myhpom:home'))
        self.assertFalse(auth.get_user(self.client).is_authenticated())
