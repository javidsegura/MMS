USE menu_management_system;

CREATE TABLE FrequentlyAccessedMenus AS
SELECT 
    m.id AS menu_id,
    ms.name AS menu_section,
    COUNT(al.id) AS access_count,
    r.name AS restaurant_name
FROM
    menus_auditlog al
JOIN 
    menus_menu m ON al.menu_version_id = m.version_id
JOIN 
    menus_menusection ms ON ms.menu_id = m.id
JOIN 
    menus_restaurant r ON m.restaurant_id = r.id
GROUP BY 
    m.id, ms.name, r.name
ORDER BY 
    access_count DESC;

DELIMITER //

CREATE PROCEDURE RefreshFrequentlyAccessedMenus()
BEGIN
    -- Delete the old data
    TRUNCATE TABLE FrequentlyAccessedMenus;
    
    -- Insert the new data
    INSERT INTO FrequentlyAccessedMenus
    SELECT 
        m.id AS menu_id,
        ms.name AS menu_section,
        COUNT(al.id) AS access_count,
        r.name AS restaurant_name
    FROM
        menus_auditlog al
    JOIN 
        menus_menu m ON al.menu_version_id = m.version_id
    JOIN 
        menus_menusection ms ON ms.menu_id = m.id
    JOIN 
        menus_restaurant r ON m.restaurant_id = r.id
    GROUP BY 
        m.id, ms.name, r.name
    ORDER BY 
        access_count DESC;
END //

DELIMITER ;

DELIMITER //SET GLOBAL event_scheduler = ON;

CREATE EVENT RefreshFrequentlyAccessedMenusEvent
ON SCHEDULE EVERY 1 HOUR
DO
CALL RefreshFrequentlyAccessedMenus();

