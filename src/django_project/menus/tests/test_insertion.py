from django.test import TestCase
from menus.utils.extraction import extract_pdf_content  # We should change this with our function to export text from a pdf
import os

class ExtractPdfContentTests(TestCase):
    def test_extract_pdf_content(self):
        # Path to the sample PDF file
        pdf_path = os.path.join(os.path.dirname(__file__), "sample_menu.pdf") # We should change sample_menu.pdf with the name of the actual pdf

        # and replace here with the actual expected data
        expected_data = {
            "restaurant_info": {
                "restaurant_name": "Test Restaurant",
                "phone": "123-456-7890",
                "address": "123 Test St",
                "website": "http://testrestaurant.com"
            },
            "menu_sections": [
                {
                    "section_name": "Starters",
                    "items": [
                        {"name": "Soup", "price": 5.99},
                        {"name": "Salad", "price": 4.99}
                    ]
                }
            ]
        }


        extracted_data = extract_pdf_content(pdf_path)

        # Lastly verify the extracted data matches the expected data
        self.assertEqual(extracted_data, expected_data)


import pytest
from menus.models import Menu, MenuSection, MenuItem, Restaurant
from menus.utils.insertion import populate_menu_data # We should change this with our function to export text from a pdf


@pytest.mark.django_db
class TestPopulateMenuData:

    def test_valid_data_population(self):
        
        # Test if valid data is correctly processed and saved into the database. (sample menu of course)
        
        
        menu = Menu.objects.create(name="Test Menu")
        valid_data = {
            "restaurant_info": {
                "restaurant_name": "Dynamic Restaurant",
                "phone": "123-456-7890",
                "address": "456 Real World St",
                "website": "http://dynamicrestaurant.com"
            },
            "menu_sections": [
                {
                    "section_name": "Appetizers",
                    "items": [
                        {"name": "Bruschetta", "price": 8.99},
                        {"name": "Garlic Bread", "price": 4.99}
                    ]
                }
            ]
        }

       
        populate_menu_data(menu, valid_data)

        # This part of the test verifies that valid data is correctly stored in the database after being 
        # processed by the populate_menu_data function. It checks if the data (restaurant, menu sections, and menu items), 
        # matches what was provided as input.
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
       
        # this part tests if invalid data (exceeding model constraints) raises appropriate exceptions.
        
        menu = Menu.objects.create(name="Test Menu")
        invalid_data = {
            "restaurant_info": {
                "restaurant_name": "A" * 60,  # Exceeds max_length of 50
                "phone": "123-456-7890",
                "address": "789 Error St",
                "website": "http://errorrestaurant.com"
            },
            "menu_sections": [
                {
                    "section_name": "Main Course",
                    "items": [
                        {"name": "A" * 120, "price": 12.99}  # Exceeds max_length of 99
                    ]
                }
            ]
        }

        # Act & Assert: Ensure invalid data raises exceptions
        with pytest.raises(Exception) as excinfo:
            populate_menu_data(menu, invalid_data)

        assert "restaurant_name exceeds max_length" in str(excinfo.value) or \
               "name exceeds max_length" in str(excinfo.value)

    def test_partial_data_handling(self):
        
        # Test if partial or incomplete data is gracefully handled without crashing.
    
        menu = Menu.objects.create(name="Test Menu")
        partial_data = {
            "restaurant_info": {
                "restaurant_name": "Partial Restaurant",
                "phone": None,  # Missing phone number
                "address": None,
                "website": "http://partialrestaurant.com"
            },
            "menu_sections": [
                {
                    "section_name": None,  # Missing section name
                    "items": [
                        {"name": "Pasta", "price": 10.99}
                    ]
                }
            ]
        }

        populate_menu_data(menu, partial_data)


        restaurant = Restaurant.objects.get(name="Partial Restaurant")
        assert restaurant.website == "http://partialrestaurant.com"
        assert restaurant.phone is None
        assert restaurant.street is None

        # Validate that menu section and items were partially saved
        section = MenuSection.objects.filter(menu=menu).first()
        assert section is None or section.name is None

        item = MenuItem.objects.filter(name="Pasta").first()
        assert item and item.price == 10.99

