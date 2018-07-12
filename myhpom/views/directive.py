from django.views.decorators.http import require_GET, require_POST
from django.shortcuts import render


@require_GET
def upload_index(request):
    # TODO a document is required for upload, what else?
    return render(request, 'myhpom/directive/upload.html')


@require_POST
def upload_ad(self):
    """ TODO document function """
    pass
