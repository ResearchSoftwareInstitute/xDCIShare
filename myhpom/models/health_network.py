from django.db import models
from django.core.exceptions import ValidationError
from .state import State

PRIORITY = {0: u"Primary Network", 1: u"Additional Network", 2: u"Independent System"}


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
        unique_together = (('state', 'name'),)


def health_network_pre_save_receiver(sender, instance, **kwargs):
    """
    * Ensure that the HealthNetwork fields are valid before saving:
        * priority: in PRIORITY.keys()
    """
    if instance.priority not in PRIORITY.keys():
        raise ValidationError("priority must be in %r" % PRIORITY.keys())


models.signals.pre_save.connect(health_network_pre_save_receiver, sender=HealthNetwork)
