from django.shortcuts import render, redirect
from django.views.decorators.http import require_GET
from django.contrib.auth.decorators import login_required


@require_GET
def choose_network(request):
    return redirect('myhpom:home')


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
