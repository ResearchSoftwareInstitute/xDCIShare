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

    url(r'^profile/?$', myhpom_views.view_profile, name='view_profile'),
    url(r'^profile/edit/?$', myhpom_views.edit_profile, name='edit_profile'),
    url(r'^logout/?$', myhpom_views.logout, name='logout'),

    url(r'^accounts/signup/?$', myhpom_views.signup, name='signup'),
    url(r'^accounts/next-steps/?$', myhpom_views.next_steps, name='next_steps'),
    url(r'^accounts/choose-network/?$', myhpom_views.choose_network,
        {'is_update': False}, name='choose_network'),
    url(r'^accounts/update-network/?$', myhpom_views.choose_network,
        {'is_update': True}, name='update_network'),

    url(r'^download/(?P<path>.*)$', myhpom_views.irods_download, name='irods_download'),
    url(r'^document/(?P<key>[A-Za-z0-9]+)/(?P<filename>[^/]+)/?$', 
        myhpom_views.document_by_key, name='document_by_key'),

    url(r'^states/(?P<state>[a-zA-Z]{2})/template/?$', myhpom_views.state_template, name='state_template'),

    url(r'^faq/?$', myhpom_views.faq, name='faq'),

    url(r'^styleguide/$', 'django.views.static.serve',
        {'document_root': settings.STATIC_ROOT + '/styleguide', 'path': 'index.html'}),
]

# Static pages that have no actual view logic (but likely will at some future
# date):
static_views = [
    [r'^about/?', 'about', 'myhpom/about.html'],
    [r'^how-it-works/?', 'how-it-works', 'myhpom/content/how-it-works.html'],
    [r'^legal/?', 'legal', 'myhpom/legal.html'],
    [r'^privacy/?', 'privacy', 'myhpom/privacy.html'],
    [r'^why-plan/?', 'why-plan', 'myhpom/content/why-plan.html'],
]


for pattern, name, template in static_views:
    urlpatterns.append(
        url(pattern, myhpom_views.content_page, {'template': template}, name=name)
    )
