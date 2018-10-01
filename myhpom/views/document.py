import json
import mimetypes
from ipware import get_client_ip
from django.http import HttpResponseBadRequest, Http404, FileResponse, HttpResponse
from django.utils.timezone import now
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_GET, require_POST
from myhpom.models import DocumentUrl, CloudFactoryDocumentRun
from myhpom.tasks import EmailUserDocumentReviewCompleted


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


@require_POST
@csrf_exempt
def cloudfactory_response(request):
    """
    Receive the response from CloudFactory with processed document information.
    """
    try:
        body = request.body
        json_body = json.loads(body)

        if 'id' not in json_body:
            return HttpResponseBadRequest('No id found in json body')

        run = CloudFactoryDocumentRun.objects.get(run_id=json_body['id'])
    except ValueError:
        return HttpResponseBadRequest('Unable to parse json body')
    except CloudFactoryDocumentRun.DoesNotExist:
        raise Http404()
    else:
        try:
            # A run in a final state shouldn't be changed/updated again. Log an
            # error.
            if run.status in CloudFactoryDocumentRun.STATUS_FINAL_STATES:
                return HttpResponseBadRequest('Unexpected callback')

            # We already know that the body is parseable JSON so there is no need to
            # try/catch here:
            run.save_response_data(body)
        except ValueError as e:
            return HttpResponseBadRequest(e.message)
        else:
            # If the status is now STATUS_PROCESSED, this means that the review is
            # completed and the user should be notified to come view their document.
            # -- In a task so that the CF callback can finish w/o reference to the user notification.
            if run.status == CloudFactoryDocumentRun.STATUS_PROCESSED:
                EmailUserDocumentReviewCompleted.delay(run.id, request.scheme, request.get_host())

            return HttpResponse()
