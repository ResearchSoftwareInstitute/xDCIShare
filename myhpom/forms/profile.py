from django import forms
from myhpom import validators
from myhpom.models import UserDetails, State
from myhpom.models.user import User


class EditUserProfileForm(forms.ModelForm):
    """This form combines data from the User and the UserDetails models into a single form.
    see EditUserDetailsForm, below, for the fields that are handled by the UserDetails model.
    """
    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'email']

    first_name = forms.CharField(
        label='First Name',
        max_length=30,
        validators=[validators.name_validator],
        error_messages={'required': 'Please enter your first name.'},
    )
    last_name = forms.CharField(
        label='Last Name',
        max_length=30,
        validators=[validators.name_validator],
        error_messages={'required': 'Please enter your last name.'},
    )
    email = forms.EmailField(label='Email Address', validators=[validators.email_validator])

    def __init__(self, data=None, instance=None):
        super(forms.ModelForm, self).__init__(data=data, instance=instance)
        if instance is not None:
            self.UserDetailsForm = EditUserDetailsForm(data=data, instance=instance.userdetails)
        else:
            self.UserDetailsForm = None

    def is_valid(self):
        return (
            super(forms.ModelForm, self).is_valid()
            and self.UserDetailsForm is not None
            and self.UserDetailsForm.is_valid()
        )

    @property
    def errors(self):
        errs = super(forms.ModelForm, self).errors
        errs.update(**self.UserDetailsForm.errors)
        return errs

    def save(self, commit=True):
        instance = super(forms.ModelForm, self).save(commit=commit)
        instance.userdetails = self.UserDetailsForm.save(commit=commit)
        return instance


class EditUserDetailsForm(forms.ModelForm):
    class Meta:
        model = UserDetails
        fields = ['middle_name', 'zip_code', 'birthdate', 'gender', 'is_organ_donor']

    state = forms.ChoiceField(
        label='State of Residence',
        choices=((state.name, state.title) for state in State.objects.all()),
        required=True,
        error_messages={'required': 'Please select your state.'},
    )

    def save(self, commit=True):
        instance = super(forms.ModelForm, self).save(commit=False)
        state = State.objects.filter(name=self.cleaned_data['state']).first()
        if state is None:
            raise ValueError("State not found: %s" % self.cleaned_data['state'])
        instance.state = state
        if commit == True:
            instance.save()
        return instance
