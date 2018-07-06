from django.shortcuts import render, redirect
from myhpom.models.state import State
from myhpom.models.health_network import HealthNetwork, PRIORITY
from myhpom.forms.choose_network import ChooseNetworkForm
import math


def choose_network(request):
    """
    Allow the logged in user to choose their health network.
    If the user is in an unsupported state, redirect to next_steps. Otherwise,
    GET: display the health networks available for the user's state
    POST: store user's the selected network, if any, and continue to next_steps
    """
    state = State.objects.get(name="NC")  # for now, since we don't have an auth user

    if request.method == "POST":
        form = ChooseNetworkForm(request.POST)
        custom_provider = (form.data.get("custom_provider") or '').strip()
        network_id = form.data.get("health_network")
        network = None
        if custom_provider != '':
            # see if it actually already exists
            networks = HealthNetwork.objects.filter(state=state, name=custom_provider.strip())
            if len(networks) > 0:
                network = networks[0]
            else:
                # add UserDetails.custom_provider (need login user to complete)
                pass
        elif network_id is not None:
            network = HealthNetwork.objects.get(id=network_id)

        if network is not None:
            # add a reference to this network to the user's UserDetails
            # -- need login user before this can be completed
            pass

        # go ahead to the dashboard even if the network has not been assigned.
        return redirect("myhpom:next_steps")

    # request.method == 'GET'
    state_networks = HealthNetwork.objects.filter(state=state)
    health_networks = {
        n: [network for network in state_networks if network.priority == n] for n in PRIORITY.keys()
    }
    # priority=0: 3 entries per row
    priority_0_rows = [
        health_networks[0][(row) * 3 : ((row) * 3) + 3]
        for row in range(int(math.ceil(len(health_networks[0]) / 3.)))
    ]
    _ = health_networks.pop(0)  # because we're going to iterate the groups with priority 1..N
    context = {
        'state': state,
        'health_networks': health_networks,
        "priority_0_rows": priority_0_rows,
        "PRIORITY": PRIORITY,
    }
    return render(request, 'myhpom/accounts/choose_network.html', context=context)
