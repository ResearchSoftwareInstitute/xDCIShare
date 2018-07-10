from django.core.urlresolvers import reverse
from django.test import Client, TestCase
from myhpom import models
from myhpom.models.user import User


class ChooseNetworkTestCase(TestCase):
    """
    * GET with supported state views this page
    * GET with unsupported state redirects to next_steps
    * POST redirects to next_steps
    * POST with custom_provider adds it to the user's UserDetails
    * POST with health_network_id adds that health_network to the user's UserDetails

    QUESTION: What if the user both selects a health network and types a custom provider?
    (not addressed in the AC for MH-18)
    """

    def setUp(self):
        user_data = dict(email="Ab@example.com", password="Abbbbb1@", first_name='A', last_name='b')
        self.user = User(**user_data)
        self.user.set_password(user_data['password'])
        self.user.save()
        self.client = Client()
        self.client.login(username=user_data['email'], password=user_data['password'])
        self.url = reverse('myhpom:choose_network')
        state = models.State.objects.get(name="NC")
        userdetails = models.UserDetails.objects.create(user=self.user, state=state)

    def test_GET_supported_state(self):
        """GET with supported state views this page
        """
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/accounts/choose_network.html')

    def test_GET_unsupported_state(self):
        self.user.userdetails.state = models.State.objects.order_by_ad().last()
        self.user.userdetails.save()
        response = self.client.get(self.url)
        self.assertRedirects(response, reverse('myhpom:next_steps'), fetch_redirect_response=False)

    def test_POST_custom_provider(self):
        """POST with custom_provider adds it to the user's UserDetails 
        and redirects to next_steps
        """
        form_data = {"custom_provider": "My Non-existent Custom Provider", "health_network_id": ""}
        state = models.State.objects.order_by_ad().first()
        response = self.client.post(self.url, data=form_data)
        self.assertRedirects(response, reverse('myhpom:next_steps'), fetch_redirect_response=False)
        userdetails = models.UserDetails.objects.get(id=self.user.userdetails.id)
        self.assertEquals(userdetails.custom_provider, form_data['custom_provider'])
        self.assertIsNone(userdetails.health_network)

    def test_POST_health_network(self):
        """POST with health_network_id adds that health_network to the user's UserDetails
        and redirects to next_steps
        """
        state = self.user.userdetails.state
        health_network = models.HealthNetwork.objects.filter(state=state, priority=0)[0]
        form_data = {"custom_provider": "", "health_network": health_network.id}
        response = self.client.post(self.url, data=form_data)
        self.assertRedirects(response, reverse('myhpom:next_steps'), fetch_redirect_response=False)
        userdetails = models.UserDetails.objects.get(id=self.user.userdetails.id)
        self.assertIsNotNone(userdetails.health_network)
        self.assertIsNone(userdetails.custom_provider)
