import re
from datetime import date

from django.contrib.auth.models import User
from django.core.exceptions import ValidationError
from django.core.validators import EmailValidator, RegexValidator

# First Name, Last Name: At least one alphanumeric character.
name_validator = RegexValidator(regex=r'\w', flags=re.U, message='Please enter your name')

# Email: valid email address
email_validator = EmailValidator()

# Email is not already taken
def email_not_taken_validator(email):
    if User.objects.filter(email=email).exists():
        raise ValidationError(u'Email already in use.')


# Password: At least 8 chars total, 1 uppercase, lowercase, digit, special char.
def password_validator(password):
    if (
        len(password) < 8
        or re.search(r"[a-z]", password) is None
        or re.search(r"[A-Z]", password) is None
        or re.search(r"\d", password) is None
        or re.search(r"[!\@\#\$\%\^\*\(\)\_\+\-\=]", password) is None
    ):
        raise ValidationError(
            # non-breaking spaces for better display formatting
            u"Please enter a password 8 characters or longer with at least 1\u00a0lowercase, "
            + u"1\u00a0uppercase, 1\u00a0number, and 1\u00a0special character "
            + u"\u00a0".join(u"( @ # $ % ^ * ( ) _ + - = )".split())
        )


def validate_date_in_past(value):
    if value > date.today():
        raise ValidationError("Please select a valid date on or before today.")


def validate_not_blank(value):
    if (
        value is None
        or (isinstance(value, unicode) and unicode(value.strip()) == u'')
        or (isinstance(value, str) and str(value.strip()) == '')
    ):
        raise ValidationError("A blank value is not allowed.")
