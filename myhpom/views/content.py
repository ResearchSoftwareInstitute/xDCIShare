from django.shortcuts import render
from django.views.decorators.http import require_GET


@require_GET
def content_page(request, template):
    return render(request, template)
