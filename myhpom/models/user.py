from django.db import models
from django.contrib.auth.models import User
from myhpom import validators

"""Connect a pre_save receiver/hook to the User model, and use this model in all imports"""


def user_pre_save_receiver(sender, instance, **kwargs):
    """
    * Ensure that the User fields are valid before saving:
        * first_name
        * last_name
        * email
    * If the username hasn't been set, set it to the email
    """
    validators.name_validator(instance.first_name)
    validators.name_validator(instance.last_name)
    validators.email_validator(instance.email)
    if instance.username in [None, '']:
        instance.username = instance.email


models.signals.pre_save.connect(user_pre_save_receiver, sender=User)
