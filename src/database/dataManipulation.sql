

-- FIRST QUERY
SELECT 
	mitem.name as item_name,
    mitem.description as item_desscription,
    mitem.price as item_price,
    mitem.currency as item_currency,
    mrestaurant.name as resturant_name,
    mmenu.menu_file as menu_file_url,
    mmenu.available_until as menu_available_unitl,
    mmenu.available_from as menu_available_from,
    musers.username as username
FROM menus_menu mmenu
INNER JOIN menus_user musers 
	ON musers.id = mmenu.user_id_id
INNER JOIN menus_menusection msection
	ON msection.menu_id = mmenu.id
INNER JOIN menus_menuitem mitem
	ON mitem.menu_section_id = msection.id
INNER JOIN menus_restaurant mrestaurant
	ON mrestaurant.id = mmenu.restaurant_id;


--2. Filter Items by Dietary Restrictions
-- Finds menu items based on specific dietary restrictions (e.g., Lactose Intolerant).

DELIMITER $$

CREATE PROCEDURE GetMenuItemsByDietaryRestriction(IN restriction_name VARCHAR(255))
BEGIN
    SELECT 
        mi.name AS item_name,
        mi.description AS item_description,
        mi.price AS item_price,
        mi.currency AS item_currency,
        mi.available AS item_available,
        dr.name AS restriction_name
    FROM 
        menus_menuitem mi
    INNER JOIN 
        menus_dietaryrestriction_menu_items dr_mi
        ON dr_mi.menuitem_id = mi.id
    INNER JOIN 
        menus_dietaryrestriction dr
        ON dr.id = dr_mi.dietaryrestriction_id
    WHERE 
        dr.name = restriction_name;
END$$

DELIMITER ;

CALL GetMenuItemsByDietaryRestriction('Lactose Intolerant');

--3. Track PDF Processing Status
-- Retrieves information about menu uploads and their status from the audit log.

SELECT 
    m.id AS menu_id,                       -- menus_menu.id
    ms.name AS menu_section,               -- menus_menusection.name
    al.status,                             -- menus_auditlog.status
    al.phase,                              -- menus_auditlog.phase
    al.other AS error_details,             -- menus_auditlog.other
    al.time_registered AS updated_time     -- menus_auditlog.time_registered
FROM 
    menus_menu m                           -- menus_menu table
JOIN 
    menus_menusection ms ON m.id = ms.menu_id -- menus_menusection.menu_id links to menus_menu.id
JOIN 
    menus_auditlog al ON m.id = al.menu_version_id; -- menus_auditlog.menu_version_id links to menus_menu.id

--4. Generate Reports on Menu Items and Prices
-- Creates a summary report of menu items with their prices grouped by restaurant.

SELECT 
    mr.name AS restaurant_name,         -- menus_restaurant.name
    mi.name AS item_name,               -- menus_menuitem.name
    mi.price,                           -- menus_menuitem.price
    mi.currency,                        -- menus_menuitem.currency
    ms.name AS section_name             -- menus_menusection.name
FROM 
    menus_restaurant mr                 -- Restaurant table
JOIN 
    menus_menu m ON mr.id = m.restaurant_id -- menus_menu.restaurant_id links to menus_restaurant.id
JOIN 
    menus_menusection ms ON m.id = ms.menu_id -- menus_menusection.menu_id links to menus_menu.id
JOIN 
    menus_menuitem mi ON ms.id = mi.menu_section_id -- menus_menuitem.menu_section_id links to menus_menusection.id
WHERE 
    mi.available = TRUE                 -- Only include available items
ORDER BY 
    mr.name,                            -- Order by restaurant name
    ms.name,                            -- Then by section name
    mi.price;                           -- Finally by price
    

--5. Handle Menu Updates and Versioning
-- Inserts a new menu version or updates an existing one.

DELIMITER $$

CREATE PROCEDURE UpdateMenuVersion(
    IN p_restaurant_id BIGINT,       
    IN p_menu_file_url VARCHAR(255)
)
BEGIN
    DECLARE new_version INT;

    SELECT MAX(version_number) INTO new_version
    FROM menus_menuversion
    WHERE restaurant_id = p_restaurant_id;

    IF new_version IS NULL THEN
        SET new_version = 1;
    ELSE
        SET new_version = new_version + 1;
    END IF;

    SET @new_composite_id = CONCAT('Restaurant-v', new_version, ':', p_restaurant_id);

    INSERT INTO menus_menuversion (
        version_number, composite_id, restaurant_id
    )
    VALUES (
        new_version, @new_composite_id, p_restaurant_id
    );

    INSERT INTO menus_menu (
        restaurant_id, menu_file, version_id, last_edited
    )
    VALUES (
        p_restaurant_id, p_menu_file_url, LAST_INSERT_ID(), NOW()
    );
END $$

DELIMITER ;

CALL UpdateMenuVersion(1, 'https://imgur.com/a/yJwWtZs');







