import base64
import json
import os
from mock import patch
from django.core.urlresolvers import reverse
from django.test import TestCase, override_settings
from myhpom.models import CloudFactoryDocumentRun
from myhpom.tests.factories import CloudFactoryDocumentRunFactory

CF_PATH = os.path.join(os.path.dirname(__file__), 'fixtures', 'cloudfactory')
SUCCESS_DATA = open(os.path.join(CF_PATH, 'callback_success.json')).read()
ABORT_DATA = open(os.path.join(CF_PATH, 'callback_abort.json')).read()


class CloudfactoryResponseTest(TestCase):
    def post_json(self, url, data):
        return self.client.post(url, data=data, content_type='application/json')

    def test_no_data(self):
        # When no data is posted to the viewpoint, a 4xx code is returned,
        # alerting the requestor that the problem is theirs
        response = self.client.post(reverse('myhpom:cloudfactory_response'))
        self.assertEqual(400, response.status_code)

    @override_settings(
        CLOUDFACTORY_CALLBACK_ENFORCE_AUTH=True,
        CLOUDFACTORY_CALLBACK_AUTH='user:pass'
    )
    def test_enforce_authentication_setting(self):
        # When CLOUDFACTORY_CALLBACK_ENFORCE_AUTH is set, the value of the
        # CLOUDFACTORY_CALLBACK_AUTH is checked.
        CloudFactoryDocumentRun.objects.create(
            run_id='SUCCESS_ID', status=CloudFactoryDocumentRun.STATUS_PROCESSING)

        # When the password is wrong, the requestor will see an authentication
        # failed response code.
        response = self.client.post(
            reverse('myhpom:cloudfactory_response'),
            data=SUCCESS_DATA,
            content_type='application/json',
            secure=False,
            HTTP_AUTHORIZATION='blah')
        self.assertEqual(403, response.status_code)

        # When the user/pass are correct, the requestor will see a 200
        response = self.client.post(
            reverse('myhpom:cloudfactory_response'),
            data=SUCCESS_DATA,
            content_type='application/json',
            secure=False,
            HTTP_AUTHORIZATION='basic ' + base64.b64encode('user:pass'))
        self.assertEqual(200, response.status_code)

    def test_badly_formed_data(self):
        # When non-json data is sent, we return a 400 to alert the user to the
        # bad formatting.
        response = self.post_json(reverse('myhpom:cloudfactory_response'), 'blah')
        self.assertEqual(400, response.status_code)

    def test_no_id(self):
        # Record doesn't exist on our end - we want a log of this.
        response = self.post_json(reverse('myhpom:cloudfactory_response'), SUCCESS_DATA)
        self.assertEqual(404, response.status_code)

    def test_no_output(self):
        # When no output is in the json, a 4xx code is returned,
        # alerting the requestor that the problem is theirs
        run = CloudFactoryDocumentRunFactory(
            run_id='SUCCESS_ID', status=CloudFactoryDocumentRun.STATUS_PROCESSING)
        no_output = json.loads(SUCCESS_DATA)
        del no_output['units'][0]['output']
        response = self.post_json(reverse('myhpom:cloudfactory_response'), json.dumps(no_output))
        self.assertEqual(400, response.status_code)
        run.refresh_from_db()
        self.assertEqual(CloudFactoryDocumentRun.STATUS_ERROR, run.status)

    def test_abort(self):
        # When an abort happens, we should handle it gracefully.
        run = CloudFactoryDocumentRunFactory(
            run_id='ABORT_ID', status=CloudFactoryDocumentRun.STATUS_ABORTED)
        abort_data = json.loads(ABORT_DATA)
        response = self.post_json(reverse('myhpom:cloudfactory_response'), json.dumps(abort_data))
        self.assertEqual(200, response.status_code)
        run.refresh_from_db()
        self.assertEqual(CloudFactoryDocumentRun.STATUS_ABORTED, run.status)

    def test_already_finished(self):
        # When CloudFactoryDocumentRun exists, but it is already 'finished' - we
        # don't expect to receive any updates
        run = CloudFactoryDocumentRun.objects.create(run_id='SUCCESS_ID')
        for status in CloudFactoryDocumentRun.STATUS_FINAL_STATES:
            run.status = status
            run.save()
            response = self.post_json(reverse('myhpom:cloudfactory_response'), SUCCESS_DATA)
            self.assertEqual(400, response.status_code, '%s should fail' % status)

    def test_failed_review(self):
        # We get back a response that says any of the output criteria failed
        run = CloudFactoryDocumentRun.objects.create(run_id='SUCCESS_ID')

        # Try all the possible keys that could fail - they should all cause the
        # run to transition to finished.
        for output in json.loads(SUCCESS_DATA)['units'][0]['output'].keys():
            failed_data = json.loads(SUCCESS_DATA)
            failed_data['units'][0]['output'][output] = False
            run.status = CloudFactoryDocumentRun.STATUS_PROCESSING
            run.save()
            response = self.post_json(
                reverse('myhpom:cloudfactory_response'), json.dumps(failed_data)
            )
            self.assertEqual(200, response.status_code, '%s=False should return 200' % output)
            run.refresh_from_db()
            # The status and the response should be saved:
            self.assertEqual(
                CloudFactoryDocumentRun.STATUS_PROCESSED,
                run.status,
                '%s=False should transition to processed' % output,
            )
            self.assertEqual(json.dumps(failed_data), run.response_content)

    def test_successful_review(self):
        # We get back a response that says any of the output criteria failed
        run = CloudFactoryDocumentRun.objects.create(
            run_id='SUCCESS_ID', status=CloudFactoryDocumentRun.STATUS_PROCESSING)

        response = self.post_json(reverse('myhpom:cloudfactory_response'), SUCCESS_DATA)
        self.assertEqual(200, response.status_code)
        run.refresh_from_db()
        # The status and the response should be saved:
        self.assertEqual(CloudFactoryDocumentRun.STATUS_PROCESSED, run.status)
        self.assertEqual(SUCCESS_DATA, run.response_content)

    @patch('myhpom.views.document.EmailUserDocumentReviewCompleted')
    def test_user_email_task_on_completed_review(self, task_mock):
        """
        When a review has been completed, the view should trigger the email task.
        """
        run = CloudFactoryDocumentRun.objects.create(
            run_id='SUCCESS_ID', status=CloudFactoryDocumentRun.STATUS_PROCESSING
        )
        response = self.post_json(reverse('myhpom:cloudfactory_response'), SUCCESS_DATA)
        self.assertEqual(200, response.status_code)  # indicates successful review completion
        task_mock.delay.assert_called_once_with(run.pk, 'http', 'testserver')
