"""
Tests extraction phase. Whatever change occurs to the extraction phase, this needs to always be passed.
"""

from extraction import ai_call  # Testing this function directly

"""
Missing:
- Correct path
- expectedJSON may not be fully complete
"""


MENUPATH = "/Users/javierdominguezsegura/Programming/College/Sophomore/Databases/Final project/MMS/others/menuExamples/pdfs/sampleMenu.pdf"
class TestInsertion:
    def test_ai_call(self):
        expectedJSON = {
            "menu_sections": [
                {
                    "name": "APPETIZERS",
                    "items": [
                        {"name": "Bruschetta", "description": "", "price": 8.99, "dietary_restrictions": []},
                        {"name": "Garlic Bread", "description": "", "price": 4.99, "dietary_restrictions": []},

                    ],
                },
                {
                    "name": "DESSERTS",
                    "items": [
                        {"name": "Tiramisu", "description": "", "price": 12.99, "dietary_restrictions": []},
                    ],
                }
            ],
            "restaurant_info": {
                "restaurant_name": "Dynamic Restaurant",
                "address": "456 Real World St",
                "phone": "123-456-7890",
                "website": "http://dynamicrestaurant.com",
                "email": "",
                "country": "",
                "city": "",
                "state": "",
                "zip": "-1",
                "street": "456 Real World St"
            },
        }

        with open(MENUPATH, "rb") as menu_file:
            returnedJSON = ai_call(menu_file, "pdf", True)

        print(returnedJSON, "\n\n", expectedJSON)
        assert returnedJSON == expectedJSON


if __name__ == "__main__":
    test = TestInsertion()
    test.test_ai_call()
