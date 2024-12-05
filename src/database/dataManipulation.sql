

-- FIRST QUERY
DELIMITER $$

CREATE PROCEDURE GetCompleteMenuInfo()
BEGIN
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
END$$

DELIMITER ;

CALL GetCompleteMenuInfo();



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

DELIMITER $$

CREATE PROCEDURE GetPDFProcessingStatus()
BEGIN
    SELECT 
        m.id AS menu_id,                       
    ms.name AS menu_section,               
    al.status,                             
    al.phase,                              
    al.other AS error_details,             
    al.time_registered AS updated_time     
FROM 
    menus_menu m                           
JOIN 
    menus_menusection ms ON m.id = ms.menu_id
JOIN 
    menus_auditlog al ON m.id = al.menu_version_id;
END$$

DELIMITER ;

CALL GetPDFProcessingStatus();

--4. Generate Reports on Menu Items and Prices
-- Creates a summary report of menu items with their prices grouped by restaurant.

DELIMITER $$

CREATE PROCEDURE GetMenuItemsAndPrices()
BEGIN
    SELECT 
        mr.name AS restaurant_name,         
    mi.name AS item_name,               
    mi.price,                           
    mi.currency,                        
    ms.name AS section_name             
FROM 
    menus_restaurant mr                 
JOIN 
    menus_menu m ON mr.id = m.restaurant_id
JOIN 
    menus_menusection ms ON m.id = ms.menu_id
JOIN 
    menus_menuitem mi ON ms.id = mi.menu_section_id
WHERE 
    mi.available = TRUE                 
ORDER BY 
    mr.name,                            
    ms.name,                            
    mi.price;                           
END$$

DELIMITER ;

CALL GetMenuItemsAndPrices();

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







