
import json
import datetime
from django.db import models
from django.core.urlresolvers import reverse
from django.conf import settings
from myhpom.models import DocumentUrl

# from myhpom.models.user import User

STATUS_NEW = 'NEW'
STATUS_DELETED = 'DELETED'
STATUS_PROCESSING = 'Processing'
STATUS_PROCESSED = 'Processed'
STATUS_VALUES = [STATUS_NEW, STATUS_DELETED, STATUS_PROCESSING, STATUS_PROCESSED]
STATUS_MAX_LENGTH = 16
STATUS_CHOICES = [(i, i) for i in STATUS_VALUES]


class CloudFactoryDocumentRun(models.Model):
    """Store information about current and past CloudFactory document runs
    (processing for AdvanceDirective.DocumentUrl objects).
    """

    document_url = models.ForeignKey(
        DocumentUrl,
        on_delete=models.SET_NULL,
        null=True,
        help_text="the DocumentUrl object with which this run is associated.",
    )
    document_host = models.CharField(
        max_length=64,
        blank=True,
        default="",
        help_text="The document host to which this run is connected.",
    )
    inserted_at = models.DateTimeField(
        auto_now_add=True, help_text="When the run instance was inserted into our system."
    )

    # The following four fields are pulled out of the response_data for use in the admin.
    run_id = models.CharField(
        max_length=32, unique=True, help_text="The id of this production run at CloudFactory."
    )
    status = models.CharField(
        choices=STATUS_CHOICES,
        max_length=STATUS_MAX_LENGTH,
        default=STATUS_NEW,
        help_text="The status of the run.",
    )
    created_at = models.DateTimeField(
        blank=True, null=True, help_text="When the run was created at CloudFactory."
    )
    processed_at = models.DateTimeField(
        blank=True, null=True, help_text="When run processing was finished at CloudFactory."
    )

    post_data = models.TextField(
        blank=True,
        default="",
        help_text="The raw data that was submitted to CloudFactory when this run was created",
    )
    response_content = models.TextField(
        blank=True,
        default="",
        help_text="The raw content of the most recent response from CloudFactory",
    )

    def __unicode__(self):
        return (
            "%s (%s %s)"
            % (self.run_id, self.status, self.processed_at or self.created_at or self.inserted_at)
        ).strip()

    def create_post_data(self):
        """Return the post data that CloudFactory expects when creating a run.
        see https://docs.google.com/document/d/1VHD3iVq2Ky_SblQScv9O7tlphv9QHllMpGvn-bkWM_8/edit
        """
        ad = self.document_url.advancedirective
        unit_data = {
            'full_name': ad.user.get_full_name(),
            'state': ad.user.userdetails.state.name if ad.user.userdetails.state else None,
            'pdf_url': self.document_host + self.document_url.url,
            'date_signed': str(ad.valid_date),
        }
        # Only submit non-blank values, to ensure valid input. (CloudFactory accepts blank values
        # on POST, even though those values are invalid, but does not accept missing keys.)
        # (The User's state can be null in our models. Others are ensured by model validations.)

        unit_post_data = {k: v for k, v in unit_data.items() if bool(v) is True}

        data = {
            "line_id": settings.CLOUDFACTORY_LINE_ID,
            "callback_url": self.document_host + reverse('myhpom:cloudfactory_response'),
            "units": [unit_post_data],
        }
        return data

    def save_response(self, response):
        """update the response_data field and the other fields that are extracted from it.
        """
        # we want to save the response_content to self.response_data no matter what.
        self.response_content = response.content
        self.save()

        # now we try to unpack the response.content on the assumption that it is json.
        data = json.loads(response.content)  # throws an error if not json
        CloudFactoryDocumentRun.objects.filter(pk=self.pk).update(
            run_id=data['id'] if 'id' in data else None,
            **{key: data[key] for key in ['status', 'created_at', 'processed_at'] if key in data}
        )
        self.refresh_from_db()
