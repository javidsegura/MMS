from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Restaurant, Menu, MenuSection, MenuItem, DietaryRestriction
from .serializers import (
    RestaurantSerializer, 
    MenuSerializer,
    MenuSectionSerializer,
    MenuItemSerializer,
    DietaryRestrictionSerializer
)

# Class-Based Views
class RestaurantViewSet(viewsets.ModelViewSet):
    queryset = Restaurant.objects.all()
    serializer_class = RestaurantSerializer
