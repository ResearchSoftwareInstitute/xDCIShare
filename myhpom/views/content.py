from django.http import Http404
from django.shortcuts import render
from django.views.decorators.http import require_http_methods


SLUG_TO_TEMPLATE = {
    'why-plan': 'myhpom/content/why-plan.html',
}


@require_http_methods(['GET'])
def content_page(request, slug):
    if slug not in SLUG_TO_TEMPLATE:
        raise Http404
    return render(request, SLUG_TO_TEMPLATE[slug])
