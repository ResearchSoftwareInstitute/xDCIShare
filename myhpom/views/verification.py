from django.shortcuts import render, redirect
from django.core.urlresolvers import reverse
from django.views.decorators.http import require_GET
from django.contrib.auth.decorators import login_required
from myhpom.decorators import require_ajax_login


@login_required
@require_ajax_login
def send_account_verification(request):
    """Triggering this URL via AJAX:
    * if already verified => returns message: success: verification already completed
    * if unverified => 
        * if no verification code: set it and save UserDetails
        * send the verification email and returns message: success: email sent, please check
    """
    return 'not sent'


@require_GET
@login_required
def verify_account(request, code):
    """This URL is usually accessed from an email.
    * If already verified, message: success: email already verified
    * If not yet verified:
        * Check the given verification_code against the user's verification code
            * if match
                * set verification_completed as now and save UserDetails
                * message: success: email verified
            * if not match
                * message: invalid: the verification code is invalid. 
                * link to send verification code.
    """
    return redirect('myhpom:dashboard')
