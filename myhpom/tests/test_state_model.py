
from django.test import TestCase
from myhpom.models import State


class StateModelTestCase(TestCase):
    """
    * State.objects.all() returns supported states first
    """

    def test_supported_states_first(self):
        states = State.objects.all()
        supported_states = [state for state in states if state.supported == True]
        assert (
            supported_states == states[: len(supported_states)]
        ), "supported states should be first"
