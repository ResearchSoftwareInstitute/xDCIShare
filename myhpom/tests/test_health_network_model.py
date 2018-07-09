
from django.test import TestCase
from django.core.exceptions import ValidationError
from django.db import IntegrityError
from myhpom.models.health_network import HealthNetwork, PRIORITY
from myhpom.models.state import State


class HealthNetworkModelTestCase(TestCase):
    """
    * with objects.all(), ordering should be by priority, name
    * health networks should be unique for (state, name)
        - can't add the same network name twice for the same state.
        - can add the same network name for two different states.
    * priority must be within [0, 1, 2]
    """

    def test_health_networks_ordering(self):
        """ordering of health networks should be by priority, name
        """
        state = State.objects.get(name="NC")
        hns = HealthNetwork.objects.filter(state=state)
        hns_p = {n: [hn for hn in hns if hn.priority == n] for n in PRIORITY.keys()}
        self.assertEqual(
            hns_p[0], hns[: len(hns_p[0])], msg="priority 0 health networks should be first"
        )
        self.assertEqual(
            hns_p[1],
            hns[len(hns_p[0]) : len(hns_p[0]) + len(hns_p[1])],
            msg="priority 1 health networks should be second",
        )
        self.assertEqual(
            hns_p[2],
            hns[len(hns_p[0]) + len(hns_p[1]) : len(hns_p[0]) + len(hns_p[1]) + len(hns_p[2])],
            msg="priority 2 health networks should be third",
        )

    def test_unique_health_networks_per_state(self):
        """creating a network with the same name in a different state is fine,
        but creating a network with the same name in the same state raises an IntegrityError
        """
        state1 = State.objects.get(name="NC")
        state2 = State.objects.get(name="SC")
        kwargs = dict(priority=0, name="My Non-existent Health Network")
        hn1 = HealthNetwork.objects.create(state=state1, **kwargs)
        hn2 = HealthNetwork.objects.create(state=state2, **kwargs)
        self.assertRaises(IntegrityError, HealthNetwork.objects.create, state=state2, **kwargs)

    def test_add_wrong_priority(self):
        """adding a network with an unsupported priority raises an error
        """
        state = State.objects.get(name="NC")
        bad_priority = len(list(PRIORITY.keys()))   # 1 higher than the available priorities.
        kwargs = dict(state=state, priority=bad_priority, name="My Non-existent Health Network")
        self.assertRaises(ValidationError, HealthNetwork.objects.create, **kwargs)
