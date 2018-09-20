
import os
import json
import random
import requests
import requests_mock
from glob import glob
from django.test import TestCase
from django.conf import settings
from django.core.files.uploadedfile import SimpleUploadedFile
from django.utils.timezone import now
from myhpom.tests.factories import UserFactory
from myhpom.models import CloudFactoryRun, CloudFactoryUnit, AdvanceDirective
from myhpom.tasks import CloudFactorySubmitAdvanceDirectiveRun
import myhpom

FIXTURE_PATH = os.path.join(os.path.dirname(myhpom.__file__), 'tests', 'fixtures')
PDF_FILENAME = os.path.join(FIXTURE_PATH, 'afile.pdf')  # can be anything
LINE_ID = settings.CLOUDFACTORY_PRODUCTION_LINES['TEST']
MOCK_REQUEST_DATA = [
    json.load(f)
    for f in [
        open(fn) for fn in glob(os.path.join(FIXTURE_PATH, 'cloudfactory', 'post_run__*.json'))
    ]
]
REQUEST_URL = settings.CLOUDFACTORY_API_URL + '/runs'
DOCUMENT_HOST = ""
CALLBACK_URL = ""


def mock_post_run(post_data):
    """This function returns a method that mocks CloudFactorySubmitAdvanceDirectiveRun.post_run().
    It uses request/response data in fixtures/cloudfactory to represent current expectations. 
    For a given 'post_data' block, it returns the corresponding 'response_data'.
    The 'post_data' must exist in one of the MOCK_REQUEST_DATA blocks.
    The 'response_data' must have the same keys that python-requests expects.
    """
    url = REQUEST_URL
    for data in MOCK_REQUEST_DATA:
        if data['post_data'] == post_data:
            with requests_mock.Mocker() as requestmocker:
                requestmocker.get(url, **data['response_data'])
                response = requests.get(url)
                return lambda x: response

    # if the post_data isn't in data, then return a 404 response.
    with requests_mock.Mocker() as requestmocker:
        requestmocker.get(
            url, status_code=404, json={'message': 'post_data not in MOCK_REQUEST_DATA'}
        )
        response = requests.get(url)
        return lambda x: response


class CloudFactorySubmitAdvanceDirectiveRunTestCase(TestCase):
    """In the task:
    * submitting a run with valid data to CloudFactory returns 201 and run object with expected vals
    * various situations that raise exceptions in the task:
        * the AdvanceDirective id that was submitted to celery no longer exists 
            (deleted by user while task in queue).
        * submitting a run with invalid data returns 422 (Unprocessable Entity)
    * raising an exception in a task causes error mail to be created
    """

    def setUp(self):
        user = UserFactory()
        document = SimpleUploadedFile(
            os.path.basename(PDF_FILENAME), open(PDF_FILENAME, 'rb').read()
        )
        self.ad = AdvanceDirective.objects.create(
            user=user, share_with_ehs=False, document=document, valid_date=now()
        )
        self.task = CloudFactorySubmitAdvanceDirectiveRun
        self.task_args = [self.ad.id, LINE_ID, DOCUMENT_HOST, CALLBACK_URL]

    def test_submit_cloudfactory_run(self):
        for request_data in MOCK_REQUEST_DATA:
            self.task.post_run = mock_post_run(request_data['post_data'])
            if request_data['response_data']['status_code'] == 201:
                result = self.task(*self.task_args)
                self.assertEqual(result['status'], 'CREATED')
            else:
                with self.assertRaises(ValueError):
                    result = self.task(*self.task_args)

    def test_submit_deleted_ad(self):
        ad_id = self.ad.id
        self.ad.delete()
        # the post_data is moot - it won't post_run - but we still want to avoid posting to the API
        self.task.post_run = mock_post_run({})
        result = self.task(*self.task_args)
        self.assertEqual(result['status'], 'ABORTED')
        self.assertIn('no longer exists', result['message'])
