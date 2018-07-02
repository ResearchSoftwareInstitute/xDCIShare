from django.shortcuts import render


def home(request):
    return render(request, 'myhpom/home.html')


def signup(request):
    # NOTE: this can be replaced with an appropriate CBV or whatever
    # as necessary; for now it is a placeholder to render a template.
    return render(request, 'myhpom/accounts/signup.html')
