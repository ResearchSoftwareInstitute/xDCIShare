import os
import shutil

from django.contrib.auth.models import Group
from django.core.urlresolvers import reverse

from rest_framework import status

from mezzanine.pages.models import Page
from mezzanine.pages.models import RichTextPage

from hs_core import hydroshare
from hs_core.views import create_resource_select_resource_type, my_resources
from hs_core.testing import MockIRODSTestCaseMixin, ViewTestCase


class TestProfileRequiredViewFunctions(MockIRODSTestCaseMixin, ViewTestCase):
    def setUp(self):
        super(TestProfileRequiredViewFunctions, self).setUp()
        self.group, _ = Group.objects.get_or_create(name='Resource Author')
        self.username = 'john'
        self.password = 'jhmypassword'
        self.user = hydroshare.create_account(
            'john@gmail.com',
            username=self.username,
            first_name='John',
            last_name='Clarson',
            superuser=False,
            password=self.password,
            groups=[]
        )

        self.user.userprofile.middle_name = 'Williams'
        self.user.userprofile.state = 'Iowa'
        self.user.userprofile.zipcode = 50112
        self.user.userprofile.country = 'USA'
        self.user.userprofile.date_of_birth = '06/21/1978'
        self.user.userprofile.last_four_ss = 3476
        self.user.userprofile.phone_1 = '641-234-4573'
        self.user.userprofile.save()

        self.client.login(username=self.username, password=self.password)

    def tearDown(self):
        if os.path.exists(self.temp_dir):
            shutil.rmtree(self.temp_dir)
        super(TestProfileRequiredViewFunctions, self).tearDown()

    def test_view_create_resource_profile_complete(self):
        # here we are testing the profile_required on the
        # create_resource_select_resource_type view
        # with our profile complete

        url = reverse('create_resource_select_resource_type')
        request = self.factory.get(url)
        request.user = self.user

        response = create_resource_select_resource_type(request)

        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_view_create_resource_profile_not_complete(self):
        # here we are testing the profile_required decorator
        # on a view when a user has not filled out their profile

        # removing fields from profile
        self.user.userprofile.last_four_ss=None
        self.user.userprofile.phone_1=None
        self.user.userprofile.save()


        url = reverse('create_resource_select_resource_type')
        request = self.factory.get(url)
        request.user = self.user

        response = create_resource_select_resource_type(request)

        self.assertEqual(response.status_code, status.HTTP_302_FOUND)

        # seeing if the redirect url is the one set in the
        # profile_required decorator by default
        redirect_url = response._headers['location'][1]
        self.assertEqual(redirect_url, "/my-documents/#_")

        my_documents_page, _ = RichTextPage.objects.get_or_create(title='My Documents', slug='my-documents')
        response2 = self.client.get(redirect_url, follow=True)

        # seeing if the redirect was successful and that the page
        self.assertEqual(response2.status_code, status.HTTP_200_OK)
        self.assertEqual(response2.context[-1]['_current_page'].id, my_documents_page.id)

    def test_view_create_resource_profile_not_complete_with_referer(self):
        # here we are testing the profile_required decorator
        # on a view when a user has not filled out their profile
        # and where the user is coming from a specific page

        # removing fields from profile
        self.user.userprofile.last_four_ss=None
        self.user.userprofile.phone_1=None
        self.user.userprofile.save()

        url = reverse('create_resource_select_resource_type')
        request = self.factory.get(url)
        request.user = self.user

        # setting the page that the user is on
        request.environ['HTTP_REFERER'] = '/where-i-was/'

        response = create_resource_select_resource_type(request)

        self.assertEqual(response.status_code, status.HTTP_302_FOUND)

        # seeing if the redirect url is the same page
        # the user came from
        redirect_url = response._headers['location'][1]
        self.assertEqual(redirect_url, "/where-i-was/#_")

        my_documents_page, _ = RichTextPage.objects.get_or_create(title='Where I was', slug='where-i-was')
        response2 = self.client.get(redirect_url, follow=True)

        # seeing that redirect was successful and that the page
        self.assertEqual(response2.status_code, status.HTTP_200_OK)
        self.assertEqual(response2.context[-1]['_current_page'].id, my_documents_page.id)
