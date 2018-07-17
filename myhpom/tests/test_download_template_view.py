from django.test import Client, TestCase
from django.core.urlresolvers import reverse
from django.core.files.base import ContentFile

from myhpom.models.user import User
from myhpom.models import State
from myhpom.tests.factories import UserFactory


class DownloadTemplateTestCase(TestCase):
    """
    * GET
        * user from state that has an advance_directive_template file should get that file
        * user from state that does not have an advance_directive_template file should not get that file
    """

    def setUp(self):
        self.url = reverse('myhpom:download_template')
        self.user = UserFactory()
        self.user.set_password('password')
        self.user.save()
        self.assertTrue(self.client.login(username=self.user.username, password='password'))

    def test_state_has_ad(self):
        state = self.user.userdetails.state
        state = self.user.userdetails.state = State.objects.order_by_ad().first()
        self.user.userdetails.save()
        content_file = ContentFile("not your grandfather's template")
        state.advance_directive_template.save('not.pdf', content_file)
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertEqual(len(content_file), len(response.content))

    def test_state_has_no_ad(self):
        state = self.user.userdetails.state = State.objects.order_by_ad().last()
        self.user.userdetails.save()
        response = self.client.get(self.url)
        self.assertEqual(404, response.status_code)
