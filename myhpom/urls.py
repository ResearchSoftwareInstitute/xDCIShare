from django.conf.urls import url
from myhpom import views as myhpom_views

urlpatterns = [
    url(r'^accounts/signup/$', myhpom_views.signup, name='signup'),
    url(r'^$', myhpom_views.home, name='home'),
]
