from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_GET, require_http_methods
from django.shortcuts import render
from django.http import HttpResponseRedirect
from django.core.urlresolvers import reverse
from django.utils.timezone import now

from myhpom.forms.upload_requirements import SharingForm, UploadADForm
from myhpom.models import AdvanceDirective


@require_GET
@login_required
def upload_index(request):
    return render(request, 'myhpom/upload/index.html')


@require_http_methods(['GET', 'POST'])
@login_required
def upload_requirements(request):
    if request.method == 'POST':
        if hasattr(request.user, 'advancedirective'):
            form = UploadADForm(
                request.POST,
                request.FILES,
                instance=request.user.advancedirective
            )
        else:
            form = UploadADForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('myhpom:upload_sharing'))

    return render(request, 'myhpom/dashboard.html', {
        'widget_template': 'myhpom/upload/requirements.html'
    })


@require_GET
@login_required
def upload_current_ad(request):
    if not hasattr(request.user, 'advancedirective'):
        return HttpResponseRedirect(reverse('myhpom:upload_index'))

    return render(request, 'myhpom/dashboard.html', {
        'advancedirective': request.user.advancedirective,
        'widget_template': 'myhpom/upload/current_ad.html',
    })


@require_http_methods(['GET', 'POST'])
@login_required
def upload_sharing(request):
    if not hasattr(request.user, 'advancedirective'):
        return HttpResponseRedirect(reverse('myhpom:upload_requirements'))
        # TODO this check should be changed in MH-102 - it is assumed at
        # this point that a user has an advancedirective (if it doesn't
        # exist, go to upload_index).
        advancedirective = AdvanceDirective(user=request.user, valid_date=now(), share_with_ehs=False)
        advancedirective.save()
    else:
        advancedirective = request.user.advancedirective

    form = SharingForm(instance=advancedirective)

    if request.POST:
        form = SharingForm(request.POST, instance=advancedirective)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('myhpom:upload_current_ad'))

    return render(request, 'myhpom/dashboard.html', {
        'form': form,
        'widget_template': 'myhpom/upload/sharing.html'
    })
