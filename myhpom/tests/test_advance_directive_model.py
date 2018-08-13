from django.core.files.uploadedfile import SimpleUploadedFile
from django.test import TestCase
from django.utils.timezone import now
from mock import MagicMock

from myhpom.models import AdvanceDirective
from myhpom.models.document import remove_documents_on_delete
from myhpom.tests.factories import UserFactory


class RemoveDocumentsOnDeleteTest(TestCase):

    def test_a_file(self):
        # When an AD is deleted its corresponding file should be deleted from
        # the system
        user = UserFactory()
        document = SimpleUploadedFile('afile.pdf', 'content')
        directive = AdvanceDirective(
            user=user, share_with_ehs=False, document=document, valid_date=now())
        directive.save()

        directive.document.storage = MagicMock()
        remove_documents_on_delete(None, directive, 'default')
        self.assertTrue(directive.document.storage.delete.called)
        directive.delete()

        # When there is no document associated with the AD, nothing happens:
        directive = AdvanceDirective(
            user=user, share_with_ehs=False, valid_date=now())
        directive.save()

        directive.document.storage = MagicMock()
        remove_documents_on_delete(None, directive, 'default')
        self.assertFalse(directive.document.storage.delete.called)
