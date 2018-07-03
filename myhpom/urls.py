from django.conf import settings
from django.conf.urls import url
from myhpom import views as myhpom_views

urlpatterns = [
    url(r'^$', myhpom_views.home, name='home'),
    url(r'^styleguide/(?P<path>.*)', 'django.views.static.serve', {'document_root': settings.STATIC_ROOT + '/styleguide'}),
]
