from rest_framework import serializers
from .models import User, Restaurant, MenuVersion, Menu, MenuSection, MenuItem, DietaryRestriction, AuditLog

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

class RestaurantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Restaurant
        fields = '__all__'

class MenuVersionSerializer(serializers.ModelSerializer):
    class Meta:
        model = MenuVersion
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