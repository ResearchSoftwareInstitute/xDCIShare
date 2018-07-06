from django.core.urlresolvers import reverse
from django.test import Client, TestCase
from myhpom.models import User, UserDetails, State


class SignupTestCase(TestCase):
    """
    * GET retries page
    * POST invalid data returns to the page
    * POST valid data in non-supported state for non-existing user redirects to 'next_steps'
    * POST valid data in supported state for non-existing user redirects to 'choose_network'
    """

    def setUp(self):
        self.client = Client()
        self.url = reverse('myhpom:signup')
        self.form_data = {
            'first_name': 'A',
            'last_name': 'B',
            'email': 'ab@example.com',
            'password': 'Abbbbbbb1@',
            'password_confirm': 'Abbbbbbb1@',
            'state': 'NC',  # a supported state
            'accept_tos': True,
        }

    def test_get_signup(self):
        """GET the signup page should work"""
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/accounts/signup.html')

    def test_post_signup_invalid(self):
        """invalid signup should redisplay signup page and result in form errors"""
        data = {}  # empty signup data is certainly invalid!
        response = self.client.post(self.url, data=data)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/accounts/signup.html')
        self.assertFalse(response.context['form'].is_valid())

    def test_post_signup_valid_supported(self):
        """valid signup with a supported state should redirect to choose_network"""
        data = self.form_data
        data['state'] = State.objects.filter(supported=True)[0].name
        response = self.client.post(self.url, data=data)
        # reset database state
        User.objects.get(email=self.form_data['email']).delete()
        # test assertions
        self.assertEqual(302, response.status_code)
        self.assertEqual('http://testserver'+reverse('myhpom:choose_network'), response.url)

    def test_post_signup_valid_unsupported(self):
        """valid signup with an unsupported state should redirect to next_steps"""
        data = self.form_data
        data['state'] = State.objects.filter(supported=None)[0].name
        response = self.client.post(self.url, data=data)
        # reset database state
        User.objects.get(email=self.form_data['email']).delete()
        # test assertions
        self.assertEqual(302, response.status_code)
        self.assertEqual('http://testserver'+reverse('myhpom:next_steps'), response.url)
