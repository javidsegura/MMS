import pytest
import os
from extraction import ai_call



class TestMenuExtraction:
    def __init__(self):
        self.testFilePath = "/Users/gregfu/Documents/MMS/others/menuExamples/pdfs/sample_menu.pdf"


    def test_valid_pdf_extraction(self):
        print("Im about to call")
        extracted_data = ai_call(self.testFilePath, "pdf")
        expected_data = {
            "restaurant_info": {
                "restaurant_name": "Test Restaurant",
                "phone": "123-456-7890",
                "address": "123 Test St",
                "website": "http://testrestaurant.com",
            },
            "menu_sections": [
                {
                    "section_name": "Starters",
                    "items": [
                        {"name": "Soup", "price": 5.99},
                        {"name": "Salad", "price": 4.99},
                    ],
                }
            ],
        }
        print(extracted_data)
        assert extracted_data == expected_data, "Extracted data does not match expected data."
'''
    def test_exceeding_max_length(self):
        invalid_data_pdf_path = "/tmp/invalid_data_menu.pdf"
        with open(invalid_data_pdf_path, "w") as invalid_data_pdf:
            invalid_data_pdf.write("%PDF-1.4\n" + "A" * 1000)  # Exceeding max length constraints

        menu = MockMenu(invalid_data_pdf_path)
        with pytest.raises(ValueError) as excinfo:
            ai_call(menu, "pdf")

        assert "exceeds max_length" in str(excinfo.value)

    def test_partial_data_handling(self):
        partial_data_pdf_path = "/tmp/partial_data_menu.pdf"
        with open(partial_data_pdf_path, "w") as partial_data_pdf:
            partial_data_pdf.write("%PDF-1.4\nPartial Restaurant Data")

        menu = MockMenu(partial_data_pdf_path)
        extracted_data = ai_call(menu, "pdf")
        assert extracted_data is None, "Partial data should return None."

    def test_invalid_data_handling(self):
        invalid_pdf_path = "/tmp/invalid_structure_menu.pdf"
        with open(invalid_pdf_path, "w") as invalid_pdf:
            invalid_pdf.write("Invalid PDF Content")

        menu = MockMenu(invalid_pdf_path)
        with pytest.raises(ValueError) as excinfo:
            ai_call(menu, "pdf")

        assert "Invalid PDF" in str(excinfo.value)

    def teardown_method(self):
        temp_files = [
            "/tmp/invalid_data_menu.pdf",
            "/tmp/partial_data_menu.pdf",
            "/tmp/invalid_structure_menu.pdf",
        ]
        for file_path in temp_files:
            if os.path.exists(file_path):
                os.remove(file_path)
'''