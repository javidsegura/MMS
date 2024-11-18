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
