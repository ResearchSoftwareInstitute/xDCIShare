from django import forms
from myhpom import validators
from myhpom.models import UserDetails, State
from myhpom.models.user import User


class EditUserForm(forms.ModelForm):
    """subform for EditProfileForm (below) to handle the User portion."""
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


class EditUserDetailsForm(forms.ModelForm):
    """subform for EditProfileForm (below) to handle the UserDetails portion."""
    class Meta:
        model = UserDetails
        fields = ['middle_name', 'state', 'zip_code', 'birthdate', 'gender', 'is_organ_donor']

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

