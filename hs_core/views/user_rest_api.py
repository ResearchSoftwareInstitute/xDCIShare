from rest_framework.views import APIView
from rest_framework.response import Response

from theme.forms import UserProfileForm


class UserInfo(APIView):
    def get(self, request):
        if not request.user.is_authenticated():
            return Response({ "title": "None", "organization": "None"})

        user_info = {
            "username": ['Username', request.user.username],
            "email": ['Email', ''],
            "id": ['Id',''],
            "first_name": ['First name', ''],
            "last_name": ['Last name', ''],
            "middle_name": [UserProfileForm.base_fields['middle_name'].label, ''],
            "state": [UserProfileForm.base_fields['state'].label, ''],
            "zipcode": [UserProfileForm.base_fields['zipcode'].label, ''],
            "country": [UserProfileForm.base_fields['country'].label, ''],
            "date_of_birth": [UserProfileForm.base_fields['date_of_birth'].label, ''],
            "last_four_ss": [UserProfileForm.base_fields['last_four_ss'].label, ''],
            "phone_1": [UserProfileForm.base_fields['phone_1'].label, '']
        }

        if request.user.email:
            user_info['email'][1] = request.user.email
        if request.user.first_name:
            user_info['first_name'][1] = request.user.first_name
        if request.user.id:
            user_info['id'][1] = request.user.id
        if request.user.last_name:
            user_info['last_name'][1] = request.user.last_name

        user_profile = request.user.userprofile
        if user_profile.middle_name:
            user_info['middle_name'][1] = user_profile.middle_name
        if user_profile.state:
            user_info['state'][1] = user_profile.state
        if user_profile.zipcode:
            user_info['zipcode'][1] = user_profile.zipcode
        if user_profile.country:
            user_info['country'][1] = user_profile.country
        if user_profile.date_of_birth:
            user_info['date_of_birth'][1] = user_profile.date_of_birth
        if user_profile.last_four_ss:
            user_info['last_four_ss'][1] = user_profile.last_four_ss
        if user_profile.phone_1:
            user_info['phone_1'][1] = user_profile.phone_1

        return Response(user_info)

