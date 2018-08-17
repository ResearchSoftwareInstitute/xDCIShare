import os
from django.core.files.uploadedfile import SimpleUploadedFile
from django.test import TestCase
from django.utils.timezone import now
from mock import MagicMock

from myhpom.models import AdvanceDirective
from myhpom.models.document import remove_documents_on_delete
from myhpom.tests.factories import UserFactory

PDF_FILENAME = os.path.join(os.path.dirname(__file__), 'fixtures', 'afile.pdf')


class RemoveDocumentsOnDeleteTest(TestCase):
    def test_a_file(self):
        # When an AD is deleted its corresponding file and thumbnail should be deleted from
        # the system. (this test requires an actual PDF)
        user = UserFactory()
        with open(PDF_FILENAME, 'rb') as f:
            document = SimpleUploadedFile(os.path.basename(PDF_FILENAME), f.read())
        directive = AdvanceDirective(
            user=user, share_with_ehs=False, document=document, valid_date=now())
        directive.thumbnail = SimpleUploadedFile(
            os.path.splitext(os.path.basename(PDF_FILENAME))[0] + '.jpg',
            directive.render_thumbnail_data(),
        )
        directive.save()
        self.assertTrue(directive.document.storage.exists(directive.document.name))
        self.assertTrue(directive.thumbnail.storage.exists(directive.thumbnail.name))

        directive.document.storage = MagicMock()
        directive.thumbnail.storage = MagicMock()
        remove_documents_on_delete(None, directive, 'default')
        self.assertTrue(directive.document.storage.delete.called)
        self.assertTrue(directive.thumbnail.storage.delete.called)
        directive.delete()

        # When there is no document associated with the AD, nothing happens:
        directive = AdvanceDirective(
            user=user, share_with_ehs=False, valid_date=now())
        directive.save()

        directive.document.storage = MagicMock()
        remove_documents_on_delete(None, directive, 'default')
        self.assertFalse(directive.document.storage.delete.called)

