from django.conf.urls import url
from myhpom import views as myhpom_views

urlpatterns = [
    url(r'^$', myhpom_views.home, name='home')
]
