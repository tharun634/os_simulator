from django.conf.urls import url
from . import views

app_name = 'wiki'
urlpatterns = [
    url(r'^bankers/$', views.bankers,  name='bankers'),
    url(r'^disk/$', views.disk, name='disk'),
    url(r'^semaphore/$', views.semaphore, name='semaphore'),
    url(r'^page/$', views.mem, name='page'),
    url(r'^pra/$', views.pra, name='pra'),
    url(r'^process/$', views.process, name='process'),
    url(r'^file/$', views.file, name='file'),
    url(r'^memory/$', views.mem, name='mem'),
]
