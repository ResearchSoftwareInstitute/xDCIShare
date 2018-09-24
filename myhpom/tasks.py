import json
import requests
from django.core.mail import send_mail
from django.conf import settings
from django.template.loader import get_template
from django.template import Context
from celery import shared_task
from celery.task import Task
from celery.signals import task_failure
from myhpom.models.document import DocumentUrl
from myhpom.models import cloudfactory


@shared_task
class CloudFactorySubmitDocumentRun(Task):
    def run(self, document_url_id, document_host=None):
        """
        ## Arguments
        * document_url_id = the database id for the DocumentUrl that is being submitted
        * document_host = the host (incl. protocol/scheme) to use for the DocumentURL & callback
            -- configurable so that we can tell CloudFactory which server to interact with
            (the document_host and the callback_host are assumed the same)

        ## Task Process
        - submit the DocumentUrl to the CloudFactory (test) endpoint
        - store the status of the submitted document
        - if the DocumentUrl no longer exists, abort the task without an Exception.
            - the DocumentUrl might no longer exist by the time celery picks it up,
            - or the document it points to might have been removed.
        - if an error occurs in this process, send support email.
        """
        cf_run = cloudfactory.CloudFactoryDocumentRun(document_host=document_host or '')

        # If the DocumentUrl has been deleted, abort the task with a message
        # -- no need to admin support email, this is an expected case.
        try:
            cf_run.document_url = DocumentUrl.objects.get(id=document_url_id)
        except:
            cf_run.status = cloudfactory.STATUS_DELETED
            cf_run.save()
            return cf_run.id

        # Any exception in the rest of the task should result in support email
        cf_run.post_data = cf_run.create_post_data()
        cf_run.save()

        response = requests.post(settings.CLOUDFACTORY_API_URL + '/runs', json=cf_run.post_data)
        cf_run.save_response(response)  # throws an error if response.content is not json

        # if the run could not be created (status_code != 201), send support email
        # -- we need to understand why the the run could not be created at CloudFactory.
        if response.status_code != 201:
            raise ValueError(
                "== POST DATA ==\n%s\n\n== RESPONSE CONTENT ==\n%s"
                % (json.dumps(cf_run.post_data, indent=2), cf_run.response_content)
            )
        return cf_run.pk


@shared_task
def test_error_email(data=None):
    """the sole purpose of this task is to poke celery into sending an error email."""
    raise ValueError(
        "This is a test of the celery error email. data:\n" + json.dumps(data, indent=2)
    )


# == SIGNALS ==


@task_failure.connect()
def send_celery_error_mail(task_id=None, einfo=None, sender=None, *args, **kwargs):
    task = sender.name
    subject = '{prefix}[celery] Error: {task} ({task_id})'.format(
        prefix=settings.EMAIL_SUBJECT_PREFIX, task=task, task_id=task_id
    )
    context = Context({'traceback': einfo, 'task': task})
    message = get_template('myhpom/celery_task_error_email.txt').render(context)
    send_mail(subject, message, settings.DEFAULT_FROM_EMAIL, [settings.DEFAULT_SUPPORT_EMAIL])
