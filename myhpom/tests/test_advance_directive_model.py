import json
import os
from django.test import TestCase
from mock import MagicMock

from myhpom.tests.factories import AdvanceDirectiveFactory, CloudFactoryDocumentRunFactory
from myhpom.models import CloudFactoryDocumentRun
from myhpom.models.document import remove_documents_on_delete


class AdvanceDirectiveTest(TestCase):

    def test_remove_a_file(self):
        # When an AD is deleted its corresponding file and thumbnail should be deleted from
        # the system. (this test requires an actual PDF)
        directive = AdvanceDirectiveFactory()
        self.assertTrue(directive.document.storage.exists(directive.document.name))
        self.assertTrue(directive.thumbnail.storage.exists(directive.thumbnail.name))

        directive.document.storage = MagicMock()
        directive.thumbnail.storage = MagicMock()
        remove_documents_on_delete(None, directive, 'default')
        self.assertTrue(directive.document.storage.delete.called)
        self.assertTrue(directive.thumbnail.storage.delete.called)
        directive.delete()

        # When there is no document associated with the AD, nothing happens:
        directive = AdvanceDirectiveFactory(document=None)
        directive.document.storage = MagicMock()
        remove_documents_on_delete(None, directive, 'default')
        self.assertFalse(directive.document.storage.delete.called)

    def test_verification_succeeded(self):
        SUCCESS_DATA = open(os.path.join(
            os.path.dirname(__file__), 'fixtures/cloudfactory/callback_success.json')).read()

        # If the status is equal to a successful run, and all the outputs are
        # successful, then verification_succeeded will return True
        run = CloudFactoryDocumentRunFactory()
        ad = run.document_url.advancedirective

        run.save_response_content(SUCCESS_DATA)
        self.assertTrue(ad.verification_succeeded)

        # Even if the successful run is true, if the status is failed, so is
        # this the run:
        run.status = CloudFactoryDocumentRun.STATUS_ABORTED
        run.save()
        self.assertFalse(ad.verification_succeeded)

        # If a one of the outputs are false, then the run is not successful.
        failed_run = json.loads(SUCCESS_DATA)
        failed_run['units'][0]['output']['owner_name_matches'] = False
        run.save_response_content(json.dumps(failed_run))
        self.assertFalse(ad.verification_succeeded)

        # Especially if the status is aborted
        failed_run['status'] = CloudFactoryDocumentRun.STATUS_ABORTED
        run.save_response_content(json.dumps(failed_run))
        self.assertFalse(ad.verification_succeeded)
