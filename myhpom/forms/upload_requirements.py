from django import forms
from django.conf import settings
from myhpom.models import AdvanceDirective


class UploadRequirementsForm(forms.ModelForm):
    """ Capture the valid_date for the user's AD """

    class Meta:
        model = AdvanceDirective
        fields = ['valid_date', 'document', 'original_filename']

    def clean_document(self):
        document = self.cleaned_data['document']
        if document is None:
            return None

        errors = []
        if not document.name.lower().endswith('.pdf'):
            errors.append(forms.ValidationError('File can only be PDF format'))
        if document.size > settings.MAX_AD_SIZE:
            errors.append(forms.ValidationError(
                'File must be smaller than %d megabytes' % (settings.MAX_AD_SIZE / 1024 / 1024)))

        if len(errors) > 0:
            raise forms.ValidationError(errors)

        return document

    def clean(self):
        data = self.cleaned_data
        if 'document' in data:
            data['original_filename'] = data['document'].name

        return data


class SharingForm(forms.ModelForm):
    """ Update the sharing settings for the user's AD """

    class Meta:
        model = AdvanceDirective
        fields = ['share_with_ehs']
