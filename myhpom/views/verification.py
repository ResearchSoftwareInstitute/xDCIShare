from smtplib import SMTPException
from django.core.urlresolvers import reverse
from django.core.mail import send_mail
from django.conf import settings
from django.views.decorators.http import require_GET
from django.shortcuts import render, redirect
from django.template.loader import get_template
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.utils import timezone
from myhpom.decorators import require_ajax_login


@login_required
def send_account_verification(request, return_redirect=True):
    """
    * if already verified => returns message: success: verification already completed
    * if unverified => 
        * if no verification code: set it and save UserDetails
        * send the verification email and returns message: success: email sent, please check
    """
    userdetails = request.user.userdetails
    if userdetails.verification_completed:
        messages.info(request, "Your email address is already verified.")
    else:
        userdetails.reset_verification()
        code = userdetails.verification_code
        subject = 'Mind My Health Email Verification'
        template = get_template('myhpom/accounts/verification_email.txt')
        try:
            send_mail(
                subject,
                template.render({'code': code}),
                settings.CONTACT_EMAIL,
                [request.user.email],
                fail_silently=False,
            )
            messages.info(request, "Please check your email to verify your address.")
        except SMTPException:
            messages.error(
                request, "The verification email could not be sent. Please try again later."
            )
        userdetails.save()

    if return_redirect:
        return redirect('myhpom:dashboard')


@require_GET
@login_required
def verify_account(request, code):
    """This URL is usually accessed from an email. Login will redirect here if needed.
    * if already verified => returns message: success: verification already completed
    * if not verified: Check the given code against the user's verification code
        * if match:
            * set verification_completed as now and save UserDetails
            * message: success: email verified
        * if not match:
            * message: invalid: the verification code is invalid. 
    """
    userdetails = request.user.userdetails
    if userdetails.verification_completed:
        messages.info(request, "Your email address is already verified.")
    else:
        if code == userdetails.verification_code:
            userdetails.verification_completed = timezone.now()
            userdetails.save()
            messages.success(request, "Your email address is now verified.")
        else:
            messages.error(request, "The verification code is invalid.")
    return redirect('myhpom:dashboard')
