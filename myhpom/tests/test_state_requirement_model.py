from django.test import TestCase
from myhpom.models import StateRequirements


class StateRequirementModelTestCase(TestCase):
    """
    * state => State: the state in which this requirement applies (REQUIRED)
    * position: the ordered position of the requirement in the list for this state (REQUIRED)
    * description: a textual description of the requirement (REQUIRED)
    * UNIQUE(state, order) -- protect against multiple items in the same position
    * UNIQUE(state, description) -- protect against multiple items with the same description

    """
