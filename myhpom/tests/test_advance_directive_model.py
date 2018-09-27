import json
import os
from django.test import TestCase
from mock import MagicMock

from myhpom.tests.factories import AdvanceDirectiveFactory, CloudFactoryDocumentRunFactory
from myhpom.models import CloudFactoryDocumentRun
from myhpom.models.document import remove_documents_on_delete

SUCCESS_DATA = open(os.path.join(
    os.path.dirname(__file__), 'fixtures/cloudfactory/callback_success.json')).read()


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
        # If the status is equal to a successful run, and all the outputs are
        # successful, then verification_succeeded will return True
        run = CloudFactoryDocumentRunFactory()
        ad = run.document_url.advancedirective

        run.save_response_data(SUCCESS_DATA)
        self.assertTrue(ad.verification_succeeded)

        # Even if the successful run is true, if the status is failed, so is
        # this the run:
        run.status = CloudFactoryDocumentRun.STATUS_ABORTED
        run.save()
        self.assertFalse(ad.verification_succeeded)

        # If a one of the outputs are false, then the run is not successful.
        failed_run = json.loads(SUCCESS_DATA)
        failed_run['units'][0]['output']['owner_name_matches'] = False
        run.save_response_data(json.dumps(failed_run))
        self.assertFalse(ad.verification_succeeded)

        # Especially if the status is aborted, it is not a success
        failed_run['status'] = CloudFactoryDocumentRun.STATUS_ABORTED
        run.save_response_data(json.dumps(failed_run))
        self.assertFalse(ad.verification_succeeded)

        # We expect a certain set of keys in the output - if they are missing,
        # that is also not a success:
        failed_run['status'] = CloudFactoryDocumentRun.STATUS_PROCESSED
        failed_run['units'][0]['output'] = {}
        run.save_response_data(json.dumps(failed_run))
        self.assertFalse(ad.verification_succeeded)

    def test_verification_in_progress(self):
        # When there are no runs associated with an AD, then it isn't in
        # progress
        ad_wo_run = AdvanceDirectiveFactory()
        self.assertFalse(ad_wo_run.verification_in_progress)

        # When there is an AD, but it isn't finished, then it is in progress
        run = CloudFactoryDocumentRunFactory()
        ad = run.document_url.advancedirective
        run.status = CloudFactoryDocumentRun.STATUS_PROCESSING
        run.save()
        self.assertTrue(ad.verification_in_progress)

        # When the run failed for some reason, it is no longer in progress
        run.status = CloudFactoryDocumentRun.STATUS_ABORTED
        run.save()
        self.assertFalse(ad.verification_in_progress)

    def test_verification_result(self):
        # When there is no run, there are no results
        ad_wo_run = AdvanceDirectiveFactory()
        self.assertIsNone(ad_wo_run.verification_result)

        # When there is a run, but there are no parseable results, returns None
        run = CloudFactoryDocumentRunFactory()
        ad = run.document_url.advancedirective
        self.assertIsNone(ad.verification_result)

        # When there is no output, but the results are parseable, return None
        run = CloudFactoryDocumentRunFactory()
        ad = run.document_url.advancedirective
        run.response_content = 'not-json'
        run.status = CloudFactoryDocumentRun.STATUS_PROCESSED
        run.save()
        self.assertIsNone(ad.verification_result)

        # When there is a run, and its results are parsable, return a dictionary of results
        run.save_response_data(SUCCESS_DATA)
        self.assertIsNotNone(ad.verification_result)

        # When the run finished, a dictionary is still returned, even if some
        # outputs failed to pass
        failed_run = json.loads(SUCCESS_DATA)
        failed_run['units'][0]['output']['owner_name_matches'] = False
        run.save_response_data(json.dumps(failed_run))
        self.assertIsNotNone(ad.verification_result)
