from django.core.urlresolvers import reverse
from django.test import TestCase

from myhpom.storage import MyhpomStorage


class MyhpomStorageTest(TestCase):
    def setUp(self):
        self.storage = MyhpomStorage()

    def test_url(self):
        # A URL is returned that is myhpom specific:
        self.assertEqual(
            reverse('myhpom:irods_download', kwargs={'path': 'path'}),
            self.storage.url('path')
        )
