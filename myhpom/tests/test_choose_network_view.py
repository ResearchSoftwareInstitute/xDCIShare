from django.core.urlresolvers import reverse
from django.test import Client, TestCase
from myhpom import models


class ChooseNetworkTestCase(TestCase):
    """
    * GET with supported state views this page
    * GET with unsupported state redirects to next_steps
    * POST redirects to next_steps

    After we have a login user, we should also assert:

    * POST with custom_provider adds it to the user's UserDetails
    * POST with network_id adds that health_network to the user's UserDetails

    QUESTION: What if the user both selects a health network and types a custom provider?
    (not addressed in the AC for MH-18)
    """

    def setUp(self):
        self.client = Client()
        self.url = reverse('myhpom:choose_network')

    def test_GET_supported_state(self):
        state = models.State.objects.filter(supported=True)[0]
        response = self.client.get(self.url + "?state=" + state.name)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/accounts/choose_network.html')

    def test_GET_unsupported_state(self):
        state = models.State.objects.filter(supported=None)[0]
        response = self.client.get(self.url + "?state=" + state.name)
        self.assertRedirects(response, reverse('myhpom:next_steps'), fetch_redirect_response=False)

    def test_POST(self):
        state = models.State.objects.filter(supported=True)[0]
        health_network = models.HealthNetwork.objects.filter(state=state, priority=0)[0]
        custom_provider = "My Custom Provider Who Doesn't Exist"
        form_data = {"health_network_id": health_network.id, "custom_provider": custom_provider}
        response = self.client.post(self.url, data=form_data)
        self.assertRedirects(response, reverse('myhpom:next_steps'), fetch_redirect_response=False)
