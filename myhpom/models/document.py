import os

from .user import User
from django.db import models


class AdvanceDirective(models.Model):
    """ A user's Advance Directive. """

    user = models.OneToOneField(User)

    document = models.FileField(
        upload_to='myhpom/advance_directives',
        help_text='The document representing this user\'s Advance Directive.',
    )
    valid_date = models.DateField(
        help_text='Date that this document is legally valid.'
    )
    share_with_ehs = models.BooleanField(
        help_text=('True when user this document can be shared with the user\'s healthcare system.')
    )

    @property
    def filename(self):
        return os.path.basename(self.document.name)
