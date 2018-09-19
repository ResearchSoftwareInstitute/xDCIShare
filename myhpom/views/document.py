import mimetypes
from ipware import get_client_ip
from django.http import Http404, FileResponse
from django.utils.timezone import now
from django.views.decorators.http import require_GET
from myhpom.models import DocumentUrl


@require_GET
def document_url(request, key):
    """download the document at the given url.
    * key = the DocumentUrl.key by which to find the document
    """
    # -- the DocumentUrl has to exist and match
    doc_url = DocumentUrl.objects.filter(key=key).first()
    if not doc_url or not doc_url.advancedirective.document:
        raise Http404()

    # -- the client_ip should exist and be authorized
    client_ip, _ = get_client_ip(request)
    if not client_ip or not doc_url.authorized_client_ip(client_ip):
        raise Http404()

    # -- the document url should not be expired
    if doc_url.expiration and doc_url.expiration < now():
        raise Http404()

    # -- it's also possible that the document file was removed for some reason.
    try:
        document_file = doc_url.advancedirective.document.file
    except:
        raise Http404()

    # If we've gotten this far, the doc_url is valid, so send the document
    response = FileResponse(
        document_file,
        content_type=(mimetypes.guess_type(doc_url.filename)[0] or 'application-x/octet-stream'),
    )
    response['Content-Disposition'] = 'inline; filename="%s"' % doc_url.filename
    return response