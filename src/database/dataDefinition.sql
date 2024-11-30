CREATE DATABASE IF NOT EXISTS menu_management_system;

USE menu_management_system;

CREATE TABLE `menus_auditlog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `status` varchar(99) DEFAULT NULL,
  `other` varchar(99) DEFAULT NULL,
  `phase` varchar(99) DEFAULT NULL,
  `time_registered` datetime(6) DEFAULT NULL,
  `menu_version_id` bigint DEFAULT NULL,
  `last_edited` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menus_auditlog_menu_version_id_bef77f0f_fk_menus_menuversion_id` (`menu_version_id`),
  CONSTRAINT `menus_auditlog_menu_version_id_bef77f0f_fk_menus_menuversion_id` FOREIGN KEY (`menu_version_id`) REFERENCES `menus_menuversion` (`id`)
)

CREATE TABLE `menus_dietaryrestriction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(99) DEFAULT NULL,
  `last_edited` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_dietaryrestriction_name_e56b1d3d_uniq` (`name`)
)

CREATE TABLE `menus_dietaryrestriction_menu_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dietaryrestriction_id` bigint NOT NULL,
  `menuitem_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_dietaryrestriction_dietaryrestriction_id_me_00824ddf_uniq` (`dietaryrestriction_id`,`menuitem_id`),
  KEY `menus_dietaryrestric_menuitem_id_750317e0_fk_menus_men` (`menuitem_id`),
  CONSTRAINT `menus_dietaryrestric_dietaryrestriction_i_ee4f6c70_fk_menus_die` FOREIGN KEY (`dietaryrestriction_id`) REFERENCES `menus_dietaryrestriction` (`id`),
  CONSTRAINT `menus_dietaryrestric_menuitem_id_750317e0_fk_menus_men` FOREIGN KEY (`menuitem_id`) REFERENCES `menus_menuitem` (`id`)
)

CREATE TABLE `menus_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `active_status` tinyint(1) DEFAULT NULL,
  `available_until` date DEFAULT NULL,
  `available_from` date DEFAULT NULL,
  `menu_file` varchar(100) DEFAULT NULL,
  `restaurant_id` bigint DEFAULT NULL,
  `timeUpload` datetime(6) DEFAULT NULL,
  `user_id_id` bigint DEFAULT NULL,
  `version_id` bigint DEFAULT NULL,
  `last_edited` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menus_menu_user_id_id_87f756a1_fk_menus_user_id` (`user_id_id`),
  KEY `menus_menu_version_id_b7b04197_fk_menus_menuversion_id` (`version_id`),
  KEY `menus_menu_restaurant_id_fae48d76_fk_menus_restaurant_id` (`restaurant_id`),
  CONSTRAINT `menus_menu_restaurant_id_fae48d76_fk_menus_restaurant_id` FOREIGN KEY (`restaurant_id`) REFERENCES `menus_restaurant` (`id`),
  CONSTRAINT `menus_menu_user_id_id_87f756a1_fk_menus_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `menus_user` (`id`),
  CONSTRAINT `menus_menu_version_id_b7b04197_fk_menus_menuversion_id` FOREIGN KEY (`version_id`) REFERENCES `menus_menuversion` (`id`)
)

CREATE TABLE `menus_menuitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(99) DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL,
  `price` int DEFAULT NULL,
  `currency` varchar(99) DEFAULT NULL,
  `available` tinyint(1) DEFAULT NULL,
  `menu_section_id` bigint DEFAULT NULL,
  `last_edited` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menus_menuitem_menu_section_id_a2019aee_fk_menus_menusection_id` (`menu_section_id`),
  CONSTRAINT `menus_menuitem_menu_section_id_a2019aee_fk_menus_menusection_id` FOREIGN KEY (`menu_section_id`) REFERENCES `menus_menusection` (`id`),
  FULLTEXT KEY `fulltext_name_description` (`name`, `description`) -- Added FULLTEXT index for `name` and `description`
)

CREATE TABLE `menus_menusection` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(99) DEFAULT NULL,
  `menu_id` bigint DEFAULT NULL,
  `last_edited` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menus_menusection_menu_id_5d8f94b3_fk_menus_menu_id` (`menu_id`),
  CONSTRAINT `menus_menusection_menu_id_5d8f94b3_fk_menus_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `menus_menu` (`id`),
  FULLTEXT KEY `fulltext_name` (`name`) -- Added FULLTEXT index for `name`
)

CREATE TABLE `menus_menuversion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `version_number` int NOT NULL,
  `composite_id` varchar(255) NOT NULL,
  `restaurant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `composite_id` (`composite_id`),
  KEY `menus_menuversion_restaurant_id_688f3c51_fk_menus_restaurant_id` (`restaurant_id`),
  CONSTRAINT `menus_menuversion_restaurant_id_688f3c51_fk_menus_restaurant_id` FOREIGN KEY (`restaurant_id`) REFERENCES `menus_restaurant` (`id`)
)

CREATE TABLE `menus_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(3) DEFAULT NULL,
  `zip` smallint DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
)

CREATE TABLE `menus_restaurant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(3) DEFAULT NULL,
  `zip` smallint DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `website` varchar(200) DEFAULT NULL,
  `last_edited` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_restaurant_name_d5529e64_uniq` (`name`),
  FULLTEXT KEY `fulltext_name` (`name`) -- Added FULLTEXT index for `name`
)