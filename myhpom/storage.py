from django.core.files.storage import Storage
from django.core.urlresolvers import reverse

from django_irods.storage import IrodsStorage


class MyhpomStorage(IrodsStorage):
    """
    An IRODs based storage method that assigns filenames the same way that the
    default Storage class does, and uses MYHPOM specific URLs to access them.
    """

    def url(self, name):
        return reverse('myhpom:irods_download', kwargs={'path': name})

    def get_available_name(self, name):
        return super(Storage, self).get_available_name(name)
