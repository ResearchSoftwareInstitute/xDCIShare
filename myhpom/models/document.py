import os, tempfile, base64, uuid, iptools

from .user import User
from django.db import models
from django.core.urlresolvers import reverse
from django.conf import settings
from django.utils.timezone import now
from django.core.files.base import ContentFile
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

    def __str__(self):
        return self.document.name


def remove_documents_on_delete(sender, instance, using, **kwargs):
    if instance.thumbnail:
        instance.thumbnail.storage.delete(instance.thumbnail.name)
    if instance.document:
        instance.document.storage.delete(instance.document.name)


models.signals.post_delete.connect(remove_documents_on_delete, sender=AdvanceDirective)


class DocumentUrl(models.Model):
    """
    An Advance Directive is accessible internally from its instance.document.url, but we don't want
    to expose that to anyone but the owner. For CloudFactory, we will provide URLs that expire
    and that are non-guessable. The DocumentUrl model holds "keys" to documents.
    * advancedirective = foreign key to the AdvanceDirective
    * key = the non-guessable string that identifies this DocumentUrl
    * expiration = (optional) timestamp, based on a new setting (now + settings.DOCUMENT_URLS_EXPIRE_IN)
    * ip = (optional) IP / range to limit IP address to client. Can be:
        * a single IP address, e.g., "10.16.239.82"
        * a comma-delimited string with 2 values, e.g., "10.16.239.82, 10.16.239.85"
        * an IP address with netmask, e.g., "10.16.239.82/24"
      (uses the iptools.IpRange object)
    """

    advancedirective = models.ForeignKey(
        AdvanceDirective,
        on_delete=models.CASCADE,
        help_text="The AdvanceDirective to which this URL points.",
    )
    key = models.CharField(
        max_length=48,
        unique=True,
        help_text="The non-guessable string that indentifies this DocumentUrl.",
    )
    expiration = models.DateTimeField(
        null=True,  # optional
        blank=True,
        help_text="The optional timestamp indicating when this DocumentUrl expires.",
    )
    ip = models.CharField(
        max_length=64,
        null=True,  # optional
        blank=True,
        help_text="The optional IP address or range to which this DocumentUrl is limited",
        verbose_name='IP',
    )

    def __str__(self):
        return self.url

    @property
    def url(self):
        return reverse('myhpom:document_url', kwargs={'key': self.key, 'filename': self.filename})

    @property
    def filename(self):
        return self.advancedirective.filename

    @property
    def ip_range(self):
        """return an IpRange object representing this instance's ip attribute"""
        if self.ip:
            return iptools.IpRange(*[ip.strip() for ip in self.ip.split(',')][:2])

    def authorized_client_ip(self, ip_address):
        """The given ip_address is valid if either:
        * the instance has no ip_range; or
        * the ip_address is in this instance's ip_range
        """
        if not self.ip_range:
            return True
        else:
            return ip_address in self.ip_range


def document_url_before_save(sender, instance, using, **kwargs):
    """
    * automatically calculate the key for new instances
    * automatically set the expiration timestamp for new instances
        (note: not overloading the expires attribute, since it is expects as a timestamp)
    """
    if not instance.pk:
        # protect against a (very-remotely-possible) key collision
        while not instance.key or sender.objects.filter(key=instance.key).exists():
            instance.key = base64.urlsafe_b64encode(str(uuid.uuid4()))
        if not instance.expiration:
            instance.expiration = now() + settings.DOCUMENT_URLS_EXPIRE_IN


models.signals.pre_save.connect(document_url_before_save, sender=DocumentUrl)
