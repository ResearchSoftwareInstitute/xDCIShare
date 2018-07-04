from django.db import models
from .user import User
from .state import State


class UserDetails(models.Model):
    """Added user details to that are included when the user signs up."""

    user = models.OneToOneField(User)
    state = models.ForeignKey(State, on_delete=models.SET_NULL, null=True, blank=True)
    middle_name = models.CharField(max_length=30, null=True, blank=True)
    tos_affirmed = models.NullBooleanField()
