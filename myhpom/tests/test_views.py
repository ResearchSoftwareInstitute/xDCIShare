from django.core.urlresolvers import reverse
from django.test import (
    Client,
    TestCase,
)

from myhpom.tests import factories


class NextStepsTestCase(TestCase):
    def setUp(self):
        self.client = Client()
        self.url = reverse('myhpom:next_steps')

    def test_no_upload_links_with_invalid_state(self):
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertNotContains(
            response,
            'Welcome to MindMyHealth',
        )
        self.assertNotContains(
            response,
            'Download a Template Advance Directive',
        )
        self.assertContains(
            response,
            'Thank you for registering',
        )

    def test_upload_links_with_valid_state(self):
        factories.StateAdvanceDirectiveFactory(
            state='NC',
        )
        response = self.client.get(
            reverse('myhpom:next_steps', kwargs={
                'state': 'nc',
            })
        )
        self.assertEqual(200, response.status_code)
        self.assertContains(
            response,
            'Welcome to MindMyHealth',
        )
        self.assertContains(
            response,
            'Download a Template Advance Directive',
        )
        self.assertNotContains(
            response,
            'Thank you for registering',
        )
