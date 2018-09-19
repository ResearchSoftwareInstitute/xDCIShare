
import os
import random
import requests.models
from mock import MagicMock
from django.test import TestCase
from django.conf import settings
from django.core.files.uploadedfile import SimpleUploadedFile
from django.utils.timezone import now
from myhpom.tests.factories import UserFactory
from myhpom.models import CloudFactoryRun, CloudFactoryUnit, AdvanceDirective
from myhpom.tasks import CloudFactorySubmitAdvanceDirectiveTask
import myhpom

PDF_FILENAME = os.path.join(
    os.path.dirname(myhpom.__file__), 'tests', 'fixtures', 'afile.pdf'  # can be anything
)
LINE_ID = settings.CLOUDFACTORY_PRODUCTION_LINES['TEST']
DOCUMENT_HOST = CALLBACK_URL = ""


class MockResponse(requests.models.Response):
    # we only need the json data and the status_code, nothing else.
    def __init__(self, status_code, data):
        super(requests.models.Response, self).__init__()
        self.status_code = status_code
        self.__data = data

    # this mirrors the worldview of the requests Response object
    def json(self):
        return self.__data


def mock_post_run(post_data):
    """This function mirrors the response logic of the CloudFactory run API without calling it.
    * required keys, which are only checked for presence on input:
        * 'line_id' = the id of the production line
        * 'units' = an array of CloudFactoryUnit.post_data. required keys:
            * 'pdf_url' 
            * 'full_name'
            * 'state'
            * 'date_signed'
    * optional keys:
        * 'callback_url' = the url that the product line can call with results when ready
    * If all required keys are present, the response is 401, with additional data keys:
        * 'id' = string representing the id of this run
        * 'status': 'Processing'
        * 'created_at': '<timestamp>'
    * If required keys are not present the response is 422, with the following data keys:
        * 'message': 'Invalid request. <explanation>'
    """
    for key in ['line_id']:
        if key not in post_data:
            return MockResponse(
                422, {'message': 'Invalid request. "%s" is missing in the request.' % key}
            )
    for unit in post_data['units']:
        for key in ['pdf_url', 'full_name', 'state', 'date_signed']:
            if key not in unit:
                return MockResponse(
                    422, {'message': 'Invalid request. "%s" is missing in the request.' % key}
                )
    id_chars = [
        chr(i)
        for i in range(ord('A'), ord('Z')) + range(ord('a'), ord('z')) + range(ord('0'), ord('9'))
    ]
    return MockResponse(
        201,
        {
            'status': 'Processing',
            'line_id': post_data['line_id'],
            'created_at': now().strftime('%Y-%m-%dT%H:%M:%S.%UZ'),
            'id': ''.join(random.sample(id_chars, 10)),
        },
    )


class CloudFactorySubmitAdvanceDirectiveTaskTestCase(TestCase):
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
        self.task = CloudFactorySubmitAdvanceDirectiveTask
        self.task.post_run = mock_post_run

    def test_submit_valid(self):
        data = self.task(self.ad.id, LINE_ID, DOCUMENT_HOST, CALLBACK_URL)
        self.assertIsNotNone(data.created_at)
        self.assertIsNone(data.processed_at)

    def test_submit_deleted_ad(self):
        ad_id = self.ad.id
        self.ad.delete()
        run = cloudfactory_submit_advancedirective.delay(
            ad_id, LINE_ID, DOCUMENT_HOST, CALLBACK_URL
        )
