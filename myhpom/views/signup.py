from django.contrib.auth import authenticate, login
from django.contrib.auth.models import User
from django.core.urlresolvers import reverse
from django.shortcuts import redirect, render

from myhpom.forms.signup import SignupForm
from myhpom.models import State, UserDetails


def signup(request):
    if request.user.is_authenticated():
        return redirect(reverse('myhpom:dashboard'))

    if request.method == "POST":
        form = SignupForm(request.POST)
        if form.is_valid():
            user_keys = ['first_name', 'last_name', 'email']
            user = User(**{key: val for key, val in form.data.items() if key in user_keys})
            user.set_password(form.cleaned_data['password'])
            user.save()
            user_details = UserDetails(
                user=user,
                state=State.objects.get(name=form.cleaned_data['state']),
                middle_name=form.cleaned_data['middle_name'],
                accept_tos=form.cleaned_data['accept_tos'],
            )
            user_details.save()

            user = authenticate(
                username=form.cleaned_data['email'], password=form.cleaned_data['password']
            )
            login(request, user)

            if user_details.state.healthnetwork_set.exists():
                return redirect('myhpom:choose_network')
            else:
                return redirect('myhpom:next_steps')
        # else it falls through to re-display the page with errors
    else:
        form = SignupForm()

    # fall through to re-rendering the form
    us_states = State.objects.all().order_by_ad()
    return render(
        request, 'myhpom/accounts/signup.html', context={'form': form, 'us_states': us_states}
    )
