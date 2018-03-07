from django.test import TestCase
from mezzanine.pages.models import RichTextPage


class TestSignUp(TestCase):

    def test_context(self):
        """ A sign-up page will get a recaptch site key. """
        sign_up_page, _ = RichTextPage.objects.get_or_create(title='Sign Up', slug='sign-up')
        response = self.client.get(sign_up_page.get_absolute_url())
        self.assertTrue('SITE_KEY' in response.context)
