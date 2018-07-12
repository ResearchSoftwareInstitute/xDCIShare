from django.db import models
from .state_requirement import StateRequirement

class StateRequirementLink(models.Model):
    """an FAQ link for a given StateRequirement (listed under the requirement checkbox)
    * requirement => StateRequirement: to which this Link applies (REQUIRED)
    * text: The text to display in the link
    * href: the href for the link
    """
    requirement = models.ForeignKey(StateRequirement, on_delete=models.CASCADE)
    text = models.CharField(max_length=1024)
    href = models.CharField(max_length=1024)

