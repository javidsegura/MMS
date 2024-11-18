from django.test import TestCase
from menus.models import Menu, MenuItem, MenuSection, Restaurant
from menus.utils.insertion import populate_menu_data


class PopulateMenuDataTests(TestCase):
   def setUp(self):
       # Set up a sample menu object
       self.menu = Menu.objects.create(name="Test Menu")


   def test_populate_valid_data(self):
       # Define sample data
       sample_data = {
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


       # Call the function to populate data
       populate_menu_data(self.menu, sample_data)


       # Assert that the restaurant was created
       restaurant = Restaurant.objects.get(name="Test Restaurant")
       self.assertEqual(restaurant.phone, "123-456-7890")
       self.assertEqual(restaurant.street, "123 Test St")
       self.assertEqual(restaurant.website, "http://testrestaurant.com")


       # Assert menu sections and items were created
       section = MenuSection.objects.get(section_name="Starters")
       self.assertEqual(section.menu, self.menu)


       soup = MenuItem.objects.get(name="Soup")
       self.assertEqual(soup.price, 5.99)
       self.assertEqual(soup.section, section)




###this test code uses django's built in testing framework to validate the functionality of the function to extract data from a pdf.
#The setUp method initializes a sample Menu object as the context for testing. In the test method 'test_populate_valid_data', a sample data dictionary is passed
# to the 'populate_menu_data' function. This data contains restaurant details, menu sections, and items. The test then verifies that the function correctly
# saves the restaurant details, menu sections, and items in the database. Assertions ensure that:
#·The restaurant's information (e.g., name, phone, address) matches the input data.
#·The menu sections and items are properly linked to the correct menu and section. This ensures the function works as expected with valid input data.

