from django.test import TestCase
from django.core.exceptions import ValidationError
from django.db import transaction, IntegrityError
from myhpom.models import State, StateRequirement


class StateRequirementModelTestCase(TestCase):
    def setUp(self):
        # get a state that has both global and non-global requirements: NC
        self.state = State.objects.get(name="NC")
        self.state_reqs = list(StateRequirement.objects.filter(state=self.state))
        self.global_reqs = list(StateRequirement.objects.filter(state=None))

    def test__create_invalid(self):
        """
        cannot create StateRequirement without the required fields: text.
        """
        invalid_data = [
            {'text': ''},  # needs valid text
        ]
        for data in invalid_data:
            with transaction.atomic():
                self.assertRaises(ValidationError, StateRequirement.objects.create, **data)

    def test__create_not_unique(self):
        """
        cannot create StateRequirement that violates uniqueness: (state, text)
        """
        invalid_data = [
            # state-specific
            {
                'state': self.state,
                'text': self.state_reqs[0].text,  # violate uniqueness for state, text
            },
            {
                'state': None,
                'text': self.global_reqs[0].text,  # violate uniqueness for state, text
            },
        ]
        for data in invalid_data:
            with transaction.atomic():
                self.assertRaises(IntegrityError, StateRequirement.objects.create, **data)

    def test__for_state_ordering(self):
        """
        StateRequirement QuerySet for any state orders by global (state=null) first, then by id
        """
        requirements = list(StateRequirement.for_state(self.state))
        # global requirements should come first, followed by state-specific requirements
        self.assertEqual(self.global_reqs, requirements[: len(self.global_reqs)])
        self.assertEqual(self.state_reqs, requirements[len(self.global_reqs) :])
        # each set of requirements should be in id order
        prev_id = -1
        for req in requirements[: len(self.global_reqs)]:  # global ordering
            self.assertGreater(req.id, prev_id)
            prev_id = req.id
        prev_id = -1
        for req in requirements[len(self.global_reqs) :]:  # state-specific ordering
            self.assertGreater(req.id, prev_id)
            prev_id = req.id

    def test__save_null_state(self):
        """
        If state is null, it should allow saving an existing instance
        """
        data = {'state': None, 'text': 'A non-existent global requirement'}
        req = StateRequirement.objects.create(**data)
        req.text = 'An edited non-existent global requirement.'
        req.save()
