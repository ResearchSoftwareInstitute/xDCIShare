from django.contrib.auth.models import User
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


class UploadSharingTestCase(UploadMixin, TestCase):
    def setUp(self):
        self.url = reverse('myhpom:upload_sharing')

    def test_not_logged_in(self):
        response = self.client.get(self.url)
        self.assertEqual(302, response.status_code)

    def test_get(self):
        # When GETting, see the sharing template.
        user = self._setup_user_and_login()
        response = self.client.get(self.url)
        self.assertEqual(302, response.status_code)

        advancedirective = AdvanceDirective(user=user, valid_date=now(), share_with_ehs=False)
        advancedirective.save()
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/upload/sharing.html')

    def test_post(self):
        # When POSTing - even no data is sufficient to succeed and redirect
        user = self._setup_user_and_login()
        advancedirective = AdvanceDirective(user=user, valid_date=now(), share_with_ehs=False)
        advancedirective.save()

        # no submitted data == invalid form
        response = self.client.post(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/upload/sharing.html')

        response = self.client.post(self.url, {
            'share_with_ehs': False,
        })
        self.assertRedirects(response, reverse('myhpom:upload_current_ad'))
        self.assertFalse(user.advancedirective.share_with_ehs)

        # Checking the share box saves the result.
        response = self.client.post(self.url, {
            'share_with_ehs': True,
        })
        self.assertRedirects(response, reverse('myhpom:upload_current_ad'))
        user.advancedirective.refresh_from_db()
        self.assertTrue(user.advancedirective.share_with_ehs)


class UploadDeleteTestCase(UploadMixin, TestCase):
    url = reverse('myhpom:upload_delete_ad')

    def test_not_logged_in(self):
        # A user must be logged in to see their dashboard:
        response = self.client.post(self.url)
        self.assertEqual(302, response.status_code)

    def test_get_rejected(self):
        self._setup_user_and_login()
        response = self.client.get(self.url)
        self.assertEqual(405, response.status_code)

    def test_deletes_ad(self):
        user = self._setup_user_and_login()
        advancedirective = AdvanceDirective(user=user, valid_date=now(), share_with_ehs=False)
        advancedirective.save()
        self.assertTrue(hasattr(user, 'advancedirective'))
        self.assertEqual(advancedirective, user.advancedirective)

        response = self.client.post(self.url)
        user = User.objects.get(id=user.id)
        self.assertFalse(hasattr(user, 'advancedirective'))
        self.assertRedirects(response, reverse('myhpom:dashboard'))

        # doing this twice should be fine
        response = self.client.post(self.url)
        user = User.objects.get(id=user.id)
        self.assertFalse(hasattr(user, 'advancedirective'))
        self.assertRedirects(response, reverse('myhpom:dashboard'))
