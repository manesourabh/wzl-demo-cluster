from django.urls import path
from . import views

urlpatterns = [
    path('', views.admin, name='admin-leaf'),
    path('admin_leaf/', views.admin, name='admin-leaf'),
    path('profile/', views.profilepage, name='profile-page'),
    #path('werker/', views.verker, name='werker-leaf'),
    #path('vorarbeiter/', views.vorarbeiter, name='vorarbeiter-leaf'),
    #path('nfmvorarbeiter/', views.nfmvorarbeiter, name='nfmvorarbeiter-leaf'),
    #path('nfmwerker/', views.nfmwerker, name='nfmwerker-leaf'),
    path('nfmadmin/', views.nfmadmin, name='nfmadmin-leaf'),
    #path('sample/', views.sample, name='sample-leaf'),
    path('nfmpreprocessing/', views.nfmpreprocessing, name='nfmpreprocessing-leaf'),
    path('fmeditpreprocessing/<int:fm_id>', views.fmeditpreprocessing, name='fmeditpreprocessing-leaf'),
    path('datenbank/', views.datenbank, name='daten-bank'),
    path('index/', views.index, name='index'),
    path('fmedit/', views.fmedit, name='fmedit'),
    path('fmedit/<int:fm_id>', views.fmedit_id, name='fmedit_id'),
    path('processinglogout/', views.processinglogout, name='processinglogout'),
]