from django.core.urlresolvers import reverse
from django.test import TestCase
from django.utils.timezone import now


class SendVerificationViewTestCase(TestCase):
    """
    + Already verified user: message.info = "Your email address is already verified."
    + Unverified user: 
        + message.info = "Please check your email to verify your address."
        + user's verification code has changed because UserDetails.reset_verification() is done.
        + test the send_mail call?
    + Result: 
        + default: returns redirect to myhpom:dashboard
        + if called with return_redirect=False, returns None (as when called from signup)
    """


class VerifyAccountViewTestCase(TestCase):
    """
    + Already verified user: message.info = "Your email address is already verified."
    + Unverified user, correct code (matches UserDetails.verification_code):
        + message.success = "Your email address is now verified."
        + UserDetails.verification_completed is not None 
    + Unverified user, incorrect code (does not match UserDetails.verification_code):
        + message.error = "The verification code is invalid."
    """
