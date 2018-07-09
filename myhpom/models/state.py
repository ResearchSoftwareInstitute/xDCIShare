from django.db import models


class State(models.Model):
    """a list of states to choose from: each MyHPOM user is in a state.
    * name = the two-letter state abbreviation
    * title = the full (common) name of the state (e.g., Rhode Island)
    * supported = if True, means that the state is supported by the app.
    """

    name = models.CharField(max_length=2, unique=True)
    title = models.CharField(max_length=1024)
    supported = models.NullBooleanField()  # if True, the state is a supported state

    class Meta:
        ordering = ['supported', 'name']  # puts the first=true fields before the first=null fields.
