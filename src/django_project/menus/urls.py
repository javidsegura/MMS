from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

router = DefaultRouter()
router.register(r'restaurants', views.RestaurantViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('upload-menu/', views.upload_menu, name='upload-menu'),
] 

