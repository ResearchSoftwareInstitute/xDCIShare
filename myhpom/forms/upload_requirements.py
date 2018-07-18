from django import forms
from django.utils.timezone import now

from myhpom.models import AdvanceDirective


class UploadADForm(forms.ModelForm):
    valid_date = forms.DateField(required=False)
    share_with_ehs = forms.BooleanField(required=False)

    def clean_valid_date(self):
        data = self.cleaned_data['valid_date']
        if not data:
            return now()
        return data

    class Meta:
        model = AdvanceDirective
        fields = [
            'user',
            'document',
            'valid_date',
            'share_with_ehs',
        ]


class SharingForm(forms.ModelForm):
    """ Update the sharing settings for the user's AD """
    class Meta:
        model = AdvanceDirective
        fields = [
            'share_with_ehs',
        ]
