from django.core.files.storage import Storage
from django.core.urlresolvers import reverse

from django_irods.storage import IrodsStorage


class MyhpomStorage(IrodsStorage):
    """
    An IRODs based storage method that assigns filenames the same way that the
    default Storage class does, and uses MYHPOM specific URLs to access them.
    """

    def url(self, name):
        # Rather than relying on views in the irods package (which require yet
        # other hydroshare specific applications), provide one for myhpom:
        return reverse('myhpom:irods_download', kwargs={'path': name})

    def get_available_name(self, name):
        # Use the default method of creating the name used to save 'name' as.
        # The IrodsStorage implementation will prevent files with the same
        # 'name' from being stored:
        return Storage.get_available_name(self, name)
