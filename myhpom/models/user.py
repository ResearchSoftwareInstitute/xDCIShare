from django.db import models
from django.contrib.auth.models import User
from myhpom import validators


def user_pre_save_receiver(sender, instance, **kwargs):
    validators.name_validator(instance.first_name)
    validators.name_validator(instance.last_name)
    validators.email_validator(instance.email)
    if instance.username in [None, '']:
        instance.username = instance.email


models.signals.pre_save.connect(user_pre_save_receiver, sender=User)
