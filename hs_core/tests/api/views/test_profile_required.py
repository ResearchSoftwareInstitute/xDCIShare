import os
import shutil
import json

from django.contrib.auth.models import Group

from rest_framework import status

from hs_core import hydroshare
from hs_core.views import create_resource_select_resource_type
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

        self.user.userprofile.middle_name='Williams'
        self.user.userprofile.state='Iowa'
        self.user.userprofile.zipcode=50112
        self.user.userprofile.country= 'USA'
        self.user.userprofile.date_of_birth='06/21/1978'
        self.user.userprofile.last_four_ss=3476
        self.user.userprofile.phone_1='641-234-4573'
        self.user.userprofile.save()

    def tearDown(self):
        if os.path.exists(self.temp_dir):
            shutil.rmtree(self.temp_dir)
        super(TestProfileRequiredViewFunctions, self).tearDown()

    def test_view_create_resource_profile_complete(self):
        # here we are testing the profile_required on the
        # create_resource_select_resource_type view
        # with our profile complete

        url = '/hsapi/_internal/create-resource/'
        request = self.factory.get(url)
        request.user = self.user

        response = create_resource_select_resource_type(request)
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_view_create_resource_profile_not_complete(self):
        # here we are testing the profile_required on the
        # create_resource_select_resource_type view
        # with an incomplete profile

        # removing fields from profile
        self.user.userprofile.last_four_ss=None
        self.user.userprofile.phone_1=None
        self.user.userprofile.save()


        url = '/hsapi/_internal/create-resource/'
        request = self.factory.get(url)
        request.user = self.user

        response = create_resource_select_resource_type(request)
        self.assertEqual(response.status_code, status.HTTP_302_FOUND)
