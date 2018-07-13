from django.core.urlresolvers import reverse
from django.test import TestCase
from django.core.files.uploadedfile import SimpleUploadedFile

from myhpom.models import State
from myhpom.tests.factories import UserFactory


class NextStepsTestCase(TestCase):
    def setUp(self):
        self.url = reverse('myhpom:next_steps')
        self.user = UserFactory()
        self.user.set_password('password')
        self.user.save()
        State.objects.filter(name='NC') \
            .update(advance_directive_template=SimpleUploadedFile('afile.txt', ''))

    def test_not_logged_in(self):
        response = self.client.get(self.url)
        self.assertEqual(302, response.status_code)

    def test_no_upload_links_with_invalid_state(self):
        self.client.login(username=self.user.username, password='password')
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/accounts/next_steps_no_ad_template.html')

    def test_upload_links_with_valid_state(self):
        self.user.userdetails.state = State.objects.get(name='NC')
        self.user.userdetails.save()
        self.client.login(username=self.user.username, password='password')
        response = self.client.get(reverse('myhpom:next_steps'))
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/accounts/signup.html')
        self.assertEqual(
            self.user.userdetails.state.advance_directive_template,
            response.context['ad_template'],
        )


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
