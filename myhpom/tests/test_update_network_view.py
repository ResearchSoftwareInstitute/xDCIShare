from django.core.urlresolvers import reverse
from django.test import TestCase
from myhpom import models
from myhpom.tests.factories import UserFactory


class UpdateNetworkTestCase(TestCase):
    """Test the unique behavior for update_network, which is based on choose_network
    (so it doesn't re-test those behaviors).
    * GET with supported state has supported_state==True
    * GET with unsupported state has supported_state==False
    * POST returns to dashboard, health_network_updated (timestamp) is updated
    """

    def setUp(self):
        self.user = UserFactory()
        self.user.set_password('password')
        self.user.save()
        self.assertTrue(self.client.login(username=self.user.email, password='password'))
        self.url = reverse('myhpom:update_network')

    def test_GET_supported_state(self):
        """GET with supported state views this page
        """
        self.user.userdetails.state = models.State.objects.get(name='NC')
        self.user.userdetails.save()
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/accounts/choose_network.html')
        self.assertTrue(response.context['is_update'])
        self.assertTrue(response.context['supported_state'], self.user.userdetails.state.name)

    def test_GET_unsupported_state(self):
        self.user.userdetails.state = models.State.objects.last()
        self.user.userdetails.save()
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/accounts/choose_network.html')
        self.assertTrue(response.context['is_update'])
        self.assertFalse(response.context['supported_state'])

    def test_POST(self):
        health_network_updated_initial = self.user.userdetails.health_network_updated
        response = self.client.post(
            self.url, data={"custom_provider": "My Non-existent Custom Provider"}
        )
        self.assertRedirects(response, reverse('myhpom:dashboard'), fetch_redirect_response=False)
        userdetails = models.UserDetails.objects.get(id=self.user.userdetails.id)
        self.assertGreater(userdetails.health_network_updated, health_network_updated_initial)

    def test_POST_no_data_supported_state(self):
        self.user.userdetails.state = models.State.objects.get(name='NC')
        self.user.userdetails.save()
        form_data = {"custom_provider": "", "health_network": None}
        response = self.client.post(self.url, data=form_data)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/accounts/choose_network.html')
        self.assertTrue(response.context['is_update'])
        self.assertTrue(response.context['supported_state'])
        form = response.context['form']
        self.assertIn(
            'Please either choose a network or enter a custom network.', form.non_field_errors()
        )

    def test_POST_no_data_unsupported_state(self):
        self.user.userdetails.state = models.State.objects.last()
        self.user.userdetails.save()
        form_data = {"custom_provider": ""}
        response = self.client.post(self.url, data=form_data)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/accounts/choose_network.html')
        self.assertTrue(response.context['is_update'])
        self.assertFalse(response.context['supported_state'])
        form = response.context['form']
        self.assertIn('Please enter a custom network.', form.non_field_errors())
