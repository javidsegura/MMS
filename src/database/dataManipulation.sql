DELIMITER $$

CREATE PROCEDURE GetMenuItemsByDietaryRestriction(IN restriction_name VARCHAR(255))
BEGIN
    SELECT 
        m_items.name AS item_name,
        m_items.description AS item_description,
        m_items.price AS item_price,
        m_items.currency AS item_currency,
        m_items.available AS item_available,
        mdr.name AS restriction_name
    FROM menus_menuitem m_items
    INNER JOIN menus_dietaryrestriction_menu_items mr_items 
        ON mr_items.menuitem_id = m_items.id
    INNER JOIN menus_dietaryrestriction mdr 
        ON mdr.id = mr_items.dietaryrestriction_id
    WHERE mdr.name = restriction_name;
END$$

DELIMITER ;
