from django.conf import settings
from django.conf.urls import url
from myhpom import views as myhpom_views

urlpatterns = [
    url(r'^$', myhpom_views.home, name='home'),
    url(r'^accounts/signup/$', myhpom_views.signup, name='signup'),
    url(r'^styleguide/$', 'django.views.static.serve', {'document_root': settings.STATIC_ROOT + '/astrum', 'path': 'index.html'}),
    url(r'^styleguide/(?P<path>.*)', 'django.views.static.serve', {'document_root': settings.STATIC_ROOT + '/astrum'}),
]
