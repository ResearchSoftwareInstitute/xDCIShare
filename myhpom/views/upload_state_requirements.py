from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from myhpom import models

EARLIEST_YEAR = 1950


@login_required
def upload_state_requirements(request):
    """
    GET: show the upload/state_requirements form for the current user/state
        select file (using file picker on the "Select File" button)
    POST: upload the file to a temporary location and store that location in the session
        redirect to the upload/submit view.
    """
    context = {'user': request.user, 'requirements': models.StateRequirement.for_state(user.state)}
    return render(request, "myhpom/upload/state_requirements.html", context=context)
