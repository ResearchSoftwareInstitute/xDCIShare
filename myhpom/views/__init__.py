from django.shortcuts import render, redirect
from django.views.decorators.http import require_GET
from django.contrib.auth.decorators import login_required

from myhpom import models
from myhpom.views.signup import signup


@require_GET
def home(request):
    return render(request, 'myhpom/home.html')


@require_GET
def choose_network(request):
    return redirect('myhpom:home')


@require_GET
def dashboard(request):
    return render(request, 'myhpom/dashboard.html')


@require_GET
@login_required
def next_steps(request):
    state = request.user.userdetails.state
    if state.advance_directive_template:
        context = {
            'ad_template': state.advance_directive_template
        }
        return render(request, 'myhpom/accounts/next_steps.html', context)
    return render(request, 'myhpom/accounts/next_steps_no_ad_template.html')
