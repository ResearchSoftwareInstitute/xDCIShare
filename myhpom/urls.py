from django.conf import settings
from django.conf.urls import url
from myhpom import views as myhpom_views

urlpatterns = [
    url(r'^$', myhpom_views.home, name='home'),
    url(r'^dashboard/$', myhpom_views.dashboard, name='dashboard'),
    url(r'^logout$', myhpom_views.logout, name='logout'),
    url(r'^accounts/signup/$', myhpom_views.signup, name='signup'),
    # The `state` argument in the following URL is mainly useful for testing
    # at the moment and can be removed as necessary further down the road.
    url(r'^accounts/next-steps/?$', myhpom_views.next_steps, name='next_steps'),
    url(r'^accounts/choose-network/?$', myhpom_views.choose_network, name='choose_network'),
    url(r'^styleguide/$', 'django.views.static.serve',
        {'document_root': settings.STATIC_ROOT + '/styleguide', 'path': 'index.html'}),
    url(r'^styleguide/(?P<path>.*)', 'django.views.static.serve',
        {'document_root': settings.STATIC_ROOT + '/styleguide'}),
]
