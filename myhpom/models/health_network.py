from django.db import models
from .state import State

PRIORITY = {
    0: u"Primary Network",
    1: u"Additional Network",
    2: u"Independent System",
}

class HealthNetwork(models.Model):
    """a list of health networks for each state
    * state => State: the state in which this health network is available.
        (a network could conceivably exist in more than one state, but in practice they don't;
        if they do, we here treat them as two separate networks anyway.)
    * name: the displayed name of the health network
    * priority: which list to display this network on (from PRIORITY dict)
    """
    state = models.ForeignKey(State, on_delete=models.CASCADE)
    name = models.CharField(max_length=1024)
    priority = models.PositiveSmallIntegerField(choices=PRIORITY.items())

    class Meta:
        ordering = ['priority', 'name']
