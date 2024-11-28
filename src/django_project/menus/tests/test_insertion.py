import pytest
from menus.utils.insertion import populate_menu_data


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

def test_valid_menu_insertion(sample_menu):
    # Simulate populating menu data
    menu_instance = {"menu_file": "mock_file"}
    result = populate_menu_data(menu=menu_instance, menu_data=sample_menu)

    # Assert: Verify the function ran successfully
    assert result is True, "Menu data population should succeed."

def test_exceeding_max_length():
    oversized_name = "a" * 256  # Exceeding the 255-character limit for a name
    invalid_menu = {
        "restaurant_info": {
            "restaurant_name": oversized_name,
            "phone": "123-456-7890",
            "address": "123 Test Street",
        },
        "menu_sections": [],
    }

    menu_instance = {"menu_file": "mock_file"}
    with pytest.raises(Exception):
        populate_menu_data(menu=menu_instance, menu_data=invalid_menu)

def test_incomplete_data():
    incomplete_menu = {
        "restaurant_info": {},  # Missing required fields
        "menu_sections": [],
    }

    menu_instance = {"menu_file": "mock_file"}
    with pytest.raises(Exception):
        populate_menu_data(menu=menu_instance, menu_data=incomplete_menu)

def test_dietary_restrictions():
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

    menu_instance = {"menu_file": "mock_file"}
    result = populate_menu_data(menu=menu_instance, menu_data=menu_with_dietary)

    # Assert: Verify the function ran successfully
    assert result is True, "Dietary restriction handling should succeed."
