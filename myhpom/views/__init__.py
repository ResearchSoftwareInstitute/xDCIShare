from django.shortcuts import render, redirect
from django.views.decorators.http import require_GET
from django.contrib.auth.decorators import login_required

from myhpom import models
from myhpom.views.signup import signup
from myhpom.views.accounts import choose_network, next_steps
from myhpom.views.auth import logout


@require_GET
def home(request):
    return render(request, 'myhpom/home.html')


@require_GET
def dashboard(request):
    return render(request, 'myhpom/dashboard.html')
