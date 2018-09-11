import os
import random
import yaml

from django.conf import settings
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.http import Http404, HttpResponseRedirect
from django.views.decorators.http import require_GET
from django.contrib.staticfiles.templatetags.staticfiles import static
from django.core.urlresolvers import reverse

from myhpom import models
from myhpom.views.accounts import next_steps
from myhpom.views.auth import logout
from myhpom.views.choose_network import choose_network
from myhpom.views.content import content_page
from myhpom.views.irods import irods_download
from myhpom.views.upload import (upload_current_ad, upload_index, upload_requirements,
    upload_sharing, upload_delete_ad)
from myhpom.views.signup import signup
from myhpom.views.profile import (edit_profile, view_profile)
from myhpom.views.document import document_url

FAQS = yaml.load(open(os.path.join(settings.PROJECT_ROOT, '../myhpom/static/myhpom/data/faq.yaml'), 'r'))


@require_GET
def home(request):
    if request.user.is_authenticated():
        return redirect(reverse('myhpom:dashboard'))

    return render(
        request,
        'myhpom/home.html',
        {
            'hero_image': static('myhpom/img/home/mmh-home-%s.jpg' % (random.choice((1, 2, 3,)))),
        }
    )


@require_GET
def faq(request):
    context = {
        'faqs': FAQS,
    }
    return render(request, 'myhpom/faq.html', context)


@require_GET
def state_template(request, state):
    try:
        state = models.State.objects.get(name__iexact=state)
    except models.State.DoesNotExist:
        raise Http404()

    if not state.advance_directive_template:
        raise Http404()

    return HttpResponseRedirect(state.advance_directive_template.url)


@require_GET
@login_required
def dashboard(request):
    template = 'myhpom/upload/index.html'
    advancedirective = None
    if hasattr(request.user, 'advancedirective'):
        template = 'myhpom/upload/current_ad.html'
        advancedirective = request.user.advancedirective

    return render(request, 'myhpom/dashboard.html', {
        'widget_template': template,
        'advancedirective': advancedirective,
    })
