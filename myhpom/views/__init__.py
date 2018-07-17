from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_GET
from django.core.urlresolvers import reverse

from myhpom import models
from myhpom.views.accounts import next_steps
from myhpom.views.auth import logout
from myhpom.views.choose_network import choose_network
from myhpom.views.upload import (upload_current_ad, upload_index, upload_requirements,
    upload_sharing)
from myhpom.views.signup import signup
from myhpom.views.download_template import download_template


@require_GET
def home(request):
    if request.user.is_authenticated():
        return redirect(reverse('myhpom:dashboard'))

    return render(request, 'myhpom/home.html')


@require_GET
@login_required
def dashboard(request):
    state = request.user.userdetails.state
    if (not hasattr(state, 'advance_directive_template') 
        or not hasattr(state.advance_directive_template, 'path')
    ):
        advance_directive_template = None
    else:
        advance_directive_template = state.advance_directive_template
    return render(request, 'myhpom/dashboard.html', {
        'widget_template': 'myhpom/upload/index.html',
        'advance_directive_template': advance_directive_template,
    })
