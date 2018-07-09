from django.test import TestCase
from django.core.files.uploadedfile import SimpleUploadedFile
from myhpom.models import State


class StateModelTestCase(TestCase):

    def test_order_by_ad(self):
        # Files with ADs should be at the front of the list, and they should be
        # in alphabetical order (regardless of the template filename)
        NC = State.objects.filter(name='NC')
        SC = State.objects.filter(name='SC')
        NC.update(advance_directive_template=SimpleUploadedFile('afile.txt', ''))
        SC.update(advance_directive_template=SimpleUploadedFile('zfile.txt', ''))

        first_states = State.objects.order_by_ad()[:2]
        self.assertEqual(list(first_states), [NC.first(), SC.first()])
