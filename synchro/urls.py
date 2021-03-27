from django.conf.urls import url, include
from django.contrib import admin
from . import views

app_name = 'semaphores'

urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^socket/$', views.socket, name='socket'),
    url(r'^deadlocks/$', views.deadlocks, name='deadlocks'),
    url(r'^demo/(?P<pk>[0-9]+)/$', views.demo, name='demo'),
    url(r'^bankalgo/$', views.bankalgo, name='bankalgo'),
]
