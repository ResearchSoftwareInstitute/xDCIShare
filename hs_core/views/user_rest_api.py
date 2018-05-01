from django.contrib.auth.forms import UserChangeForm

from rest_framework.views import APIView
from rest_framework.response import Response

from theme.forms import UserProfileForm


class UserInfo(APIView):
    def get(self, request):
        if not request.user.is_authenticated():
            return Response({ "title": "None", "organization": "None"})

        user_profile = request.user.userprofile
        user_info = {
            "username": [UserChangeForm.base_fields['username'].label, request.user.username],
            "id": ['Id', getattr(request.user, 'id', '')],
            "email": [UserChangeForm.base_fields['email'].label, getattr(request.user, 'email', '')],
            "first_name": [UserChangeForm.base_fields['first_name'].label, getattr(request.user, 'first_name', '')],
            "last_name": [UserChangeForm.base_fields['last_name'].label, getattr(request.user, 'last_name', '')],
            "middle_name": [UserProfileForm.base_fields['middle_name'].label, getattr(user_profile, 'middle_name', '')],
            "state": [UserProfileForm.base_fields['state'].label, getattr(user_profile, 'state', '')],
            "zipcode": [UserProfileForm.base_fields['zipcode'].label, getattr(user_profile, 'zipcode', '')],
            "country": [UserProfileForm.base_fields['country'].label, getattr(user_profile, 'country', '')],
            "date_of_birth": [UserProfileForm.base_fields['date_of_birth'].label, getattr(user_profile, 'date_of_birth', '')],
            "last_four_ss": [UserProfileForm.base_fields['last_four_ss'].label, getattr(user_profile, 'last_four_ss', '')],
            "phone_1": [UserProfileForm.base_fields['phone_1'].label, getattr(user_profile, 'phone_1', '')]
        }

        return Response(user_info)

