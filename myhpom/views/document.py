import mimetypes
import requests
from ipware import get_client_ip
from django.http import Http404, HttpResponse, FileResponse
from django.utils.timezone import now
from django.contrib.sites.models import Site
from myhpom.models import DocumentKey


def document_by_key(request, key, filename):
    """download the document at the given url.
    * key: the DocumentKey.key by which to find the document
    * filename: included in the URL to provide a sensible filename and to verify the URL
    """
    # protect on client_ip, doc_key match, expiration, and filename
    client_ip, _ = get_client_ip(request)
    doc_key = DocumentKey.objects.filter(key=key).first()
    if (
        not client_ip
        or not doc_key
        or (doc_key.expiration is not None and doc_key.expiration < now())
        or (doc_key.ip is not None and not doc_key.valid_client_ip(client_ip))
        or not doc_key.advancedirective.document
        or filename != doc_key.advancedirective.filename
    ):
        raise Http404()

    # If we've gotten this far, the doc_key is valid, so send the document
    ad = doc_key.advancedirective
    response = FileResponse(
        ad.document.file,
        content_type=(mimetypes.guess_type(ad.filename)[0] or 'application-x/octet-stream'),
    )
    response['Content-Disposition'] = 'inline; filename="{filename}"'.format(filename=ad.filename)
    return response
