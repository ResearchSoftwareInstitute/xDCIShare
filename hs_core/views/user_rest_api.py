from rest_framework.views import APIView
from rest_framework.response import Response

from theme.models import UserProfile


class UserInfo(APIView):
    def get(self, request):
        if not request.user.is_authenticated():
            return Response({ "title": "None", "organization": "None"})

        user_info = {
            "username": request.user.username,
            "email": '',
            "first_name": '',
            "id": '',
            "last_name": '',
            "middle_name": '',
            "state": '',
            "zipcode": '',
            "country": '',
            "date_of_birth": '',
            "last_four_ss": '',
            "phone_1": ''
        }

        if request.user.email:
            user_info['email'] = request.user.email
        if request.user.first_name:
            user_info['first_name'] = request.user.first_name
        if request.user.id:
            user_info['id'] = request.user.id
        if request.user.last_name:
            user_info['last_name'] = request.user.last_name

        user_profile = UserProfile.objects.filter(user=request.user).first()
        if user_profile.middle_name:
            user_info['middle_name'] = user_profile.middle_name
        if user_profile.state:
            user_info['state'] = user_profile.state
        if user_profile.zipcode:
            user_info['zipcode'] = user_profile.zipcode
        if user_profile.country:
            user_info['country'] = user_profile.country
        if user_profile.date_of_birth:
            user_info['date_of_birth'] = user_profile.date_of_birth
        if user_profile.last_four_ss:
            user_info['last_four_ss'] = user_profile.last_four_ss
        if user_profile.phone_1:
            user_info['phone_1'] = user_profile.phone_1

        return Response(user_info)

