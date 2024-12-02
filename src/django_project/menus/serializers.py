from rest_framework import serializers
from .models import Restaurant, Menu, MenuSection, MenuItem, DietaryRestriction

class RestaurantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Restaurant
        fields = '__all__'

class MenuItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = MenuItem
        fields = '__all__'

class MenuSectionSerializer(serializers.ModelSerializer):
    menu_items = MenuItemSerializer(source='menuitem_set', many=True, read_only=True)
    
    class Meta:
        model = MenuSection
        fields = '__all__'

class MenuSerializer(serializers.ModelSerializer):
    sections = MenuSectionSerializer(source='menusection_set', many=True, read_only=True)
    
    class Meta:
        model = Menu
        fields = '__all__'

class DietaryRestrictionSerializer(serializers.ModelSerializer):
    class Meta:
        model = DietaryRestriction
        fields = '__all__' 