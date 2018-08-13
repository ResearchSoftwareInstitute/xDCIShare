import mimetypes

from django.http import FileResponse
from django.views.decorators.http import require_GET
from django.http import HttpResponseNotFound

from django_irods.icommands import GLOBAL_SESSION, SessionException

from myhpom.models import AdvanceDirective


@require_GET
def irods_download(request, path):
    """ Return a public file in the system, or a file that a user owns.

    NOTE: this method assumes that MyhpomStorage is set as the
    DEFAULT_FILE_STORAGE method (that the system under test is using irods for
    file system).

    This method also assumes that the system is configured with
    IRODS_GLOBAL_SESSION=True and USE_IRODS=True. (The django_irods application
    supports non-global sessions, but hydroshare itself was configured in
    staging/production without it.)
    """
    # Retrieve file size to set up Content-Length header
    file_name = path.split('/')[-1]

    try:
        path_info = GLOBAL_SESSION.run('ils', None, '-l', path)[0].split()
    except SessionException as se:
        return HttpResponseNotFound()

    # If the path is also an AD, make sure it is owned by the user:
    ad = AdvanceDirective.objects.filter(document=path).first()
    if ad and (request.user is None or ad.user != request.user):
        return HttpResponseNotFound()

    if ad:
        file_name = ad.original_filename

    # obtain mime_type to set content_type
    mtype = 'application-x/octet-stream'
    mime_type = mimetypes.guess_type(path)
    if mime_type[0] is not None:
        mtype = mime_type[0]

    # Get the file from irods, and return via stdout
    proc = GLOBAL_SESSION.run_safe('iget', None, path, '-')
    response = FileResponse(proc.stdout, content_type=mtype)
    response['Content-Disposition'] = 'inline; filename="{name}"'.format(name=file_name)
    response['Content-Length'] = int(path_info[3])
    return response
