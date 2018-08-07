from django.core.urlresolvers import reverse
from django.test import TestCase
from django.utils.timezone import now
from mock import MagicMock, PropertyMock, patch

from django_irods.icommands import SessionException
from myhpom.models import AdvanceDirective
from myhpom.tests.factories import UserFactory


def run_side_effect(*args, **kwargs):
    """ side_effect for run() with example output for irods commands. """
    # Session.run() returns (stdout, stderr)
    if args[0] == 'ils':
        return ('wwwHydroProx      0 hydroshareReplResc            7 2018-08-06.18:05 & tmpBktX04', '')


def run_safe_side_effect(*args, **kwargs):
    """ side_effect for run_safe() with example output for irods commands. """
    # Session.run_safe() returns a process
    if args[0] == 'iget':
        proc_mock = MagicMock()
        type(proc_mock).stdout = PropertyMock(return_value='content')
        return proc_mock


@patch('myhpom.views.irods.GLOBAL_SESSION')
class IrodsDownloadTest(TestCase):
    url = reverse('myhpom:irods_download', kwargs={'path': 'a_path'})

    def test_non_existant(self, session_mock):
        # If the path does not exist in irods, return an error
        session_mock.run.side_effect = SessionException(1, '', '')
        response = self.client.get(self.url)
        self.assertEqual(404, response.status_code)

    def test_file(self, session_mock):
        # When the file is in the system, but isn't an AdvanceDirective,
        # any user should be able to download the file (regardless of whether
        # they are logged in or not)
        session_mock.run.side_effect = run_side_effect
        session_mock.run_safe.side_effect = run_safe_side_effect
        response = self.client.get(self.url)
        self.assertEqual(''.join(response.streaming_content), 'content')

    def test_mime_type(self, session_mock):
        # The content type is populated if possible - a rando filename will
        # result in octet-stream:
        session_mock.run.side_effect = run_side_effect
        session_mock.run_safe.side_effect = run_safe_side_effect
        response = self.client.get(self.url)
        self.assertEqual('application-x/octet-stream', response.get('content-type'))

        # A PDF file will have the correct content type:
        self.url = reverse('myhpom:irods_download', kwargs={'path': 'a_path.pdf'})
        response = self.client.get(self.url)
        self.assertEqual('application/pdf', response.get('content-type'))

    def test_advance_directive(self, session_mock):
        # When the file is an AdvanceDirective, the user must be logged in and
        # they must own the file in order to download it.
        session_mock.run.side_effect = run_side_effect
        session_mock.run_safe.side_effect = run_safe_side_effect
        user = UserFactory()
        user.set_password('password')
        user.save()

        # If the user is not logged in, then return an error
        advancedirective = AdvanceDirective(user=user, valid_date=now(), document='a_path', share_with_ehs=False)
        advancedirective.save()
        response = self.client.get(self.url)
        self.assertEqual(404, response.status_code)

        # When the user is logged in, they can retrieve their file:
        self.assertTrue(self.client.login(username=user.username, password='password'))
        response = self.client.get(self.url)
        self.assertEqual(''.join(response.streaming_content), 'content')

        # When the user doesn't own the path, return an error
        another_user = UserFactory()
        advancedirective.user = another_user
        advancedirective.save()
        response = self.client.get(self.url)
        self.assertEqual(404, response.status_code)
