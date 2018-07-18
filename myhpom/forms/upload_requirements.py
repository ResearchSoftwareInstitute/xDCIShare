from django import forms

from myhpom.models import AdvanceDirective


class SharingForm(forms.ModelForm):
    """ Update the sharing settings for the user's AD """
    class Meta:
        model = AdvanceDirective
        fields = [
            'user',
            'document',
            'share_with_ehs',
        ]
