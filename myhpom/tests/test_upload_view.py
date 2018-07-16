from django.core.urlresolvers import reverse
from django.test import TestCase
from django.utils.timezone import now

from myhpom.models import AdvanceDirective
from myhpom.tests.factories import UserFactory


class UploadMixin:
    def _setup_user_and_login(self):
        user = UserFactory()
        user.set_password('password')
        user.save()
        self.assertTrue(self.client.login(username=user.username, password='password'))
        return user

    def test_not_logged_in(self):
        # A user must be logged in to see their dashboard:
        response = self.client.get(self.url)
        self.assertEqual(302, response.status_code)


class GETMixin(UploadMixin):

    def test_get(self):
        # Renders the proper template on GET:
        self._setup_user_and_login()
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/upload/requirements.html')


class UploadIndexTestCase(GETMixin, TestCase):
    def setUp(self):
        self.url = reverse('myhpom:upload_index')


class UploadRequirementsTestCase(GETMixin, TestCase):
    def setUp(self):
        self.url = reverse('myhpom:upload_requirements')


class UploadSharingTestCase(GETMixin, TestCase):
    def setUp(self):
        self.url = reverse('myhpom:upload_sharing')


class UploadCurrentAdTestCase(UploadMixin, TestCase):
    def setUp(self):
        self.url = reverse('myhpom:upload_current_ad')

    def test_get(self):
        # Users that don't yet have an AD are sent to the upload_index
        user = self._setup_user_and_login()
        response = self.client.get(self.url)
        self.assertRedirects(response, reverse('myhpom:upload_index'))

        # When the user does have an advancedirective, they can visit the page.
        advancedirective = AdvanceDirective(user=user, valid_date=now(), share_with_ehs=False)
        advancedirective.save()


class UploadSubmitTestCase(UploadMixin, TestCase):
    def setUp(self):
        self.url = reverse('myhpom:upload_submit')

    def test_not_logged_in(self):
        response = self.client.get(self.url)
        self.assertEqual(405, response.status_code)

    def test_get_fails(self):
        self._setup_user_and_login()
        response = self.client.get(self.url)
        self.assertEqual(405, response.status_code)