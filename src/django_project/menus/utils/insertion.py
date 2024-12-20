
"""
After png info has been extracted, write it to the database. 
"""

from menus.models import (MenuItem, 
                          MenuSection, 
                          DietaryRestriction, 
                          AuditLog, 
                          Restaurant, 
                          Menu)

def populate_menu_data(menu: Menu, menu_data: dict) -> AuditLog:
    """
    Populate the database with the data extracted from the menu file
    """
    ai_insertion_log = AuditLog.objects.create(
        phase="Inserting data",
        status="Processing"
    )
    try:

        # Get info from the dictionary
        restaurant_info = menu_data.get('restaurant_info', {})

        if restaurant_info:
            restaurant_name = restaurant_info.get('restaurant_name', '')[:99]
            phone = restaurant_info.get('phone', '')[:99]
            address = restaurant_info.get('address', '')[:99]
            website = restaurant_info.get('website', '')[:99]
            email = restaurant_info.get('email', '')[:99]
            country = restaurant_info.get('country', '')[:99]
            city = restaurant_info.get('city', '')[:99]
            state = restaurant_info.get('state', '')[:99]
            zip = restaurant_info.get('zip', '')
            street = restaurant_info.get('street', '')[:99]

            if restaurant_name:
                # Try to find existing restaurant
                existing_restaurant = Restaurant.objects.filter(name=restaurant_name).first()
                if existing_restaurant:
                    menu.restaurant = existing_restaurant 
                    if menu.restaurant.phone != phone: # Filter through possible updates
                        menu.restaurant.phone = phone
                    if menu.restaurant.street != address:
                        menu.restaurant.street = address
                    if menu.restaurant.website != website:
                        menu.restaurant.website = website
                    if menu.restaurant.email != email:
                        menu.restaurant.email = email
                    if menu.restaurant.country != country:
                        menu.restaurant.country = country
                    if menu.restaurant.city != city:
                        menu.restaurant.city = city
                    if menu.restaurant.state != state:
                        menu.restaurant.state = state
                    if menu.restaurant.zip != zip:
                        menu.restaurant.zip = zip if zip != -1 else None
                    if menu.restaurant.street != street:
                        menu.restaurant.street = street
                    menu.restaurant.save()
                else:
                    # Create new restaurant if it doesn't exist
                    menu.restaurant = Restaurant.objects.create(
                        name=restaurant_name,
                        phone=phone,
                        street=address,
                        website=website,
                        email=email,
                        country=country,
                        city=city,
                        state=state,
                        zip=zip if zip != -1 else None,
                    )
                menu.save()  # Save the menu with the saved restaurant
        
        # Create menu sections and populate them with items 
        for section_data in menu_data.get('menu_sections', []):
            section_name = section_data.get('name', '')
            if len(section_name) > 99:
                section_name = section_name[:99]
            section = MenuSection.objects.create(
                menu=menu,
                name=section_name
            )
            
            # Create menu items for this section
            for item_data in section_data.get('items', []):
                item_name = item_data.get('name', '')
                if len(item_name) > 99:
                    item_name = item_name[:99]
                menu_item = MenuItem.objects.create(
                    menu_section=section,
                    name=item_name,
                    description=item_data.get('description', ''),
                    price=item_data.get('price', 0.0),
                    available=item_data.get('available', True),
                    currency=item_data.get('currency', 'USD')
                )
                
                # Handle dietary restrictions properly
                dietary_restrictions = item_data.get('dietary_restrictions', [])
                if dietary_restrictions:
                    for restriction in dietary_restrictions:
                        if len(restriction) > 99:
                            restriction = restriction[:99]
                        restriction_obj, _ = DietaryRestriction.objects.get_or_create(
                            name=restriction
                        )
                        menu_item.dietary_restrictions.add(restriction_obj)
            
        ai_insertion_log.status = "Success"
        return ai_insertion_log
                
    except Exception as e:
        print(f"Error in populate_menu_data: {str(e)}")
        ai_insertion_log.status = "Failed"
        ai_insertion_log.other = str(e)
        return ai_insertion_log
