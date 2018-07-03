from django.shortcuts import render

from myhpom import models


def home(request):
    return render(request, 'myhpom/home.html')


def signup(request):
    # NOTE: this can be replaced with an appropriate CBV or whatever
    # as necessary; for now it is a placeholder to render a template.
    return render(request, 'myhpom/accounts/signup.html')


def next_steps(request):
    # TODO: when the user profile is set up, use the request's associated
    # user to determine what this should be.
    MOCK_USER_STATE_CHOICE = 'NC'
    try:
        ad_template = models.StateAdvanceDirective.objects.get(
            state=MOCK_USER_STATE_CHOICE
        )
        context = {
            'ad_template': ad_template
        }
        return render(request, 'myhpom/accounts/next_steps.html', context)
    except models.StateAdvanceDirective.DoesNotExist:
        return render(request, 'myhpom/accounts/next_steps_no_ad_template.html')
