import re
from django.core.exceptions import ValidationError
from django.core.validators import EmailValidator, RegexValidator
from django.contrib.auth.models import User

# First Name, Last Name: At least one alphanumeric character.
name_validator = RegexValidator(
    regex=r'\w',
    flags=re.U,
    message='Please enter your name'
)

# Email: valid email address
email_validator = EmailValidator()

# Email is not already taken
def email_not_taken_validator(email):
    if len(User.objects.filter(email=email)) > 0:
        raise ValidationError(u'Email already in use.')

# Password: At least 8 chars total, 1 uppercase, lowercase, digit, special char.
def password_validator(password):
    errors = []
    if len(password) < 8:
        errors.append(u'8 characters total')
    if re.search(r"[a-z]", password) is None:
        errors.append(u'1 lowercase letter (a-z)')
    if re.search(r"[A-Z]", password) is None:
        errors.append(u'1 uppercase letter (A-Z)')
    if re.search(r"\d", password) is None:
        errors.append(u'1 number (0-9)')
    if re.search(r"[!\@\#\$\%\^\*\(\)\_\+\-\=]", password) is None:
        errors.append(u'1 special character (! @ # $ % ^ * ( ) _ + - =)')
    if len(errors) > 0:
        raise ValidationError(u'Please enter a password with at least ' + u', '.join(errors))

