from __future__ import unicode_literals

from django.conf import settings
from django.conf.urls import include, url
from django.conf.urls.static import static
from django.contrib import admin
from django.contrib.auth import views as auth_views

from myhpom.forms.signup import SetPasswordForm

admin.autodiscover()


urlpatterns = [
    url("^mmh-admin/", include(admin.site.urls)),
    url(r'^accounts/reset/(?P<uidb64>[0-9A-Za-z_\-]+)/(?P<token>[0-9A-Za-z]{1,13}-[0-9A-Za-z]{1,20})/$',
        auth_views.password_reset_confirm,
        {'set_password_form': SetPasswordForm}, name='password_reset_confirm'),
    url(r'^accounts/', include('django.contrib.auth.urls'), name='login'),
    url(r'', include('myhpom.urls', namespace='myhpom')),
]

# These should be served by nginx for deployed environments,
# presumably this is here to allow for running without DEBUG
# on in local dev environments.
if not settings.DEBUG:   # if DEBUG is True it will be served automatically
    urlpatterns += [
        url(r'^static/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.STATIC_ROOT}),
    ]
else:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
