
"""
After png info has been extracted, write it to the database. 
"""

from menus.models import MenuItem, MenuSection, DietaryRestriction, AuditLog, Restaurant

def populate_menu_data(menu, menu_data: dict) -> AuditLog:
    print(f"Populating menu data for {menu}")
    ai_insertion_log = AuditLog.objects.create(
        phase="Inserting data",
        status="Processing"
    )
    try:
        # Get or create restaurant based on name
        restaurant_info = menu_data.get('restaurant_info', {})
        phone = restaurant_info.get('phone')
        address = restaurant_info.get('address')
        website = restaurant_info.get('website')
        email = restaurant_info.get('email')
        country = restaurant_info.get('country')
        city = restaurant_info.get('city')
        state = restaurant_info.get('state')
        zip = restaurant_info.get('zip')
        street = restaurant_info.get('street')

        # Reducing size of big fields
        if len(restaurant_info) > 0:
            restaurant_info['restaurant_name'] = restaurant_info['restaurant_name'][:99]
            restaurant_info['phone'] = restaurant_info['phone'][:99]
            restaurant_info['address'] = restaurant_info['address'][:99]
            restaurant_info['website'] = restaurant_info['website'][:99]
            restaurant_info['email'] = restaurant_info['email'][:99]
            restaurant_info['country'] = restaurant_info['country'][:99]
            restaurant_info['city'] = restaurant_info['city'][:99]
            restaurant_info['state'] = restaurant_info['state'][:99]
            restaurant_info['street'] = restaurant_info['street'][:99]

        if restaurant_info:
            restaurant_name = restaurant_info.get('restaurant_name')
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
                    available=True
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
