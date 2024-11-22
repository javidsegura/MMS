--1. Frequently Accessed Menus

CREATE MATERIALIZED VIEW FrequentlyAccessedMenus AS
SELECT 
    m.menu_id,
    m.section AS menu_section,
    COUNT(al.log_id) AS access_count,
    r.name AS restaurant_name
FROM
    audit_log al
JOIN 
    menu m ON al.menu_id = m.menu_id
JOIN 
    restaurant r ON m.restaurant_id = r.restaurant_id
GROUP BY 
    m.menu_id, m.section, r.name
ORDER BY 
    access_count DESC;

-- Add indexes
CREATE INDEX idx_fam_menu_id ON FrequentlyAccessedMenus(menu_id);
CREATE INDEX idx_fam_access_count ON FrequentlyAccessedMenus(access_count);

--2. Recently Updated Menus

CREATE MATERIALIZED VIEW RecentlyUpdatedMenus AS
SELECT 
    m.menu_id,
    m.section AS menu_section,
    r.name AS restaurant_name,
    al.time_registered AS last_updated
FROM
    menu m
JOIN 
    restaurant r ON m.restaurant_id = r.restaurant_id
JOIN 
    audit_log al ON al.menu_id = m.menu_id
WHERE 
    al.phase = 'Updated'
ORDER BY 
    al.time_registered DESC;

-- Add indexes
CREATE INDEX idx_rum_last_updated ON RecentlyUpdatedMenus(last_updated);
CREATE INDEX idx_rum_menu_id ON RecentlyUpdatedMenus(menu_id);

--3. Menus By Location

CREATE MATERIALIZED VIEW MenusByLocation AS
SELECT 
    r.name AS restaurant_name,
    m.section AS menu_section,
    r.country,
    r.state,
    r.city,
    m.menu_id
FROM
    menu m
JOIN 
    restaurant r ON m.restaurant_id = r.restaurant_id
WHERE 
    m.activeStatus = TRUE
ORDER BY 
    r.country, r.state, r.city, r.name;

-- Add indexes
CREATE INDEX idx_mbl_country_state_city ON MenusByLocation(country, state, city);
CREATE INDEX idx_mbl_menu_id ON MenusByLocation(menu_id);

--4. Menu Version History

CREATE MATERIALIZED VIEW MenuVersionHistory AS
SELECT 
    m.menu_id,
    m.section AS menu_section,
    m.menu_version,
    m.timeUpload AS version_created_at,
    r.name AS restaurant_name
FROM
    menu m
JOIN 
    restaurant r ON m.restaurant_id = r.restaurant_id
ORDER BY 
    m.timeUpload DESC;

-- Add indexes
CREATE INDEX idx_mvh_version_created_at ON MenuVersionHistory(version_created_at);
CREATE INDEX idx_mvh_menu_id ON MenuVersionHistory(menu_id);
