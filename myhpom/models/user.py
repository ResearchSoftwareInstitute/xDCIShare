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
            * if the email has changed (!= username), reset user verification_code 
                (this is also true if the user is a new user)
    * Set the username to the email
    """
    validators.name_validator(instance.first_name)
    validators.name_validator(instance.last_name)
    validators.email_validator(instance.email)
    if instance.email != instance.username and hasattr(instance, 'userdetails'):
        instance.userdetails.reset_verification()
    instance.username = instance.email


models.signals.pre_save.connect(user_pre_save_receiver, sender=User)
