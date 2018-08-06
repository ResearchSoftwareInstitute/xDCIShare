from django.conf import settings
from django.conf.urls import url
from myhpom import views as myhpom_views

urlpatterns = [
    url(r'^$', myhpom_views.home, name='home'),
    url(r'^dashboard/?$', myhpom_views.dashboard, name='dashboard'),
    url(r'^upload/?$', myhpom_views.upload_index, name='upload_index'),
    url(r'^upload/current_ad/?$', myhpom_views.upload_current_ad, name='upload_current_ad'),
    url(r'^upload/requirements/?$', myhpom_views.upload_requirements, name='upload_requirements'),
    url(r'^upload/sharing/?$', myhpom_views.upload_sharing, name='upload_sharing'),
    url(r'^upload/delete/?$', myhpom_views.upload_delete_ad, name='upload_delete_ad'),
    url(r'^logout/?$', myhpom_views.logout, name='logout'),
    url(r'^accounts/signup/?$', myhpom_views.signup, name='signup'),
    url(r'^accounts/next-steps/?$', myhpom_views.next_steps, name='next_steps'),
    url(r'^accounts/choose-network/?$', myhpom_views.choose_network, name='choose_network'),
    url(r'^styleguide/$', 'django.views.static.serve',
        {'document_root': settings.STATIC_ROOT + '/styleguide', 'path': 'index.html'}),
    url(r'^styleguide/(?P<path>.*)', 'django.views.static.serve',
        {'document_root': settings.STATIC_ROOT + '/styleguide'}),
    url(r'^download/(?P<path>.*)$', myhpom_views.irods_download, name='irods_download'),
    url(r'^profile/?$', myhpom_views.view_profile, name='view_profile'),
    url(r'^profile/edit/?$', myhpom_views.edit_profile, name='edit_profile'),
]
