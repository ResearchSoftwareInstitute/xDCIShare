from django.shortcuts import render
from django.views.decorators.http import require_http_methods


@require_http_methods(['GET'])
def why_plan(request):
    return render(request, 'myhpom/content/why-plan.html')
