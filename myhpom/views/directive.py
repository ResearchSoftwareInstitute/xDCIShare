from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_GET, require_POST
from django.shortcuts import render, redirect
from django.core.urlresolvers import reverse
from myhpom import models
from myhpom.forms.upload_requirements import UploadRequirementsForm
from datetime import datetime


@require_GET
@login_required
def upload_index(request):
    return render(request, 'myhpom/upload/index.html')


@login_required
def upload_requirements(request):
    """
    GET: show the upload/state_requirements form for the current user/state
    POST: store the advance directive date, redirect to the upload/submit view.
    """
    MIN_YEAR = 1950
    if request.method == "POST":
        form = UploadRequirementsForm(request.POST)
        if form.is_valid():
            if hasattr(request.user, 'advancedirective'):
                directive = request.user.advancedirective
            else:
                directive = models.AdvanceDirective(user=request.user, share_with_ehs=False)
            directive.valid_date = form.cleaned_data['valid_date']
            directive.save()
            return redirect("myhpom:upload_submit")
    else:
        form = UploadRequirementsForm()
    context = {
        'user': request.user,
        'form': form,
        'requirements': models.StateRequirement.for_state(request.user.userdetails.state),
        'MIN_YEAR': MIN_YEAR,
        'MAX_YEAR': datetime.now().year,
        'widget_template': 'myhpom/upload/requirements.html'
    }
    return render(request, "myhpom/dashboard.html", context=context)


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


@login_required
def upload_submit(request):
    # TODO check the incoming file size
    # TODO checkboxes, etc
    # TODO redirect on submit
    return render(request, 'myhpom/dashboard.html', {
        'widget_template': 'myhpom/upload/sharing.html'
    })
