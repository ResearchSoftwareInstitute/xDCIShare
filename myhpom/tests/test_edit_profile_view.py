from django.core.urlresolvers import reverse
from django.test import TestCase
from myhpom.tests.factories import UserFactory


class EditProfileViewTestCase(TestCase):
    """
    * user must be logged in
    * GET provides the user_form and user_details_form with values from the user's profile
    * POST with invalid data redisplays the page with form errors
    * POST with valid data saves the forms to the user's profile and redirects to dashboard
    """

    def setUp(self):
        self.url = reverse('myhpom:edit_profile')

    def test__not_logged_in(self):
        # A user must be logged in to edit their profile
        response = self.client.get(self.url)
        self.assertEqual(302, response.status_code)

    def test__GET(self):
        user = UserFactory()
        user.set_password('password')
        user.save()
        self.assertTrue(self.client.login(username=user.username, password='password'))
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/profile/edit.html')
        self.assertIsNotNone(response.context['user_form'])
        self.assertIsNotNone(response.context['user_details_form'])
        for key in response.context['user_form'].data.keys():
            self.assertEqual(response.context['user_form'].data[key], user.__getattribute__(key))
        for key in response.context['user_details_form'].data.keys():
            if key == 'state':
                self.assertEqual(
                    response.context['user_details_form'].data['state'], user.userdetails.state.name
                )
            else:
                self.assertEqual(
                    response.context['user_details_form'].data[key],
                    user.userdetails.__getattribute__(key),
                )

    def test__POST(self):
        user = UserFactory()
        user.set_password('password')
        user.save()
        self.assertTrue(self.client.login(username=user.username, password='password'))
        # since we test the form elsewhere, we can minimize our valid data test
        valid_post_data = dict(
            state=user.userdetails.state.name,
            **{key: user.__getattribute__(key) for key in ['first_name', 'last_name', 'email']}
        )
        # default redirect to dashboard
        response = self.client.post(self.url, data=valid_post_data)
        self.assertRedirects(response, reverse('myhpom:dashboard'), fetch_redirect_response=False)
        # invalid POST redisplays page
        invalid_post_data = dict(
            birthdate='today',  # not a date
            gender='NOT A GENDER',  # not in GENDER_CHOICES
            **valid_post_data
        )
        response = self.client.post(self.url, data=invalid_post_data)
        self.assertEqual(200, response.status_code)
