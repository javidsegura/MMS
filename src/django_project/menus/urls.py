from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

router = DefaultRouter()
router.register('users', views.UserViewSet)
router.register('restaurants', views.RestaurantViewSet)
router.register('menu-versions', views.MenuVersionViewSet)
router.register('menu-items', views.MenuItemViewSet)
router.register('menus', views.MenuViewSet)
router.register('menu-sections', views.MenuSectionViewSet)
router.register('dietary-restrictions', views.DietaryRestrictionViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('upload-menu/', views.upload_menu, name='upload-menu'),
    path("raw-sql/", views.raw_sql_query, name="raw-sql-query"),
] 

