from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_GET
from django.http import HttpResponse, Http404
import mimetypes


@require_GET
@login_required
def download_template(request):
    state = request.user.userdetails.state
    if not hasattr(state, 'advance_directive_template') or not hasattr(
        state.advance_directive_template, 'path'
    ):
        raise Http404("Advance Directive Template not found for %s" % (state.title,))
    else:
        with open(state.advance_directive_template.path, 'rb') as f:
            data = f.read()
        content_type = (
            mimetypes.guess_type(state.advance_directive_template.name)[0] or 'application/pdf'
        )
        return HttpResponse(data, content_type=content_type)
