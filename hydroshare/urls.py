from __future__ import unicode_literals

from django.conf import settings
from django.conf.urls import include, url
from django.contrib import admin
from django.contrib.auth import views as auth_views


admin.autodiscover()


urlpatterns = [
    url("^mmh-admin/", include(admin.site.urls)),
    url(r'^accounts/login/$', auth_views.login, name='login'),
    url(r'', include('myhpom.urls', namespace='myhpom')),
]

# These should be served by nginx for deployed environments,
# presumably this is here to allow for running without DEBUG
# on in local dev environments.
if settings.DEBUG is False:   # if DEBUG is True it will be served automatically
    urlpatterns += [
        url(r'^static/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.STATIC_ROOT}),
]
