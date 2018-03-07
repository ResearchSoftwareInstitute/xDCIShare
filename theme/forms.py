import requests

from django import forms
from django.utils.translation import ugettext
from django.contrib.auth.models import User
from localflavor.us.forms import USZipCodeField

from mezzanine.generic.models import Rating
from django_comments.forms import CommentSecurityForm
from mezzanine.conf import settings

from .models import UserProfile
from hs_core.hydroshare.users import create_account

from hydroshare import settings as hydroshare_settings


class RatingForm(CommentSecurityForm):
    """
    Form for a rating. Subclasses ``CommentSecurityForm`` to make use
    of its easy setup for generic relations.
    """
    value = 1

    def __init__(self, request, *args, **kwargs):
        self.request = request
        super(RatingForm, self).__init__(*args, **kwargs)

    def clean(self):
        """
        Check unauthenticated user's cookie as a light check to
        prevent duplicate votes.
        """
        bits = (self.data["content_type"], self.data["object_pk"])
        self.current = "%s.%s" % bits
        request = self.request
        self.previous = request.COOKIES.get("mezzanine-rating", "").split(",")
        already_rated = self.current in self.previous
        if already_rated and not self.request.user.is_authenticated():
            raise forms.ValidationError(ugettext("Already rated."))
        return 1

    def save(self):
        """
        Saves a new rating - authenticated users can update the
        value if they've previously rated.
        """
        user = self.request.user
        rating_value = 1
        rating_name = self.target_object.get_ratingfield_name()
        rating_manager = getattr(self.target_object, rating_name)
        if user.is_authenticated():
            try:
                rating_instance = rating_manager.get(user=user)
            except Rating.DoesNotExist:
                rating_instance = Rating(user=user, value=rating_value)
                rating_manager.add(rating_instance)
            else:
                if rating_instance.value != int(rating_value):
                    rating_instance.value = rating_value
                    rating_instance.save()
                else:
                    # User submitted the same rating as previously,
                    # which we treat as undoing the rating (like a toggle).
                    rating_instance.delete()
        else:
            rating_instance = Rating(value=rating_value)
            rating_manager.add(rating_instance)
        return rating_instance


class SignupForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['password1', 'password2', 'email', 'zip_code', 'username',
                  'first_name', 'last_name', 'Captcha', 'challenge', 'response']

    password1 = forms.CharField(label="Password", widget=forms.PasswordInput())
    password2 = forms.CharField(label="Confirm Password", widget=forms.PasswordInput())

    zip_code = USZipCodeField()

    def __init__(self, request, *args, **kwargs):
        self.request = request
        super(SignupForm, self).__init__(*args, **kwargs)

    def verify_captcha(self):
        url = hydroshare_settings.RECAPTCHA_VERIFY_URL
        values = {
            'secret': hydroshare_settings.RECAPTCHA_SECRET_KEY,
            'response': self.request.POST.get('g-recaptcha-response')
        }
        response = requests.post(url, values)
        result = response.json()
        if(result["success"]):
            return (True, [])

        return (False, result["error-codes"])


    def clean(self):
        success, error_codes = self.verify_captcha()

        if not success:
            self.add_error(None, " ".join(error_codes))


    def clean_password2(self):
        data = self.cleaned_data
        if data["password1"] == data["password2"]:
            data["password"] = data["password1"]
            return data
        else:
            raise forms.ValidationError("Password must be confirmed")

    def save(self, *args, **kwargs):
        data = self.cleaned_data
        user = create_account(
            email=data['email'],
            username=data['username'],
            first_name=data['first_name'],
            last_name=data['last_name'],
            superuser=False,
            password=data['password'],
            active=False,
        )
        user.userprofile.zip_code = data['zip_code']
        user.userprofile.save()
        return user


class UserForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'email']

    def clean_first_name(self):
        data = self.cleaned_data['first_name']
        if len(data.strip()) == 0:
            raise forms.ValidationError("First name is a required field.")
        return data

    def clean_last_name(self):
        data = self.cleaned_data['last_name']
        if len(data.strip()) == 0:
            raise forms.ValidationError("Last name is a required field.")
        return data

    def clean_email(self):
        data = self.cleaned_data['email']
        if len(data.strip()) == 0:
            raise forms.ValidationError("Email is a required field.")
        return data


class UserProfileForm(forms.ModelForm):
    class Meta:
        model = UserProfile
        exclude = ['user', 'public', 'create_irods_user_account']

    def clean_organization(self):
        data = self.cleaned_data['organization']
        if len(data.strip()) == 0:
            raise forms.ValidationError("Organization is a required field.")
        return data

    def clean_country(self):
        data = self.cleaned_data['country']
        if len(data.strip()) == 0:
            raise forms.ValidationError("Country is a required field.")
        return data

    def clean_state(self):
        data = self.cleaned_data['state']
        if len(data.strip()) == 0:
            raise forms.ValidationError("State is a required field.")
        return data
