from functools import wraps
from django.http import HttpResponse, HttpResponseForbidden


class HttpResponseUnauthorized(HttpResponse):
    status_code = 401


def require_ajax_login(function):
    """ Require that the request is AJAX, and that the user is logged in. """
    @wraps(function)
    def wrapper(request):
        """ A request wrapper """
        if not request.is_ajax():
            return HttpResponseForbidden()
        if not request.user.is_authenticated():
            return HttpResponseUnauthorized()
        return function(request)
    return wrapper
