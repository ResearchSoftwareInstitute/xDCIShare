from django.db import models
from .state import State


class StateRequirement(models.Model):
    """an advance directive requirement for a given state.
    * state => State: the state in which this requirement applies. If null, global to all states.
    * position: the ordered position of the requirement in the list for this state (REQUIRED)
    * text: a textual description of the requirement (REQUIRED)
    * UNIQUE(state, order) -- protect against multiple items in the same position
    * UNIQUE(state, text) -- protect against multiple items with the same text
    """

    state = models.ForeignKey(State, on_delete=models.CASCADE, null=True, blank=True)
    position = models.PositiveSmallIntegerField()
    text = models.CharField(max_length=1024)

    class Meta:
        unique_together = (('state', 'position'), ('state', 'text'))
        ordering = ['-state', 'position']  # state=None (global requirements) first

    @classmethod
    def for_state(Class, state):
        """
        return the ordered list of requirements for this state, includes global then specific:
        """
        return Class.objects.filter(models.Q(state=None) | models.Q(state=state))
