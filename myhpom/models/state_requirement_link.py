import sys
from django.db import models
from django.core.exceptions import ValidationError
from .state_requirement import StateRequirement
from myhpom.validators import validate_not_blank


class StateRequirementLink(models.Model):
    """an FAQ link for a given StateRequirement (listed under the requirement checkbox)
    * requirement => StateRequirement: to which this Link applies (REQUIRED)
    * text: The text to display in the link
    * href: the href for the link
    """

    requirement = models.ForeignKey(StateRequirement, on_delete=models.CASCADE)
    text = models.CharField(max_length=1024)
    href = models.CharField(max_length=1024)


def state_requirement_link_pre_save_receiver(sender, instance, **kwargs):
    """
    * Ensure that the StateRequirementLink fields are valid before saving:
        * href: not blank
        * text: not blank
    """
    for key in ['href', 'text']:
        validate_not_blank(instance.__dict__.get(key))

models.signals.pre_save.connect(
    state_requirement_link_pre_save_receiver, sender=StateRequirementLink
)
