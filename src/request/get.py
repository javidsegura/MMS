

import requests
from requests.auth import HTTPBasicAuth

url = 'http://localhost:8000/api/upload-menu/'
files = {
    'menu_file': open('../../others/menuExamples/images/defaultRestaurant.png', 'rb')
}

# Then make the request
response = requests.post(url, files=files, data={'user_id': 1}) # Data is failing to work
print(response.json())