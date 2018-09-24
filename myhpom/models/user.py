from django.db import models
from django.contrib.auth.models import User
from myhpom import validators
import base64
import hashlib

"""
* Connect a pre_save receiver/hook to the User model, and use this model in all imports
* monkeypatch User.__unicode__ to return the email address
"""

User.__unicode__ = lambda u: u.email


def get_username(email):
    """unique username as hash of the email.
    Must be <= 30 characters long. 30, Django? Really?
    """
    h = hashlib.new('sha1')  # the longest hash algorithm that base64-encodes at <= 30 characters
    h.update(email)
    return base64.urlsafe_b64encode(h.digest()).strip('=')


# replace the built-in get_full_name() with one that includes the middle_name, if any.
User.get_full_name = lambda self: ' '.join(
    name
    for name in [self.first_name, self.userdetails.middle_name, self.last_name]
    if name != ''  # in the not-uncommon case that one of the names is blank
)


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
    if instance.username != get_username(instance.email) and hasattr(instance, 'userdetails'):
        instance.userdetails.reset_verification()
    instance.username = get_username(instance.email)


models.signals.pre_save.connect(user_pre_save_receiver, sender=User)
