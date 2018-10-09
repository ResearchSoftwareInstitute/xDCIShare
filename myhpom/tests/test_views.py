from django.core.urlresolvers import reverse
from django.test import TestCase
from django.core.files.uploadedfile import SimpleUploadedFile
from myhpom.models import State


class StateTemplateTest(TestCase):

    def test_no_such_state(self):
        url = reverse('myhpom:state_template', kwargs={'state': 'ZZ'})
        result = self.client.get(url)
        self.assertEqual(404, result.status_code)

    def test_existing_state(self):
        # Even if the state exists it will return a 404 if there is no template:
        url = reverse('myhpom:state_template', kwargs={'state': 'NC'})
        result = self.client.get(url)
        self.assertEqual(404, result.status_code)

        # With an AD it should redirect to the URL of the template:
        state = State.objects.filter(name='NC')
        state.update(advance_directive_template=SimpleUploadedFile('afile.txt', ''))
        state = state.first()
        result = self.client.get(url)
        self.assertRedirects(
            result, state.advance_directive_template.url, fetch_redirect_response=False)
