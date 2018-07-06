from django.shortcuts import render, redirect

from myhpom import models
from myhpom.views.signup import signup


def home(request):
    return render(request, 'myhpom/home.html')


def choose_network(request):
    return redirect('myhpom:home')


def choose_network(request):
    context = {
        'state': 'North Carolina',
    }
    return render(request, 'myhpom/accounts/choose_network.html', context)


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
