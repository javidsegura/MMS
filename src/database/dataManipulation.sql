-- **DATA MANIPULATION SQL FILE**

-- 1. Retrieve Complete Menu Information
-- Includes restaurant details, menu sections, and menu items.
SELECT 
    r.name AS restaurant_name,
    r.city,
    r.state,
    mi.name AS item_name,
    mi.description AS item_description,
    mi.price,
    mi.currency,
    mi.available,
    ms.section_id AS menu_section_id
FROM 
    menu_management_system.restaurant r
JOIN 
    menu_management_system.menu_info m ON r.restaurant_id = m.menu_id
JOIN 
    menu_management_system.menu_section ms ON m.menu_id = ms.menu_id
JOIN 
    menu_management_system.menu_item mi ON ms.section_id = mi.section_id
WHERE 
    m.activeStatus = TRUE;

-- 2. Filter Items by Dietary Restrictions
-- Finds menu items based on specific dietary restrictions (e.g., Vegetarian).
DELIMITER $$

CREATE PROCEDURE GetMenuItemsByDietaryRestriction(IN dietaryType VARCHAR(99))
BEGIN
    SELECT 
        mi.name AS item_name,
        mi.description AS item_description,
        mi.price,
        mi.currency,
        dr.description AS dietary_restriction
    FROM 
        menu_item mi
    JOIN 
        item_dietary_restrictions idr ON mi.menu_item_id = idr.menu_item_id
    JOIN 
        dietary_restrictions dr ON idr.dietary_restrict_id = dr.dietary_restrict_id
    WHERE 
        dr.description = dietaryType;
END $$

DELIMITER ;


CALL GetMenuItemsByDietaryRestriction('Vegetarian');

-- 3. Track PDF Processing Status
-- Retrieves information about menu uploads and their status from the audit log.
SELECT 
    m.menu_id,
    m.section AS menu_section,
    al.status,
    al.phase,
    al.other AS error_details, 
    al.time_registered AS updated_time
FROM 
    menu m
JOIN 
    audit_log al ON m.menu_id = al.menu_id;



-- 4. Generate Reports on Menu Items and Prices
-- Creates a summary report of menu items with their prices grouped by restaurant.

SELECT 
    r.name AS restaurant_name,
    mi.name AS item_name,
    mi.price,
    mi.currency,
    ms.section_id AS section_name
FROM 
    restaurant r
JOIN 
    menu_info m ON r.restaurant_id = m.menu_id
JOIN 
    menu_section ms ON m.menu_id = ms.menu_id
JOIN 
    menu_item mi ON ms.section_id = mi.section_id
WHERE 
    mi.available = TRUE
ORDER BY 
    r.name, ms.section_id, mi.price;

-- 5. Handle Menu Updates and Versioning
-- Inserts a new menu version or updates an existing one.

DELIMITER $$

CREATE PROCEDURE UpdateMenuVersion(
    IN p_restaurant_id INT,   -- Restaurant ID (e.g., 18 for Nobu)
    IN p_version INT,         -- Menu version (e.g., v1)
    IN p_composite_id VARCHAR(255),  -- Composite ID (e.g., 'Restaurant-v1:18')
    IN p_menu_file_url VARCHAR(255)  -- URL to the menu file (e.g., hosted on S3)
)
BEGIN
    DECLARE new_version INT;

    -- Check if the menu version for this restaurant already exists
    SELECT MAX(SUBSTRING_INDEX(composite_id, '-', -1)) INTO new_version
    FROM menu_info
    WHERE restaurant_id = p_restaurant_id
    AND composite_id LIKE CONCAT('%-', p_restaurant_id);

    -- If no version exists, set the initial version to 1
    IF new_version IS NULL THEN
        SET new_version = 1;
    ELSE
        SET new_version = new_version + 1;
    END IF;

    -- Construct the new composite ID based on the new version
    SET @new_composite_id = CONCAT('Restaurant-v', new_version, ':', p_restaurant_id);

    -- Insert or update the menu version with the new composite ID and file URL
    INSERT INTO menu_info (
        restaurant_id, composite_id, menu_file_url
    )
    VALUES (
        p_restaurant_id, @new_composite_id, p_menu_file_url
    )
    ON DUPLICATE KEY UPDATE
        composite_id = @new_composite_id,
        menu_file_url = p_menu_file_url;
END $$

DELIMITER ;

CALL UpdateMenuVersion(
    18,  -- p_restaurant_id (Nobu)
    1,   -- p_version (e.g., 'v1')
    'Restaurant-v1:18',  -- p_composite_id (e.g., 'Restaurant-v1:18')
    'https://mms-storage-s3.s3.us-east-1.amazonaws.com/menu_files/PDF-Menus-For-Restaurants.png'  -- p_menu_file_url (URL to the menu PDF)
);



