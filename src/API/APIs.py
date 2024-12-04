import requests

"""
The JSON  passed should be {db_field: value} (note not all are mandatory)
This module provides classes for interacting with APIs for menus, users, restaurants, and other entities.
"""

class UploadMenu:
    """
    Handles menu file uploads to the API.
    """
    def upload_menu(self, data: dict = None, filePath: str = None):
        """
        Uploads a menu file and associated data to the server.

        :param data: Dictionary containing menu data.
        :param filePath: Path to the file to be uploaded.
        """
        try:
            with open(filePath, 'rb') as file:
                url = 'http://localhost:8000/api/upload-menu/'
                menuResponse = requests.post(url, data=data, files=file)
            print(f"Menu: {menuResponse.json()}")
        except Exception as e:
            print(f"Error uploading menu: {e}")

class Users:
    """
    Provides API interactions for user-related operations.
    """
    def get_users(self, userID: int = None):
        """
        Retrieves user information.

        :param userID: ID of the user to retrieve. If None, retrieves all users.
        """
        try:
            if userID:
                url = f'http://localhost:8000/api/users/{userID}'
            else:
                url = 'http://localhost:8000/api/users/'
            usersResponse = requests.get(url)
            print(f"Users {userID if userID else ''}: {usersResponse.json()}")
        except Exception as e:
            print(f"Error getting users: {e}")
        
    def add_user(self, json: dict = None):
        """
        Adds a new user.

        :param json: Dictionary containing user data.
        """
        try:
            if not json:
                raise Exception("JSON is required to add a user")
            url = 'http://localhost:8000/api/users/'
            userResponse = requests.post(url, json=json)
            print(f"User: {userResponse.json()}")
        except Exception as e:
            print(f"Error adding user: {e}")
        
    def update_user(self, userID: int, json: dict = None):
        """
        Updates a user's information.

        :param userID: ID of the user to update.
        :param json: Dictionary containing updated user data.
        """
        try:
            if not userID:
                raise Exception("User ID is required to update a user")
            if not json:
                raise Exception("JSON is required to update a user")
            url = f'http://localhost:8000/api/users/{userID}/'
            userResponse = requests.put(url, json=json)
            print(f"User {userID}: {userResponse.json()}")
        except Exception as e:
            print(f"Error updating user: {e}")
        
    def delete_user(self, userID: int):
        """
        Deletes a user.

        :param userID: ID of the user to delete.
        """
        try:
            if not userID:
                raise Exception("User ID is required to delete a user")
            url = f'http://localhost:8000/api/users/{userID}/'
            userResponse = requests.delete(url)
            print(f"User {userID}: {userResponse.json()}")
        except Exception as e:
            print(f"Error deleting user: {e}")
        
    def patch_user(self, userID: int, json: dict = None):
        """
        Partially updates a user's information.

        :param userID: ID of the user to update.
        :param json: Dictionary containing the fields to update.
        """
        try:
            url = f'http://localhost:8000/api/users/{userID}/'
            userResponse = requests.patch(url, json=json)
            print(f"User {userID}: {userResponse.json()}")
        except Exception as e:
            print(f"Error patching user: {e}")

class Restaurants:
    """
    Provides API interactions for restaurant-related operations.
    """
    def get_restaurants(self, restaurantID=None):
        """
        Retrieves restaurant information.

        :param restaurantID: ID of the restaurant to retrieve. If None, retrieves all restaurants.
        """
        try:
            if restaurantID:
                url = f'http://localhost:8000/api/restaurants/{restaurantID}/'
            else:
                url = 'http://localhost:8000/api/restaurants/'
            response = requests.get(url)
            print(f"Restaurants: {response.json()}")
        except Exception as e:
            print(f"Error getting restaurants: {e}")

    def add_restaurant(self, json=None):
        """
        Adds a new restaurant.

        :param json: Dictionary containing restaurant data.
        """
        try:
            if not json:
                raise Exception("JSON is required to add a restaurant")
            url = 'http://localhost:8000/api/restaurants/'
            response = requests.post(url, json=json)
            print(f"Restaurant added: {response.json()}")
        except Exception as e:
            print(f"Error adding restaurant: {e}")
    
    def update_restaurant(self, restaurantID, json=None):
        """
        Updates restaurant information.

        :param restaurantID: ID of the restaurant to update.
        :param json: Dictionary containing updated restaurant data.
        """
        try:
            if not restaurantID or not json:
                raise Exception("Restaurant ID and JSON are required to update a restaurant")
            url = f'http://localhost:8000/api/restaurants/{restaurantID}/'
            response = requests.put(url, json=json)
            print(f"Restaurant updated: {response.json()}")
        except Exception as e:
            print(f"Error updating restaurant: {e}")
    
    def delete_restaurant(self, restaurantID):
        """
        Deletes a restaurant.

        :param restaurantID: ID of the restaurant to delete.
        """
        try:
            if not restaurantID:
                raise Exception("Restaurant ID is required to delete a restaurant")
            url = f'http://localhost:8000/api/restaurants/{restaurantID}/'
            response = requests.delete(url)
            print(f"Restaurant deleted: {response.json()}")
        except Exception as e:
            print(f"Error deleting restaurant: {e}")

class MenuVersions:
    """
    Handles API interactions for menu version-related operations.
    """
    def get_menu_version(self, versionID: int = None):
        """
        Retrieves menu version information.

        :param versionID: ID of the menu version to retrieve. 
                          If None, retrieves all menu versions.
        """
        try:
            if versionID:
                url = f'http://localhost:8000/api/menu-versions/{versionID}'
            else:
                url = 'http://localhost:8000/api/menu-versions/'
            response = requests.get(url)
            print(f"Menu Version {versionID if versionID else ''}: {response.json()}")
        except Exception as e:
            print(f"Error getting menu version: {e}")

    def add_menu_version(self, json: dict = None):
        """
        Adds a new menu version.

        :param json: Dictionary containing menu version data.
        """
        try:
            if not json:
                raise Exception("JSON is required to add a menu version")
            url = 'http://localhost:8000/api/menu-versions/'
            response = requests.post(url, json=json)
            print(f"Menu Version: {response.json()}")
        except Exception as e:
            print(f"Error adding menu version: {e}")

    def update_menu_version(self, versionID: int, json: dict = None):
        """
        Updates menu version information.

        :param versionID: ID of the menu version to update.
        :param json: Dictionary containing updated menu version data.
        """
        try:
            if not versionID or not json:
                raise Exception("Version ID and JSON are required to update a menu version")
            url = f'http://localhost:8000/api/menu-versions/{versionID}/'
            response = requests.put(url, json=json)
            print(f"Menu Version {versionID}: {response.json()}")
        except Exception as e:
            print(f"Error updating menu version: {e}")

    def delete_menu_version(self, versionID: int):
        """
        Deletes a menu version.

        :param versionID: ID of the menu version to delete.
        """
        try:
            if not versionID:
                raise Exception("Version ID is required to delete a menu version")
            url = f'http://localhost:8000/api/menu-versions/{versionID}/'
            response = requests.delete(url)
            print(f"Menu Version {versionID}: {response.json()}")
        except Exception as e:
            print(f"Error deleting menu version: {e}")

class Menus:
    """
    Handles API interactions for menu-related operations.
    """
    def get_menu(self, menuID: int = None):
        """
        Retrieves menu information.

        :param menuID: ID of the menu to retrieve. If None, retrieves all menus.
        """
        try:
            if menuID:
                url = f'http://localhost:8000/api/menus/{menuID}'
            else:
                url = 'http://localhost:8000/api/menus/'
            response = requests.get(url)
            print(f"Menu {menuID if menuID else ''}: {response.json()}")
        except Exception as e:
            print(f"Error getting menu: {e}")

    def add_menu(self, json: dict = None):
        """
        Adds a new menu.

        :param json: Dictionary containing menu data.
        """
        try:
            if not json:
                raise Exception("JSON is required to add a menu")
            url = 'http://localhost:8000/api/menus/'
            response = requests.post(url, json=json)
            print(f"Menu: {response.json()}")
        except Exception as e:
            print(f"Error adding menu: {e}")

    def update_menu(self, menuID: int, json: dict = None):
        """
        Updates menu information.

        :param menuID: ID of the menu to update.
        :param json: Dictionary containing updated menu data.
        """
        try:
            if not menuID or not json:
                raise Exception("Menu ID and JSON are required to update a menu")
            url = f'http://localhost:8000/api/menus/{menuID}/'
            response = requests.put(url, json=json)
            print(f"Menu {menuID}: {response.json()}")
        except Exception as e:
            print(f"Error updating menu: {e}")

    def delete_menu(self, menuID: int):
        """
        Deletes a menu.

        :param menuID: ID of the menu to delete.
        """
        try:
            if not menuID:
                raise Exception("Menu ID is required to delete a menu")
            url = f'http://localhost:8000/api/menus/{menuID}/'
            response = requests.delete(url)
            print(f"Menu {menuID}: {response.json()}")
        except Exception as e:
            print(f"Error deleting menu: {e}")

class MenuSections:
    """
    Handles API interactions for menu section-related operations.
    """
    def get_menu_section(self, sectionID: int = None):
        """
        Retrieves menu section information.

        :param sectionID: ID of the menu section to retrieve. If None, retrieves all menu sections.
        """
        try:
            if sectionID:
                url = f'http://localhost:8000/api/menu-sections/{sectionID}'
            else:
                url = 'http://localhost:8000/api/menu-sections/'
            response = requests.get(url)
            print(f"Menu Section {sectionID if sectionID else ''}: {response.json()}")
        except Exception as e:
            print(f"Error getting menu section: {e}")

    def add_menu_section(self, json: dict = None):
        """
        Adds a new menu section.

        :param json: Dictionary containing menu section data.
        """
        try:
            if not json:
                raise Exception("JSON is required to add a menu section")
            url = 'http://localhost:8000/api/menu-sections/'
            response = requests.post(url, json=json)
            print(f"Menu Section: {response.json()}")
        except Exception as e:
            print(f"Error adding menu section: {e}")

    def update_menu_section(self, sectionID: int, json: dict = None):
        """
        Updates menu section information.

        :param sectionID: ID of the menu section to update.
        :param json: Dictionary containing updated menu section data.
        """
        try:
            if not sectionID or not json:
                raise Exception("Section ID and JSON are required to update a menu section")
            url = f'http://localhost:8000/api/menu-sections/{sectionID}/'
            response = requests.put(url, json=json)
            print(f"Menu Section {sectionID}: {response.json()}")
        except Exception as e:
            print(f"Error updating menu section: {e}")

    def delete_menu_section(self, sectionID: int):
        """
        Deletes a menu section.

        :param sectionID: ID of the menu section to delete.
        """
        try:
            if not sectionID:
                raise Exception("Section ID is required to delete a menu section")
            url = f'http://localhost:8000/api/menu-sections/{sectionID}/'
            response = requests.delete(url)
            print(f"Menu Section {sectionID}: {response.json()}")
        except Exception as e:
            print(f"Error deleting menu section: {e}")

class MenuItems:
    """
    Handles API interactions for menu item-related operations.
    """
    def get_menu_item(self, itemID: int = None):
        """
        Retrieves menu item information.

        :param itemID: ID of the menu item to retrieve. If None, retrieves all menu items.
        """
        try:
            if itemID:
                url = f'http://localhost:8000/api/menu-items/{itemID}'
            else:
                url = 'http://localhost:8000/api/menu-items/'
            response = requests.get(url)
            print(f"Menu Item {itemID if itemID else ''}: {response.json()}")
        except Exception as e:
            print(f"Error getting menu item: {e}")

    def add_menu_item(self, json: dict = None):
        """
        Adds a new menu item.

        :param json: Dictionary containing menu item data.
        """
        try:
            if not json:
                raise Exception("JSON is required to add a menu item")
            url = 'http://localhost:8000/api/menu-items/'
            response = requests.post(url, json=json)
            print(f"Menu Item: {response.json()}")
        except Exception as e:
            print(f"Error adding menu item: {e}")

    def update_menu_item(self, itemID: int, json: dict = None):
        """
        Updates menu item information.

        :param itemID: ID of the menu item to update.
        :param json: Dictionary containing updated menu item data.
        """
        try:
            if not itemID or not json:
                raise Exception("Item ID and JSON are required to update a menu item")
            url = f'http://localhost:8000/api/menu-items/{itemID}/'
            response = requests.put(url, json=json)
            print(f"Menu Item {itemID}: {response.json()}")
        except Exception as e:
            print(f"Error updating menu item: {e}")

    def delete_menu_item(self, itemID: int):
        """
        Deletes a menu item.

        :param itemID: ID of the menu item to delete.
        """
        try:
            if not itemID:
                raise Exception("Item ID is required to delete a menu item")
            url = f'http://localhost:8000/api/menu-items/{itemID}/'
            response = requests.delete(url)
            print(f"Menu Item {itemID}: {response.json()}")
        except Exception as e:
            print(f"Error deleting menu item: {e}")

class DietaryRestrictions:
    """
    Handles API interactions for dietary restriction-related operations.
    """
    def get_dietary_restriction(self, restrictionID: int = None):
        """
        Retrieves dietary restriction information.

        :param restrictionID: ID of the dietary restriction to retrieve. 
                              If None, retrieves all dietary restrictions.
        """
        try:
            if restrictionID:
                url = f'http://localhost:8000/api/dietary-restrictions/{restrictionID}'
            else:
                url = 'http://localhost:8000/api/dietary-restrictions/'
            response = requests.get(url)
            print(f"Dietary Restriction {restrictionID if restrictionID else ''}: {response.json()}")
        except Exception as e:
            print(f"Error getting dietary restriction: {e}")

    def add_dietary_restriction(self, json: dict = None):
        """
        Adds a new dietary restriction.

        :param json: Dictionary containing dietary restriction data.
        """
        try:
            if not json:
                raise Exception("JSON is required to add a dietary restriction")
            url = 'http://localhost:8000/api/dietary-restrictions/'
            response = requests.post(url, json=json)
            print(f"Dietary Restriction: {response.json()}")
        except Exception as e:
            print(f"Error adding dietary restriction: {e}")

    def update_dietary_restriction(self, restrictionID: int, json: dict = None):
        """
        Updates dietary restriction information.

        :param restrictionID: ID of the dietary restriction to update.
        :param json: Dictionary containing updated dietary restriction data.
        """
        try:
            if not restrictionID or not json:
                raise Exception("Restriction ID and JSON are required to update a dietary restriction")
            url = f'http://localhost:8000/api/dietary-restrictions/{restrictionID}/'
            response = requests.put(url, json=json)
            print(f"Dietary Restriction {restrictionID}: {response.json()}")
        except Exception as e:
            print(f"Error updating dietary restriction: {e}")

    def delete_dietary_restriction(self, restrictionID: int):
        """
        Deletes a dietary restriction.

        :param restrictionID: ID of the dietary restriction to delete.
        """
        try:
            if not restrictionID:
                raise Exception("Restriction ID is required to delete a dietary restriction")
            url = f'http://localhost:8000/api/dietary-restrictions/{restrictionID}/'
            response = requests.delete(url)
            print(f"Dietary Restriction {restrictionID}: {response.json()}")
        except Exception as e:
            print(f"Error deleting dietary restriction: {e}")

class AuditLogs:
    """
    Handles API interactions for audit log-related operations.
    """
    def get_audit_log(self, logID: int = None):
        """
        Retrieves audit log information.

        :param logID: ID of the audit log to retrieve. 
                      If None, retrieves all audit logs.
        """
        try:
            if logID:
                url = f'http://localhost:8000/api/audit-logs/{logID}'
            else:
                url = 'http://localhost:8000/api/audit-logs/'
            response = requests.get(url)
            print(f"Audit Log {logID if logID else ''}: {response.json()}")
        except Exception as e:
            print(f"Error getting audit log: {e}")

    def add_audit_log(self, json: dict = None):
        """
        Adds a new audit log.

        :param json: Dictionary containing audit log data.
        """
        try:
            if not json:
                raise Exception("JSON is required to add an audit log")
            url = 'http://localhost:8000/api/audit-logs/'
            response = requests.post(url, json=json)
            print(f"Audit Log: {response.json()}")
        except Exception as e:
            print(f"Error adding audit log: {e}")

    def update_audit_log(self, logID: int, json: dict = None):
        """
        Updates audit log information.

        :param logID: ID of the audit log to update.
        :param json: Dictionary containing updated audit log data.
        """
        try:
            if not logID or not json:
                raise Exception("Log ID and JSON are required to update an audit log")
            url = f'http://localhost:8000/api/audit-logs/{logID}/'
            response = requests.put(url, json=json)
            print(f"Audit Log {logID}: {response.json()}")
        except Exception as e:
            print(f"Error updating audit log: {e}")

    def delete_audit_log(self, logID: int):
        """
        Deletes an audit log.

        :param logID: ID of the audit log to delete.
        """
        try:
            if not logID:
                raise Exception("Log ID is required to delete an audit log")
            url = f'http://localhost:8000/api/audit-logs/{logID}/'
            response = requests.delete(url)
            print(f"Audit Log {logID}: {response.json()}")
        except Exception as e:
            print(f"Error deleting audit log: {e}")


class DatabaseQueries():
    """
    Handles raw SQL queries sent to the API.
    """
    def execute_raw_sql(self, query: str, params: tuple = None):
        """
        Executes a raw SQL query through the API.

        :param query: The SQL query to execute.
        :param params: Parameters for the SQL query.
        :return: JSON response or None in case of an error.
        """
        try:
            url = 'http://localhost:8000/api/all-cheap-items/'
            data = {
                'query': query,
                'params': params if params else []
            }
            headers = {'Content-Type': 'application/json'}
            response = requests.post(url, json=data, headers=headers)
            
            if response.status_code == 200:
                return response.json()
            else:
                print(f"Server error: {response.text}")
                return None
                
        except Exception as e:
            print(f"Error executing raw SQL: {e}")
            return None

if __name__ == "__main__":
    db = DatabaseQueries()
    temp = db.execute_raw_sql("SELECT * FROM menus_user WHERE is_staff = %s", (1,))
    print(temp)