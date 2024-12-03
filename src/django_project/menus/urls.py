from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

router = DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'restaurants', views.RestaurantViewSet)
router.register(r'menu-versions', views.MenuVersionViewSet)
router.register(r'menu-items', views.MenuItemViewSet)
router.register(r'menus', views.MenuViewSet)
router.register(r'menu-sections', views.MenuSectionViewSet)
router.register(r'dietary-restrictions', views.DietaryRestrictionViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('upload-menu/', views.upload_menu, name='upload-menu'),
] 

