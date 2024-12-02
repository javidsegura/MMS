import requests

#files = {'menu_file': open('path/to/your/menu.pdf', 'rb')}
response = requests.get('http://localhost:8000/api/restaurants/')

print(response.json())