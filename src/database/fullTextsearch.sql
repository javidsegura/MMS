ALTER TABLE `menus_restaurant`
ADD FULLTEXT INDEX `ft_name_country` (`name`, `country`);

-- Observing relevance score
SELECT *,
       MATCH(`name`, `country`) AGAINST('India' IN NATURAL LANGUAGE MODE) AS relevance_score
FROM `menus_restaurant`
WHERE MATCH(`name`, `country`) AGAINST('India' IN NATURAL LANGUAGE MODE)
ORDER BY relevance_score DESC;

ALTER TABLE `menus_menuitem`
ADD FULLTEXT INDEX `ft_name_description` (`name`, `description`);

-- Observing relevance score
SELECT *,
       MATCH(`name`, `description`) AGAINST('Chocolate' IN NATURAL LANGUAGE MODE) AS relevance_score
FROM `menus_menuitem`
WHERE MATCH(`name`, `description`) AGAINST('Chocolate' IN NATURAL LANGUAGE MODE)
ORDER BY relevance_score DESC;