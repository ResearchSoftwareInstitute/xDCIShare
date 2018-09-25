import os
import tempfile
import base64
import uuid

from .user import User
from django.db import models
from django.core.urlresolvers import reverse
from django.conf import settings
from django.utils.timezone import now
from myhpom.validators import validate_date_in_past
from bgs import GS

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
