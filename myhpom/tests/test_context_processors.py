from django.core.urlresolvers import reverse
from django.test import TestCase


class ContactEmailProcessorTestCase(TestCase):
    def test_email_is_available(self):
        for example_email in ('foo@example.com', 'bar@example.com', ):
            with self.settings(CONTACT_EMAIL=example_email):
                # arbitrary view: they should all have it!
                response = self.client.get(reverse('myhpom:home'))
                self.assertIn('contact_email', response.context)
                self.assertEqual(example_email, response.context['contact_email'])
