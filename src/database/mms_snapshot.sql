-- MySQL dump 10.13  Distrib 9.0.1, for macos14.7 (arm64)
--
-- Host: mms.cheqey0s0sx8.us-east-1.rds.amazonaws.com    Database: mms
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `FrequentlyAccessedMenus`
--

DROP TABLE IF EXISTS `FrequentlyAccessedMenus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FrequentlyAccessedMenus` (
  `restaurant_name` varchar(99) DEFAULT NULL,
  `access_count` bigint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FrequentlyAccessedMenus`
--

LOCK TABLES `FrequentlyAccessedMenus` WRITE;
/*!40000 ALTER TABLE `FrequentlyAccessedMenus` DISABLE KEYS */;
INSERT INTO `FrequentlyAccessedMenus` VALUES ('18',0),('6',0),('3',0),('3',0),('3',0),('3',0),('3',0),('3',0);
/*!40000 ALTER TABLE `FrequentlyAccessedMenus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add Menu',6,'add_menu'),(22,'Can change Menu',6,'change_menu'),(23,'Can delete Menu',6,'delete_menu'),(24,'Can view Menu',6,'view_menu'),(25,'Can add user',7,'add_user'),(26,'Can change user',7,'change_user'),(27,'Can delete user',7,'delete_user'),(28,'Can view user',7,'view_user'),(29,'Can add Audit Log',8,'add_auditlog'),(30,'Can change Audit Log',8,'change_auditlog'),(31,'Can delete Audit Log',8,'delete_auditlog'),(32,'Can view Audit Log',8,'view_auditlog'),(33,'Can add Menu Item',9,'add_menuitem'),(34,'Can change Menu Item',9,'change_menuitem'),(35,'Can delete Menu Item',9,'delete_menuitem'),(36,'Can view Menu Item',9,'view_menuitem'),(37,'Can add Dietary Restriction',10,'add_dietaryrestriction'),(38,'Can change Dietary Restriction',10,'change_dietaryrestriction'),(39,'Can delete Dietary Restriction',10,'delete_dietaryrestriction'),(40,'Can view Dietary Restriction',10,'view_dietaryrestriction'),(41,'Can add Restaurant',11,'add_restaurant'),(42,'Can change Restaurant',11,'change_restaurant'),(43,'Can delete Restaurant',11,'delete_restaurant'),(44,'Can view Restaurant',11,'view_restaurant'),(45,'Can add Menu Section',12,'add_menusection'),(46,'Can change Menu Section',12,'change_menusection'),(47,'Can delete Menu Section',12,'delete_menusection'),(48,'Can view Menu Section',12,'view_menusection'),(49,'Can add Menu Versions',13,'add_menuversion'),(50,'Can change Menu Versions',13,'change_menuversion'),(51,'Can delete Menu Versions',13,'delete_menuversion'),(52,'Can view Menu Versions',13,'view_menuversion');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_menus_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_menus_user_id` FOREIGN KEY (`user_id`) REFERENCES `menus_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-12-04 20:37:21.334756','1','Five Guys-v1:1',1,'[{\"added\": {}}]',6,1),(2,'2024-12-04 21:15:30.283646','2','Five Guys-v2:1',1,'[{\"added\": {}}]',6,1),(3,'2024-12-04 21:16:02.627028','1','Five Guys-v1:1',3,'',6,1),(4,'2024-12-04 21:19:09.892303','3','Five Guys-v3:1',1,'[{\"added\": {}}]',6,1),(5,'2024-12-05 07:22:22.623222','4','Five Guys-v4:1',1,'[{\"added\": {}}]',6,1),(6,'2024-12-05 07:22:49.790117','5','restaurant name-v1:2',1,'[{\"added\": {}}]',6,1),(7,'2024-12-05 07:24:16.372870',NULL,'No version: None',1,'[{\"added\": {}}]',6,1),(8,'2024-12-05 07:27:38.835250','5','restaurant name-v1:2',3,'',6,1),(9,'2024-12-05 07:28:50.831780','7','JD\'S Burgers-v1:3',1,'[{\"added\": {}}]',6,1),(10,'2024-12-05 07:32:10.431423',NULL,'No version: None',1,'[{\"added\": {}}]',6,1),(11,'2024-12-05 07:36:59.859874',NULL,'No version: None',1,'[{\"added\": {}}]',6,1),(12,'2024-12-05 07:40:17.163614',NULL,'No version: None',1,'[{\"added\": {}}]',6,1),(13,'2024-12-05 07:44:56.986954',NULL,'No version: None',1,'[{\"added\": {}}]',6,1),(14,'2024-12-05 07:48:27.386671',NULL,'No version: None',1,'[{\"added\": {}}]',6,1),(15,'2024-12-05 07:52:55.076207',NULL,'No version: None',1,'[{\"added\": {}}]',6,1),(16,'2024-12-05 07:54:17.454068',NULL,'No version: None',1,'[{\"added\": {}}]',6,1),(17,'2024-12-05 08:01:09.818077',NULL,'No version: None',1,'[{\"added\": {}}]',6,1),(18,'2024-12-05 08:03:04.422428',NULL,'No version: None',1,'[{\"added\": {}}]',6,1),(19,'2024-12-05 08:06:18.518062','17','Five Guys-v5:1',1,'[{\"added\": {}}]',6,1),(20,'2024-12-05 08:07:00.528271','18','Obee\'s Pizza Pasta-v1:4',1,'[{\"added\": {}}]',6,1),(21,'2024-12-05 08:07:41.904089','2','restaurant name',3,'',11,1),(22,'2024-12-05 08:08:49.490305','19','Buffalo Bill\'s-v1:5',1,'[{\"added\": {}}]',6,1),(23,'2024-12-05 08:09:36.617082','20','Plane Food-v1:6',1,'[{\"added\": {}}]',6,1),(24,'2024-12-05 08:10:36.325589','6','Gordon Ramsay\'s Plane Food',2,'[{\"changed\": {\"fields\": [\"Name\", \"Website\"]}}]',11,1),(25,'2024-12-05 08:13:34.008158','21','D-MARIS BAY-v1:7',1,'[{\"added\": {}}]',6,1),(26,'2024-12-05 08:17:00.014143','7','Nusr-Et Steakhouse D-Maris, D-MARIS BAY',2,'[{\"changed\": {\"fields\": [\"Name\", \"Phone\", \"Website\", \"Country\"]}}]',11,1),(27,'2024-12-05 08:20:05.796043','22','Nobu-v1:8',1,'[{\"added\": {}}]',6,1),(28,'2024-12-05 09:59:55.290181','1','javi',2,'[{\"changed\": {\"fields\": [\"Username\"]}}]',7,1),(29,'2024-12-05 10:22:17.647999','23','Obee\'s Pizza Pasta-v2:4',1,'[{\"added\": {}}]',6,1),(30,'2024-12-05 10:26:13.251021','24','Five Guys-v6:1',1,'[{\"added\": {}}]',6,2),(31,'2024-12-05 10:26:31.616393','25','Five Guys-v7:1',1,'[{\"added\": {}}]',6,2),(32,'2024-12-05 10:28:03.950377','22','Nobu-v1:8',2,'[{\"changed\": {\"fields\": [\"Available from\"]}}]',6,1),(33,'2024-12-05 10:29:13.375374','26','restaurant name-v1:9',1,'[{\"added\": {}}]',6,2),(34,'2024-12-05 10:30:24.553837',NULL,'No version: None',1,'[{\"added\": {}}]',6,2),(35,'2024-12-05 20:25:20.181120',NULL,'No version: None',1,'[{\"added\": {}}]',6,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(8,'menus','auditlog'),(10,'menus','dietaryrestriction'),(6,'menus','menu'),(9,'menus','menuitem'),(12,'menus','menusection'),(13,'menus','menuversion'),(11,'menus','restaurant'),(7,'menus','user'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-12-04 20:27:50.416363'),(2,'contenttypes','0002_remove_content_type_name','2024-12-04 20:27:51.036021'),(3,'auth','0001_initial','2024-12-04 20:27:52.485217'),(4,'auth','0002_alter_permission_name_max_length','2024-12-04 20:27:52.745320'),(5,'auth','0003_alter_user_email_max_length','2024-12-04 20:27:52.839250'),(6,'auth','0004_alter_user_username_opts','2024-12-04 20:27:52.935166'),(7,'auth','0005_alter_user_last_login_null','2024-12-04 20:27:53.035200'),(8,'auth','0006_require_contenttypes_0002','2024-12-04 20:27:53.126630'),(9,'auth','0007_alter_validators_add_error_messages','2024-12-04 20:27:53.224793'),(10,'auth','0008_alter_user_username_max_length','2024-12-04 20:27:53.324143'),(11,'auth','0009_alter_user_last_name_max_length','2024-12-04 20:27:53.423185'),(12,'auth','0010_alter_group_name_max_length','2024-12-04 20:27:53.624176'),(13,'auth','0011_update_proxy_permissions','2024-12-04 20:27:53.980367'),(14,'auth','0012_alter_user_first_name_max_length','2024-12-04 20:27:54.078402'),(15,'menus','0001_initial','2024-12-04 20:28:00.332834'),(16,'admin','0001_initial','2024-12-04 20:28:01.162546'),(17,'admin','0002_logentry_remove_auto_add','2024-12-04 20:28:01.261946'),(18,'admin','0003_logentry_add_action_flag_choices','2024-12-04 20:28:01.360934'),(19,'menus','0002_alter_user_city_alter_user_country_alter_user_state_and_more','2024-12-04 20:28:02.262177'),(20,'menus','0003_menu_menupdf','2024-12-04 20:28:02.476844'),(21,'menus','0004_remove_menu_section_remove_menuitem_menu_and_more','2024-12-04 20:28:09.636072'),(22,'menus','0005_alter_menu_active_status_alter_menu_available_from_and_more','2024-12-04 20:28:09.799110'),(23,'menus','0006_remove_menu_menupdf_menu_menu_file','2024-12-04 20:28:10.130786'),(24,'menus','0007_alter_menu_menu_file','2024-12-04 20:28:10.231963'),(25,'menus','0008_alter_menu_menu_file','2024-12-04 20:28:10.333785'),(26,'menus','0009_rename_description_dietaryrestriction_name','2024-12-04 20:28:10.533353'),(27,'menus','0010_alter_menu_menu_file','2024-12-04 20:28:10.637563'),(28,'menus','0011_remove_menuversion_post_alter_menuversion_restaurant_and_more','2024-12-04 20:28:12.600015'),(29,'menus','0012_alter_menuversion_restaurant','2024-12-04 20:28:12.709221'),(30,'menus','0013_alter_auditlog_options_and_more','2024-12-04 20:28:12.838478'),(31,'menus','0014_rename_action_auditlog_other_and_more','2024-12-04 20:28:14.782267'),(32,'menus','0015_remove_restaurant_opening_hours_delete_openinghours','2024-12-04 20:28:15.117778'),(33,'menus','0016_alter_menu_menu_version_remove_auditlog_menu_version_and_more','2024-12-04 20:28:19.422720'),(34,'menus','0017_remove_auditlog_menu_remove_menu_menu_version_and_more','2024-12-04 20:28:21.339266'),(35,'menus','0018_alter_menuversion_options','2024-12-04 20:28:21.436790'),(36,'menus','0019_alter_menu_restaurant','2024-12-04 20:28:22.351894'),(37,'menus','0020_alter_menu_restaurant','2024-12-04 20:28:23.275683'),(38,'menus','0021_alter_restaurant_name','2024-12-04 20:28:23.371655'),(39,'menus','0022_alter_restaurant_name','2024-12-04 20:28:23.467563'),(40,'menus','0023_auditlog_time_till_change_and_more','2024-12-04 20:28:23.682400'),(41,'menus','0024_alter_menuitem_description','2024-12-04 20:28:23.886692'),(42,'menus','0025_remove_auditlog_time_till_change_and_more','2024-12-04 20:28:24.096363'),(43,'menus','0026_auditlog_last_edited_dietaryrestriction_last_edited_and_more','2024-12-04 20:28:25.482142'),(44,'menus','0027_alter_restaurant_name','2024-12-04 20:28:25.688245'),(45,'menus','0028_alter_dietaryrestriction_name','2024-12-04 20:28:25.886809'),(46,'menus','0029_alter_user_options_and_more','2024-12-04 20:28:27.296259'),(47,'menus','0030_alter_restaurant_state','2024-12-04 20:28:27.581854'),(48,'menus','0031_alter_menuitem_description_alter_restaurant_city_and_more','2024-12-04 20:28:29.295514'),(49,'sessions','0001_initial','2024-12-04 20:28:29.699534');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('2ylcketkcgsyor7b0n48wl2vl4slex6p','.eJxVjMsOwiAQRf-FtSED5enSvd9AhgGkaiAp7cr479qkC93ec859sYDbWsM28hLmxM5MstPvFpEeue0g3bHdOqfe1mWOfFf4QQe_9pSfl8P9O6g46rcu4EAXtKhigeISJuvMpAoIpSV5Y5VIkaKdJi9IaOkzEuhsnUML3hn2_gDlfzd-:1tJ92W:0gZF-xUzewrNvbjGgOsMd4aDBog61xSdkLbw3S2dVL8','2024-12-19 10:24:56.390339'),('w6mhtywiwm7wmwumt7e0jdcptbrqx91t','.eJxVjEEOwiAQRe_C2hAYrBSX7j0DGZgZqRpISrsy3l2bdKHb_977LxVxXUpcO89xInVWVh1-t4T5wXUDdMd6azq3usxT0puid9r1tRE_L7v7d1Cwl2_tnBHvJYxgJFnvwJCAgCPrKNngsiQmPiICy4hm8GjhFIQhWDOAJPX-AONMOCE:1tIw6i:josCNlOD25xxxBg7Hv9-Imlh-wr3iL3qh-4vNEG0ljM','2024-12-18 20:36:24.275092');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus_auditlog`
--

DROP TABLE IF EXISTS `menus_auditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus_auditlog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `status` varchar(99) DEFAULT NULL,
  `other` varchar(99) DEFAULT NULL,
  `phase` varchar(99) DEFAULT NULL,
  `time_registered` datetime(6) DEFAULT NULL,
  `menu_version_id` bigint DEFAULT NULL,
  `last_edited` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menus_audit_menu_ve_30881a_idx` (`menu_version_id`),
  CONSTRAINT `menus_auditlog_menu_version_id_bef77f0f_fk_menus_menuversion_id` FOREIGN KEY (`menu_version_id`) REFERENCES `menus_menuversion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus_auditlog`
--

LOCK TABLES `menus_auditlog` WRITE;
/*!40000 ALTER TABLE `menus_auditlog` DISABLE KEYS */;
INSERT INTO `menus_auditlog` VALUES (1,'Stored successfully',NULL,'Uploaded file','2024-12-04 20:37:00.299138',1,'2024-12-04 20:37:21.065053'),(2,'Success',NULL,'Extraction','2024-12-04 20:37:00.388724',1,'2024-12-04 20:37:21.159402'),(3,'Success',NULL,'Inserting data','2024-12-04 20:37:18.406308',1,'2024-12-04 20:37:21.246743'),(4,'Stored successfully',NULL,'Uploaded file','2024-12-04 21:14:52.527351',2,'2024-12-04 21:15:30.018286'),(5,'Success',NULL,'Extraction','2024-12-04 21:14:52.614975',2,'2024-12-04 21:15:30.105660'),(6,'Success',NULL,'Inserting data','2024-12-04 21:15:25.633631',2,'2024-12-04 21:15:30.194526'),(7,'Stored successfully',NULL,'Uploaded file','2024-12-04 21:18:42.135073',3,'2024-12-04 21:19:09.629536'),(8,'Success',NULL,'Extraction','2024-12-04 21:18:42.225079',3,'2024-12-04 21:19:09.715678'),(9,'Success',NULL,'Inserting data','2024-12-04 21:19:06.509888',3,'2024-12-04 21:19:09.802246'),(10,'Stored successfully',NULL,'Uploaded file','2024-12-05 07:22:02.856288',4,'2024-12-05 07:22:22.371827'),(11,'Success',NULL,'Extraction','2024-12-05 07:22:02.941786',4,'2024-12-05 07:22:22.455690'),(12,'Success',NULL,'Inserting data','2024-12-05 07:22:19.739651',4,'2024-12-05 07:22:22.539066'),(16,'Received',NULL,'Uploaded file','2024-12-05 07:23:14.844849',NULL,'2024-12-05 07:23:14.844944'),(17,'Failed','\'NoneType\' object has no attribute \'name\'','Extraction','2024-12-05 07:23:14.928381',NULL,'2024-12-05 07:24:16.118100'),(18,'Processing',NULL,'Inserting data','2024-12-05 07:24:16.034945',NULL,'2024-12-05 07:24:16.035104'),(19,'Stored successfully',NULL,'Uploaded file','2024-12-05 07:28:44.183824',6,'2024-12-05 07:28:50.520074'),(20,'Success',NULL,'Extraction','2024-12-05 07:28:44.286748',6,'2024-12-05 07:28:50.624542'),(21,'Success',NULL,'Inserting data','2024-12-05 07:28:48.849526',6,'2024-12-05 07:28:50.728762'),(22,'Received',NULL,'Uploaded file','2024-12-05 07:30:29.405707',NULL,'2024-12-05 07:30:29.405818'),(23,'Failed','\'NoneType\' object has no attribute \'name\'','Extraction','2024-12-05 07:30:29.510062',NULL,'2024-12-05 07:32:10.016459'),(24,'Processing',NULL,'Inserting data','2024-12-05 07:32:09.913420',NULL,'2024-12-05 07:32:09.913520'),(25,'Received',NULL,'Uploaded file','2024-12-05 07:36:12.973830',NULL,'2024-12-05 07:36:12.973902'),(26,'Failed','\'NoneType\' object has no attribute \'name\'','Extraction','2024-12-05 07:36:13.075845',NULL,'2024-12-05 07:36:59.552342'),(27,'Processing',NULL,'Inserting data','2024-12-05 07:36:59.451024',NULL,'2024-12-05 07:36:59.451120'),(28,'Received',NULL,'Uploaded file','2024-12-05 07:39:50.677743',NULL,'2024-12-05 07:39:50.677792'),(29,'Failed','\'NoneType\' object has no attribute \'name\'','Extraction','2024-12-05 07:39:50.778844',NULL,'2024-12-05 07:40:16.851273'),(30,'Processing',NULL,'Inserting data','2024-12-05 07:40:16.749247',NULL,'2024-12-05 07:40:16.749297'),(31,'Received',NULL,'Uploaded file','2024-12-05 07:44:23.365585',NULL,'2024-12-05 07:44:23.365699'),(32,'Failed','\'NoneType\' object has no attribute \'name\'','Extraction','2024-12-05 07:44:23.451988',NULL,'2024-12-05 07:44:56.729501'),(33,'Processing',NULL,'Inserting data','2024-12-05 07:44:56.644973',NULL,'2024-12-05 07:44:56.645082'),(34,'Received',NULL,'Uploaded file','2024-12-05 07:47:55.324533',NULL,'2024-12-05 07:47:55.324577'),(35,'Failed','\'NoneType\' object has no attribute \'name\'','Extraction','2024-12-05 07:47:55.426836',NULL,'2024-12-05 07:48:27.074036'),(36,'Processing',NULL,'Inserting data','2024-12-05 07:48:26.965374',NULL,'2024-12-05 07:48:26.965504'),(37,'Received',NULL,'Uploaded file','2024-12-05 07:52:40.481580',NULL,'2024-12-05 07:52:40.481688'),(38,'Failed','\'NoneType\' object has no attribute \'name\'','Extraction','2024-12-05 07:52:40.583450',NULL,'2024-12-05 07:52:54.761858'),(39,'Processing',NULL,'Inserting data','2024-12-05 07:52:54.658891',NULL,'2024-12-05 07:52:54.658986'),(40,'Received',NULL,'Uploaded file','2024-12-05 07:53:52.910989',NULL,'2024-12-05 07:53:52.911063'),(41,'Failed','\'NoneType\' object has no attribute \'name\'','Extraction','2024-12-05 07:53:53.012775',NULL,'2024-12-05 07:54:17.139021'),(42,'Processing',NULL,'Inserting data','2024-12-05 07:54:17.035962',NULL,'2024-12-05 07:54:17.036075'),(43,'Received',NULL,'Uploaded file','2024-12-05 08:00:51.441074',NULL,'2024-12-05 08:00:51.441195'),(44,'Failed','\'NoneType\' object has no attribute \'name\'','Extraction','2024-12-05 08:00:51.545410',NULL,'2024-12-05 08:01:09.502079'),(45,'Processing',NULL,'Inserting data','2024-12-05 08:01:09.397247',NULL,'2024-12-05 08:01:09.397322'),(46,'Received',NULL,'Uploaded file','2024-12-05 08:02:32.277252',NULL,'2024-12-05 08:02:32.277315'),(47,'Failed','\'NoneType\' object has no attribute \'name\'','Extraction','2024-12-05 08:02:32.360304',NULL,'2024-12-05 08:03:03.651214'),(48,'Processing',NULL,'Inserting data','2024-12-05 08:03:00.830125',NULL,'2024-12-05 08:03:00.830238'),(49,'Stored successfully',NULL,'Uploaded file','2024-12-05 08:05:44.212489',7,'2024-12-05 08:06:18.215570'),(50,'Success',NULL,'Extraction','2024-12-05 08:05:44.312651',7,'2024-12-05 08:06:18.316186'),(51,'Success',NULL,'Inserting data','2024-12-05 08:06:10.730323',7,'2024-12-05 08:06:18.416574'),(52,'Stored successfully',NULL,'Uploaded file','2024-12-05 08:06:42.664890',8,'2024-12-05 08:07:00.228524'),(53,'Success',NULL,'Extraction','2024-12-05 08:06:42.764953',8,'2024-12-05 08:07:00.328691'),(54,'Success',NULL,'Inserting data','2024-12-05 08:06:57.973112',8,'2024-12-05 08:07:00.428553'),(55,'Stored successfully',NULL,'Uploaded file','2024-12-05 08:08:15.087531',9,'2024-12-05 08:08:49.231411'),(56,'Success',NULL,'Extraction','2024-12-05 08:08:15.172122',9,'2024-12-05 08:08:49.316928'),(57,'Success',NULL,'Inserting data','2024-12-05 08:08:44.740188',9,'2024-12-05 08:08:49.402205'),(58,'Stored successfully',NULL,'Uploaded file','2024-12-05 08:09:09.606012',10,'2024-12-05 08:09:36.356649'),(59,'Success',NULL,'Extraction','2024-12-05 08:09:09.691094',10,'2024-12-05 08:09:36.443214'),(60,'Success',NULL,'Inserting data','2024-12-05 08:09:30.608685',10,'2024-12-05 08:09:36.530451'),(61,'Stored successfully',NULL,'Uploaded file','2024-12-05 08:12:42.834525',11,'2024-12-05 08:13:33.661327'),(62,'Success',NULL,'Extraction','2024-12-05 08:12:42.920178',11,'2024-12-05 08:13:33.748004'),(63,'Success',NULL,'Inserting data','2024-12-05 08:13:27.059990',11,'2024-12-05 08:13:33.834214'),(64,'Stored successfully',NULL,'Uploaded file','2024-12-05 08:17:54.004542',12,'2024-12-05 08:20:05.531746'),(65,'Success',NULL,'Extraction','2024-12-05 08:17:54.094771',12,'2024-12-05 08:20:05.619673'),(66,'Success',NULL,'Inserting data','2024-12-05 08:19:42.643559',12,'2024-12-05 08:20:05.707516'),(67,'Stored successfully',NULL,'Uploaded file','2024-12-05 10:21:41.458189',13,'2024-12-05 10:22:17.252720'),(68,'Success',NULL,'Extraction','2024-12-05 10:21:41.549118',13,'2024-12-05 10:22:17.356104'),(69,'Success',NULL,'Inserting data','2024-12-05 10:22:12.427289',13,'2024-12-05 10:22:17.479653'),(70,'Stored successfully',NULL,'Uploaded file','2024-12-05 10:25:48.650873',14,'2024-12-05 10:26:12.969495'),(71,'Success',NULL,'Extraction','2024-12-05 10:25:48.738653',14,'2024-12-05 10:26:13.055768'),(72,'Success',NULL,'Inserting data','2024-12-05 10:26:09.311492',14,'2024-12-05 10:26:13.145306'),(73,'Stored successfully',NULL,'Uploaded file','2024-12-05 10:26:09.477240',15,'2024-12-05 10:26:31.353832'),(74,'Success',NULL,'Extraction','2024-12-05 10:26:09.566727',15,'2024-12-05 10:26:31.441548'),(75,'Success',NULL,'Inserting data','2024-12-05 10:26:28.025132',15,'2024-12-05 10:26:31.529072'),(76,'Stored successfully',NULL,'Uploaded file','2024-12-05 10:28:58.016946',16,'2024-12-05 10:29:13.118194'),(77,'Success',NULL,'Extraction','2024-12-05 10:28:58.101581',16,'2024-12-05 10:29:13.204237'),(78,'Success',NULL,'Inserting data','2024-12-05 10:29:10.977436',16,'2024-12-05 10:29:13.290110'),(79,'Received',NULL,'Uploaded file','2024-12-05 10:29:58.952892',NULL,'2024-12-05 10:29:58.952921'),(80,'Failed','\'NoneType\' object has no attribute \'name\'','Extraction','2024-12-05 10:29:59.077351',NULL,'2024-12-05 10:30:24.280124'),(81,'Processing',NULL,'Inserting data','2024-12-05 10:30:24.193395',NULL,'2024-12-05 10:30:24.193438'),(84,'Received',NULL,'Uploaded file','2024-12-05 20:25:18.081865',NULL,'2024-12-05 20:25:18.081885'),(85,'Failed','No menu_json returned from AI call','Extraction','2024-12-05 20:25:18.173186',NULL,'2024-12-05 20:25:19.897693');
/*!40000 ALTER TABLE `menus_auditlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus_dietaryrestriction`
--

DROP TABLE IF EXISTS `menus_dietaryrestriction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus_dietaryrestriction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(99) DEFAULT NULL,
  `last_edited` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_dietaryrestriction_name_e56b1d3d_uniq` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus_dietaryrestriction`
--

LOCK TABLES `menus_dietaryrestriction` WRITE;
/*!40000 ALTER TABLE `menus_dietaryrestriction` DISABLE KEYS */;
INSERT INTO `menus_dietaryrestriction` VALUES (1,'Vegetarian','2024-12-04 21:15:27.553702'),(2,'Vegan','2024-12-04 21:15:28.009371'),(3,'Gluten-Free','2024-12-05 08:06:13.832049'),(4,'Dairy-Free','2024-12-05 08:06:14.330976'),(5,'Nut-Free','2024-12-05 08:06:14.829515'),(6,'Pescatarian','2024-12-05 08:09:34.896535'),(7,'No Pork','2024-12-05 08:19:46.507275'),(8,'Soy-Free','2024-12-05 08:19:52.603307');
/*!40000 ALTER TABLE `menus_dietaryrestriction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus_dietaryrestriction_menu_items`
--

DROP TABLE IF EXISTS `menus_dietaryrestriction_menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus_dietaryrestriction_menu_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dietaryrestriction_id` bigint NOT NULL,
  `menuitem_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_dietaryrestriction_dietaryrestriction_id_me_00824ddf_uniq` (`dietaryrestriction_id`,`menuitem_id`),
  KEY `menus_dietaryrestric_menuitem_id_750317e0_fk_menus_men` (`menuitem_id`),
  CONSTRAINT `menus_dietaryrestric_dietaryrestriction_i_ee4f6c70_fk_menus_die` FOREIGN KEY (`dietaryrestriction_id`) REFERENCES `menus_dietaryrestriction` (`id`),
  CONSTRAINT `menus_dietaryrestric_menuitem_id_750317e0_fk_menus_men` FOREIGN KEY (`menuitem_id`) REFERENCES `menus_menuitem` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus_dietaryrestriction_menu_items`
--

LOCK TABLES `menus_dietaryrestriction_menu_items` WRITE;
/*!40000 ALTER TABLE `menus_dietaryrestriction_menu_items` DISABLE KEYS */;
INSERT INTO `menus_dietaryrestriction_menu_items` VALUES (1,1,32),(3,1,33),(4,1,34),(5,1,139),(10,1,140),(15,1,141),(20,1,159),(24,1,188),(26,1,191),(27,1,193),(28,1,194),(29,1,195),(30,1,196),(33,1,199),(36,1,201),(39,1,206),(40,1,207),(41,1,214),(42,1,215),(43,1,216),(44,1,217),(45,1,218),(46,1,219),(48,1,238),(49,1,239),(50,1,240),(51,1,241),(52,1,242),(53,1,243),(67,1,251),(111,1,289),(117,1,294),(118,1,295),(119,1,296),(121,1,297),(123,1,298),(125,1,299),(127,1,300),(128,1,301),(130,1,302),(131,1,303),(133,1,304),(135,1,305),(136,1,306),(137,1,307),(139,1,308),(2,2,32),(6,2,139),(11,2,140),(16,2,141),(25,2,189),(31,2,197),(34,2,200),(47,2,219),(54,2,244),(58,2,245),(62,2,246),(72,2,259),(76,2,260),(80,2,261),(87,2,268),(92,2,270),(93,2,271),(95,2,272),(96,2,274),(98,2,275),(99,2,276),(103,2,282),(113,2,291),(115,2,293),(132,2,303),(134,2,304),(138,2,307),(7,3,139),(12,3,140),(17,3,141),(23,3,171),(32,3,197),(35,3,200),(55,3,244),(59,3,245),(63,3,246),(73,3,259),(77,3,260),(81,3,261),(88,3,268),(97,3,274),(112,3,289),(116,3,293),(120,3,296),(122,3,297),(126,3,299),(129,3,301),(8,4,139),(13,4,140),(18,4,141),(56,4,244),(60,4,245),(64,4,246),(74,4,259),(78,4,260),(82,4,261),(89,4,268),(94,4,271),(104,4,282),(124,4,298),(9,5,139),(14,5,140),(19,5,141),(21,5,163),(22,5,164),(57,5,244),(61,5,245),(65,5,246),(75,5,259),(79,5,260),(83,5,261),(90,5,268),(37,6,202),(38,6,205),(66,6,248),(69,6,254),(70,6,255),(71,6,256),(84,6,263),(85,6,264),(86,6,265),(100,6,277),(101,6,278),(102,6,279),(105,6,283),(106,6,284),(107,6,285),(108,6,286),(109,6,287),(110,6,288),(114,6,292),(68,7,252),(91,8,268);
/*!40000 ALTER TABLE `menus_dietaryrestriction_menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus_menu`
--

DROP TABLE IF EXISTS `menus_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
  KEY `menus_menu_availab_2acdc4_idx` (`available_from`,`available_until`),
  CONSTRAINT `menus_menu_restaurant_id_fae48d76_fk_menus_restaurant_id` FOREIGN KEY (`restaurant_id`) REFERENCES `menus_restaurant` (`id`),
  CONSTRAINT `menus_menu_user_id_id_87f756a1_fk_menus_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `menus_user` (`id`),
  CONSTRAINT `menus_menu_version_id_b7b04197_fk_menus_menuversion_id` FOREIGN KEY (`version_id`) REFERENCES `menus_menuversion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus_menu`
--

LOCK TABLES `menus_menu` WRITE;
/*!40000 ALTER TABLE `menus_menu` DISABLE KEYS */;
INSERT INTO `menus_menu` VALUES (2,1,NULL,NULL,'fiveguys.png',1,'2024-12-04 21:14:52.433264',1,2,'2024-12-04 21:15:29.929832'),(3,1,NULL,NULL,'fiveguys.png',1,'2024-12-04 21:18:42.044711',1,3,'2024-12-04 21:19:09.543691'),(4,1,NULL,NULL,'fiveguys.png',1,'2024-12-05 07:22:02.764039',1,4,'2024-12-05 07:22:22.285924'),(7,1,NULL,NULL,'myMenu.html',3,'2024-12-05 07:28:44.078841',1,6,'2024-12-05 07:28:50.416678'),(17,1,NULL,NULL,'fiveguys.png',1,'2024-12-05 08:05:44.112080',1,7,'2024-12-05 08:06:18.116865'),(18,1,NULL,NULL,'PDF-Menus-For-Restaurants_1.png',4,'2024-12-05 08:06:42.561774',1,8,'2024-12-05 08:07:00.126360'),(19,1,NULL,NULL,'buffalo_bill.jpg',5,'2024-12-05 08:08:15.002604',1,9,'2024-12-05 08:08:49.147462'),(20,1,NULL,NULL,'gordoRamsayPF.png',6,'2024-12-05 08:09:09.519613',1,10,'2024-12-05 08:09:36.269924'),(21,1,NULL,NULL,'nusr_et.pdf',7,'2024-12-05 08:12:42.747707',1,11,'2024-12-05 08:13:33.575423'),(22,1,NULL,'2024-12-05','nobu.pdf',8,'2024-12-05 08:17:53.915634',1,12,'2024-12-05 10:28:03.754008'),(23,1,NULL,NULL,'PDF-Menus-For-Restaurants_1.png',4,'2024-12-05 10:21:41.304547',1,13,'2024-12-05 10:22:17.114589'),(24,1,NULL,NULL,'fiveguys_ip0vnFi_jc27WTf_l0EjRgc.png',1,'2024-12-05 10:25:48.565746',2,14,'2024-12-05 10:26:12.873443'),(25,1,NULL,NULL,'fiveguys_ip0vnFi_jc27WTf_Z9kV5sl.png',1,'2024-12-05 10:26:09.391091',2,15,'2024-12-05 10:26:31.267197'),(26,1,'2024-12-31','2024-12-05','defaultRestaurant_qxBGTPx.png',9,'2024-12-05 10:28:57.932985',2,16,'2024-12-05 10:29:13.033511');
/*!40000 ALTER TABLE `menus_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus_menuitem`
--

DROP TABLE IF EXISTS `menus_menuitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus_menuitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(99) DEFAULT NULL,
  `description` varchar(199) DEFAULT NULL,
  `price` int DEFAULT NULL,
  `currency` varchar(99) DEFAULT NULL,
  `available` tinyint(1) DEFAULT NULL,
  `menu_section_id` bigint DEFAULT NULL,
  `last_edited` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menus_menuitem_menu_section_id_a2019aee_fk_menus_menusection_id` (`menu_section_id`),
  KEY `menus_menui_name_fcb5c5_idx` (`name`),
  FULLTEXT KEY `ft_name_description` (`name`,`description`),
  CONSTRAINT `menus_menuitem_menu_section_id_a2019aee_fk_menus_menusection_id` FOREIGN KEY (`menu_section_id`) REFERENCES `menus_menusection` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=391 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus_menuitem`
--

LOCK TABLES `menus_menuitem` WRITE;
/*!40000 ALTER TABLE `menus_menuitem` DISABLE KEYS */;
INSERT INTO `menus_menuitem` VALUES (20,'Hamburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',8,'dollar',1,6,'2024-12-04 21:15:26.072452'),(21,'Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',9,'dollar',1,6,'2024-12-04 21:15:26.160315'),(22,'Bacon Burger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',9,'dollar',1,6,'2024-12-04 21:15:26.247368'),(23,'Bacon Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',10,'dollar',1,6,'2024-12-04 21:15:26.335704'),(24,'Little Hamburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',5,'dollar',1,6,'2024-12-04 21:15:26.423278'),(25,'Little Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',6,'dollar',1,6,'2024-12-04 21:15:26.510047'),(26,'Little Bacon Burger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',6,'dollar',1,6,'2024-12-04 21:15:26.598106'),(27,'Little Bacon Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',6,'dollar',1,6,'2024-12-04 21:15:26.684114'),(28,'Kosher Style Hot Dog','',5,'dollar',1,7,'2024-12-04 21:15:26.856584'),(29,'Cheese Dog','',5,'dollar',1,7,'2024-12-04 21:15:26.943773'),(30,'Bacon Dog','',6,'dollar',1,7,'2024-12-04 21:15:27.031014'),(31,'Bacon Cheese Dog','',6,'dollar',1,7,'2024-12-04 21:15:27.117951'),(32,'Veggie Sandwich','',2,'dollar',1,8,'2024-12-04 21:15:27.292454'),(33,'Cheese Veggie Sandwich','',4,'dollar',1,8,'2024-12-04 21:15:28.270148'),(34,'Grilled Cheese','',4,'dollar',1,8,'2024-12-04 21:15:28.533151'),(35,'BLT','',NULL,'dollar',1,8,'2024-12-04 21:15:28.795378'),(36,'Five Guys Style or Cajun Style','Cooked in cholesterol free pure peanut oil',5,'dollar',1,9,'2024-12-04 21:15:28.967346'),(37,'Regular','',9,'dollar',1,9,'2024-12-04 21:15:29.055339'),(38,'Large','',13,'dollar',1,9,'2024-12-04 21:15:29.141937'),(39,'Five Guys Shake','Add Whip Cream',6,'dollar',1,10,'2024-12-04 21:15:29.315541'),(40,'Regular','',0,'dollar',1,11,'2024-12-04 21:15:29.490738'),(41,'Large','',0,'dollar',1,11,'2024-12-04 21:15:29.578494'),(42,'Bottled Water','',0,'dollar',1,11,'2024-12-04 21:15:29.665748'),(43,'Hamburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',8,'dollar',1,12,'2024-12-04 21:19:06.945596'),(44,'Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',9,'dollar',1,12,'2024-12-04 21:19:07.032549'),(45,'Bacon Burger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',9,'dollar',1,12,'2024-12-04 21:19:07.118772'),(46,'Bacon Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',10,'dollar',1,12,'2024-12-04 21:19:07.204645'),(47,'Little Hamburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',5,'dollar',1,12,'2024-12-04 21:19:07.291191'),(48,'Little Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',6,'dollar',1,12,'2024-12-04 21:19:07.378173'),(49,'Little Bacon Burger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',6,'dollar',1,12,'2024-12-04 21:19:07.463844'),(50,'Little Bacon Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',6,'dollar',1,12,'2024-12-04 21:19:07.550080'),(51,'Kosher Style Hot Dog','',5,'dollar',1,13,'2024-12-04 21:19:07.721574'),(52,'Cheese Dog','',5,'dollar',1,13,'2024-12-04 21:19:07.807499'),(53,'Bacon Dog','',6,'dollar',1,13,'2024-12-04 21:19:07.892757'),(54,'Bacon Cheese Dog','',6,'dollar',1,13,'2024-12-04 21:19:07.993792'),(55,'Five Guys Style or Cajun Style','Little',5,'dollar',1,14,'2024-12-04 21:19:08.164740'),(56,'Five Guys Style or Cajun Style','Regular',9,'dollar',1,14,'2024-12-04 21:19:08.250332'),(57,'Five Guys Style or Cajun Style','Large',13,'dollar',1,14,'2024-12-04 21:19:08.336669'),(58,'Veggie Sandwich','',2,'dollar',1,15,'2024-12-04 21:19:08.508147'),(59,'Cheese Veggie Sandwich','',4,'dollar',1,15,'2024-12-04 21:19:08.595830'),(60,'Grilled Cheese','',4,'dollar',1,15,'2024-12-04 21:19:08.683199'),(61,'BLT','',6,'dollar',1,15,'2024-12-04 21:19:08.768278'),(62,'Five Guys Shake','Add Whip Cream',6,'dollar',1,16,'2024-12-04 21:19:08.940301'),(63,'Regular','',0,'dollar',1,17,'2024-12-04 21:19:09.111334'),(64,'Large','',0,'dollar',1,17,'2024-12-04 21:19:09.197145'),(65,'Bottled Water','',0,'dollar',1,17,'2024-12-04 21:19:09.283631'),(66,'HAMBURGER','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',8,'dollar',1,18,'2024-12-05 07:22:20.179176'),(67,'CHEESEBURGER','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',9,'dollar',1,18,'2024-12-05 07:22:20.267054'),(68,'BACON BURGER','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',9,'dollar',1,18,'2024-12-05 07:22:20.351724'),(69,'BACON CHEESEBURGER','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',10,'dollar',1,18,'2024-12-05 07:22:20.435599'),(70,'LITTLE HAMBURGER','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',5,'dollar',1,18,'2024-12-05 07:22:20.519906'),(71,'LITTLE CHEESEBURGER','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',6,'dollar',1,18,'2024-12-05 07:22:20.604619'),(72,'LITTLE BACON BURGER','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',6,'dollar',1,18,'2024-12-05 07:22:20.688425'),(73,'LITTLE BACON CHEESEBURGER','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',6,'dollar',1,18,'2024-12-05 07:22:20.772280'),(74,'KOSHER STYLE HOT DOG','',5,'dollar',1,19,'2024-12-05 07:22:20.942591'),(75,'CHEESE DOG','',5,'dollar',1,19,'2024-12-05 07:22:21.025887'),(76,'BACON DOG','',6,'dollar',1,19,'2024-12-05 07:22:21.110880'),(77,'BACON CHEESE DOG','',6,'dollar',1,19,'2024-12-05 07:22:21.195232'),(78,'LITTLE','FIVE GUYS STYLE OR CAJUN STYLE',5,'dollar',1,20,'2024-12-05 07:22:21.363586'),(79,'REGULAR','FIVE GUYS STYLE OR CAJUN STYLE',9,'dollar',1,20,'2024-12-05 07:22:21.446208'),(80,'LARGE','FIVE GUYS STYLE OR CAJUN STYLE',13,'dollar',1,20,'2024-12-05 07:22:21.530540'),(81,'FIVE GUYS SHAKE','Add Whip Cream',6,'dollar',1,21,'2024-12-05 07:22:21.697551'),(82,'REGULAR','',0,'dollar',1,22,'2024-12-05 07:22:21.864806'),(83,'LARGE','',0,'dollar',1,22,'2024-12-05 07:22:21.948100'),(84,'BOTTLED WATER','',0,'dollar',1,22,'2024-12-05 07:22:22.032508'),(91,'Bruschetta','Grilled bread with tomato, basil, and olive oil.',6,'dollar',1,26,'2024-12-05 07:28:49.384237'),(92,'Stuffed Mushrooms','Mushrooms stuffed with garlic and cheese.',7,'dollar',1,26,'2024-12-05 07:28:49.490627'),(93,'Grilled Salmon','Fresh salmon with a lemon butter sauce.',18,'dollar',1,27,'2024-12-05 07:28:49.696626'),(94,'Chicken Alfredo','Fettuccine pasta with creamy Alfredo sauce.',15,'dollar',1,27,'2024-12-05 07:28:49.798898'),(95,'Chocolate Cake','Rich and moist chocolate cake.',5,'dollar',1,28,'2024-12-05 07:28:50.003955'),(96,'Cheesecake','Classic cheesecake with a graham cracker crust.',5,'dollar',1,28,'2024-12-05 07:28:50.106665'),(123,'Hamburger','100% fresh beef -- no fillers or preservatives',0,'dollar',1,36,'2024-12-05 08:06:11.235010'),(124,'Cheeseburger','',0,'dollar',1,36,'2024-12-05 08:06:11.335643'),(125,'Bacon Burger','',0,'dollar',1,36,'2024-12-05 08:06:11.436819'),(126,'Bacon Cheeseburger','',0,'dollar',1,36,'2024-12-05 08:06:11.536381'),(127,'Little Hamburger','',0,'dollar',1,36,'2024-12-05 08:06:11.636770'),(128,'Little Cheeseburger','',0,'dollar',1,36,'2024-12-05 08:06:11.736072'),(129,'Little Bacon Burger','',0,'dollar',1,36,'2024-12-05 08:06:11.833899'),(130,'Little Bacon Cheeseburger','',0,'dollar',1,36,'2024-12-05 08:06:11.935081'),(131,'Kosher Style Hot Dog','',0,'dollar',1,37,'2024-12-05 08:06:12.133472'),(132,'Cheese Dog','',0,'dollar',1,37,'2024-12-05 08:06:12.233460'),(133,'Bacon Dog','',0,'dollar',1,37,'2024-12-05 08:06:12.332416'),(134,'Bacon Cheese Dog','',0,'dollar',1,37,'2024-12-05 08:06:12.432492'),(135,'Veggie Sandwich','',0,'dollar',1,38,'2024-12-05 08:06:12.631626'),(136,'Cheese Veggie Sandwich','',0,'dollar',1,38,'2024-12-05 08:06:12.731647'),(137,'Grilled Cheese','',0,'dollar',1,38,'2024-12-05 08:06:12.830999'),(138,'BLT','',0,'dollar',1,38,'2024-12-05 08:06:12.930555'),(139,'Little','Five Guys style or Cajun style cooked in cholesterol free pure peanut oil',0,'dollar',1,39,'2024-12-05 08:06:13.130766'),(140,'Regular','Five Guys style or Cajun style cooked in cholesterol free pure peanut oil',0,'dollar',1,39,'2024-12-05 08:06:15.127011'),(141,'Large','Five Guys style or Cajun style cooked in cholesterol free pure peanut oil',0,'dollar',1,39,'2024-12-05 08:06:16.227840'),(142,'Regular','',0,'dollar',1,40,'2024-12-05 08:06:17.420374'),(143,'Large','',0,'dollar',1,40,'2024-12-05 08:06:17.519514'),(144,'Bottled Water','',0,'dollar',1,40,'2024-12-05 08:06:17.619616'),(145,'Five Guys Shake','add whipped cream',0,'dollar',1,41,'2024-12-05 08:06:17.818624'),(146,'2PC SNACK','includes 4 wedges & coleslaw',10,'dollar',1,42,'2024-12-05 08:06:58.468397'),(147,'3PC SNACK','includes 4 wedges & coleslaw',13,'dollar',1,42,'2024-12-05 08:06:58.569003'),(148,'9PC','',30,'dollar',1,43,'2024-12-05 08:06:58.766965'),(149,'15PC','',39,'dollar',1,43,'2024-12-05 08:06:58.865243'),(150,'20PC','',49,'dollar',1,43,'2024-12-05 08:06:58.963386'),(151,'WEDGES SMALL','',3,'dollar',1,44,'2024-12-05 08:06:59.159743'),(152,'WEDGES MED','',4,'dollar',1,44,'2024-12-05 08:06:59.263095'),(153,'WEDGES LARGE','',7,'dollar',1,44,'2024-12-05 08:06:59.366085'),(154,'Henny Penny Sizzling Wing','10-11 pieces',11,'dollar',1,45,'2024-12-05 08:06:59.567305'),(155,'4 Large Pizzas with 2 Toppings','6 Cans of Pop',73,'dollar',1,46,'2024-12-05 08:06:59.763529'),(156,'Buffalo Bill Burger','Classic American burger with your choice of American cheese, lettuce, tomato, red onion, mustard, ketchup, pickles or mayo.',6,'dollar',1,47,'2024-12-05 08:08:45.165226'),(157,'Bubba BBQ','Zesty BBQ sauce, hickory-smoked bacon, Cheddar cheese, onion, and pickles.',8,'dollar',1,47,'2024-12-05 08:08:45.248593'),(158,'Hubcap Burger','Chili, cheese sauce, chopped onion.',8,'dollar',1,47,'2024-12-05 08:08:45.332869'),(159,'Veggie Burger','Made with brown rice, black beans, oats and lentils. With lettuce, tomato, onion, mustard, and mayo.',8,'dollar',1,47,'2024-12-05 08:08:45.417990'),(160,'The Southwestern Burger','Zoe burger infused with Chipotle, jalapenos, onion and bell peppers topped with pepper jack cheese and avocado.',8,'dollar',1,47,'2024-12-05 08:08:45.676109'),(161,'Bandito Burger','Tortilla, jalapenos, cheddar cheese, sour cream.',6,'dollar',1,47,'2024-12-05 08:08:45.759702'),(162,'Our Classic Burger','Served on a fresh roll, all toppings extra.',7,'dollar',1,47,'2024-12-05 08:08:45.843145'),(163,'Hand-Cut Fries','Cooked in pure peanut oil.',2,'dollar',1,48,'2024-12-05 08:08:46.009587'),(164,'Onion Rings','Cooked in pure peanut oil.',2,'dollar',1,48,'2024-12-05 08:08:46.265797'),(165,'Triple Cheesesteak','Beer battered rings that are fried to a golden-crisp.',6,'dollar',1,48,'2024-12-05 08:08:46.527787'),(166,'The Hero','Breaded or Grilled Chicken topped with Ham, Swiss, Mayo, Mustard, Lettuce.',6,'dollar',1,49,'2024-12-05 08:08:46.696645'),(167,'Chicken Cheese Steak','Thinly sliced chicken sautéed with onions and topped with melted provolone cheese, lettuce and mayonnaise on a French baguette.',8,'dollar',1,49,'2024-12-05 08:08:46.781936'),(168,'Buffalo Bomb','Breaded or grilled buffalo chicken breast with Blue cheese lettuce & tomato.',6,'dollar',1,49,'2024-12-05 08:08:46.865448'),(169,'Grilled Chicken Panini','Fresh mozzarella, roasted red peppers, sliced tomatoes, mixed field greens and balsamic vinaigrette.',11,'dollar',1,49,'2024-12-05 08:08:46.949232'),(170,'Steak Special','With melted American cheese and onion.',7,'dollar',1,50,'2024-12-05 08:08:47.116954'),(171,'Steak and Cheddar','Cheddar cheese and peppers blend perfect with real steak and fresh mushrooms.',11,'dollar',1,50,'2024-12-05 08:08:47.201552'),(172,'Triple Cheesesteak','Our since 1975 original. Three slices of cheese melt perfectly over fresh steak blended.',8,'dollar',1,51,'2024-12-05 08:08:47.538645'),(173,'Big Buffalo Cheesesteak','Freshly cut and cooked with chicken breast blended with fresh steak and mixed cheese.',11,'dollar',1,51,'2024-12-05 08:08:47.622054'),(174,'Double Soul Burger','With applewood bacon, Swiss, sautéed mushrooms, grilled onions.',12,'dollar',1,52,'2024-12-05 08:08:47.790831'),(175,'Prime Rib Sandwich','Tender seasoned prime rib, sliced thin, topped with smoked Gouda and caramelized onions on a fresh Italian roll.',11,'dollar',1,52,'2024-12-05 08:08:47.875961'),(176,'Burnt Belly Cheeseburger','Ham, salad, coleslaw, cheese served on Cuban bread with American fries.',12,'dollar',1,52,'2024-12-05 08:08:47.959572'),(177,'Garlic Melt Beef','Grilled beef, onion, prepared garlic on lettuce and tomato.',10,'dollar',1,52,'2024-12-05 08:08:48.043471'),(178,'Open Face Beef Brisket','Beef brisket served with brown gravy, and coleslaw.',11,'dollar',1,52,'2024-12-05 08:08:48.127616'),(179,'The Diablo','Fried jalapenos, sharp pepper jack, grilled bacon, charred onions.',13,'dollar',1,52,'2024-12-05 08:08:48.211686'),(180,'Strawberry','',3,'dollar',1,53,'2024-12-05 08:08:48.385867'),(181,'Mango','',3,'dollar',1,53,'2024-12-05 08:08:48.469607'),(182,'Creamsicle','',3,'dollar',1,53,'2024-12-05 08:08:48.552662'),(183,'Mocha Chip','',4,'dollar',1,53,'2024-12-05 08:08:48.636479'),(184,'Lychee','',3,'dollar',1,53,'2024-12-05 08:08:48.720528'),(185,'Oreo Cookie','',4,'dollar',1,53,'2024-12-05 08:08:48.805782'),(186,'Caramel','',3,'dollar',1,53,'2024-12-05 08:08:48.889001'),(187,'English Breakfast','Bacon, free-range eggs, Cumberland sausage, flat mushroom, tomato, beans',19,'dollar',1,54,'2024-12-05 08:09:31.045013'),(188,'Veggie Breakfast','Free-range eggs, spinach, mushrooms, tomato, halloumi cheese, beans',15,'dollar',1,54,'2024-12-05 08:09:31.130679'),(189,'Vegan Breakfast','Avocado, spinach, mushrooms, tomato, beans',15,'dollar',1,54,'2024-12-05 08:09:31.387744'),(190,'Eggs Benedict','Ham, hollandaise, muffin',11,'dollar',1,54,'2024-12-05 08:09:31.642803'),(191,'Eggs Florentine','Spinach, mornay sauce, muffin',11,'dollar',1,54,'2024-12-05 08:09:31.728073'),(192,'Smoked Scottish Salmon','Scrambled free-range eggs',15,'dollar',1,54,'2024-12-05 08:09:31.986272'),(193,'Vanilla Yoghurt & Granola','Honey, mixed berries',8,'dollar',1,54,'2024-12-05 08:09:32.071915'),(194,'Porridge & Fresh Berries','',8,'dollar',1,54,'2024-12-05 08:09:32.326352'),(195,'Croissant, Pain au Chocolat or Pain au Raisin','',5,'dollar',1,54,'2024-12-05 08:09:32.582380'),(196,'Bread Basket','',5,'dollar',1,55,'2024-12-05 08:09:32.925812'),(197,'Edamame, Soy Bean & Sea Salt','',7,'dollar',1,55,'2024-12-05 08:09:33.181700'),(198,'Lobster Linguine','',40,'dollar',1,55,'2024-12-05 08:09:33.610031'),(199,'Rigatoni','',22,'dollar',1,55,'2024-12-05 08:09:33.695251'),(200,'Roasted Romero Pepper & Tomato Soup','',9,'dollar',1,55,'2024-12-05 08:09:33.951240'),(201,'Burrata','',14,'dollar',1,55,'2024-12-05 08:09:34.383515'),(202,'California Rolls','',19,'dollar',1,55,'2024-12-05 08:09:34.641420'),(203,'Harissa Marinated Lamb Ribs','',21,'dollar',1,55,'2024-12-05 08:09:35.152762'),(204,'Butter Chicken Curry','',26,'dollar',1,55,'2024-12-05 08:09:35.240071'),(205,'Fish & Chips','',23,'dollar',1,55,'2024-12-05 08:09:35.324898'),(206,'Cheesecake & Blueberries','',10,'dollar',1,55,'2024-12-05 08:09:35.584796'),(207,'Chocolate Tart','',10,'dollar',1,55,'2024-12-05 08:09:35.840851'),(208,'DANA CARPACCIO / BEEF CARPACCIO','',460,'TRY',1,56,'2024-12-05 08:13:27.490711'),(209,'DANA FÜME / SMOKED BEEF','',595,'TRY',1,56,'2024-12-05 08:13:27.583256'),(210,'FÜME RIBEYE / SMOKED RIBEYE','',650,'TRY',1,56,'2024-12-05 08:13:27.669202'),(211,'STEAK TARTAR / STEAK TARTARE','',650,'TRY',1,56,'2024-12-05 08:13:27.754453'),(212,'KARİDES IZGARA / JUMBO SHRIMP','',310,'TRY',1,56,'2024-12-05 08:13:27.839595'),(213,'NUSR- ET SPECIAL SUSHI','',420,'TRY',1,56,'2024-12-05 08:13:27.924428'),(214,'ROKA SALATASI / ROCKET SALAD','',330,'TRY',1,57,'2024-12-05 08:13:28.093774'),(215,'TULUM PEYNIR SALATASI / GOAT CHEESE SALAD','',460,'TRY',1,57,'2024-12-05 08:13:28.349322'),(216,'AKDENİZ SALATASI / MEDITERRANEAN SALAD','',595,'TRY',1,57,'2024-12-05 08:13:28.605977'),(217,'KAŞIK SALATASI / SPOON SALAD','',680,'TRY',1,57,'2024-12-05 08:13:28.863085'),(218,'DOMATES SALATASI / TOMATO SALAD','',195,'TRY',1,57,'2024-12-05 08:13:29.123321'),(219,'AVOKADO SALATASI / AVOCADO SALAD','',255,'TRY',1,57,'2024-12-05 08:13:29.380091'),(220,'DANA KABURGA / ASADO BEEF RIBS','',1285,'TRY',1,58,'2024-12-05 08:13:29.894309'),(221,'DANA ANTRİKOT / ENTRECOTE','',1850,'TRY',1,58,'2024-12-05 08:13:29.979553'),(222,'DANA ŞAŞLIK / MARINATED SLICED BEEF','',2400,'TRY',1,58,'2024-12-05 08:13:30.069057'),(223,'DANA SIRTI / BEEF TENDERLOIN','',2900,'TRY',1,58,'2024-12-05 08:13:30.153802'),(224,'NUSR-ET SPAGHETTI','',3425,'TRY',1,58,'2024-12-05 08:13:30.238395'),(225,'LOKUM / LOKUM BEEF FILLET','',800,'TRY',1,58,'2024-12-05 08:13:30.324595'),(226,'GOLDEN DANA KABURGA / GOLD ASADO BEEF RIBS','',2750,'TRY',1,59,'2024-12-05 08:13:30.494176'),(227,'GOLDEN STEAK','',3950,'TRY',1,59,'2024-12-05 08:13:30.579267'),(228,'GOLDEN GIANT TOMAHAWK','',5200,'TRY',1,59,'2024-12-05 08:13:30.665214'),(229,'GOLD NEW YORK','',6375,'TRY',1,59,'2024-12-05 08:13:30.750332'),(230,'GOLD DALLAS','',7550,'TRY',1,59,'2024-12-05 08:13:30.834702'),(231,'GOLDEN BURGER','',2500,'TRY',1,59,'2024-12-05 08:13:30.920879'),(232,'LOKUM BURGER','',650,'TRY',1,60,'2024-12-05 08:13:31.090800'),(233,'NUSR-ET BURGER','',180,'TRY',1,60,'2024-12-05 08:13:31.177437'),(234,'NUSR-ET KÖFTE / NUSR-ET MEATBALLS','',300,'TRY',1,60,'2024-12-05 08:13:31.263016'),(235,'TOMAHAWK GIANT TOMAHAWK (1.1 KG)','',1300,'TRY',1,61,'2024-12-05 08:13:31.433006'),(236,'DALLAS STEAK','',150,'TRY',1,61,'2024-12-05 08:13:31.520225'),(237,'NEW YORK STEAK','',130,'TRY',1,61,'2024-12-05 08:13:31.605543'),(238,'PATAES KROKET / POTATO CROQUETTES','',130,'TRY',1,62,'2024-12-05 08:13:31.775820'),(239,'SOĞAN ÇIÇEĞI / ONION FLOWER','',150,'TRY',1,62,'2024-12-05 08:13:32.032363'),(240,'PATATES PÜRESI / MASHED POTATO','',120,'TRY',1,62,'2024-12-05 08:13:32.289601'),(241,'MANTAR / MUSHROOMS','',130,'TRY',1,62,'2024-12-05 08:13:32.545475'),(242,'HAVUÇ DİLİMİ','',160,'TRY',1,63,'2024-12-05 08:13:32.889566'),(243,'DONDURMA / VANILLA ICE CREAM','',120,'TRY',1,63,'2024-12-05 08:13:33.145422'),(244,'Edamame','',8,'€',1,64,'2024-12-05 08:19:43.084107'),(245,'Sesame Chilli Edamame','',10,'€',1,64,'2024-12-05 08:19:43.875736'),(246,'Padron Peppers Den Miso','',12,'€',1,64,'2024-12-05 08:19:44.665378'),(247,'Crispy Rice with Spicy Tuna, Salmon or Yellowtail','',29,'€',1,64,'2024-12-05 08:19:45.452513'),(248,'Oyster with Matsuhisa Dressing','',9,'€',1,64,'2024-12-05 08:19:45.539687'),(249,'Sweet Shrimps Tempura Donburi','',18,'€',1,64,'2024-12-05 08:19:45.805495'),(250,'Dashi fries 80grs portion','',14,'€',1,64,'2024-12-05 08:19:45.892799'),(251,'Vegetable Hand Roll with Sesame Sauce','',16,'€',1,64,'2024-12-05 08:19:45.980583'),(252,'Crispy Pork Belly with Spicy Miso','',19,'€',1,64,'2024-12-05 08:19:46.242857'),(253,'Wagyu Sliders, Tofu Bun (2pcs)','',42,'€',1,64,'2024-12-05 08:19:46.769402'),(254,'Cup Sushi Selection (5pcs)','',30,'€',1,64,'2024-12-05 08:19:46.856225'),(255,'Salmon Tartar Tamari sauce','',23,'€',1,64,'2024-12-05 08:19:47.119093'),(256,'Black Cod Croquetas (5pcs)','',21,'€',1,64,'2024-12-05 08:19:47.384429'),(257,'The Nobu “Club”','',22,'€',1,64,'2024-12-05 08:19:47.648212'),(258,'Umami Chicken Wings','',20,'€',1,64,'2024-12-05 08:19:47.736531'),(259,'Edamame','',9,'€',1,65,'2024-12-05 08:19:47.914779'),(260,'Sesame Chilli Edamame','',11,'€',1,65,'2024-12-05 08:19:48.726499'),(261,'Padron Peppers Den Miso','',12,'€',1,65,'2024-12-05 08:19:49.540832'),(262,'Umami Chicken Wings','',27,'€',1,65,'2024-12-05 08:19:50.375291'),(263,'Tuna','Minimum order of 2',16,'€',1,66,'2024-12-05 08:19:50.562368'),(264,'Salmon','',14,'€',1,66,'2024-12-05 08:19:50.825535'),(265,'Lobster','',23,'€',1,66,'2024-12-05 08:19:51.088258'),(266,'Chicken','',15,'€',1,66,'2024-12-05 08:19:51.359404'),(267,'Japanese Wagyu Beef','6pcs',105,'€',1,66,'2024-12-05 08:19:51.449169'),(268,'Nasu Miso','',15,'€',1,67,'2024-12-05 08:19:51.622571'),(269,'Warm Mushroom Salad','',21,'€',1,67,'2024-12-05 08:19:52.862731'),(270,'Roasted Cauliflower','',19,'€',1,67,'2024-12-05 08:19:52.949610'),(271,'Broccolini Spicy Garlic','',19,'€',1,67,'2024-12-05 08:19:53.208892'),(272,'Kelp Salad','',14,'€',1,67,'2024-12-05 08:19:53.642020'),(273,'Shiitake Mushroom Salad','',19,'€',1,67,'2024-12-05 08:19:53.904083'),(274,'Avocado Tartare','',18,'€',1,67,'2024-12-05 08:19:53.990414'),(275,'Crispy Rice with Avocado','',23,'€',1,67,'2024-12-05 08:19:54.428710'),(276,'New Style Tofu','',15,'€',1,67,'2024-12-05 08:19:54.690588'),(277,'Salmon','2 skewers per order · Served with Anticucho or Teriyaki Sauce',22,'€',1,68,'2024-12-05 08:19:55.043090'),(278,'Shrimp','',24,'€',1,68,'2024-12-05 08:19:55.305827'),(279,'Scallop','',28,'€',1,68,'2024-12-05 08:19:55.571169'),(280,'Chicken','',20,'€',1,68,'2024-12-05 08:19:55.863522'),(281,'Beef','',26,'€',1,68,'2024-12-05 08:19:55.967031'),(282,'Asparagus','',13,'€',1,68,'2024-12-05 08:19:56.053185'),(283,'Salmon Egg','',9,'€',1,69,'2024-12-05 08:19:56.589799'),(284,'Smelt Egg','',5,'€',1,69,'2024-12-05 08:19:56.850148'),(285,'Octopus','',7,'€',1,69,'2024-12-05 08:19:57.113817'),(286,'Shrimp','',8,'€',1,69,'2024-12-05 08:19:57.376123'),(287,'Sweet Shrimp','',7,'€',1,69,'2024-12-05 08:19:57.634394'),(288,'Freshwater Eel','',8,'€',1,69,'2024-12-05 08:19:57.893793'),(289,'Tamago','',4,'€',1,69,'2024-12-05 08:19:58.151664'),(290,'Japanese Wagyu','',18,'€',1,69,'2024-12-05 08:19:58.588469'),(291,'Miso Soup','',9,'€',1,70,'2024-12-05 08:19:58.765791'),(292,'Spicy Seafood Soup','',25,'€',1,70,'2024-12-05 08:19:59.046744'),(293,'Steamed Rice','',6,'€',1,70,'2024-12-05 08:19:59.309512'),(294,'Chocolate Bento Box','Valrhona Dark Chocolate Fondant with Imperial Matcha Gelato Cream | Coulant de Chocolate Negro Valrhona con Helado de Té Verde Imperial',15,'€',1,71,'2024-12-05 08:19:59.831097'),(295,'Miso Cappuccino','Miso Cream, Candied Pecans, Vanilla Cream, Espresso Foam',15,'€',1,71,'2024-12-05 08:20:00.109875'),(296,'Lychee Apple Pavlova','Meringue, Lychee curd, white chocolate cream, Yuzu sorbet',17,'€',1,71,'2024-12-05 08:20:00.388369'),(297,'Lemon Panna Cotta','Coconut Sablè, Orange and Mint Marmalade with Yuzu Ice',15,'€',1,71,'2024-12-05 08:20:00.832546'),(298,'Melon Kakigori','Shaved Melon Ice, Coconut Ice Cream, Coconut Crumble',16,'€',1,71,'2024-12-05 08:20:01.274913'),(299,'Peach Melba','Vanilla Parfait, Poached Peach topped with Almond Ice cream Raspberry sauce and Yuzu Jelly, served with White Peach sauce',16,'€',1,71,'2024-12-05 08:20:01.706623'),(300,'Nobu Cheesscake','Pecan Nut Crumble, Mix Berries Sauce, Raspberry and Wasabi Sorbet',16,'€',1,71,'2024-12-05 08:20:02.145516'),(301,'Assorted Mochi Ice Cream','Helado Recubierto de Pasta de Arroz',12,'€',1,71,'2024-12-05 08:20:02.404530'),(302,'House Made Gelato or Sorbet (3 scoops)','Helado o sorbete casero',15,'€',1,71,'2024-12-05 08:20:02.842525'),(303,'Espresso','',4,'€',1,72,'2024-12-05 08:20:03.188594'),(304,'Double Espresso','',5,'€',1,72,'2024-12-05 08:20:03.618343'),(305,'Cappuccino','',5,'€',1,72,'2024-12-05 08:20:04.054095'),(306,'Caffè Latte','',5,'€',1,72,'2024-12-05 08:20:04.315431'),(307,'Americano','',5,'€',1,72,'2024-12-05 08:20:04.573873'),(308,'Macchiato','',4,'€',1,72,'2024-12-05 08:20:05.010136'),(309,'2PC SNACK','includes 4 wedges & coleslaw',10,'CAD',1,73,'2024-12-05 10:22:13.258041'),(310,'3PC SNACK','includes 6 wedges & coleslaw',13,'CAD',1,73,'2024-12-05 10:22:13.450267'),(311,'9PC','',30,'CAD',1,74,'2024-12-05 10:22:13.643185'),(312,'15PC','',39,'CAD',1,74,'2024-12-05 10:22:13.975491'),(313,'20PC','',49,'CAD',1,74,'2024-12-05 10:22:14.069671'),(314,'Single Pieces','Wing/Drum, Rib/Thigh, Breast',NULL,'CAD',1,74,'2024-12-05 10:22:14.174938'),(315,'Small Wedges','',3,'CAD',1,75,'2024-12-05 10:22:14.505798'),(316,'Med Wedges','',4,'CAD',1,75,'2024-12-05 10:22:14.595847'),(317,'Large Wedges','',7,'CAD',1,75,'2024-12-05 10:22:14.686962'),(318,'Small Gravy','',3,'CAD',1,75,'2024-12-05 10:22:14.780227'),(319,'Large Gravy','',4,'CAD',1,75,'2024-12-05 10:22:14.895926'),(320,'Small Coleslaw','',2,'CAD',1,75,'2024-12-05 10:22:15.021431'),(321,'Large Coleslaw','',4,'CAD',1,75,'2024-12-05 10:22:15.120392'),(322,'Henny Penny Sizzling Wing','Honey Garlic, Salt & Pepper, Teriyaki, BBQ, Sweet Chili',11,'CAD',1,76,'2024-12-05 10:22:15.307952'),(323,'4 Large Pizzas','12\" with 2 Toppings All',73,'CAD',1,77,'2024-12-05 10:22:15.700826'),(324,'2 Large Pizzas','12\" with 3 Topping All',49,'CAD',1,78,'2024-12-05 10:22:15.942886'),(325,'2 Lasagna Or Spaghetti w/ Garlic Toast OR 1 Large 12\" 3 Topping Pizza','',37,'CAD',1,79,'2024-12-05 10:22:16.180980'),(326,'Mega 1','48 Slices/Feeds 20',175,'CAD',1,80,'2024-12-05 10:22:16.391722'),(327,'Mega 2','48 Slices/Feeds 20',133,'CAD',1,80,'2024-12-05 10:22:16.599258'),(328,'Mega 3','32 Slices/Feeds 15',100,'CAD',1,80,'2024-12-05 10:22:16.717331'),(329,'Hamburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',8,'dollar',1,81,'2024-12-05 10:26:09.763924'),(330,'Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',9,'dollar',1,81,'2024-12-05 10:26:09.850279'),(331,'Bacon Burger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',9,'dollar',1,81,'2024-12-05 10:26:09.943542'),(332,'Bacon Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',10,'dollar',1,81,'2024-12-05 10:26:10.033305'),(333,'Little Hamburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',5,'dollar',1,81,'2024-12-05 10:26:10.135758'),(334,'Little Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',6,'dollar',1,81,'2024-12-05 10:26:10.242812'),(335,'Little Bacon Burger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',6,'dollar',1,81,'2024-12-05 10:26:10.346404'),(336,'Little Bacon Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',6,'dollar',1,81,'2024-12-05 10:26:10.437051'),(337,'Kosher Style Hot Dog','',5,'dollar',1,82,'2024-12-05 10:26:10.631012'),(338,'Cheese Dog','',5,'dollar',1,82,'2024-12-05 10:26:10.737940'),(339,'Bacon Dog','',6,'dollar',1,82,'2024-12-05 10:26:10.844991'),(340,'Bacon Cheese Dog','',6,'dollar',1,82,'2024-12-05 10:26:10.931775'),(341,'Little Fries','FIVE GUYS STYLE OR CAJUN STYLE',5,'dollar',1,83,'2024-12-05 10:26:11.113171'),(342,'Regular Fries','FIVE GUYS STYLE OR CAJUN STYLE',9,'dollar',1,83,'2024-12-05 10:26:11.199675'),(343,'Large Fries','FIVE GUYS STYLE OR CAJUN STYLE',13,'dollar',1,83,'2024-12-05 10:26:11.295563'),(344,'Regular Drink','',0,'dollar',1,84,'2024-12-05 10:26:11.510943'),(345,'Large Drink','',0,'dollar',1,84,'2024-12-05 10:26:11.611267'),(346,'Bottled Water','',0,'dollar',1,84,'2024-12-05 10:26:11.736180'),(347,'Veggie Sandwich','',2,'dollar',1,85,'2024-12-05 10:26:11.984162'),(348,'Cheese Veggie Sandwich','',4,'dollar',1,85,'2024-12-05 10:26:12.081009'),(349,'Grilled Cheese','',4,'dollar',1,85,'2024-12-05 10:26:12.176944'),(350,'BLT','',6,'dollar',1,85,'2024-12-05 10:26:12.275588'),(351,'Five Guys Shake','Adding whipped cream',6,'dollar',1,86,'2024-12-05 10:26:12.503359'),(352,'Hamburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',8,'dollar',1,87,'2024-12-05 10:26:28.498913'),(353,'Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',9,'dollar',1,87,'2024-12-05 10:26:28.606290'),(354,'Bacon Burger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',9,'dollar',1,87,'2024-12-05 10:26:28.693804'),(355,'Bacon Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',10,'dollar',1,87,'2024-12-05 10:26:28.781232'),(356,'Little Hamburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',5,'dollar',1,87,'2024-12-05 10:26:28.869542'),(357,'Little Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',6,'dollar',1,87,'2024-12-05 10:26:28.960406'),(358,'Little Bacon Burger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',6,'dollar',1,87,'2024-12-05 10:26:29.049476'),(359,'Little Bacon Cheeseburger','100% FRESH BEEF -- NO FILLERS OR PRESERVATIVES',6,'dollar',1,87,'2024-12-05 10:26:29.138470'),(360,'Kosher Style Hot Dog','',5,'dollar',1,88,'2024-12-05 10:26:29.313494'),(361,'Cheese Dog','',5,'dollar',1,88,'2024-12-05 10:26:29.400204'),(362,'Bacon Dog','',6,'dollar',1,88,'2024-12-05 10:26:29.490281'),(363,'Bacon Cheese Dog','',6,'dollar',1,88,'2024-12-05 10:26:29.576566'),(364,'Veggie Sandwich','',2,'dollar',1,89,'2024-12-05 10:26:29.754948'),(365,'Cheese Veggie Sandwich','',4,'dollar',1,89,'2024-12-05 10:26:29.841550'),(366,'Grilled Cheese','',4,'dollar',1,89,'2024-12-05 10:26:29.928236'),(367,'BLT','',6,'dollar',1,89,'2024-12-05 10:26:30.025682'),(368,'Little Fries','FIVE GUYS STYLE OR CAJUN STYLE',5,'dollar',1,90,'2024-12-05 10:26:30.200124'),(369,'Regular Fries','FIVE GUYS STYLE OR CAJUN STYLE',9,'dollar',1,90,'2024-12-05 10:26:30.286302'),(370,'Large Fries','FIVE GUYS STYLE OR CAJUN STYLE',13,'dollar',1,90,'2024-12-05 10:26:30.373087'),(371,'Five Guys Shake','Add Whip Cream',6,'dollar',1,91,'2024-12-05 10:26:30.552893'),(372,'Mix-ins (Add to basic item)','Various options available',0,'dollar',1,91,'2024-12-05 10:26:30.650969'),(373,'Regular Drink','',0,'dollar',1,92,'2024-12-05 10:26:30.831280'),(374,'Large Drink','',0,'dollar',1,92,'2024-12-05 10:26:30.917273'),(375,'Bottled Water','',0,'dollar',1,92,'2024-12-05 10:26:31.007503'),(376,'Fried Rice','',10,'dollar',1,93,'2024-12-05 10:29:11.409441'),(377,'Sirloin Steak','',11,'dollar',1,93,'2024-12-05 10:29:11.496830'),(378,'Spicy Chicken','',12,'dollar',1,93,'2024-12-05 10:29:11.582117'),(379,'Grilled Salmon Fish','',13,'dollar',1,93,'2024-12-05 10:29:11.668897'),(380,'Deep Bake Goose','',14,'dollar',1,93,'2024-12-05 10:29:11.755195'),(381,'Avocado Toast','',10,'dollar',1,94,'2024-12-05 10:29:11.924042'),(382,'Spaghetti Pasta','',11,'dollar',1,94,'2024-12-05 10:29:12.011030'),(383,'Chicken Pie','',12,'dollar',1,94,'2024-12-05 10:29:12.095560'),(384,'Fish Sandwich','',13,'dollar',1,94,'2024-12-05 10:29:12.182328'),(385,'Vegetable Salad','',14,'dollar',1,94,'2024-12-05 10:29:12.267815'),(386,'Mineral Water','',5,'dollar',1,95,'2024-12-05 10:29:12.436890'),(387,'Jasmine Tea','',6,'dollar',1,95,'2024-12-05 10:29:12.521995'),(388,'Lemonade','',7,'dollar',1,95,'2024-12-05 10:29:12.607407'),(389,'Fresh Juice','',8,'dollar',1,95,'2024-12-05 10:29:12.692509'),(390,'Smoothie','',9,'dollar',1,95,'2024-12-05 10:29:12.776582');
/*!40000 ALTER TABLE `menus_menuitem` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `after_menu_item_update` AFTER UPDATE ON `menus_menuitem` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `menus_menusection`
--

DROP TABLE IF EXISTS `menus_menusection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus_menusection` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(99) DEFAULT NULL,
  `menu_id` bigint DEFAULT NULL,
  `last_edited` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menus_menusection_menu_id_5d8f94b3_fk_menus_menu_id` (`menu_id`),
  CONSTRAINT `menus_menusection_menu_id_5d8f94b3_fk_menus_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `menus_menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus_menusection`
--

LOCK TABLES `menus_menusection` WRITE;
/*!40000 ALTER TABLE `menus_menusection` DISABLE KEYS */;
INSERT INTO `menus_menusection` VALUES (6,'BURGERS',2,'2024-12-04 21:15:25.985071'),(7,'DOGS',2,'2024-12-04 21:15:26.770812'),(8,'SANDWICHES',2,'2024-12-04 21:15:27.204860'),(9,'FRIES',2,'2024-12-04 21:15:28.881424'),(10,'MILKSHAKES',2,'2024-12-04 21:15:29.228455'),(11,'DRINKS',2,'2024-12-04 21:15:29.403737'),(12,'BURGERS',3,'2024-12-04 21:19:06.859018'),(13,'DOGS',3,'2024-12-04 21:19:07.635515'),(14,'FRIES',3,'2024-12-04 21:19:08.078932'),(15,'SANDWICHES',3,'2024-12-04 21:19:08.423195'),(16,'MILKSHAKES',3,'2024-12-04 21:19:08.854592'),(17,'DRINKS',3,'2024-12-04 21:19:09.025817'),(18,'BURGERS',4,'2024-12-05 07:22:20.093667'),(19,'DOGS',4,'2024-12-05 07:22:20.858106'),(20,'FRIES',4,'2024-12-05 07:22:21.280622'),(21,'MILKSHAKES',4,'2024-12-05 07:22:21.614440'),(22,'DRINKS',4,'2024-12-05 07:22:21.781528'),(26,'Appetizers',7,'2024-12-05 07:28:49.265383'),(27,'Main Courses',7,'2024-12-05 07:28:49.593911'),(28,'Desserts',7,'2024-12-05 07:28:49.901849'),(36,'BURGERS',17,'2024-12-05 08:06:11.134359'),(37,'DOGS',17,'2024-12-05 08:06:12.033847'),(38,'SANDWICHES',17,'2024-12-05 08:06:12.531172'),(39,'FRIES',17,'2024-12-05 08:06:13.031165'),(40,'DRINKS',17,'2024-12-05 08:06:17.320647'),(41,'MILKSHAKES',17,'2024-12-05 08:06:17.718817'),(42,'Hot n\' Tender Chicken meals',18,'2024-12-05 08:06:58.369726'),(43,'Hot n\' Tender Chicken Family size',18,'2024-12-05 08:06:58.668414'),(44,'Spuds & Stuff',18,'2024-12-05 08:06:59.061327'),(45,'Wing',18,'2024-12-05 08:06:59.468742'),(46,'Obee’s Family Specials',18,'2024-12-05 08:06:59.665932'),(47,'Burgers',19,'2024-12-05 08:08:45.081201'),(48,'Fries & Onion Rings',19,'2024-12-05 08:08:45.926649'),(49,'Chicken Sandwiches',19,'2024-12-05 08:08:46.612152'),(50,'Steak Sandwiches',19,'2024-12-05 08:08:47.032581'),(51,'Big Steak Sandwiches',19,'2024-12-05 08:08:47.454373'),(52,'The Chuck Wagon',19,'2024-12-05 08:08:47.705818'),(53,'Frappes',19,'2024-12-05 08:08:48.301309'),(54,'Breakfast',20,'2024-12-05 08:09:30.956920'),(55,'Plane Food',20,'2024-12-05 08:09:32.841492'),(56,'BAŞLANGIÇLAR / STARTERS',21,'2024-12-05 08:13:27.404873'),(57,'SALATALAR / SALADS',21,'2024-12-05 08:13:28.009620'),(58,'NUSR-ET SPECIALS / MEATS',21,'2024-12-05 08:13:29.809217'),(59,'GOLDEN FEAST',21,'2024-12-05 08:13:30.409514'),(60,'BURGERS & MEATBALLS',21,'2024-12-05 08:13:31.006261'),(61,'STEAKLER / STEAKS',21,'2024-12-05 08:13:31.348116'),(62,'GARNITÜRLER / GARNISH',21,'2024-12-05 08:13:31.690606'),(63,'TATLILAR / DESSERTS',21,'2024-12-05 08:13:32.802746'),(64,'GOLDEN HOUR TAPAS',22,'2024-12-05 08:19:42.995558'),(65,'SHUKO | SNACKS',22,'2024-12-05 08:19:47.826638'),(66,'NOBU TACOS',22,'2024-12-05 08:19:50.464396'),(67,'VEGETABLES',22,'2024-12-05 08:19:51.535504'),(68,'KUSHIYAKI',22,'2024-12-05 08:19:54.955029'),(69,'NIGIRI & SASHIMI',22,'2024-12-05 08:19:56.497668'),(70,'SOUP AND RICE',22,'2024-12-05 08:19:58.674363'),(71,'DESSERT',22,'2024-12-05 08:19:59.741081'),(72,'CoFFEE',22,'2024-12-05 08:20:03.102476'),(73,'Hot n\' Tender Chicken meals',23,'2024-12-05 10:22:13.160058'),(74,'Hot n\' Tender Chicken Family size',23,'2024-12-05 10:22:13.543714'),(75,'Spuds & Stuff',23,'2024-12-05 10:22:14.272408'),(76,'Wing',23,'2024-12-05 10:22:15.218517'),(77,'Obee\'s Family Specials',23,'2024-12-05 10:22:15.582423'),(78,'Obee\'s Party or Game Night Pack',23,'2024-12-05 10:22:15.817783'),(79,'Obee\'s 2 Can Dine Meal Deals',23,'2024-12-05 10:22:16.074011'),(80,'Mega Pizza Party Packs',23,'2024-12-05 10:22:16.286850'),(81,'Burgers',24,'2024-12-05 10:26:09.671448'),(82,'Dogs',24,'2024-12-05 10:26:10.527881'),(83,'Fries',24,'2024-12-05 10:26:11.018688'),(84,'Drinks',24,'2024-12-05 10:26:11.413849'),(85,'Sandwiches',24,'2024-12-05 10:26:11.875145'),(86,'Milkshakes',24,'2024-12-05 10:26:12.388930'),(87,'BURGERS',25,'2024-12-05 10:26:28.407005'),(88,'DOGS',25,'2024-12-05 10:26:29.225420'),(89,'SANDWICHES',25,'2024-12-05 10:26:29.667946'),(90,'FRIES',25,'2024-12-05 10:26:30.113217'),(91,'MILKSHAKES',25,'2024-12-05 10:26:30.464705'),(92,'DRINKS',25,'2024-12-05 10:26:30.742415'),(93,'MAIN COURSE',26,'2024-12-05 10:29:11.319365'),(94,'APPETIZERS',26,'2024-12-05 10:29:11.839957'),(95,'DRINKS',26,'2024-12-05 10:29:12.352390');
/*!40000 ALTER TABLE `menus_menusection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus_menuversion`
--

DROP TABLE IF EXISTS `menus_menuversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus_menuversion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `version_number` int NOT NULL,
  `composite_id` varchar(255) NOT NULL,
  `restaurant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `composite_id` (`composite_id`),
  KEY `menus_menuv_restaur_bbcd47_idx` (`restaurant_id`,`version_number`),
  CONSTRAINT `menus_menuversion_restaurant_id_688f3c51_fk_menus_restaurant_id` FOREIGN KEY (`restaurant_id`) REFERENCES `menus_restaurant` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus_menuversion`
--

LOCK TABLES `menus_menuversion` WRITE;
/*!40000 ALTER TABLE `menus_menuversion` DISABLE KEYS */;
INSERT INTO `menus_menuversion` VALUES (1,1,'Five Guys-v1:1',1),(2,2,'Five Guys-v2:1',1),(3,3,'Five Guys-v3:1',1),(4,4,'Five Guys-v4:1',1),(6,1,'JD\'S Burgers-v1:3',3),(7,5,'Five Guys-v5:1',1),(8,1,'Obee\'s Pizza Pasta-v1:4',4),(9,1,'Buffalo Bill\'s-v1:5',5),(10,1,'Plane Food-v1:6',6),(11,1,'D-MARIS BAY-v1:7',7),(12,1,'Nobu-v1:8',8),(13,2,'Obee\'s Pizza Pasta-v2:4',4),(14,6,'Five Guys-v6:1',1),(15,7,'Five Guys-v7:1',1),(16,1,'restaurant name-v1:9',9),(17,8,'Restaurant-v8:1',1),(18,9,'Restaurant-v9:1',1),(19,10,'Restaurant-v10:1',1);
/*!40000 ALTER TABLE `menus_menuversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus_restaurant`
--

DROP TABLE IF EXISTS `menus_restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus_restaurant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(99) DEFAULT NULL,
  `phone` varchar(99) DEFAULT NULL,
  `email` varchar(99) DEFAULT NULL,
  `country` varchar(99) DEFAULT NULL,
  `city` varchar(99) DEFAULT NULL,
  `state` varchar(99) DEFAULT NULL,
  `zip` smallint DEFAULT NULL,
  `street` varchar(99) DEFAULT NULL,
  `website` varchar(99) DEFAULT NULL,
  `last_edited` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_restaurant_name_d5529e64_uniq` (`name`),
  KEY `menus_resta_name_6b141c_idx` (`name`),
  KEY `menus_resta_country_964088_idx` (`country`,`city`,`state`,`zip`,`street`),
  KEY `menus_resta_name_dcab00_idx` (`name`,`phone`,`email`,`website`),
  FULLTEXT KEY `fts_name_country` (`name`,`country`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus_restaurant`
--

LOCK TABLES `menus_restaurant` WRITE;
/*!40000 ALTER TABLE `menus_restaurant` DISABLE KEYS */;
INSERT INTO `menus_restaurant` VALUES (1,'Five Guys','','','','','',NULL,'','https://www.fiveguys.com','2024-12-05 10:26:28.201761'),(3,'JD\'S Burgers','Not Available','Not Available','Not Available','Not Available','Not Available',NULL,'Not Available','Not Available','2024-12-05 07:28:49.059273'),(4,'Obee\'s Pizza Pasta','403.887.4521','order@obeespizza.ca','Canada','Sylvan Lake','Alberta',NULL,'','www.obeespizza.ca','2024-12-05 10:22:12.636095'),(5,'Buffalo Bill\'s','-1','-1','-1','-1','-1',NULL,'-1','-1','2024-12-05 08:08:44.913213'),(6,'Gordon Ramsay\'s Plane Food',NULL,NULL,'UK','London',NULL,-1,NULL,'http://planefood.com','2024-12-05 08:10:36.239118'),(7,'Nusr-Et Steakhouse D-Maris, D-MARIS BAY','+90 252 441 20 00',NULL,'Turkey',NULL,NULL,NULL,NULL,'https://www.nusr-et.com.tr/','2024-12-05 08:16:59.918647'),(8,'Nobu','+34 971 192 222','','Spain','Ibiza','-1',7800,'Camí Ses Feixes, 52. 07800 Ibiza. Spain','nobuhotelibizabay.com','2024-12-05 08:19:42.819505'),(9,'restaurant name','123-456-7890','restaurant email','restaurant country','restaurant city','restaurant state',NULL,'restaurant address','http://reallygreatsite.com','2024-12-05 10:29:11.149739');
/*!40000 ALTER TABLE `menus_restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus_user`
--

DROP TABLE IF EXISTS `menus_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
  UNIQUE KEY `username` (`username`),
  KEY `menus_user_email_9dc9ad_idx` (`email`),
  KEY `menus_user_usernam_ef02c5_idx` (`username`,`email`),
  KEY `menus_user_country_f5e9c1_idx` (`country`,`city`,`state`,`zip`,`street`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus_user`
--

LOCK TABLES `menus_user` WRITE;
/*!40000 ALTER TABLE `menus_user` DISABLE KEYS */;
INSERT INTO `menus_user` VALUES (1,'pbkdf2_sha256$870000$e38XpQFFsNzL7jA6cILpSd$zj6M7Zez+oJFcaKH1tkMi3jj8ouD9MHEYK57stlEGlY=','2024-12-04 20:36:24.000000',1,'javi','','','test@gmail.com',1,1,'2024-12-04 20:36:15.000000',NULL,NULL,NULL,NULL,NULL),(2,'pbkdf2_sha256$870000$MBG6omUFZqGsC1goy76DeT$qyb/Mrq3g6NaN1EtGCcUF72n1hR52rhm2qNcTS1nq3A=','2024-12-05 10:24:56.294965',1,'David','','','dezerzer.ieu2023@student.ie.edu',1,1,'2024-12-05 10:24:24.449897',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `menus_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus_user_groups`
--

DROP TABLE IF EXISTS `menus_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_user_groups_user_id_group_id_7a5add7e_uniq` (`user_id`,`group_id`),
  KEY `menus_user_groups_group_id_aa114b09_fk_auth_group_id` (`group_id`),
  CONSTRAINT `menus_user_groups_group_id_aa114b09_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `menus_user_groups_user_id_dcf490dc_fk_menus_user_id` FOREIGN KEY (`user_id`) REFERENCES `menus_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus_user_groups`
--

LOCK TABLES `menus_user_groups` WRITE;
/*!40000 ALTER TABLE `menus_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `menus_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus_user_user_permissions`
--

DROP TABLE IF EXISTS `menus_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_user_user_permissions_user_id_permission_id_25c9a8a0_uniq` (`user_id`,`permission_id`),
  KEY `menus_user_user_perm_permission_id_541cadd4_fk_auth_perm` (`permission_id`),
  CONSTRAINT `menus_user_user_perm_permission_id_541cadd4_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `menus_user_user_permissions_user_id_77196b6c_fk_menus_user_id` FOREIGN KEY (`user_id`) REFERENCES `menus_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus_user_user_permissions`
--

LOCK TABLES `menus_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `menus_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `menus_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-05 21:43:02
