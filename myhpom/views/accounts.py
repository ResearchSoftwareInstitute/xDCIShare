from django.shortcuts import render, redirect
from django.views.decorators.http import require_GET
from django.contrib.auth.decorators import login_required

from myhpom.forms.choose_network import ChooseNetworkForm


@login_required
def next_steps(request):
    state = request.user.userdetails.state

    if state.advance_directive_template:
        context = {
            'ad_template': state.advance_directive_template,
        }
        return render(request, 'myhpom/accounts/next_steps.html', context)

    form = ChooseNetworkForm(instance=request.user.userdetails)

    if request.POST:
        form = ChooseNetworkForm(request.POST, instance=request.user.userdetails)
        if form.is_valid():
            form.save()
            return redirect("myhpom:dashboard")

    return render(request, 'myhpom/accounts/next_steps_no_ad_template.html', {
        'form': form,
    })
