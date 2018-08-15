import os, tempfile

from .user import User
from django.db import models
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
        upload_to='myhpom/advance_directives',
        help_text='The first-page thumbnail image of the user\'s Advance Directive.',
    )

    @property
    def filename(self):
        return self.original_filename or os.path.basename(self.document.name)

    def save_thumbnail(self, save=True, res=PDF_RESOLUTION, **gsargs):
        mogrify = {'resize': "%dx>" % THUMBNAIL_WIDTH}
        self.render_images(
            save=save, save_thumbnail=True, allpages=False, res=res, mogrify=mogrify, **gsargs
        )

    def render_images(
        self, save=True, save_thumbnail=True, allpages=True, res=PDF_RESOLUTION, **gsargs
    ):
        """create one or more images of pages of the current document. 
        Requires that the AD has a document in storage
        Returns a list of (temporary) filenames (deleted after the AD object goes out of scope).
        * save=True: if true, saves (persists) the underlying model
        * save_thumbnail=True: if true, saves the first image as the AD.thumbnail
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
        gs = GS()  # ghostscript interpreter
        # first write the document to a temporary file in the filesystem
        tempdir = tempfile.mkdtemp()
        pdf_filename = os.path.join(tempdir, self.filename)
        with self.document.storage.open(self.document.name, 'rb') as f:
            fd = f.read()
        with open(pdf_filename, 'wb') as f:
            f.write(fd)
        # then use ghostscript to render it
        image_filenames = gs.render(pdf_filename, res=res, allpages=allpages, **gsargs)
        # and save a thumbnail
        if save_thumbnail is True and len(image_filenames or []) > 0:
            thumbnail_filename = image_filenames[0]
            fd = open(thumbnail_filename, 'rb').read()
            # the save name of the thumbnail is the document name + ext
            name = self.document.name + os.path.splitext(thumbnail_filename)[-1]
            self.thumbnail.save(name, ContentFile(fd), save=save)
        return image_filenames


def remove_documents_on_delete(sender, instance, using, **kwargs):
    if instance.thumbnail:
        instance.thumbnail.storage.delete(instance.thumbnail.name)
    if instance.document:
        instance.document.storage.delete(instance.document.name)


models.signals.post_delete.connect(remove_documents_on_delete, sender=AdvanceDirective)
