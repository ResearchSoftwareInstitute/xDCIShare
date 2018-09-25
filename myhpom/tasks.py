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
from myhpom.models import CloudFactoryDocumentRun


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
        cf_run = CloudFactoryDocumentRun(document_host=document_host or '')

        # If the DocumentUrl has been deleted, abort the task with a message
        # -- no need to admin support email, this is an expected case.
        try:
            cf_run.document_url = DocumentUrl.objects.get(id=document_url_id)
        except DocumentUrl.DoesNotExist:
            cf_run.status = CloudFactoryDocumentRun.STATUS_DELETED
            cf_run.save()
            return cf_run.id

        # Any exception in the rest of the task should result in support email
        cf_run.post_data = cf_run.create_post_data()
        cf_run.save()

        try:
            response = requests.post(settings.CLOUDFACTORY_API_URL + '/runs', json=cf_run.post_data)
        except requests.exceptions.ConnectTimeout:
            cf_run.status = CloudFactoryDocumentRun.STATUS_TIMEOUT
            cf_run.save()
            raise

        if response.status_code == 422:
            cf_run.status = CloudFactoryDocumentRun.STATUS_UNPROCESSABLE
            cf_run.save()
        elif response.status_code == 404:
            cf_run.status = CloudFactoryDocumentRun.STATUS_NOTFOUND
            cf_run.save()
        elif response.status_code == 201:
            cf_run.status = CloudFactoryDocumentRun.STATUS_PROCESSING
            cf_run.save()

        # if the run could not be created (status_code != 201), send support email
        # -- we need to understand why the the run could not be created at CloudFactory.
        if response.status_code != 201:
            raise ValueError(
                "== POST DATA ==\n%s\n\n== RESPONSE CONTENT ==\n%s"
                % (json.dumps(cf_run.post_data, indent=2), cf_run.response_content)
            )

        # following throws an error (as it should) if response.content is not json-parsable.
        # don't change the run status here -- we haven't learned anything about it,
        # and maybe there's a response status that we don't know about.

        cf_run.save_response_content(response.content)

        return cf_run.pk


@shared_task
class CloudFactoryUpdateDocumentRun(Task):
    def run(self, cf_run_id):
        """Update the CloudFactoryDocumentRun object from the CF API.

        ## Use Cases
        * The admin user can update the status of all or selected runs from CloudFactory.

        ## Parameters
        * cf_run_id = the id (not the run_id) of the CloudFactoryDocumentRun object.
        """
        cf_run = CloudFactoryDocumentRun.objects.get(id=cf_run_id)

        if cf_run.status in [
            CloudFactoryDocumentRun.STATUS_PROCESSING,  # still going last we checked
            CloudFactoryDocumentRun.STATUS_TIMEOUT,  # didn't work last time; was it created?
            CloudFactoryDocumentRun.STATUS_ABORTED,  # we previously aborted; did it take?
        ]:
            try:
                run_url = "%s/runs/%s" % (settings.CLOUDFACTORY_API_URL, cf_run.run_id)
                response = requests.get(run_url)
            except requests.exceptions.ConnectTimeout:
                cf_run.status = CloudFactoryDocumentRun.STATUS_TIMEOUT

            if response.status_code == 404:
                cf_run.status = CloudFactoryDocumentRun.STATUS_NOTFOUND
                cf_run.response_content = response.content  # not json, shouldn't raise Exception.
                cf_run.save()
            elif response.status_code == 200:
                cf_run.save_response_content(response.content)
            else:
                # don't change the run status here -- we haven't learned anything about it,
                # and maybe there's a response status that we don't know about
                raise ValueError(
                    """URL: %s\nResponse status: %d\nResponse Data: %s"""
                    % (response.url, response.status_code, response.content)
                )


@shared_task
class CloudFactoryAbortDocumentRun(Task):
    def run(self, cf_run_id):
        """Abort the given CloudFactoryDocumentRun.
        
        ## Use Cases:
        * when the user deletes their DocumentUrl, this task is triggered automatically
            (through the deletion of the DocumentUrl).
        * can be called from the admin
        
        ## Parameters:
        * cf_run_id = the id (not the run_id) of a CloudFactoryDocumentRun object
        
        ## Process:
        * If it is in progress (status='Processing'), cancel it at CloudFactory.
            * 202 = CloudFactory accepted the request
            * 405 = already processed / aborted at CloudFactory
        * Get the run info from CloudFactory and update our models.
            * 200 = Ok
        * Any response status apart from those given should raise an exception / send error email,
            because it means we have a bug / false assumption somewhere in our system.
        """
        # update the CloudFactoryDocumentRun object first
        CloudFactoryUpdateDocumentRun(cf_run_id)

        cf_run = CloudFactoryDocumentRun.objects.get(id=cf_run_id)
        if cf_run.status in [
            CloudFactoryDocumentRun.STATUS_PROCESSING,  # still going last we checked
            CloudFactoryDocumentRun.STATUS_TIMEOUT,  # didn't work last time; was it created?
        ]:
            # abort the run
            abort_url = "%s/runs/%s/abort" % (settings.CLOUDFACTORY_API_URL, cf_run.run_id)
            response = requests.post(abort_url)  # yes, CF wants a POST without a body for this.

            if response.status_code == 404:
                cf_run.status = CloudFactoryDocumentRun.STATUS_NOTFOUND
                cf_run.save()
            elif response.status_code == 202:
                # 202 = they accepted the response, so we can consider it done.
                cf_run.status = CloudFactoryDocumentRun.STATUS_ABORTED
                cf_run.save()
            elif response.status_code == 405:
                # 405 = CF uses it to mean "already done, folks" -- whether aborted or processed
                # (the details of what was done are in the .response_content)
                cf_run.status = CloudFactoryDocumentRun.STATUS_PROCESSED
                cf_run.save()
            else:
                # don't change the run status here -- we haven't learned anything about it,
                # and maybe there's a response status that we don't know about.
                raise ValueError(
                    """URL: %s\nResponse status: %d\nResponse Content:\n%s"""
                    % (response.url, response.status_code, response.content)
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
