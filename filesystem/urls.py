from django.conf.urls import url

from . import views

app_name = 'filesystem'
urlpatterns = [
    url(r'^$', views.home, name = 'home'),
    url(r'^fileexp/(?P<choice>3)/$', views.tree),
    url(r'^fileexp/(?P<choice>2)/$', views.two),
    url(r'^fileexp/(?P<choice>1)/$', views.single),
    url(r'^fileexp/[0-9]+/process$', views.process),
    url(r'^fileexp/[0-9]+/process2$', views.process2),
]
