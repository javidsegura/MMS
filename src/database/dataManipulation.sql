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
    dr.description = 'Vegetarian';

-- 3. Track PDF Processing Status
-- Retrieves information about menu uploads and their status from the audit log.
SELECT 
    m.menu_id,
    m.menu_section,
    al.status,
    al.action,
    al.old_value AS previous_value,
    al.new_value AS updated_value
FROM 
    menu_info m
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

-- Insert a new menu version
INSERT INTO menu_version (menu_version, user_id, post_id, timeUpload)
VALUES 
(1, 2, 1, NOW()) -- Replace with actual values
ON DUPLICATE KEY UPDATE 
menu_version = menu_version + 1;

-- Update an existing menu's status and upload time
UPDATE menu_info
SET 
    activeStatus = FALSE,
    available_until = '2024-12-31'
WHERE 
    menu_id = 1;



-- Add a new version of the menu file
INSERT INTO menu_info (
    menu_section, section, activeStatus, available_until, available_from, menu_id, country, city, state, zip, street
)
VALUES 
(
    2, 'Updated Dinner Menu', TRUE, '2024-12-31', '2024-01-01', 1, 'USA', 'New York', 'NY', 10001, 'Main Street'
);


