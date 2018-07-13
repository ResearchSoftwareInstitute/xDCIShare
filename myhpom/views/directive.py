from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_GET, require_POST
from django.shortcuts import render


@require_GET
@login_required
def upload_index(request):
    return render(request, 'myhpom/upload/index.html')


@require_GET
@login_required
def upload_requirements(request):
    # TODO provide a one page 'select document' page.
    return render(request, 'myhpom/upload/requirements.html')


@require_GET
@login_required
def upload_sharing(request):
    return render(request, 'myhpom/upload/sharing.html')


@require_GET
@login_required
def upload_current_ad(request):
    return render(request, 'myhpom/upload/current_ad.html')


@require_POST
@login_required
def upload_submit(request):
    # TODO check the incoming file size
    # TODO checkboxes, etc
    # TODO redirect on submit
    return render(request, 'myhpom/upload/sharing.html')
