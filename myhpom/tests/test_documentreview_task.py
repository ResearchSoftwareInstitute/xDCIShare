from django.test import TestCase
from django.core import mail
from myhpom.models import CloudFactoryDocumentRun, DocumentUrl
from myhpom.tasks import EmailUserDocumentReviewCompleted
from myhpom.tests.factories import AdvanceDirectiveFactory


class EmailUserDocumentReviewCompletedTestCase(TestCase):
    """
    * If the corresponding DocumentUrl has been deleted, no email should be sent.
    * Otherwise, a generic email should be sent to the user who owns the DocumentUrl
    """

    def setUp(self):
        self.run = CloudFactoryDocumentRun.objects.create(
            document_url=DocumentUrl.objects.create(advancedirective=AdvanceDirectiveFactory())
        )
        self.task = EmailUserDocumentReviewCompleted

    def test_email_sent(self):
        self.task(self.run.id, 'http', 'localhost')
        self.assertEqual(len(mail.outbox), 1)

    def test_document_deleted_email_not_sent(self):
        self.run.document_url.delete()
        self.task(self.run.id, 'http', 'localhost')
        self.assertEqual(len(mail.outbox), 0)
