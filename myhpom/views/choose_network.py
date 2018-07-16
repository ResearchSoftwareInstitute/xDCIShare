from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from myhpom.models.health_network import HealthNetwork, PRIORITY
from myhpom.forms.choose_network import ChooseNetworkForm
import math


@login_required
def choose_network(request):
    """
    Allow the logged in user to choose their health network.
    If the user is in an unsupported state, redirect to next_steps. Otherwise,
    GET: display the health networks available for the user's state
    POST: store user's the selected network, if any, and continue to next_steps
    """
    user_details = request.user.userdetails
    state = user_details.state
    form = ChooseNetworkForm(instance=request.user.userdetails)

    if request.POST:
        form = ChooseNetworkForm(
            request.POST,
            instance=request.user.userdetails,
        )
        if form.is_valid():
            form.save()

            return redirect("myhpom:next_steps")

    # request.method == 'GET'
    if not user_details.state.healthnetwork_set.exists():
        return redirect("myhpom:next_steps")

    state_networks = HealthNetwork.objects.filter(state=state)
    health_networks = {
        n: [network for network in state_networks if network.priority == n] for n in PRIORITY.keys()
    }
    # priority=0: 3 entries per row
    priority_0_rows = [
        health_networks[0][(row) * 3:((row) * 3) + 3]
        for row in range(int(math.ceil(len(health_networks[0]) / 3.)))
    ]
    health_networks.pop(0)  # we're going to iterate only the groups with priority 1..N
    context = {
        "state": state,
        "health_networks": health_networks,
        "priority_0_rows": priority_0_rows,
        "PRIORITY": PRIORITY,
        "form": form,
    }
    return render(request, 'myhpom/accounts/choose_network.html', context=context)
