-- **DATA MANIPULATION SQL FILE**

-- Retrieves details of menu items grouped by restaurants and menu sections
-- Filters for active menus (active_status = TRUE).
SELECT 
    r.name AS restaurant_name,
    r.city,
    r.state,
    mi.name AS item_name,
    mi.description AS item_description,
    mi.price,
    mi.currency,
    mi.available,
    ms.id AS menu_section_id
FROM 
    menus_restaurant r
JOIN 
    menus_menu m ON r.id = m.restaurant_id
JOIN 
    menus_menusection ms ON m.id = ms.menu_id
JOIN 
    menus_menuitem mi ON ms.id = mi.menu_section_id
WHERE 
    m.active_status = TRUE;

-- Creates a stored procedure to retrieve menu items based on dietary restrictions.
-- Input parameter: dietaryType (e.g., 'Vegetarian').
-- Outputs item name, description, price, currency, and dietary restriction type.

DELIMITER $$

CREATE PROCEDURE GetMenuItemsByDietaryRestriction(IN dietaryType VARCHAR(99))
BEGIN
    SELECT 
        mi.name AS item_name,
        mi.description AS item_description,
        mi.price,
        mi.currency,
        dr.name AS dietary_restriction
    FROM 
        menus_menuitem mi
    JOIN 
        menus_dietaryrestriction_menu_items idr ON mi.id = idr.menuitem_id
    JOIN 
        menus_dietaryrestriction dr ON idr.dietaryrestriction_id = dr.id
    WHERE 
        dr.name = dietaryType;
END $$

DELIMITER ;


-- Retrieves details of menu audit logs and their statuses.
-- Includes menu sections, audit log status, phase, error details, and timestamps.
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
    menus_auditlog al ON m.version_id = al.menu_version_id
JOIN 
    menus_menusection ms ON m.id = ms.menu_id;


-- Retrieves a report of available menu items grouped by restaurants and sections.
-- Filters for available items (mi.available = TRUE).
-- Orders results by restaurant name, menu section, and price.
SELECT 
    r.name AS restaurant_name,
    mi.name AS item_name,
    mi.price,
    mi.currency,
    ms.name AS section_name
FROM 
    menus_restaurant r
JOIN 
    menus_menu m ON r.id = m.restaurant_id
JOIN 
    menus_menusection ms ON m.id = ms.menu_id
JOIN 
    menus_menuitem mi ON ms.id = mi.menu_section_id
WHERE 
    mi.available = TRUE
ORDER BY 
    r.name, ms.id, mi.price;


-- Creates a stored procedure to update or insert a new menu version for a restaurant.
-- Input parameters:
--   - p_restaurant_id: The ID of the restaurant for which the menu version is being updated.
--   - p_menu_file_url: The URL of the menu file (e.g., PDF hosted online).
-- Procedure logic:
--   1. Checks the highest version number for the restaurant.
--   2. Increments the version or sets it to 1 if no previous version exists.
--   3. Constructs a new composite ID for the menu version.
--   4. Inserts the new version into the `menus_menuversion` table.
--   5. Links the latest version to the associated `menus_menu` entry.

DELIMITER $$

CREATE PROCEDURE UpdateMenuVersion(
    IN p_restaurant_id BIGINT,
    IN p_menu_file_url VARCHAR(255)
)
BEGIN
    DECLARE max_version INT;
    DECLARE new_version INT;

    -- Get the maximum version number for the restaurant
    SELECT MAX(SUBSTRING_INDEX(composite_id, '-', -1)) INTO max_version
    FROM menus_menuversion
    WHERE restaurant_id = p_restaurant_id
    AND composite_id LIKE CONCAT('%-', p_restaurant_id);

    -- If no version exists, set to 1; otherwise, increment
    IF max_version IS NULL THEN
        SET new_version = 1;
    ELSE
        SET new_version = max_version + 1;
    END IF;

    -- Construct the new composite ID
    SET @new_composite_id = CONCAT('Restaurant-v', new_version, ':', p_restaurant_id);

    -- Insert the new version
    INSERT INTO menus_menuversion (version_number, composite_id, restaurant_id)
    VALUES (new_version, @new_composite_id, p_restaurant_id);

    -- Link the latest version to the menus_menu table
    UPDATE menus_menu
    SET version_id = LAST_INSERT_ID(), menu_file = p_menu_file_url
    WHERE restaurant_id = p_restaurant_id;

END $$

DELIMITER ;


