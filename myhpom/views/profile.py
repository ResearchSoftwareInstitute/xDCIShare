from django.shortcuts import render, redirect
from django.views.decorators.http import require_http_methods
from django.contrib.auth.decorators import login_required


@require_http_methods(['GET', 'POST'])
@login_required
def edit_profile(request):
    user = request.user

    if request.POST:
        pass

    return render(request, 'myhpom/profile/edit.html', {
        'form': form,
    })
