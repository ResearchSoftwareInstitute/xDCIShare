
from django.test import TestCase


class CloudFactorySubmitAdvanceDirectiveTaskTestCase(TestCase):
    """In the task:
    * submitting a run with valid data to CloudFactory returns 201 and run object with expected vals
    * various situations that raise exceptions in the task:
        * the AdvanceDirective id that was submitted to celery no longer exists 
            (deleted by user while task in queue).
        * submitting a run with invalid data returns 422 (Unprocessable Entity)
    * raising an exception in a task causes error mail to be created
    """

