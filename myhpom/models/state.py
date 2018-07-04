from django.db import models


class State(models.Model):
    """a list of states to choose from: each MyHPOM user is in a state."""

    name = models.CharField(max_length=2, unique=True)
    title = models.CharField(max_length=1024)
    isfirst = models.NullBooleanField()  # if True, put at the top of the list; else null

    class Meta:
        ordering = ['isfirst', 'name']  # puts the first=true fields before the first=null fields.
