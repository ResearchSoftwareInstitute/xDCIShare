
from django import forms
from myhpom import models, validators


class SignupForm(forms.Form):
    first_name = forms.CharField(
        label='First Name',
        max_length=30,
        validators=[validators.name_validator],
        error_messages={'required': 'Please enter your first name'},
    )
    middle_name = forms.CharField(label='Middle Name', max_length=30, required=False)
    last_name = forms.CharField(
        label='Last Name',
        max_length=30,
        validators=[validators.name_validator],
        error_messages={'required': 'Please enter your last name'},
    )
    email = forms.EmailField(
        label='Email Address',
        validators=[validators.email_validator],
        error_messages={'required': 'Please enter a valid email address'},
    )
    password = forms.CharField(
        label='Enter a Password',
        widget=forms.PasswordInput,
        validators=[validators.password_validator],
        error_messages={'required': 'Please enter a password'},
    )
    password_confirm = forms.CharField(
        label='Confirm Password',
        widget=forms.PasswordInput,
        error_messages={'required': 'Please enter the same password again'},
    )
    state = forms.ChoiceField(
        label='State of Residence',
        choices=((state.name, state.title) for state in models.State.objects.all()),
        required=True,
        error_messages={'required': 'Please select your state'},
    )
    accept_tos = forms.BooleanField(
        label="I Agree to the Terms and Conditions of the services provided.",
        required=True,
        error_messages={'required': 'Please agree to the Terms and Conditions'},
    )

    def clean(self):
        cleaned_data = forms.Form.clean(self)
        password = cleaned_data.get("password")
        password_confirm = cleaned_data.get("password_confirm")

        if password != password_confirm:
            self.add_error('password_confirm', "Please enter exactly the same password again")

        return cleaned_data