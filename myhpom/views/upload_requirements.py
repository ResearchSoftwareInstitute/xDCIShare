from datetime import datetime
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from myhpom import models

MIN_YEAR = 1950

@login_required
def upload_requirements(request):
    """
    GET: show the upload/state_requirements form for the current user/state
        select file (using file picker on the "Select File" button)
    POST: upload the file to a temporary location and store that location in the session
        redirect to the upload/submit view.
    """
    context = {
        'user': request.user,
        'requirements': models.StateRequirement.for_state(request.user.userdetails.state),
        'MIN_YEAR': MIN_YEAR,
        'MAX_YEAR': datetime.now().year,
    }
    return render(request, "myhpom/upload/requirements.html", context=context)
