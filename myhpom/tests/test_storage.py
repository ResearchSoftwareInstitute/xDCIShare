from django.core.urlresolvers import reverse
from django.test import TestCase

from myhpom.storage import MyhpomStorage

from StringIO import StringIO


class MyhpomStorageTest(TestCase):
    def setUp(self):
        self.storage = MyhpomStorage()

    def test_url(self):
        # A URL is returned that is myhpom specific:
        self.assertEqual(
            reverse('myhpom:irods_download', kwargs={'path': 'path'}),
            self.storage.url('path')
        )

    def test_save(self):
        # ensure that the user can save multiple files with the same name.
        a_name_1 = self.storage.save('a_name', StringIO('content'))
        a_name_2 = self.storage.save('a_name', StringIO('other_content'))
        self.assertNotEqual(a_name_1, a_name_2)
        self.assertTrue('a_name' in a_name_1)
        self.assertTrue('a_name' in a_name_2)
