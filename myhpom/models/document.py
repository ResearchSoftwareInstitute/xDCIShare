import base64
import json
import os
import tempfile
import uuid
import importlib

from django.conf import settings
from django.core.urlresolvers import reverse
from django.db import models
from django.utils.dateparse import parse_datetime
from django.utils.timezone import now

from bgs import GS
from myhpom.validators import validate_date_in_past

from .user import User

PDF_RESOLUTION = 150  # this is the resolution at which to render the PDF to images.
THUMBNAIL_WIDTH = 508  # this is the exact maximum width of the thumbnail in the layout


class AdvanceDirective(models.Model):
    """ A user's Advance Directive. """

    user = models.OneToOneField(User)

    document = models.FileField(
        upload_to='myhpom/advance_directives',
        help_text='The document representing this user\'s Advance Directive.',
    )
    original_filename = models.CharField(max_length=512, blank=True)
    valid_date = models.DateField(
        help_text='Date that this document is legally valid.', validators=[validate_date_in_past]
    )
    share_with_ehs = models.BooleanField(
        help_text=('True when user this document can be shared with the user\'s healthcare system.')
    )
    thumbnail = models.FileField(
        null=True,
        blank=True,
        upload_to='myhpom/advance_directives',
        help_text='The first-page thumbnail image of the user\'s Advance Directive.',
    )

    @property
    def filename(self):
        return self.original_filename or os.path.basename(self.document.name)

    def render_thumbnail_data(self, res=PDF_RESOLUTION, **gsargs):
        """return the thumbnail binary file data for the given AdvanceDirective instance"""
        mogrify = {'resize': "%dx>" % THUMBNAIL_WIDTH}
        filenames = self.render_images(allpages=False, res=res, mogrify=mogrify, **gsargs)
        if len(filenames) > 0:
            with open(filenames[0], 'rb') as f:
                return f.read()

    def render_images(self, allpages=True, res=PDF_RESOLUTION, **gsargs):
        """create one or more images of pages of the current document.
        Requires that the AD has a document in storage
        Returns a list of (temporary) filenames (deleted after the AD object goes out of scope).
        * allpages=False: if true, creates all pages. if False, creates only the first page.
            (if all you want is a thumbnail, creating only the first page is MUCH faster)
        * res=150: the resolution of the output images based on the pdf page size
        * **gsargs: The GS.render() method takes several other arguments that you can specify:
            * outfn: specify the output filename. If multiple pages, a numerical counter is added.
            * device='jpeg': the device to use to create the output; implies the file extension
            * alpha=4: the number of bits to use for the alpha value.
            * quality=90: the jpeg quality: 100 = highest.
            * mogrify=None: if given, these are post-processing arguments to mogrify (ImageMagick)
        """
        # first write the document to a temporary file in the filesystem
        # then use ghostscript (gs) to render it
        gs = GS()
        tempdir = tempfile.mkdtemp()
        pdf_filename = os.path.join(tempdir, self.filename)
        with open(pdf_filename, 'wb') as f:
            f.write(self.document.file.read())
        image_filenames = gs.render(pdf_filename, res=res, allpages=allpages, **gsargs)
        return image_filenames

    @property
    def verification_in_progress(self):
        """ Returns True when the CF for this AD is still in progress. """
        # Search for any run that is in progress
        return CloudFactoryDocumentRun.objects.filter(
            status=CloudFactoryDocumentRun.STATUS_PROCESSING,
            document_url__advancedirective=self).exists()

    @property
    def verification_failed(self):
        """ Returns True when the CF task has failed.

        A failure of the task (aborted, network problems, bad data at the
        protocol level, etc) -- the verification process did not happen at this
        stage (it failed before it could)
        """
        # Search for any run that is in progress
        return CloudFactoryDocumentRun.objects \
            .filter(
                status__in=CloudFactoryDocumentRun.STATUS_FINAL_STATES,
                document_url__advancedirective=self) \
            .exclude(status=CloudFactoryDocumentRun.STATUS_PROCESSED) \
            .exists()

    @property
    def verification_result(self):
        """
        Returns a dictionary of keys corresponding to the output of the
        finished CF run.

        If the CF verification is not finished or failed, returns None.
        """
        # Select all finished runs - for the first one that processed (there
        # should be only one), return its output
        processed_run = CloudFactoryDocumentRun.objects.filter(
            status=CloudFactoryDocumentRun.STATUS_PROCESSED,
            document_url__advancedirective=self).last()
        if processed_run:
            return processed_run.output()

        return None

    @property
    def verification_passed(self):
        """
        Returns True when this AD has been verified with CloudFactory.

        Notes: if the CF-run finished successfully, and all the outputs checked
        by the run are true (or not applicable).
        """
        processed_run = CloudFactoryDocumentRun.objects.filter(
            status=CloudFactoryDocumentRun.STATUS_PROCESSED,
            document_url__advancedirective=self).last()

        return processed_run and processed_run.passed()

    def __unicode__(self):
        return unicode(self.document.name)


def remove_documents_on_delete(sender, instance, using, **kwargs):
    if instance.thumbnail:
        instance.thumbnail.storage.delete(instance.thumbnail.name)
    if instance.document:
        instance.document.storage.delete(instance.document.name)


models.signals.post_delete.connect(remove_documents_on_delete, sender=AdvanceDirective)


def document_url_default_expiration():
    return now() + settings.DOCUMENT_URL_EXPIRES_IN


def document_url_create_key():
    return base64.urlsafe_b64encode(str(uuid.uuid4()))


class DocumentUrl(models.Model):
    """
    An Advance Directive is accessible internally from its instance.document.url, but we don't want
    to expose that to anyone but the owner. For CloudFactory, we will provide URLs that expire
    and that are non-guessable. The DocumentUrl model holds "keys" to documents.
    * advancedirective = foreign key to the AdvanceDirective
    * key = the non-guessable string that identifies this DocumentUrl
    * expiration = (optional) timestamp, based on a new setting
        (now + settings.DOCUMENT_URL_EXPIRES_IN)
    """

    advancedirective = models.ForeignKey(
        AdvanceDirective,
        on_delete=models.CASCADE,
        help_text="The AdvanceDirective to which this URL points.",
    )
    key = models.CharField(
        max_length=48,
        unique=True,
        default=document_url_create_key,
        help_text="The non-guessable string that indentifies this DocumentUrl.",
    )
    expiration = models.DateTimeField(
        null=True,  # optional
        blank=True,
        default=document_url_default_expiration,
        help_text="The optional timestamp indicating when this DocumentUrl expires.",
    )

    def __str__(self):
        return self.url

    @property
    def url(self):
        return reverse('myhpom:document_url', kwargs={'key': self.key})

    @property
    def filename(self):
        # no information bleed in the filename, but keep the extension from the AdvanceDirective
        return self.key + os.path.splitext(self.advancedirective.filename)[-1]

    def authorized_client_ip(self, ip_address):
        """The given ip_address is valid if either:
        * settings has no ip_ranges; or
        * the ip_address is in settings ip_ranges
        """
        if not settings.DOCUMENT_URL_IP_RANGES:
            return True
        else:
            for ip_range in settings.DOCUMENT_URL_IP_RANGES:
                if ip_address in ip_range:
                    return True
        return False


class CloudFactoryDocumentRun(models.Model):
    """Store information about current and past CloudFactory document runs
    (processing for AdvanceDirective.DocumentUrl objects).

    ## STATUS_VALUES:
    * 'NEW'         = the run is new and hasn't been submitted to CF
    * 'DELETED'     = the corresponding document has been deleted
    * 'REQ_ERROR'     = the last request to CF timed out
    * 'NOTFOUND'    = the run could not be found at CF
    * 'UNPROCESSABLE' = CF found the post_data unprocessable (422)
    * 'ERROR'       = an error occurred, such as a non-json response that we couldn't interpret
    * 'Processing'  = CF is currently processing the document
    * 'Aborted'     = We have aborted the run, CF is still listed as 'Processing'
    * 'Processed'   = CF has completed processing, details in the
                      response_content (and the content is properly formatted)
    """

    STATUS_NEW = 'NEW'
    STATUS_DELETED = 'DELETED'
    STATUS_REQ_ERROR = 'REQ_ERROR'
    STATUS_NOTFOUND = 'NOTFOUND'
    STATUS_UNPROCESSABLE = 'UNPROCESSABLE'
    STATUS_ERROR = 'ERROR'
    STATUS_PROCESSING = 'Processing'
    STATUS_ABORTED = 'Aborted'
    STATUS_PROCESSED = 'Processed'
    STATUS_VALUES = (  # if you re-order these, like I tried to do, you'll prompt a migration.
        STATUS_NEW,
        STATUS_DELETED,
        STATUS_REQ_ERROR,
        STATUS_NOTFOUND,
        STATUS_UNPROCESSABLE,
        STATUS_ERROR,
        STATUS_PROCESSING,
        STATUS_ABORTED,
        STATUS_PROCESSED,
    )

    # Once a run is in the following states, it will not transition to a new
    # state.
    STATUS_FINAL_STATES = (
        STATUS_NEW,
        STATUS_DELETED,
        STATUS_REQ_ERROR,
        STATUS_NOTFOUND,
        STATUS_UNPROCESSABLE,
        STATUS_ERROR,
        STATUS_ABORTED,
        STATUS_PROCESSED,
    )
    STATUS_MAX_LENGTH = 16
    STATUS_CHOICES = [(i, i) for i in STATUS_VALUES]

    REQUIRED_OUTPUT_KEYS = set([
        'owner_name_matches', 'witness_signature_1', 'witness_signature_2',
        'notarized', 'signed_by_owner'])
    YES_OR_NA = set(['true', 'not applicable'])

    document_url = models.ForeignKey(
        DocumentUrl,
        on_delete=models.SET_NULL,
        null=True,  # null must be allowed because of the ON DELETE SET NULL.
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
    updated_at = models.DateTimeField(
        auto_now=True, help_text="When the run instance was last updated in our system."
    )

    # The following four fields are pulled out of the response_data for use in the admin.
    run_id = models.CharField(
        max_length=32,
        unique=True,
        null=True,
        blank=True,
        default=None,  # force null if blank
        help_text="The id of this production run at CloudFactory.",
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
        return unicode(
            "%s (%s %s)"
            % (self.run_id, self.status, self.processed_at or self.created_at or self.inserted_at)
        )

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

    def save_response_data(self, response_content):
        """
        Update response_content and other fields extracted from the CF response.
        """
        # we want to save the response_content to self.response_data no matter what.
        self.response_content = response_content

        # now we try to unpack the response_content on the assumption that it is json.
        try:
            data = json.loads(response_content)  # throws an error if not json
            if 'id' in data:
                self.run_id = data['id']
            if 'status' in data:
                self.status = data['status']
            if 'created_at' in data:
                self.created_at = parse_datetime(data['created_at'])
                if self.created_at is None:
                    raise ValueError('Unable to parse created_at')
            if 'processed_at' in data:
                self.processed_at = parse_datetime(data['processed_at'])
                if self.processed_at is None:
                    raise ValueError('Unable to parse processed_at')

            if self.status == self.STATUS_PROCESSED:
                if 'units' not in data:
                    raise ValueError('No units found in result')
                units = data['units']
                if len(units) == 0 or 'output' not in units[0]:
                    raise ValueError('No output found in first unit')

                # If all the values are either true or not applicable then this
                # would be considered a successful run:
                #
                # Note that we consider only the first unit of work - which at the
                # moment is all we create.
                #
                # The output must also have at least the required keys mentioned in
                # our integration doc.
                output = units[0]['output']
                has_required_keys = self.REQUIRED_OUTPUT_KEYS <= set(output.keys())
                if not has_required_keys:
                    raise ValueError('Missing keys in output')
        except ValueError:
            self.status = self.STATUS_ERROR
            self.save()
            raise

        self.save()

    def output(self):
        """
        Returns dictionary of 'output' from run if is processed.

        Otherwise if the run failed to process returns None or return non-JSON
        return None.

        Note that this method assumes that save_response_data() has been called
        """
        if self.status != CloudFactoryDocumentRun.STATUS_PROCESSED:
            return None

        data = json.loads(self.response_content)
        units = data['units']
        return units[0]['output']

    def passed(self):
        """
        Returns True when this run processed successfully, and all the
        outputs are either true or na.

        Note that this method assumes that save_response_data() has been called
        (which ensures the content is JSON and that the required keys are
        present)
        """
        if self.status != CloudFactoryDocumentRun.STATUS_PROCESSED:
            return False

        data = json.loads(self.response_content)
        units = data['units']
        output = units[0]['output']
        all_true_or_na = set(output.values()) <= self.YES_OR_NA
        return all_true_or_na


def abort_document_runs_on_delete(sender, instance, using, **kwargs):
    """Any document runs associated with a DocumentUrl should be aborted at CF on delete."""
    if instance.cloudfactorydocumentrun_set.exists():
        tasks = importlib.import_module('myhpom.tasks')
        for run in instance.cloudfactorydocumentrun_set.all():
            tasks.CloudFactoryAbortDocumentRun.delay(run.id)


models.signals.pre_delete.connect(abort_document_runs_on_delete, sender=DocumentUrl)
