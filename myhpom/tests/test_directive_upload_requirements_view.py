from django.test import Client, TestCase
from django.core.urlresolvers import reverse
from myhpom import models
from myhpom.models.user import User

import logging

LOG = logging.getLogger(__name__)


class DirectiveUploadRequirementsTestCase(TestCase):
    """
    * GET shows the upload/state_requirements form for the current user/state
    * POST stores the advance directive date, redirect to the upload/submit view
    * POST w/o directive.valid_date (or invalid date) re-displays form, errors
    """

    def setUp(self):
        # create + login user who belongs to North Carolina
        user_data = dict(email="Ab@example.com", password="Abbbbb1@", first_name='A', last_name='b')
        self.user = User(**user_data)
        self.user.set_password(user_data['password'])
        self.user.save()
        self.client = Client()
        self.client.login(username=user_data['email'], password=user_data['password'])
        self.url = reverse('myhpom:upload_requirements')
        state = models.State.objects.get(name="NC")
        userdetails = models.UserDetails.objects.create(user=self.user, state=state)

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
