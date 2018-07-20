from functools import wraps
from django.http import HttpResponseForbidden


def require_ajax(function):
    """ Given a request method, return a http 4xx when the request is not an
    ajax request. """
    @wraps(function)
    def wrapper(request):
        """ A request wrapper """
        if not request.is_ajax():
            return HttpResponseForbidden()
        return function(request)
    return wrapper
