from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_GET, require_POST
from django.shortcuts import render, redirect
from myhpom import models


@require_GET
@login_required
def upload_index(request):
    return render(request, 'myhpom/upload/index.html')


@login_required
def upload_requirements(request):
    """
    GET: show the upload/state_requirements form for the current user/state
    POST: redirect to the upload/submit view.
    """
    MIN_YEAR = 1950
    if request.method == "POST":
        return redirect("myhpom:upload_submit")
    context = {
        'user': request.user,
        'requirements': models.StateRequirement.for_state(request.user.userdetails.state),
        'MIN_YEAR': MIN_YEAR,
        'MAX_YEAR': datetime.now().year,
    }
    return render(request, "myhpom/upload/requirements.html", context=context)


@require_GET
@login_required
def upload_sharing(request):
    return render(request, 'myhpom/dashboard.html', {
        'widget_template': 'myhpom/upload/sharing.html'
    })


@require_GET
@login_required
def upload_current_ad(request):
    return render(request, 'myhpom/dashboard.html', {
        'widget_template': 'myhpom/upload/current_ad.html'
    })


@require_POST
@login_required
def upload_submit(request):
    # TODO check the incoming file size
    # TODO checkboxes, etc
    # TODO redirect on submit
    return render(request, 'myhpom/dashboard.html', {
        'widget_template': 'myhpom/upload/sharing.html'
    })
