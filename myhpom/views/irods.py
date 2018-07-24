import mimetypes

from django.contrib.auth.decorators import login_required
from django.http import FileResponse
from django.views.decorators.http import require_GET
from django.http import HttpResponseForbidden

from django_irods.icommands import GLOBAL_SESSION

from myhpom.models import AdvanceDirective


@require_GET
@login_required
def irods_download(request, path):
    # TODO check the path for malicious structure.

    ad = AdvanceDirective.objects.filter(document=path).first()
    if ad is None or ad.user != request.user:
        return HttpResponseForbidden()

    session = GLOBAL_SESSION

    # obtain mime_type to set content_type
    mtype = 'application-x/octet-stream'
    mime_type = mimetypes.guess_type(path)
    if mime_type[0] is not None:
        mtype = mime_type[0]
    # retrieve file size to set up Content-Length header
    stdout = session.run('ils', None, '-l', path)[0].split()
    options = ('-',)  # we're redirecting to stdout.
    proc = session.run_safe('iget', None, path, *options)
    response = FileResponse(proc.stdout, content_type=mtype)
    response['Content-Disposition'] = 'attachment; filename="{name}"'.format(name=ad.original_filename)
    response['Content-Length'] = int(stdout[3])
    return response
