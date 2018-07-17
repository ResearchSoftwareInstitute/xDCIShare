from django import forms
from myhpom.models import AdvanceDirective


class UploadRequirementsForm(forms.ModelForm):
    """ Capture the valid_date for the user's AD """

    class Meta:
        model = AdvanceDirective
        fields = ['valid_date']


class SharingForm(forms.ModelForm):
    """ Update the sharing settings for the user's AD """

    class Meta:
        model = AdvanceDirective
        fields = ['share_with_ehs']
