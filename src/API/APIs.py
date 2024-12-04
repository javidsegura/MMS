import requests

"""
The JSON  passed should be {db_field: value} (note not all are mandatory)
"""

class UploadMenu:
    def upload_menu(self, data:dict=None, filePath:str=None):
        try:
            with open(filePath, 'rb') as file:
                url = 'http://localhost:8000/api/upload-menu/'
                files = {'menu_file': file}
                menuResponse = requests.post(url, 
                                         data=data, 
                                         files=files)
            print(f"Menu: {menuResponse.json()}")
        except Exception as e:
            print(f"Error uploading menu: {e}")

class Users:
        def get_users(self, userID:int=None):
            try:    
                if userID:
                    url = f'http://localhost:8000/api/users/{userID}'
                else:
                    url = 'http://localhost:8000/api/users/'
                usersResponse = requests.get(url)
                print(f"Users {userID if userID else ''}: {usersResponse.json()}")
            except Exception as e:
                print(f"Error getting users: {e}")
        
        def add_user(self, json:dict=None):
            try:
                if not json:
                    raise Exception("JSON is required to add a user")
                url = 'http://localhost:8000/api/users/'
                userResponse = requests.post(url, 
                                            json=json)
                print(f"User: {userResponse.json()}")
            except Exception as e:
                print(f"Error adding user: {e}")
        
        def update_user(self, userID:int, json:dict=None):
            try:
                if not userID:
                    raise Exception("User ID is required to update a user")
                if not json:
                    raise Exception("JSON is required to update a user")
                url = f'http://localhost:8000/api/users/{userID}/'
                userResponse = requests.put(url, 
                                        json=json)
                print(f"User {userID}: {userResponse.json()}")
            except Exception as e:
                print(f"Error updating user: {e}")
        
        def delete_user(self, userID:int):
            try:
                if not userID:
                    raise Exception("User ID is required to delete a user")
                url = f'http://localhost:8000/api/users/{userID}/'
                userResponse = requests.delete(url)
                print(f"User {userID}: {userResponse.json()}")
            except Exception as e:
                print(f"Error deleting user: {e}")
        
        def patch_user(self, userID:int, json:dict=None):
            try:
                url = f'http://localhost:8000/api/users/{userID}/'
                userResponse = requests.patch(url, json=json)
                print(f"User {userID}: {userResponse.json()}")
            except Exception as e:
                print(f"Error patching user: {e}")

class DatabaseQueries():
    def execute_raw_sql(self, query: str, params: tuple = None):
        try:
            url = 'http://localhost:8000/api/all-cheap-items/'
            data = {
                'query': query,
                'params': params if params else []
            }
            headers = {'Content-Type': 'application/json'}
            response = requests.post(url, 
                                    json=data,
                                    headers=headers)
            
            if response.status_code == 200:
                return response.json()
            else:
                print(f"Server error: {response.text}")
                return None
                
        except Exception as e:
            print(f"Error executing raw SQL: {e}")
            return None

if __name__ == "__main__":
    uploadMenu = UploadMenu()
    uploadMenu.upload_menu(data={"user_id": 1}, 
                           filePath="/Users/javierdominguezsegura/Programming/College/Sophomore/Databases/MMS/others/menuExamples/images/fiveguys.png")
   
