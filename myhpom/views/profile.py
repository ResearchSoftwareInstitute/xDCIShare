from django.shortcuts import render, redirect
from django.views.decorators.http import require_http_methods
from django.contrib.auth.decorators import login_required
from myhpom.forms.profile import EditUserForm, EditUserDetailsForm
from myhpom.models.user import User
from datetime import datetime


@require_http_methods(['GET'])
@login_required
def view_profile(request):
    return render(request, 'myhpom/profile/view.html', {'user': request.user})


@require_http_methods(['GET', 'POST'])
@login_required
def edit_profile(request):
    user = User.objects.get(username=request.user.username)
    if request.method == 'POST':
        user_form = EditUserForm(data=request.POST, instance=user)
        user_details_form = EditUserDetailsForm(data=request.POST, instance=user.userdetails)
        if user_form.is_valid() and user_details_form.is_valid():
            user_form.save()
            user_details_form.save()
            return redirect('myhpom:view_profile')
    else:
        # populate the forms with values from the User profile
        user_data = {key: user.__getattribute__(key) for key in EditUserForm().fields.keys()}
        user_details_data = {
            key: user.userdetails.__getattribute__(key)
            for key in EditUserDetailsForm().fields.keys()
        }
        user_form = EditUserForm(data=user_data, instance=user)
        user_details_form = EditUserDetailsForm(data=user_details_data, instance=user.userdetails)

    return render(
        request,
        'myhpom/profile/edit.html',
        {
            'user_form': user_form,
            'user_details_form': user_details_form,
            'MIN_YEAR': datetime.now().year - 120,  # seems old enough...
            'MAX_YEAR': datetime.now().year,
        },
    )
