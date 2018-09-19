import json
import requests
import sys
import traceback
from collections import OrderedDict
from django.core.mail import send_mail
from django.conf import settings
from django.template.loader import get_template
from django.template import Context
from celery import shared_task
from celery.task import Task
from celery.signals import task_failure
from myhpom.models import AdvanceDirective, DocumentUrl, CloudFactoryRun, CloudFactoryUnit


@shared_task
class CloudFactorySubmitAdvanceDirectiveTask(Task):
    def run(self, ad_id, line_id, document_host, callback_url):
        """ 
        * ad_id = the database id for the AdvanceDirective
        * line_id = the id of the CloudFactory production line to submit this request to.
        * document_host = the host (incl. protocol/scheme) to use for the DocumentURL
        * callback_url = the URL to use with the callback request

        - create an expiring DocumentUrl for the AdvanceDirective
        - submit the DocumentUrl to the CloudFactory (test) endpoint
        - store the status of the submitted document
        - if an error occurs in this process, send support email.
            - the AdvanceDirective might no longer exist by the time celery picks it up,
            - or the document it points to might have been removed.
        """
        # if an error occurs, send support email
        ad = AdvanceDirective.objects.get(id=ad_id)
        document_url = DocumentUrl.objects.create(advancedirective=ad)
        cf_run = CloudFactoryRun.objects.create(line_id=line_id, callback_url=callback_url or "")
        unit = CloudFactoryUnit.objects.create(
            run=cf_run, input=self.create_unit_input(document_url, document_host)
        )

        response = self.post_run(cf_run.post_data)
        response_data = response.json()

        if response.status_code != 201:
            cf_run.__dict__.update(
                status=str(response.status_code), message=response_data.get['message']
            )
            cf_run.save()
            raise ValueError(
                response_data['message']
                + '\n\n== POST DATA ==\n'
                + json.dumps(cf_run.post_data, indent=2)
                + '\n\n== RUN DATA ==\n'
                + json.dumps(cf_run.data, indent=2)
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
        unit_input = {
            'full_name': ' '.join(
                name
                for name in [ad.user.first_name, ad.user.userdetails.middle_name, ad.user.last_name]
                if name != ''  # in the not-uncommon case that one of the names is blank
            ),
            'state': ad.user.userdetails.state.name,
            'pdf_url': "%s%s" % (document_host or '', document_url.url),
            'date_signed': str(ad.valid_date),
        }
        return unit_input

@task_failure.connect(sender='myhpom.tasks.CloudFactorySubmitAdvanceDirectiveTask')
def send_celery_error_mail(
    task_id=None, exception=None, traceback=None, einfo=None, *args, **kwargs
):
    subject = '[MMH] Error Submitting AdvanceDirective to CloudFactory'
    task = 'CloudFactorySubmitAdvanceDirectiveTask'
    message = get_template('myhpom/celery_task_error_email.txt').render(
        Context({'traceback': traceback, 'task': task, 'args': args, 'kwargs': kwargs})
    )
    send_mail(subject, message, settings.DEFAULT_FROM_EMAIL, [settings.DEFAULT_SUPPORT_EMAIL])


