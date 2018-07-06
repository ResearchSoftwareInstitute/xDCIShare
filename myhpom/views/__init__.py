from django.shortcuts import render, redirect

from myhpom import models
from myhpom.views.signup import signup
from myhpom.views.choose_network import choose_network


def home(request):
    return render(request, 'myhpom/home.html')


def next_steps(request, state=''):
    if not state:
        # TODO: get user's associated state if state is not passed
        # in via URL
        state = 'NC'
    try:
        ad_template = models.StateAdvanceDirective.objects.get(
            state=state.upper()
        )
        context = {
            'ad_template': ad_template
        }
        return render(request, 'myhpom/accounts/next_steps.html', context)
    except models.StateAdvanceDirective.DoesNotExist:
        return render(request, 'myhpom/accounts/next_steps_no_ad_template.html')
