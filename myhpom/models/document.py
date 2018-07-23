import os

from .user import User
from django.db import models
from myhpom.validators import validate_date_in_past


class AdvanceDirective(models.Model):
    """ A user's Advance Directive. """

    user = models.OneToOneField(User)

    document = models.FileField(
        upload_to='myhpom/advance_directives',
        help_text='The document representing this user\'s Advance Directive.',
    )
    original_filename = models.CharField(
        max_length=512,
        blank=True,
    )
    valid_date = models.DateField(
        help_text='Date that this document is legally valid.',
        validators=[validate_date_in_past],
    )
    share_with_ehs = models.BooleanField(
        help_text=('True when user this document can be shared with the user\'s healthcare system.')
    )

    @property
    def filename(self):
        return self.original_filename or os.path.basename(self.document.name)
