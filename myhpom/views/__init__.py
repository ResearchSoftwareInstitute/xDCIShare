from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_GET
from django.core.urlresolvers import reverse

from myhpom import models
from myhpom.views.accounts import next_steps
from myhpom.views.auth import logout
from myhpom.views.choose_network import choose_network
from myhpom.views.upload import (upload_current_ad, upload_index, upload_requirements,
    upload_sharing, upload_delete_ad)
from myhpom.views.signup import signup


@require_GET
def home(request):
    if request.user.is_authenticated():
        return redirect(reverse('myhpom:dashboard'))

    return render(request, 'myhpom/home.html')


@require_GET
@login_required
def dashboard(request):
    template = 'myhpom/upload/index.html'
    advancedirective = None
    if hasattr(request.user, 'advancedirective'):
        template = 'myhpom/upload/current_ad.html'
        advancedirective = request.user.advancedirective

    return render(request, 'myhpom/dashboard.html', {
        'widget_template': template,
        'advancedirective': advancedirective,
    })
