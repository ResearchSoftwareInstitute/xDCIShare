
from django import forms
from django.core.exceptions import ValidationError
from myhpom.validators import validate_date_in_past

class UploadRequirementsForm(forms.Form):
    valid_date = forms.DateField(validators=[validate_date_in_past])
