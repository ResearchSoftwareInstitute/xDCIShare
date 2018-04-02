from functools import wraps
from django.shortcuts import redirect
from django.utils.decorators import method_decorator


def profile_required(view_func):
    '''Checks all required UserProfile fields.'''
    def _wrapped_view(request, *args, **kwargs):
        profile = request.user.userprofile
        profile_valid = (profile.middle_name and
                            profile.state and
                            profile.zipcode and
                            profile.country and
                            profile.date_of_birth and
                            profile.last_four_ss and
                            profile.phone_1)
        if profile_valid:
            return view_func(request, *args, **kwargs)
        else:
            if request.environ.get('HTTP_REFERER', False):
                return redirect(request.environ['HTTP_REFERER'] + '#_')
            else:
                return redirect('/my-documents/#_')
    return _wrapped_view
