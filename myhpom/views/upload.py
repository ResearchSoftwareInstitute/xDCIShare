from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_GET, require_http_methods
from django.shortcuts import render, redirect
from django.http import HttpResponseRedirect
from django.core.urlresolvers import reverse
from django.utils.timezone import now

from myhpom.decorators import require_ajax
from myhpom.forms.upload_requirements import SharingForm, UploadRequirementsForm
from myhpom.models import AdvanceDirective, StateRequirement


@require_GET
@login_required
@require_ajax
def upload_index(request):
    return render(request, 'myhpom/upload/index.html')


@require_GET
@login_required
@require_ajax
def upload_current_ad(request):
    if not hasattr(request.user, 'advancedirective'):
        # TODO change this to an error response
        return HttpResponseRedirect(reverse('myhpom:upload_index'))

    return render(request, 'myhpom/upload/current_ad.html', {
        'advancedirective': request.user.advancedirective,
    })


@require_http_methods(['GET', 'POST'])
@login_required
@require_ajax
def upload_requirements(request):
    """
    GET: show the upload/state_requirements form for the current user/state
    POST: store the advance directive date, redirect to the upload/submit view.
    """
    MIN_YEAR = 1950
    if request.method == "POST":
        if hasattr(request.user, 'advancedirective'):
            directive = request.user.advancedirective
        else:
            directive = AdvanceDirective(user=request.user, share_with_ehs=False)
        form = UploadRequirementsForm(request.POST, instance=directive)
        if form.is_valid():
            directive.save()
            return redirect(reverse("myhpom:upload_sharing"))
    else:
        form = UploadRequirementsForm()
    context = {
        'user': request.user,
        'form': form,
        'requirements': StateRequirement.for_state(request.user.userdetails.state),
        'MIN_YEAR': MIN_YEAR,
        'MAX_YEAR': now().year,
        'widget_template': 'myhpom/upload/requirements.html'
    }
    return render(request, "myhpom/dashboard.html", context=context)


@require_http_methods(['GET', 'POST'])
@login_required
@require_ajax
def upload_sharing(request):
    if not hasattr(request.user, 'advancedirective'):
        # TODO change this to an error response
        return HttpResponseRedirect(reverse('myhpom:upload_index'))

    if request.method == 'POST':
        form = SharingForm(request.POST, instance=request.user.advancedirective)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('myhpom:upload_current_ad'))

    form = SharingForm(instance=request.user.advancedirective)
    return render(request, 'myhpom/upload/sharing.html', {
        'form': form,
    })
