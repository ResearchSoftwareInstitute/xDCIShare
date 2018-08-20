from django.test import TestCase
from django.core.exceptions import ValidationError
from django.db import transaction, IntegrityError
from myhpom.models import State, StateRequirement, StateRequirementLink


class StateRequirementLinkTestCase(TestCase):
    """
    * cannot create without required fields: requirement, text, href (all non-blank)
    """

    def test__valid_create(self):
        req = State.objects.get(name='NC').staterequirement_set.first()
        valid_data = {'requirement': req, 'text': 'Why?', 'href': 'http://example.com/because'}
        StateRequirementLink.objects.create(**valid_data)

    def test__invalid_create(self):
        req = State.objects.get(name='NC').staterequirement_set.first()
        valid_data = {'requirement': req, 'text': 'Why?', 'href': 'http://example.com/because'}
        
        for key in ['text', 'href']:
            data = {k: v for k, v in valid_data.items() if k != key}  # missing each key
            with transaction.atomic():
                with self.assertRaises(ValidationError) as cm:
                    StateRequirementLink.objects.create(**data)

        data = {k: v for k, v in valid_data.items() if k != 'requirement'}
        with transaction.atomic():
            with self.assertRaises(IntegrityError) as cm:
                StateRequirementLink.objects.create(**data)
