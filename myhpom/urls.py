from django.conf import settings
from django.conf.urls import url
from myhpom import views as myhpom_views

urlpatterns = [
    url(r'^$', myhpom_views.home, name='home'),
    url(r'^dashboard/$', myhpom_views.dashboard, name='dashboard'),
    # url(r'^directive/?$', myhpom_views.dashboard, name='dashboard'),
    url(r'^directive/upload$', myhpom_views.upload, name='dashboard'),
    url(r'^logout$', myhpom_views.logout, name='logout'),
    url(r'^accounts/signup/$', myhpom_views.signup, name='signup'),
    url(r'^accounts/next-steps/?$', myhpom_views.next_steps, name='next_steps'),
    url(r'^accounts/choose-network/?$', myhpom_views.choose_network, name='choose_network'),
    url(r'^styleguide/$', 'django.views.static.serve',
        {'document_root': settings.STATIC_ROOT + '/styleguide', 'path': 'index.html'}),
    url(r'^styleguide/(?P<path>.*)', 'django.views.static.serve',
        {'document_root': settings.STATIC_ROOT + '/styleguide'}),
]
