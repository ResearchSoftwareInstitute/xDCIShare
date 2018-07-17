from django.test import Client, TestCase
from django.core.urlresolvers import reverse

from myhpom import models
from myhpom.models.user import User
from myhpom.tests.factories import UserFactory


class DirectiveUploadRequirementsTestCase(TestCase):
    """
    * GET shows the upload/state_requirements form for the current user/state
    * POST stores the advance directive date, redirect to the upload/submit view
    * POST w/o directive.valid_date (or invalid date) re-displays form, errors
    """

    def setUp(self):
        # create + login user who belongs to North Carolina
        self.user = UserFactory()
        self.user.set_password('password')
        self.user.save()
        self.client.login(username=self.user.username, password='password')
        self.url = reverse('myhpom:upload_requirements')
        self.user.userdetails.state = models.State.objects.get(name="NC")
        self.user.userdetails.save()

    def test__GET(self):
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/upload/requirements.html')

    def test__POST_valid_date(self):
        form_data = {'valid_date': '2018-01-01'}  # in the past
        response = self.client.post(self.url, data=form_data)
        self.assertRedirects(
            response, reverse('myhpom:upload_sharing'), fetch_redirect_response=False
        )
        self.assertEqual(
            form_data['valid_date'], self.user.advancedirective.valid_date.strftime('%Y-%m-%d')
        )

    def test__POST_invalid_date(self):
        form_data = {'valid_date': ''}
        response = self.client.post(self.url, data=form_data)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/upload/requirements.html')
