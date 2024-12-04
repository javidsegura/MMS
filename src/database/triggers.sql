USE menu_management_system;

DELIMITER $$

CREATE TRIGGER after_menu_item_update
AFTER UPDATE ON menus_menuitem
FOR EACH ROW
BEGIN
    -- Check if all items in the section are unavailable
    IF NOT EXISTS (
        SELECT 1
        FROM menus_menuitem
        WHERE menu_section_id = NEW.menu_section_id AND available = TRUE
    ) THEN
        -- Update the menu_section name to indicate it is inactive
        UPDATE menus_menusection
        SET name = CONCAT('[INACTIVE] ', name)
        WHERE id = NEW.menu_section_id;
    END IF;
END$$

DELIMITER ;
