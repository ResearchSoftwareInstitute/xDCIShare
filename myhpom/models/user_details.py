from django.db import models
from .user import User
from .state import State
from .health_network import HealthNetwork


GENDER_CHOICES = [(k, k) for k in ['Male', 'Female', 'Non-Binary / Fluid', 'Non-Gender-Conforming']]


class UserDetails(models.Model):
    """Added user details to that are included when the user signs up.
    * user = the User object that these details are associated with
    * state = the State that this user belongs to.
    * middle_name = because it's not in the User model
    * accept_tos = the user has checked/affirmed the "Terms and Conditions".
    * health_network = the user's selected health network
    """

    user = models.OneToOneField(User)
    accept_tos = models.NullBooleanField(
        help_text="Whether the user has accepted the Terms of Service."
    )
    state = models.ForeignKey(
        State, on_delete=models.SET_NULL, null=True, blank=True,
        help_text="The state in which the user receives health care.",
    )
    middle_name = models.CharField(
        max_length=30, null=True, blank=True, help_text="The user's middle name, if any."
    )
    health_network = models.ForeignKey(
        HealthNetwork, on_delete=models.SET_NULL, null=True,
        help_text="The health network that the user belongs to."
    )
    custom_provider = models.CharField(
        max_length=1024, null=True, blank=True,
        help_text="The name of the user's health care provider, if not in our database."
    )
    # zip + 4 = 10 characters
    zip_code = models.CharField(
        max_length=10, null=True, blank=True,
        help_text="The zip code for the user's health care address."
    )
    # free form phone number, long enough to include ext. etc.
    phone = models.CharField(
        max_length=32, null=True, blank=True,
        help_text="Phone number at which the user can be contacted."
    )
    birthdate = models.DateField(
        null=True, blank=True,
        help_text="The user's date of birth."
    )
    # gender according to the GENDER_CHOICES above
    gender = models.CharField(max_length=32, null=True, blank=True, choices=GENDER_CHOICES, 
        help_text="The user's gender self-identification."
    )
    # organ donor status
    is_organ_donor = models.BooleanField(default=False, 
        help_text="Whether the user is registered as an organ donor."
    )
