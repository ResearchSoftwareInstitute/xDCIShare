from django import forms
from django.conf import settings
from django.core.files.uploadedfile import SimpleUploadedFile
from myhpom.models import AdvanceDirective

import os
import uuid


class UploadRequirementsForm(forms.ModelForm):
    """ Capture the valid_date for the user's AD """

    class Meta:
        model = AdvanceDirective
        fields = ['valid_date', 'document', 'thumbnail', 'original_filename']

    def clean_document(self):
        if 'document' in self.cleaned_data:
            document = self.cleaned_data['document']

            errors = []
            if not document.name.lower().endswith('.pdf'):
                errors.append(forms.ValidationError('File can only be PDF format'))
            if document.size > settings.MAX_AD_SIZE:
                errors.append(forms.ValidationError(
                    'File must be smaller than %d megabytes' % (settings.MAX_AD_SIZE / 1024 / 1024))
                )

            if len(errors) > 0:
                raise forms.ValidationError(errors)

            return document

    def clean(self):
        data = self.cleaned_data
        if 'document' in data:
            data['original_filename'] = data['document'].name
            name, extension = os.path.splitext(data['document'].name)
            data['document'].name = "%s-%s%s" % (name, str(uuid.uuid4())[:6], extension)

            # (try to) generate a thumbnail of the document
            # NOTE: We do this here at present because we don't want to keep the PDF
            # if the thumbnail can't be created (= corrupt PDF = invalid form). This
            # assumes that processing is done in-request. In future, we will want to
            # move the thumbnail processing into an asynchronous queue, which means
            # that this simple validation setup will need to be refactored into
            # storing the document followed by tracking its state through processing.
            try:
                thumbnail_name = os.path.splitext(data['document'].name)[0] + '.jpg'
                thumbnail_data = AdvanceDirective(document=data['document']).render_thumbnail_data()
                data['thumbnail'] = SimpleUploadedFile(thumbnail_name, thumbnail_data)
            except:
                data['document'] = ''
                self.add_error(
                    'document',
                    'The uploaded PDF file was corrupt or invalid and could not be saved.',
                )
        return data


class SharingForm(forms.ModelForm):
    """ Update the sharing settings for the user's AD """

    class Meta:
        model = AdvanceDirective
        fields = ['share_with_ehs']
