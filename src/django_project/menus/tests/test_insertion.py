import pytest
from django.db import connection
from menus.models import Restaurant, Menu, MenuSection, MenuItem, DietaryRestriction
from menus.utils.insertion import populate_menu_data

# Fixture to reset the database before each test
@pytest.fixture
def reset_db():
    with connection.cursor() as cursor:
        cursor.execute("DELETE FROM menus_menuitem")
        cursor.execute("DELETE FROM menus_menusection")
        cursor.execute("DELETE FROM menus_menu")
        cursor.execute("DELETE FROM menus_restaurant")
        cursor.execute("DELETE FROM menus_dietaryrestriction")
    yield

# Sample valid menu JSON
@pytest.fixture
def sample_menu():
    return {
        "restaurant_info": {
            "restaurant_name": "Dynamic Restaurant",
            "phone": "123-456-7890",
            "address": "456 Real World St",
            "website": "http://dynamicrestaurant.com",
        },
        "menu_sections": [
            {
                "name": "Appetizers",
                "items": [
                    {"name": "Bruschetta", "price": 8.99, "description": "Toasted bread with toppings"},
                    {"name": "Garlic Bread", "price": 4.99},
                ],
            },
            {
                "name": "Main Course",
                "items": [
                    {"name": "Steak", "price": 19.99},
                    {"name": "Salmon", "price": 17.99},
                ],
            },
        ],
    }

@pytest.mark.django_db
def test_valid_menu_insertion(reset_db, sample_menu):
    # Call the function to populate menu data
    menu_instance = Menu.objects.create()
    populate_menu_data(menu=menu_instance, menu_data=sample_menu)

    # Verify restaurant creation
    restaurant = Restaurant.objects.get(name="Dynamic Restaurant")
    assert restaurant.phone == "123-456-7890"
    assert restaurant.website == "http://dynamicrestaurant.com"
    assert restaurant.street == "456 Real World St"

    # Verify menu association
    menu = Menu.objects.get(restaurant=restaurant)
    assert menu.restaurant == restaurant

    # Verify menu sections
    sections = MenuSection.objects.filter(menu=menu)
    assert len(sections) == 2
    section_names = {section.name for section in sections}
    assert section_names == {"Appetizers", "Main Course"}

    # Verify menu items
    items = MenuItem.objects.filter(menu_section__menu=menu)
    assert len(items) == 4
    item_names = {item.name for item in items}
    assert item_names == {"Bruschetta", "Garlic Bread", "Steak", "Salmon"}

    # Verify data types
    bruschetta = MenuItem.objects.get(name="Bruschetta")
    assert isinstance(bruschetta.price, int), "Price should be stored as an integer"
    assert isinstance(bruschetta.name, str), "Name should be a string"

@pytest.mark.django_db
def test_exceeding_max_length(reset_db):
    oversized_name = "a" * 256  # Exceeding the 255-character limit for a name
    invalid_menu = {
        "restaurant_info": {
            "restaurant_name": oversized_name,
            "phone": "123-456-7890",
            "address": "123 Test Street",
        },
        "menu_sections": [],
    }

    menu_instance = Menu.objects.create()
    with pytest.raises(Exception):
        populate_menu_data(menu=menu_instance, menu_data=invalid_menu)

@pytest.mark.django_db
def test_incomplete_data(reset_db):
    incomplete_menu = {
        "restaurant_info": {},  # Missing required fields
        "menu_sections": [],
    }

    menu_instance = Menu.objects.create()
    with pytest.raises(Exception):
        populate_menu_data(menu=menu_instance, menu_data=incomplete_menu)

@pytest.mark.django_db
def test_dietary_restrictions(reset_db):
    menu_with_dietary = {
        "restaurant_info": {
            "restaurant_name": "Dietary Restaurant",
            "phone": "555-555-5555",
        },
        "menu_sections": [
            {
                "name": "Healthy Options",
                "items": [
                    {
                        "name": "Gluten-Free Pizza",
                        "price": 12.99,
                        "dietary_restrictions": ["Gluten-Free", "Vegetarian"],
                    }
                ],
            }
        ],
    }

    menu_instance = Menu.objects.create()
    populate_menu_data(menu=menu_instance, menu_data=menu_with_dietary)

    # Verify dietary restrictions
    pizza = MenuItem.objects.get(name="Gluten-Free Pizza")
    restrictions = [r.name for r in pizza.dietary_restrictions.all()]
    assert set(restrictions) == {"Gluten-Free", "Vegetarian"}
