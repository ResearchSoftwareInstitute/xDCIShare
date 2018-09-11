import mimetypes
import requests
from ipware import get_client_ip
from django.http import Http404, HttpResponse, FileResponse
from django.utils.timezone import now
from django.contrib.sites.models import Site
from myhpom.models import DocumentUrl


def document_url(request, key, filename):
    """download the document at the given url.
    * key: the DocumentUrl.key by which to find the document
    * filename: included in the URL to provide a sensible filename and to verify the URL
    """
    # protect on client_ip, doc_url match, expiration, and filename
    client_ip, _ = get_client_ip(request)
    doc_url = DocumentUrl.objects.filter(key=key).first()
    if (
        not client_ip
        or not doc_url
        or (doc_url.expiration is not None and doc_url.expiration < now())
        or (doc_url.ip is not None and not doc_url.authorized_client_ip(client_ip))
        or not doc_url.advancedirective.document
        or filename != doc_url.advancedirective.filename
    ):
        raise Http404()

    # If we've gotten this far, the doc_url is valid, so send the document
    ad = doc_url.advancedirective
    response = FileResponse(
        ad.document.file,
        content_type=(mimetypes.guess_type(ad.filename)[0] or 'application-x/octet-stream'),
    )
    response['Content-Disposition'] = 'inline; filename="{filename}"'.format(filename=ad.filename)
    return response
