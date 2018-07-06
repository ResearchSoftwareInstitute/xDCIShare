from django.core.urlresolvers import reverse
from django.test import TestCase

from myhpom.tests import factories


class NextStepsTestCase(TestCase):
    def setUp(self):
        self.url = reverse('myhpom:next_steps')

    def test_no_upload_links_with_invalid_state(self):
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/accounts/next_steps_no_ad_template.html')

    def test_upload_links_with_valid_state(self):
        ad = factories.StateAdvanceDirectiveFactory(
            state='NC',
        )
        response = self.client.get(
            reverse('myhpom:next_steps', kwargs={
                'state': 'nc',
            })
        )
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/accounts/signup.html')
        self.assertEqual(
            ad,
            response.context['ad_template'],
        )


class DashboardTestCase(TestCase):
    def setUp(self):
        self.url = reverse('myhpom:dashboard')

    def test_basic_get(self):
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/dashboard.html')
