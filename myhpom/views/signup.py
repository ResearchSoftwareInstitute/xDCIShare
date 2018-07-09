from django.shortcuts import render, redirect
from django.contrib import auth
from myhpom.forms.signup import SignupForm
from myhpom.models import User, UserDetails, State


def signup(request):
    """
    TODO:
    * send an email to the user after signup
    * auth.login() user
    """
    if request.method == "POST":
        form = SignupForm(request.POST)
        if form.is_valid():
            user_keys = ['first_name', 'last_name', 'email']
            user = User(**{key: val for key, val in form.data.items() if key in user_keys})
            user.set_password(form.data['password'])
            user.save()
            user_details = UserDetails(
                user=user,
                state=State.objects.get(name=form.data['state']),
                accept_tos=form.data['accept_tos'],
            )
            user_details.save()
            # auth.login(request, user)
            # **TODO** send email here
            if user_details.state.supported is True:
                return redirect('myhpom:choose_network')
            else:
                return redirect('myhpom:next_steps')
        # else it falls through to re-display the page with errors
    else:
        form = SignupForm()

    # fall through to re-rendering the form
    us_states = State.objects.all()
    return render(
        request, 'myhpom/accounts/signup.html', context={'form': form, 'us_states': us_states}
    )
