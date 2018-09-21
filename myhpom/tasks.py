import json
import requests
from django.core.mail import send_mail
from django.conf import settings
from django.template.loader import get_template
from django.template import Context
from celery import shared_task
from celery.task import Task
from celery.signals import task_failure
from myhpom.models.document import AdvanceDirective, DocumentUrl
from myhpom.models.cloudfactory import CloudFactoryRun, CloudFactoryUnit


@shared_task
class CloudFactorySubmitAdvanceDirectiveRun(Task):
    def run(self, ad_id, line_id, document_host, callback_url):
        """
        ## Arguments
        * ad_id = the database id for the AdvanceDirective
        * line_id = the id of the CloudFactory production line to submit this request to.
        * document_host = the host (incl. protocol/scheme) to use for the DocumentURL
        * callback_url = the URL to use with the callback request

        ## Task Process
        - create an expiring DocumentUrl for the AdvanceDirective
        - submit the DocumentUrl to the CloudFactory (test) endpoint
        - store the status of the submitted document
        - if the AdvanceDirective no longer exists, abort the task without an Exception.
            - the AdvanceDirective might no longer exist by the time celery picks it up,
            - or the document it points to might have been removed.
        - if an error occurs in this process, send support email.
        """
        cf_run = CloudFactoryRun.objects.create(line_id=line_id, callback_url=callback_url or "")

        # If the AdvanceDirective has been deleted, abort the task with a message
        # -- no need to admin support email, this is an expected case.
        try:
            ad = AdvanceDirective.objects.get(id=ad_id)
        except:
            cf_run.status = 'DELETED'
            cf_run.message = 'AdvanceDirective(id=%r) no longer exists.' % ad_id
            cf_run.save()
            return cf_run.data

        # Any exception in the rest of the task should result in support email
        document_url = DocumentUrl.objects.create(advancedirective=ad)
        CloudFactoryUnit.objects.create(
            run=cf_run, input=self.create_unit_input(document_url, document_host)
        )
        response = self.post_run(cf_run.post_data)
        response_data = response.json()

        # if the run could not be created (status_code != 201), send support email
        # -- we need to understand why the the run could not be created at CloudFactory.
        if response.status_code != 201:
            cf_run.__dict__.update(
                status=str(response.status_code), message=response_data.get('message')
            )
            cf_run.save()
            raise ValueError(
                "%s\n\n== RUN POST DATA ==\n%s\n\n== FULL RUN DATA ==\n%s"
                % (
                    response_data['message'],
                    json.dumps(cf_run.post_data, indent=2),
                    json.dumps(cf_run.data, indent=2),
                )
            )

        cf_run.__dict__.update(
            run_id=response_data['id'],
            status=response_data['status'],
            created_at=response_data['created_at'],
        )
        cf_run.save()
        return cf_run.data  # json-serializable by design

    # separating this so it can be mocked during tests, and not actually hit CloudFactory then.
    def post_run(self, post_data):
        return requests.post(settings.CLOUDFACTORY_API_URL + '/runs', json=post_data)

    def create_unit_input(self, document_url, document_host):
        """For a given DocumentUrl object, return the unit input that CloudFactory expects.
        see https://docs.google.com/document/d/1VHD3iVq2Ky_SblQScv9O7tlphv9QHllMpGvn-bkWM_8/edit
        """
        ad = document_url.advancedirective
        data = {
            'full_name': ' '.join(
                name
                for name in [ad.user.first_name, ad.user.userdetails.middle_name, ad.user.last_name]
                if name != ''  # in the not-uncommon case that one of the names is blank
            ),
            'state': ad.user.userdetails.state.name if ad.user.userdetails.state else None,
            'pdf_url': "%s%s" % (document_host or '', document_url.url),
            'date_signed': str(ad.valid_date),
        }
        # only non-blank values are submitted, to prevent present but useless values
        unit_input = {k: v for k, v in data.items() if bool(v) is True}
        return unit_input


@shared_task
class CloudFactoryCancelAdvanceDirectiveRun(Task):
    def run(self, cf_run_id):
        """Find any CloudFactory runs for the given document_url and cancel them.
        (The AdvanceDirective and DocumentUrl objects have probably already been deleted, 
        so we pass the document_url as a string so as to avoid needing to refer to those models.)
        ## Use Cases:
        * when the user deletes their AdvanceDirective, this task is triggered automatically.
        ## Parameters:
        * document_url = a string representing a DocumentUrl.url
        ## Process: For each matching run,
        * If it is in progress (status='Processing'), cancel it at CloudFactory.
            * 202 = CloudFactory accepted the request
            * 405 = already processed / aborted at CloudFactory
        * Get the run info from CloudFactory and update our models.
            * 200 = Ok
        * Any response status apart from those given should raise an exception / send error email,
            because it means we have a bug / false assumption somewhere in our system.
        """
        cf_run = CloudFactoryRun.objects.get(id=cf_run_id)
        if cf_run.status == 'Processing':
            # abort the run
            response = self.post_abort(cf_run.run_id)
            if response.status_code not in [202, 405]:
                response_json = json.dumps(response.json(), indent=2)
                raise ValueError(
                    """URL: %s\nResponse status: %d\nResponse Data: %s"""
                    % (response.url, response.status_code, response_json)
                )

            # update the CloudFactoryRun object, needs another API call.
            CloudFactoryUpdateAdvanceDirectiveRun(cf_run.id)  # no delay here!

        return cf_run.data

    def post_abort(self, run_id):
        abort_url = "%s/runs/%s/abort" % (settings.CLOUDFACTORY_API_URL, run_id)
        return requests.post(abort_url)


@shared_task
class CloudFactoryUpdateAdvanceDirectiveRun(Task):
    """separate task for updating the CloudFactoryRun object from the CF API."""

    def run(self, cf_run_id):
        cf_run = CloudFactoryRun.objects.get(id=cf_run_id)
        response = self.get_run(cf_run.run_id)
        response_data = response.json()  # confusingly named, response.json() is a dict
        response_json = json.dumps(response_data, indent=2)  # so this is a string
        if response.status_code != 200:
            raise ValueError(
                """URL: %s\nResponse status: %d\nResponse Data: %s"""
                % (response.url, response.status_code, response_json)
            )
        cf_run.save_cloudfactory_response(response_data)  # takes the dict, not the string
        return cf_run.data

    def get_run(self, run_id):
        run_url = "%s/runs/%s" % (settings.CLOUDFACTORY_API_URL, run_id)
        return requests.get(run_url)


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
