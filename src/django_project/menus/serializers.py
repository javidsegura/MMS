"""
This module defines serializers for the API representation of Restaurant, Menu, MenuSection, MenuItem, 
and DietaryRestriction models using Django REST Framework.
"""

from rest_framework import serializers
from .models import Restaurant, Menu, MenuSection, MenuItem, DietaryRestriction

class RestaurantSerializer(serializers.ModelSerializer):
    """
    Serializer for the Restaurant model. Converts Restaurant model instances 
    into JSON representation and vice versa.

    Meta:
        model: Restaurant
        fields: Includes all fields from the Restaurant model.
    """
    class Meta:
        model = Restaurant
        fields = '__all__'


class MenuItemSerializer(serializers.ModelSerializer):
    """
    Serializer for the MenuItem model. Handles serialization and deserialization 
    of MenuItem instances.

    Meta:
        model: MenuItem
        fields: Includes all fields from the MenuItem model.
    """
    class Meta:
        model = MenuItem
        fields = '__all__'


class MenuSectionSerializer(serializers.ModelSerializer):
    """
    Serializer for the MenuSection model. Includes related MenuItems as nested serializers.

    Attributes:
        menu_items (MenuItemSerializer): A nested representation of MenuItem instances 
        associated with this section.

    Meta:
        model: MenuSection
        fields: Includes all fields from the MenuSection model, along with menu_items.
    """
    menu_items = MenuItemSerializer(source='menuitem_set', many=True, read_only=True)
    
    class Meta:
        model = MenuSection
        fields = '__all__'


class MenuSerializer(serializers.ModelSerializer):
    """
    Serializer for the Menu model. Includes related MenuSections as nested serializers.

    Attributes:
        sections (MenuSectionSerializer): A nested representation of MenuSection instances 
        associated with this menu.

    Meta:
        model: Menu
        fields: Includes all fields from the Menu model, along with sections.
    """
    sections = MenuSectionSerializer(source='menusection_set', many=True, read_only=True)
    
    class Meta:
        model = Menu
        fields = '__all__'


class DietaryRestrictionSerializer(serializers.ModelSerializer):
    """
    Serializer for the DietaryRestriction model. Converts DietaryRestriction model instances 
    into JSON representation and vice versa.

    Meta:
        model: DietaryRestriction
        fields: Includes all fields from the DietaryRestriction model.
    """
    class Meta:
        model = DietaryRestriction
        fields = '__all__'
