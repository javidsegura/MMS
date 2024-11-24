import pytest
from menus.models import Menu, MenuSection, MenuItem, Restaurant
from menus.utils.insertion import populate_menu_data  # Testing this function directly


@pytest.mark.django_db
class TestPopulateMenuData:
    def test_valid_data_population(self):
        # Arrange: Create a menu and define valid data
        menu = Menu.objects.create(name="Test Menu")
        valid_data = {
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
                        {"name": "Bruschetta", "price": 8.99},
                        {"name": "Garlic Bread", "price": 4.99},
                    ],
                }
            ],
        }

        # Act: Call populate_menu_data with valid input
        populate_menu_data(menu, valid_data)

        # Assert: Verify the database contains the correct data
        restaurant = Restaurant.objects.get(name="Dynamic Restaurant")
        assert restaurant.phone == "123-456-7890"
        assert restaurant.street == "456 Real World St"
        assert restaurant.website == "http://dynamicrestaurant.com"

        section = MenuSection.objects.get(menu=menu, name="Appetizers")
        assert section.name == "Appetizers"

        items = MenuItem.objects.filter(menu_section=section)
        assert items.count() == 2
        assert items.filter(name="Bruschetta", price=8.99).exists()
        assert items.filter(name="Garlic Bread", price=4.99).exists()

    def test_invalid_data_handling(self):
        # Arrange: Create a menu and define invalid data
        menu = Menu.objects.create(name="Test Menu")
        invalid_data = {
            "restaurant_info": {
                "restaurant_name": "A" * 60,  # Exceeds max_length of 50
                "phone": "123-456-7890",
                "address": "789 Error St",
                "website": "http://errorrestaurant.com",
            },
            "menu_sections": [
                {
                    "name": "Main Course",
                    "items": [
                        {"name": "A" * 120, "price": 12.99},  # Exceeds max_length of 99
                    ],
                }
            ],
        }

        # Act & Assert: Ensure invalid data raises exceptions
        with pytest.raises(ValueError) as excinfo:
            populate_menu_data(menu, invalid_data)

        assert "restaurant_name exceeds max_length" in str(excinfo.value) or \
               "name exceeds max_length" in str(excinfo.value)

    def test_partial_data_handling(self):
        # Arrange: Create a menu and define partial data
        menu = Menu.objects.create(name="Test Menu")
        partial_data = {
            "restaurant_info": {
                "restaurant_name": "Partial Restaurant",
                "phone": None,  # Missing phone number
                "address": None,
                "website": "http://partialrestaurant.com",
            },
            "menu_sections": [
                {
                    "name": None,  # Missing section name
                    "items": [
                        {"name": "Pasta", "price": 10.99},
                    ],
                }
            ],
        }

        # Act: Call populate_menu_data with partial data
        populate_menu_data(menu, partial_data)

        # Assert: Verify partial data is handled correctly
        restaurant = Restaurant.objects.get(name="Partial Restaurant")
        assert restaurant.website == "http://partialrestaurant.com"
        assert restaurant.phone is None
        assert restaurant.street is None

        section = MenuSection.objects.filter(menu=menu).first()
        assert section is None or section.name is None

        item = MenuItem.objects.filter(name="Pasta").first()
        assert item and item.price == 10.99

    def test_data_type_validation(self):
        # Arrange: Create a menu and define data with incorrect data types
        menu = Menu.objects.create(name="Test Menu")
        invalid_data = {
            "restaurant_info": {
                "restaurant_name": "Invalid Restaurant",
                "phone": 1234567890,  # Invalid type (int instead of str)
                "address": 789,  # Invalid type (int instead of str)
                "website": None,  # Missing website
            },
            "menu_sections": [
                {
                    "name": "Invalid Section",
                    "items": [
                        {"name": "Invalid Item", "price": "Free"},  # Invalid type (str instead of float)
                    ],
                }
            ],
        }

        # Act & Assert: Ensure invalid data types raise exceptions
        with pytest.raises(ValueError) as excinfo:
            populate_menu_data(menu, invalid_data)

        assert "Phone must be a string." in str(excinfo.value) or \
               "Address must be a string." in str(excinfo.value) or \
               "price must be a float" in str(excinfo.value)