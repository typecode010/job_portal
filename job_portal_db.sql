-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: job_portal_db
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts_accountprofile`
--

DROP TABLE IF EXISTS `accounts_accountprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_accountprofile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  `moderation_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `accounts_accountprofile_user_id_708f22aa_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_accountprofile`
--

LOCK TABLES `accounts_accountprofile` WRITE;
/*!40000 ALTER TABLE `accounts_accountprofile` DISABLE KEYS */;
INSERT INTO `accounts_accountprofile` VALUES (1,'student','2026-04-19 10:22:26.953993','2026-04-19 10:22:26.953993',2,'approved',1),(2,'student','2026-04-19 10:43:27.208387','2026-04-19 10:43:27.208387',3,'approved',1),(3,'student','2026-04-19 10:49:41.414522','2026-04-19 10:49:41.414522',4,'approved',1),(4,'student','2026-04-19 10:51:53.615090','2026-04-19 10:51:53.615090',5,'approved',1),(5,'alumni','2026-04-19 10:52:45.439875','2026-04-19 10:52:45.439875',6,'approved',1),(6,'student','2026-04-19 11:05:06.682117','2026-04-19 11:05:06.682117',7,'approved',1),(7,'alumni','2026-04-19 11:06:33.942916','2026-04-19 11:06:33.942916',8,'approved',1),(8,'student','2026-04-19 11:20:47.029893','2026-04-19 11:20:47.029893',9,'approved',1),(9,'student','2026-04-19 11:29:39.854011','2026-04-19 11:29:39.854011',10,'approved',1),(10,'alumni','2026-04-19 15:17:45.815652','2026-04-19 15:17:45.815652',11,'approved',1),(11,'student','2026-04-19 15:17:46.697957','2026-04-19 15:17:46.697957',12,'approved',1),(12,'student','2026-04-19 15:17:47.579584','2026-04-19 15:17:47.579584',13,'approved',1),(15,'alumni','2026-04-19 15:20:42.622705','2026-04-19 15:20:42.622705',16,'approved',1),(16,'student','2026-04-19 15:20:42.622705','2026-04-19 15:20:42.622705',17,'approved',1),(20,'alumni','2026-04-19 15:32:11.796825','2026-04-19 15:32:11.796825',21,'approved',1),(21,'student','2026-04-19 15:32:11.796825','2026-04-19 15:32:11.796825',22,'approved',1),(22,'employer','2026-04-19 15:32:11.796825','2026-04-19 15:32:11.796825',23,'approved',1),(23,'alumni','2026-04-19 20:40:26.600972','2026-04-19 20:40:26.600972',24,'approved',1),(24,'student','2026-04-19 20:40:26.616736','2026-04-19 20:40:26.616736',25,'approved',1),(25,'alumni','2026-04-19 20:40:53.346830','2026-07-12 15:10:38.189921',26,'rejected',1),(26,'student','2026-04-19 20:40:53.349830','2026-04-19 20:40:53.349830',27,'approved',1),(27,'alumni','2026-04-19 20:54:00.567286','2026-04-19 20:54:00.567286',29,'approved',1),(28,'student','2026-04-19 20:54:00.567286','2026-04-19 20:54:00.567286',30,'approved',1),(29,'student','2026-04-19 20:54:00.567286','2026-04-19 20:54:00.567286',31,'approved',1),(30,'student','2026-04-19 20:54:21.804350','2026-04-19 20:54:21.804350',33,'approved',1),(31,'student','2026-04-19 21:04:28.359459','2026-04-19 21:04:28.591102',34,'rejected',1),(32,'student','2026-04-20 10:32:00.186471','2026-04-20 10:32:00.322339',35,'approved',1),(33,'student','2026-04-20 10:32:58.602074','2026-04-20 10:32:58.797049',36,'approved',0),(34,'student','2026-04-20 10:40:01.492496','2026-07-12 14:52:42.187233',37,'approved',0),(35,'alumni','2026-07-12 14:45:52.301150','2026-07-12 14:55:51.650598',38,'approved',0),(36,'alumni','2026-07-12 15:05:23.058195','2026-07-12 15:05:23.062164',39,'approved',1);
/*!40000 ALTER TABLE `accounts_accountprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_action_logs`
--

DROP TABLE IF EXISTS `admin_action_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_action_logs` (
  `admin_action_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `admin_user_id` bigint unsigned DEFAULT NULL,
  `action_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_table` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_id` bigint unsigned DEFAULT NULL,
  `action_note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`admin_action_id`),
  KEY `idx_admin_action_admin_user` (`admin_user_id`),
  KEY `idx_admin_action_type` (`action_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_action_logs`
--

LOCK TABLES `admin_action_logs` WRITE;
/*!40000 ALTER TABLE `admin_action_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_action_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_status_history`
--

DROP TABLE IF EXISTS `application_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_status_history` (
  `status_history_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `application_id` bigint unsigned NOT NULL,
  `old_status` enum('applied','shortlisted','interview_scheduled','selected','rejected','withdrawn') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_status` enum('applied','shortlisted','interview_scheduled','selected','rejected','withdrawn') COLLATE utf8mb4_unicode_ci NOT NULL,
  `changed_by_user_id` bigint unsigned DEFAULT NULL,
  `remarks` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`status_history_id`),
  KEY `idx_application_status_application_id` (`application_id`),
  KEY `idx_application_status_changed_by` (`changed_by_user_id`),
  CONSTRAINT `fk_application_status_application` FOREIGN KEY (`application_id`) REFERENCES `job_applications` (`application_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_status_history`
--

LOCK TABLES `application_status_history` WRITE;
/*!40000 ALTER TABLE `application_status_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applications_jobapplication`
--

DROP TABLE IF EXISTS `applications_jobapplication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applications_jobapplication` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cover_letter` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `applicant_id` int NOT NULL,
  `job_id` bigint NOT NULL,
  `resume_document_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `applications_jobapplication_job_id_applicant_id_c9a6c644_uniq` (`job_id`,`applicant_id`),
  KEY `applications_jobappl_applicant_id_7adb2e6d_fk_auth_user` (`applicant_id`),
  KEY `applications_jobappl_resume_document_id_bf23100d_fk_profiles_` (`resume_document_id`),
  CONSTRAINT `applications_jobappl_applicant_id_7adb2e6d_fk_auth_user` FOREIGN KEY (`applicant_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `applications_jobappl_resume_document_id_bf23100d_fk_profiles_` FOREIGN KEY (`resume_document_id`) REFERENCES `profiles_resumedocument` (`id`),
  CONSTRAINT `applications_jobapplication_job_id_3a63fde1_fk_jobs_jobpost_id` FOREIGN KEY (`job_id`) REFERENCES `jobs_jobpost` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications_jobapplication`
--

LOCK TABLES `applications_jobapplication` WRITE;
/*!40000 ALTER TABLE `applications_jobapplication` DISABLE KEYS */;
INSERT INTO `applications_jobapplication` VALUES (1,'','applied','2026-04-19 11:29:39.861067','2026-04-19 11:29:39.861067',10,1,NULL),(2,'I am interested in this opportunity.','applied','2026-04-19 15:17:47.735539','2026-04-19 15:17:47.735539',12,2,2),(4,'','shortlisted','2026-04-19 15:20:42.644226','2026-04-19 15:20:42.722052',17,4,4),(5,'Interested','applied','2026-04-19 15:32:11.987153','2026-04-19 15:32:11.987153',22,8,6),(6,'Interested','shortlisted','2026-04-19 20:40:26.981706','2026-04-19 20:40:27.119942',25,11,7),(7,'Applying for test','applied','2026-04-19 20:54:00.940445','2026-04-19 20:54:00.940445',30,13,9),(8,'','applied','2026-04-24 11:26:48.918226','2026-04-24 11:26:48.918226',9,14,10),(9,'Hi, my name is this and i want to apply for this job , , \r\nMy preferred tech stack is this','applied','2026-06-02 10:11:58.402401','2026-06-02 10:11:58.402401',9,13,10);
/*!40000 ALTER TABLE `applications_jobapplication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',3,'add_permission'),(6,'Can change permission',3,'change_permission'),(7,'Can delete permission',3,'delete_permission'),(8,'Can view permission',3,'view_permission'),(9,'Can add group',2,'add_group'),(10,'Can change group',2,'change_group'),(11,'Can delete group',2,'delete_group'),(12,'Can view group',2,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add account profile',7,'add_accountprofile'),(26,'Can change account profile',7,'change_accountprofile'),(27,'Can delete account profile',7,'delete_accountprofile'),(28,'Can view account profile',7,'view_accountprofile'),(29,'Can add resume document',8,'add_resumedocument'),(30,'Can change resume document',8,'change_resumedocument'),(31,'Can delete resume document',8,'delete_resumedocument'),(32,'Can view resume document',8,'view_resumedocument'),(33,'Can add user profile',9,'add_userprofile'),(34,'Can change user profile',9,'change_userprofile'),(35,'Can delete user profile',9,'delete_userprofile'),(36,'Can view user profile',9,'view_userprofile'),(37,'Can add job post',10,'add_jobpost'),(38,'Can change job post',10,'change_jobpost'),(39,'Can delete job post',10,'delete_jobpost'),(40,'Can view job post',10,'view_jobpost'),(41,'Can add job application',11,'add_jobapplication'),(42,'Can change job application',11,'change_jobapplication'),(43,'Can delete job application',11,'delete_jobapplication'),(44,'Can view job application',11,'view_jobapplication'),(45,'Can add job bookmark',12,'add_jobbookmark'),(46,'Can change job bookmark',12,'change_jobbookmark'),(47,'Can delete job bookmark',12,'delete_jobbookmark'),(48,'Can view job bookmark',12,'view_jobbookmark'),(49,'Can add notification preference',14,'add_notificationpreference'),(50,'Can change notification preference',14,'change_notificationpreference'),(51,'Can delete notification preference',14,'delete_notificationpreference'),(52,'Can view notification preference',14,'view_notificationpreference'),(53,'Can add notification',13,'add_notification'),(54,'Can change notification',13,'change_notification'),(55,'Can delete notification',13,'delete_notification'),(56,'Can view notification',13,'view_notification'),(57,'Can add feedback ticket',15,'add_feedbackticket'),(58,'Can change feedback ticket',15,'change_feedbackticket'),(59,'Can delete feedback ticket',15,'delete_feedbackticket'),(60,'Can view feedback ticket',15,'view_feedbackticket'),(61,'Can add message',16,'add_message'),(62,'Can change message',16,'change_message'),(63,'Can delete message',16,'delete_message'),(64,'Can view message',16,'view_message'),(65,'Can add message thread',17,'add_messagethread'),(66,'Can change message thread',17,'change_messagethread'),(67,'Can delete message thread',17,'delete_messagethread'),(68,'Can view message thread',17,'view_messagethread'),(69,'Can add admin action log',18,'add_adminactionlog'),(70,'Can change admin action log',18,'change_adminactionlog'),(71,'Can delete admin action log',18,'delete_adminactionlog'),(72,'Can view admin action log',18,'view_adminactionlog'),(73,'Can add database backup',19,'add_databasebackup'),(74,'Can change database backup',19,'change_databasebackup'),(75,'Can delete database backup',19,'delete_databasebackup'),(76,'Can view database backup',19,'view_databasebackup');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1200000$e4WbmF42PXID7sAmXApU1u$yEETcLCILHhEMvqhlqa7jukM5ihylSkLA9PtM7fe6C4=','2026-07-12 14:51:39.623582',1,'admin','','','admin@example.com',1,1,'2026-04-18 23:23:55.025438'),(2,'pbkdf2_sha256$1200000$Ly9rpGaTCe7YnpClbAnARm$URP/dF7YA0Y5fbS40spao9geZdm638NH0AvlT3jienw=','2026-04-20 10:57:28.472606',0,'demo_student','Demo','Student','demo_student@example.com',0,1,'2026-04-19 10:22:25.994230'),(3,'pbkdf2_sha256$1200000$6MsawJm2r01Uj2cHSqDO6E$pDDU+tchlrvg7ufSreCESoFuoRLwMPFXfWfkIw7IHHY=','2026-04-19 10:43:28.141212',0,'weakpass_user','Weak','Pass','weakpass_user@example.com',0,1,'2026-04-19 10:43:26.297576'),(4,'pbkdf2_sha256$1200000$HP8GUiDVxUFASRf1bdE4Sj$6P28CAaBdjYD5SXPCFn/+ngQ1vFX+jXK+6AxIjCskPQ=','2026-07-12 14:57:30.429849',0,'a1','almuni','1','a1@gmail.com',0,1,'2026-04-19 10:49:40.472009'),(5,'pbkdf2_sha256$1200000$3pG4Ap6WDjojmUwTd7977w$3Nc8mWttGOOL8Tc+W8VZWjQ3y8p9dkGoP1T1102gi/8=',NULL,0,'redirect_test_user','Redirect','Tester','redirect_test_user@example.com',0,1,'2026-04-19 10:51:52.684278'),(6,'pbkdf2_sha256$1200000$s1eEl09XaP6ceDRY4fLrol$lomkN7kmYEF7PfbPY3Zr5R6eKIrzIqD/co65oKzoYPM=','2026-04-24 11:37:10.811892',0,'a2','almuni','2','a2@gmail.com',0,1,'2026-04-19 10:52:44.499221'),(7,'pbkdf2_sha256$1200000$wEaBMkR36S2fjyttnoTGCI$SBGWziiv08czzLU5HQRQgALLwPGLtgFGUJ/Ae16IhA4=','2026-04-19 11:05:07.664835',0,'dash_student','','','dash_student@example.com',0,1,'2026-04-19 11:05:05.800337'),(8,'pbkdf2_sha256$1200000$zATZbbWRhUgE1yxApElvhC$FIYwTCTYsj4eScFEKk3xYAyq+LXWvD1IUfctGOIj31c=','2026-04-19 11:06:33.949076',0,'dash_alumni','','','dash_alumni@example.com',0,1,'2026-04-19 11:06:33.049209'),(9,'pbkdf2_sha256$1200000$COf5AYZBWm1Tjfd7rzHLBG$dc5P0RyhqvL63QVOEbwOmxy5y60C4KzI4rRn0PQjX1w=','2026-07-12 14:40:01.237505',0,'S1','student','1','s1@gmail.com',0,1,'2026-04-19 11:20:46.062546'),(10,'pbkdf2_sha256$1200000$JGqSozgbmnY6P92VIwMt9D$dRf2ME5zBiuVjf7Is8tXlfDCOOZCUzmwTjdX7wOKFIw=','2026-04-19 11:29:39.897019',0,'student_actions','','','student_actions@example.com',0,1,'2026-04-19 11:29:38.656275'),(11,'pbkdf2_sha256$1200000$4u4vB6suAyPwVdE7JJJVId$LlogM5OIGpGnUNj1IqnG4Oe+rEGC0EiIJhb9CBXqqzo=','2026-04-19 15:17:47.610968',0,'phase3_alumni','','','phase3_alumni@example.com',0,1,'2026-04-19 15:17:44.918251'),(12,'pbkdf2_sha256$1200000$9PC6AkT7y8hYQD78OrO0y2$fXqDMINDH0lfTrhcbCT3cMS+ynhbhoEI+k/K8bBYekE=','2026-04-19 15:17:47.684276',0,'phase3_student','','','phase3_student@example.com',0,1,'2026-04-19 15:17:45.817650'),(13,'pbkdf2_sha256$1200000$Rr9MgTLPRP7MXkAlmih8Ya$2Qv5WTaeO646hGK2+PooSH7SRHxRKhJbNWuPRL/asXQ=','2026-04-19 15:17:47.788863',0,'phase3_student_nors','','','phase3_student_nors@example.com',0,1,'2026-04-19 15:17:46.699957'),(16,'pbkdf2_sha256$1200000$FpvKu768iJGWMmTfhUW97w$rSi5dXgNG842lY9Vgkt3AdRRgBOTUGkS7w7dF6gHN6I=','2026-04-19 15:20:42.661621',0,'phase3_mgr_alumni','','','phase3_mgr_alumni@example.com',0,1,'2026-04-19 15:20:40.828814'),(17,'pbkdf2_sha256$1200000$qUse3H7z75dCruX1QVYuwL$+K1lIMvMtMIXpDDCuiiJCUm30SvqvSGb0GwIyxXC3nc=','2026-04-19 15:20:42.741273',0,'phase3_mgr_student','','','phase3_mgr_student@example.com',0,1,'2026-04-19 15:20:41.733369'),(21,'pbkdf2_sha256$1200000$3ZxmNLeAcbHHRIZwcNWpmc$rXydX6nVDWR+u6MiU4RhS4OqwCPcph11ke/zGPt9ECw=','2026-04-19 15:32:11.828615',0,'phase4_alumni','','','phase4_alumni@example.com',0,1,'2026-04-19 15:32:09.021620'),(22,'pbkdf2_sha256$1200000$y17cfltwyC6rJQViSAhW3B$qDyKYkbCCo98LLbGgT7PaBRafzABDXiy45RMl7jqSqM=','2026-04-19 15:32:11.939564',0,'phase4_student','','','phase4_student@example.com',0,1,'2026-04-19 15:32:09.909095'),(23,'pbkdf2_sha256$1200000$uqc5Hka3eaV9x4orLYmQCi$PNGZLHv1BTvv7Cez3M6euX4otR9zT8t01+SWY0KXfiM=','2026-04-20 10:22:46.269623',0,'phase4_employer','','','phase4_employer@example.com',0,1,'2026-04-19 15:32:10.844036'),(24,'pbkdf2_sha256$1200000$1KWuScvfTaNw6XYk2szxmk$43GXbccPld6VUrNmENns6d/5VCtD/IQ0vy4hw0j7Zng=','2026-04-19 20:40:27.109946',0,'nfy_alumni','','','nfy_alumni@example.com',0,1,'2026-04-19 20:40:24.732708'),(25,'pbkdf2_sha256$1200000$zQaJo9Gfy42OTAUM99EOqd$HLFOLutAoW1Qsi07r7okGaqzoddir6Ui2LooVv0y1Eo=','2026-04-19 20:40:26.942199',0,'nfy_student','','','nfy_student@example.com',0,1,'2026-04-19 20:40:25.688471'),(26,'pbkdf2_sha256$1200000$wfxeE2LLE7HrlM6tMrxA0r$vhM5pvWHL0/R0eErSnGN9ZwX78WHG2f8f2Ui7IGvPAI=','2026-04-19 20:40:53.388005',0,'nfy2_alumni','','','nfy2_alumni@example.com',0,0,'2026-04-19 20:40:51.551649'),(27,'pbkdf2_sha256$1200000$IVPWEsojOt6wfUxGr6xEDl$Thrg/Tag9V5GRtmbwJ5H8AAEXd00DUw6DqkHdbmMbmU=',NULL,0,'nfy2_student','','','nfy2_student@example.com',0,1,'2026-04-19 20:40:52.456027'),(28,'pbkdf2_sha256$1200000$IpsWrqAFoIgXkYpS51VE2T$LtjIJgr0JDFgKyHx4vhjA99YYIQrVky2+ms+MJP/3ZM=','2026-04-19 20:54:00.976217',1,'phase6_admin','','','phase6_admin@example.com',1,1,'2026-04-19 20:53:57.050816'),(29,'pbkdf2_sha256$1200000$sJb4WtBH9I2miPfip1RFEA$evwc2YEYFV+YCKacWo1sTz7Zrffd7l3oV8JtffQsK6M=','2026-04-19 20:54:00.583140',0,'phase6_alumni','','','phase6_alumni@example.com',0,1,'2026-04-19 20:53:57.948497'),(30,'pbkdf2_sha256$1200000$9YOIXiDE4UIBWNh41xYLH0$CdA0TmMjx7SjkoVHEnxjBRbVgHNdhhAIeH39tMhNK1Y=','2026-04-19 20:54:01.078502',0,'phase6_student','','','phase6_student@example.com',0,1,'2026-04-19 20:53:58.813366'),(31,'pbkdf2_sha256$1200000$Wir4SuQL0Ux7IMIEkn3SJ4$Tes/yqJIXCIO4lP+PdBlxHw8ipgVuT/dQw20wjkAE0s=',NULL,0,'phase6_candidate','','','phase6_candidate@example.com',0,1,'2026-04-19 20:53:59.678245'),(32,'pbkdf2_sha256$1200000$oMgPnDiR0FDapeLeOuNExc$YiF0DPbWjpIAY+kLI428tJdyUNKcOlBJ+TjzWfDq6V4=','2026-04-19 20:54:21.835635',1,'phase6_admin_check','','','phase6_admin_check@example.com',1,1,'2026-04-19 20:54:20.022072'),(33,'pbkdf2_sha256$1200000$rk39lk4LeNAwuG07R8AZXP$Z1ZRAM6VajZ1gv+yWLuJNiKxUowsrUDTX2l/OCNHLfE=',NULL,0,'phase6_user_check','','','phase6_user_check@example.com',0,1,'2026-04-19 20:54:20.910688'),(34,'pbkdf2_sha256$1200000$NgrY1mJCPDNnH0LJ9nhXRp$JWrJN93SJzGVSCyEhBDOrVGCq9Ww/svocWkmCh3S/HU=',NULL,0,'phase6_status_test','','','phase6_status_test@example.com',0,0,'2026-04-19 21:04:27.440456'),(35,'pbkdf2_sha256$1200000$NWrfgCyrqrjUB15G0Ik7md$VaEkff9/lMOv1qPxxeaGr6rQfDbwa406HxEkymMgDq0=',NULL,0,'verify_flow_user','','','verify_flow_user@example.com',0,1,'2026-04-20 10:31:59.275587'),(36,'pbkdf2_sha256$1200000$bYWcSwSQnsDZ6QqlzyZ8J0$v7BZwrh6S2xKotjCaIDP7jH89t0pUokJTyw0sIGSn90=',NULL,0,'verify_flow_user_unverified','','','verify_flow_user_unverified@example.com',0,0,'2026-04-20 10:32:57.693286'),(37,'pbkdf2_sha256$1200000$uUjVDEJ6n7wP1jcLKE1MT8$LcFZlEPhdGapy2+iBd7vvnQp08fQBl0RGTz28KqXXHg=',NULL,0,'S3','student','3','scapegoat995@gmail.com',0,0,'2026-04-20 10:40:00.562770'),(38,'pbkdf2_sha256$1200000$MTtgWZs8IElXLgTzVolaZ0$MxkAC9QBaI6j/RB4pjrLfQRQrAQbXzygg1osd0mCfDU=',NULL,0,'alumni','alumni','1','alumni@gmail.com',0,0,'2026-07-12 14:45:51.364036'),(39,'pbkdf2_sha256$1200000$TBTlNShhaIr5j9zljkx18J$Y860lAVGgR8rDzMB0C5e0oOlNNY5rqpDoWTI2o5d5uU=','2026-07-12 15:06:25.459755',0,'alumni1','','','alumni1@example.com',0,1,'2026-07-12 15:05:22.139052');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backup_logs`
--

DROP TABLE IF EXISTS `backup_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backup_logs` (
  `backup_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `initiated_by_user_id` bigint unsigned DEFAULT NULL,
  `backup_type` enum('full','incremental') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'full',
  `backup_file_path` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('started','completed','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'started',
  `started_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_at` datetime DEFAULT NULL,
  `notes` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`backup_id`),
  KEY `idx_backup_initiated_by` (`initiated_by_user_id`),
  KEY `idx_backup_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_logs`
--

LOCK TABLES `backup_logs` WRITE;
/*!40000 ALTER TABLE `backup_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `backup_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispute_tickets`
--

DROP TABLE IF EXISTS `dispute_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dispute_tickets` (
  `dispute_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `raised_by_user_id` bigint unsigned NOT NULL,
  `against_user_id` bigint unsigned DEFAULT NULL,
  `related_job_id` bigint unsigned DEFAULT NULL,
  `related_application_id` bigint unsigned DEFAULT NULL,
  `subject` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('open','in_review','resolved','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `resolution_note` text COLLATE utf8mb4_unicode_ci,
  `resolved_by_user_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`dispute_id`),
  KEY `idx_dispute_raised_by` (`raised_by_user_id`),
  KEY `idx_dispute_status` (`status`),
  KEY `fk_dispute_against_user` (`against_user_id`),
  KEY `fk_dispute_job` (`related_job_id`),
  KEY `fk_dispute_application` (`related_application_id`),
  KEY `fk_dispute_resolved_by` (`resolved_by_user_id`),
  CONSTRAINT `fk_dispute_application` FOREIGN KEY (`related_application_id`) REFERENCES `job_applications` (`application_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_dispute_job` FOREIGN KEY (`related_job_id`) REFERENCES `jobs` (`job_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispute_tickets`
--

LOCK TABLES `dispute_tickets` WRITE;
/*!40000 ALTER TABLE `dispute_tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispute_tickets` ENABLE KEYS */;
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
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
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
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (7,'accounts','accountprofile'),(1,'admin','logentry'),(11,'applications','jobapplication'),(2,'auth','group'),(3,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(12,'jobs','jobbookmark'),(10,'jobs','jobpost'),(16,'messaging','message'),(17,'messaging','messagethread'),(13,'notifications','notification'),(14,'notifications','notificationpreference'),(8,'profiles','resumedocument'),(9,'profiles','userprofile'),(18,'reports','adminactionlog'),(19,'reports','databasebackup'),(15,'reports','feedbackticket'),(6,'sessions','session');
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
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-04-18 23:23:41.370552'),(2,'auth','0001_initial','2026-04-18 23:23:41.929072'),(3,'admin','0001_initial','2026-04-18 23:23:42.079686'),(4,'admin','0002_logentry_remove_auto_add','2026-04-18 23:23:42.079686'),(5,'admin','0003_logentry_add_action_flag_choices','2026-04-18 23:23:42.107451'),(6,'contenttypes','0002_remove_content_type_name','2026-04-18 23:23:42.213579'),(7,'auth','0002_alter_permission_name_max_length','2026-04-18 23:23:42.279560'),(8,'auth','0003_alter_user_email_max_length','2026-04-18 23:23:42.310076'),(9,'auth','0004_alter_user_username_opts','2026-04-18 23:23:42.317434'),(10,'auth','0005_alter_user_last_login_null','2026-04-18 23:23:42.373532'),(11,'auth','0006_require_contenttypes_0002','2026-04-18 23:23:42.376531'),(12,'auth','0007_alter_validators_add_error_messages','2026-04-18 23:23:42.380629'),(13,'auth','0008_alter_user_username_max_length','2026-04-18 23:23:42.475524'),(14,'auth','0009_alter_user_last_name_max_length','2026-04-18 23:23:42.612688'),(15,'auth','0010_alter_group_name_max_length','2026-04-18 23:23:42.631309'),(16,'auth','0011_update_proxy_permissions','2026-04-18 23:23:42.633608'),(17,'auth','0012_alter_user_first_name_max_length','2026-04-18 23:23:42.704850'),(18,'sessions','0001_initial','2026-04-18 23:23:42.738842'),(19,'accounts','0001_initial','2026-04-19 10:21:28.528044'),(20,'jobs','0001_initial','2026-04-19 11:28:00.168552'),(21,'applications','0001_initial','2026-04-19 11:28:00.335896'),(22,'profiles','0001_initial','2026-04-19 11:28:00.508289'),(23,'applications','0002_jobapplication_resume_document','2026-04-19 15:15:44.038285'),(24,'jobs','0002_jobbookmark','2026-04-19 15:28:30.425562'),(25,'notifications','0001_initial','2026-04-19 15:44:44.203263'),(26,'jobs','0003_jobpost_approval_status','2026-04-19 20:53:10.269311'),(27,'accounts','0002_accountprofile_moderation_status','2026-04-19 21:04:04.802733'),(28,'accounts','0003_accountprofile_email_verified','2026-04-20 10:30:22.887421'),(29,'reports','0001_initial','2026-04-20 10:56:58.028900'),(30,'messaging','0001_initial','2026-04-20 11:06:54.914399'),(31,'profiles','0002_alter_resumedocument_file','2026-04-22 11:47:01.438374'),(32,'reports','0002_adminactionlog_databasebackup','2026-04-22 11:47:01.703020');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0vggip8z4dmah7jec1p9axxb189w944a','.eJxVjEEOwiAQRe_C2hCgQAeX7j0DmRlAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xSuIshiBOvyMhP3LbSbpju82S57YuE8ldkQft8jqn_Lwc7t9BxV6_tTPBIBVHowGyDFi0YhyLZzSaB-RUiNiD1Qoseh8MqOyCdcCkdALx_gAkozhi:1wivlB:LmGxRf1CfquUmZuICIkxm5aeD6iUU7gyU2WpinSvP0g','2026-07-26 15:06:25.462753'),('2ryx4c1lsnzr94e3hrqak2t8vxrom8e8','.eJxVjMsOwiAQRf-FtSEDpTxcuvcbyAwMUjU0Ke3K-O_apAvd3nPOfYmI21rj1nmJUxZnoUCcfkfC9OC2k3zHdptlmtu6TCR3RR60y-uc-Xk53L-Dir1-a2D0iAxo8uC108YqB8h21CoAkMMwFLLJeG8UGw5B50JUtIKUkh6DeH8A_Q438g:1wEQLL:je-0eEoXLn-K5FZqrw4aO0tvhVGBAASb1VKh8bs6_mc','2026-05-03 11:29:39.899877'),('34l1i3d7p6s1qk5u31u76mi6m1tor97r','.eJxVjDsOwjAQBe_iGln-ZjeU9JwhWns3OIAcKU4qxN0hUgpo38y8lxpoW8uwNVmGidVZoTr9bonyQ-oO-E71Nus813WZkt4VfdCmrzPL83K4fweFWvnWGaJHw5isd2SwJxutE9eFEIVTNMjdaAkQuuwJJQKy830AGEEMxl69P8HeNtI:1wEPyz:2EisIgPY2X_R-1w1x18EOtFJOkXYJ_6m3jjFKAN81_c','2026-05-03 11:06:33.964280'),('3ff6ukrrcmgvmwo30hkivovqupkz7whx','.eJxVjMsOwiAQRf-FtSFMoTxcuvcbyAwMUjU0Ke3K-O_apAvd3nPOfYmI21rj1nmJUxZnYcTpdyNMD247yHdst1mmua3LRHJX5EG7vM6Zn5fD_Tuo2Ou3di6Nzg8EwEVT0sEQBNCBsi9jdjZYj8qS8gYJVTHeMWgOfmALHDSI9wfVMDdZ:1wibIG:PV8eZbHiQVaeYGMduYPWfahwKFRF1aFHAglQMog5k8o','2026-07-25 17:15:12.821733'),('4it725lgog6g682s4ai1a9r7in2os5om','.eJxVjMsOwiAQRf-FtSHDtDx06b7fQAYYpGogKe3K-O_apAvd3nPOfQlP21r81nnxcxIXocTpdwsUH1x3kO5Ub03GVtdlDnJX5EG7nFri5_Vw_w4K9fKthxxRh2xdQmcCuWCNBQBW2hASoVWcceQEdFaIyEbpAVLAMULW4LJ4fwDdzjeD:1wEZJP:1RvBjzhvrTsSFhpl8SPNwVN9F_crzeTnvx4suOyEz-o','2026-05-03 21:04:15.925382'),('4m49mabid7m86v9x87mu76tac1u9hzwi','.eJxVjEEOwiAQRe_C2hBghqnj0r1nIFBGqRpISrsy3l2bdKHb_977LxXiupSwdpnDlNVJ2UEdfscUx4fUjeR7rLemx1aXeUp6U_ROu760LM_z7v4dlNjLt6aEwGINJ_TkM8MVkBAcg8NE5I5i2HlrSHiw7KOI944iJsiQiVG9P8h0Nmw:1wETww:XnHKdI1FKPmAM1FR3lWA7jy35nglpcXn0WasTIdOEls','2026-05-03 15:20:42.744280'),('4pz5d804288zgj3bmluyl3ggnpi8h3yj','.eJxVjMsOwiAQRf-FtSG8BMal-34DGQaQqoGktCvjv2uTLnR7zzn3xQJuaw3byEuYE7swxU6_W0R65LaDdMd265x6W5c58l3hBx186ik_r4f7d1Bx1G8NXhVH1ibQqkRtvCVnNAFGIYvyXkSSqJW2ucSzcEAOpAEjCaw0KQn2_gDOujch:1wEPIJ:p_FxALGzXiOnYGpBg9CxB8njacq_YI4yiCEcCaekzLg','2026-05-03 10:22:27.917492'),('5gkgkw3r8hbmjmh9wx15ivwwk62fmn6m','.eJxVjMsOwiAQRf-FtSG8BMal-34DGQaQqoGktCvjv2uTLnR7zzn3xQJuaw3byEuYE7swxU6_W0R65LaDdMd265x6W5c58l3hBx186ik_r4f7d1Bx1G8NXhVH1ibQqkRtvCVnNAFGIYvyXkSSqJW2ucSzcEAOpAEjCaw0KQn2_gDOujch:1wElmA:22DD0W6Noae1MxFYF_4JZrxnnorkm4mR8JB8J7eG5_k','2026-05-04 10:22:46.012811'),('5qlhg9vc7avtsgsey2nyjkslo6kh5b5b','.eJxVjMsOwiAQRf-FtSG8BMal-34DGQaQqoGktCvjv2uTLnR7zzn3xQJuaw3byEuYE7swxU6_W0R65LaDdMd265x6W5c58l3hBx186ik_r4f7d1Bx1G8NXhVH1ibQqkRtvCVnNAFGIYvyXkSSqJW2ucSzcEAOpAEjCaw0KQn2_gDOujch:1wElJU:IZTetOyiYcYtEA6sLN6fQ49zNwXFuYTSIJmtZnuDiFY','2026-05-04 09:53:08.190391'),('6u77me94c1ipxnhudjie531nw6ux3cpp','.eJxVjMEOgjAQRP-lZ9N0gZbWo3e-odnubgU1JaFwMv67kHDQzG3em3mriNs6xq3KEidWV9U26vJbJqSnlIPwA8t91jSXdZmSPhR90qqHmeV1O92_gxHruK8BOEMwApJcYukgsBHnXUMeDedMxCwBE0BHfY-5s9L45IjbPday-nwBNSQ5fg:1wEZ9p:FxpamcLHRsOsU65aPg3F0rFqH3bNZs9vfRQbFTL6yYQ','2026-05-03 20:54:21.835635'),('7tnw0q4a7j3n6bmtac6oghyijmd7smfp','.eJxVjDsOwjAQBe_iGlnOBv8o6TmDtfaucQDZUpxUiLuTSCmgfTPz3iLgupSwdp7DROIirDj9bhHTk-sO6IH13mRqdZmnKHdFHrTLWyN-XQ_376BgL1vtiLy3EVGrbLMbdUYwBrWLnhy44awUAniTGTgNOILxjokITTKbrcTnC-zjN-k:1wEPxb:F4DW1TszwyckKk2gLaDuZmuAe42M1mfWrZ-ax7hswqI','2026-05-03 11:05:07.657302'),('94avtyc7fsxmvtncwd6eo26a53rf5ous','.eJxVjMsOwiAQRf-FtSHDtDx06b7fQAYYpGogKe3K-O_apAvd3nPOfQlP21r81nnxcxIXocTpdwsUH1x3kO5Ub03GVtdlDnJX5EG7nFri5_Vw_w4K9fKthxxRh2xdQmcCuWCNBQBW2hASoVWcceQEdFaIyEbpAVLAMULW4LJ4fwDdzjeD:1wEZJc:1BMOJBk3kh__GZDDGBlALfa-YcH5YMSbDAeGMLslIJ4','2026-05-03 21:04:28.386934'),('athr40d9iekzk3dks4t8zej0m49rtyyo','.eJxVjEsOwjAMBe-SNYrc1HUTlux7hsqxU1JAqdTPCnF3FKkL2L6ZeW8z8rHn8djSOs5qrqYxl98tsjxTqUAfXO6LlaXs6xxtVexJNzssml630_07yLzlWscJwac-knpyLRMRYHDBC2KHil5IpibFGJi5k9AigBCD1z5B49R8vt9uN9A:1wElw2:_ARX2xw1CXZWkPiUNZtHwPnEGOPifkev2UTsslUcJps','2026-05-04 10:32:58.647449'),('b8038a8obl4fevk8if0vvnofembi4ewu','.eJxVjMsOwiAQRf-FtSG8BMal-34DGQaQqoGktCvjv2uTLnR7zzn3xQJuaw3byEuYE7swxU6_W0R65LaDdMd265x6W5c58l3hBx186ik_r4f7d1Bx1G8NXhVH1ibQqkRtvCVnNAFGIYvyXkSSqJW2ucSzcEAOpAEjCaw0KQn2_gDOujch:1wEj28:dGiRUK9AXI_XtVtYC4GYLy3fedfIQBt4Bch6wF7KuO4','2026-05-04 07:27:04.490405'),('c9i3ipyd266wzspg6otzkl4eiunis3gq','.eJxVjDsOwjAQBe_iGln-O6akzxmsXXuNA8iR4qRC3J1ESgHtm5n3ZhG2tcat0xKnzK5MC3b5HRHSk9pB8gPafeZpbusyIT8UftLOxznT63a6fwcVet3rAZUhWQjs3gwyeAPeoChOlRDQktXotPTFOPSYtDTBSmsUCaeCVkKyzxcLcTdA:1wEZ9V:4Uzjgyj0Cmsph9CrjR5SZe7MyIm7DEnqWtaL5i96aj4','2026-05-03 20:54:01.081536'),('e77i6lot73u21r9szgnfs90u42nn5ny2','.eJxVjMsOwiAQRf-FtSHDtDx06b7fQAYYpGogKe3K-O_apAvd3nPOfQlP21r81nnxcxIXocTpdwsUH1x3kO5Ub03GVtdlDnJX5EG7nFri5_Vw_w4K9fKthxxRh2xdQmcCuWCNBQBW2hASoVWcceQEdFaIyEbpAVLAMULW4LJ4fwDdzjeD:1wEZAs:pyq02o05apkmzov_tkGbLfjgcYn8y_e3Y-1WB5mqFpk','2026-05-03 20:55:26.043993'),('eo3krmo8qpuq3tfzchj7xphyzgcredb7','.eJxVjEEOwiAQRe_C2hCgAoNL9z0DmWFAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERTpx-N8L0yG0HfMd2m2Wa27pMJHdFHrTLceb8vB7u30HFXr81GOuy9k6ZpPSAhZy1g2arlWIm8IoLhFAYS_IBTHBnU7SHBBCYPIF4fwDGGTdj:1wGEqM:aEGd-b3H1yNxSJbZ0-WpHF7eb_e_80yvwdE5WYeDB5o','2026-05-08 11:37:10.815889'),('f4ii391yxbwrpxgovfg238f5o1ikaxf1','.eJxVjEEOwiAQRe_C2hAyjBRcuvcMZGAGqRqalHbVeHdt0oVu_3vvbyrSutS4dpnjyOqiwKnT75goP6XthB_U7pPOU1vmMeld0Qft-jaxvK6H-3dQqddv7TiIC8SQDQWDjJKE0VBJxUPIbBwWFMueiTCDHUAygTcog9jgz-r9ATfeOPw:1wEYwn:WBzVIZTiBcZSGYZoKuWZ7lmRfESBOLGN7yRtlbqBRY0','2026-05-03 20:40:53.395005'),('fqwxzubi5qng0rnz1xf1jygviqjgneed','.eJxVjEsOwiAUAO_C2hDg8Sku3fcMhAdPqRpISrsy3l1JutDtzGReLMR9K2HvtIYlszPz7PTLMKYH1SHyPdZb46nVbV2Qj4QftvO5ZXpejvZvUGIvYytFVs4CSaU9KrJTcsY5CVoKL9GkK-AXKNBGgBcxOyCkCY112kBE9v4AqZc2iQ:1wEm42:GlERKoEu0-pkZtkwWxIR_ODZyVB_lYfRAfvp0cFsN-8','2026-05-04 10:41:14.336574'),('fuk0icst1bxrkud018uz1i3tvkkr90ue','.eJxVjEsOwjAMBe-SNYrc1HUTlux7hsqxU1JAqdTPCnF3FKkL2L6ZeW8z8rHn8djSOs5qrqYxl98tsjxTqUAfXO6LlaXs6xxtVexJNzssml630_07yLzlWscJwac-knpyLRMRYHDBC2KHil5IpibFGJi5k9AigBCD1z5B49R8vt9uN9A:1wEj1y:soME2xoEmAONMipjpBK18vrXMzFHz6C1y0Nuc8JZ6Wo','2026-05-04 07:26:54.562391'),('iuw23a3lz49vjz22owtmc887w2cuiuck','.eJxVjEEOwiAQRe_C2hBaYACX7j0DGTqDVA1NSrsy3l1JutDVT_57eS8Rcd9K3BuvcSZxFoMWp98z4fTg2gndsd4WOS11W-ckuyIP2uR1IX5eDvcvULCV3s2QsqJkFSePzgQi8h45ExsA651yFlh7E8AMjhVZwgCax-_wCFq8PyLDOFQ:1wETu7:fpRP4E7uDcR9OJ0yw3aogb8xU275SBg4NwuGXV1e_y8','2026-05-03 15:17:47.791896'),('ixxgzr8elbsm1dcdk47xfnv51o5p7lby','.eJxVjMsOwiAUBf-FtSEILb24dN9vINwHUjU0Ke3K-O_apAvdnpk5LxXTtpa4NVnixOqizkGdfkdM9JC6E76neps1zXVdJtS7og_a9DizPK-H-3dQUivf2nmDgToIA3nnLBFy9iAJHJPrjBjKvRAgAljgADYjGCNJyPWMA6j3BxvOONw:1wEU6v:5X2zUj8Y4aRgx9yAaI9yybk-DTHr32nhJBzvYHVYdks','2026-05-03 15:31:01.464787'),('jijr1wjy7gwi485nx2phpdqh8r03xaw5','.eJxVjEsOwjAMBe-SNYrc1HUTlux7hsqxU1JAqdTPCnF3FKkL2L6ZeW8z8rHn8djSOs5qrqYxl98tsjxTqUAfXO6LlaXs6xxtVexJNzssml630_07yLzlWscJwac-knpyLRMRYHDBC2KHil5IpibFGJi5k9AigBCD1z5B49R8vt9uN9A:1wElv6:gpZXAVMImQbxmwejHIVBbyoNjPxtrO7ihwverj2fR0k','2026-05-04 10:32:00.273430'),('jvin78gc68csvzt71d8yi5ikhnkhtx11','.eJxVjEEOgjAQRe_StWlgOuLUpXvOQKYzraCmTSisjHcXEha6_e-9_zYDr8s4rDXOw6TmagDN6XcMLM-Yd6IPzvdipeRlnoLdFXvQavui8XU73L-Dkeu41c4r-jZBq85J5M5Te46uIaBAqVEB8oApOcbUCAaJqB0lALkQhk0xny__WjhG:1wEYwN:yCNM8wVISQb2ibgFbyR9i2PJzT4GQRUPuhDAnaH0NdQ','2026-05-03 20:40:27.111940'),('l1e0q3tjwjwi4cli7mq4qngyecntnq0f','.eJxVjDsOwjAUBO_iGll2HP8o6TmD9Zx9JgHkSHFSIe4OkVJAuzOzL5FoW8e0NV7SBHEWnRGn3zHT8OC6E9yp3mY5zHVdpix3RR60yesMfl4O9-9gpDZ-a8NeoQe6aIMpjgMr0s71AQTrdHTaR_QUooIqPhD7HH0JNmMggIx4fwADXziD:1wEU84:s-gaWsU18rqV1lEvl-USABJMqRxNDIkECx5ximmLylg','2026-05-03 15:32:12.023442'),('lx48qpnx00eg537diklovkkntr74h0pr','.eJxVjMsOwiAQRf-FtSG8BMal-34DGQaQqoGktCvjv2uTLnR7zzn3xQJuaw3byEuYE7swxU6_W0R65LaDdMd265x6W5c58l3hBx186ik_r4f7d1Bx1G8NXhVH1ibQqkRtvCVnNAFGIYvyXkSSqJW2ucSzcEAOpAEjCaw0KQn2_gDOujch:1wEmA2:8_jhVugMjVG2LoZ0jFTHiFgEH1ff3oZ-XtKSjV2L-Z8','2026-05-04 10:47:26.723574'),('n2zru0sifmf74ay9scvke9zzxp23129j','.eJxVjMsOwiAQRf-FtSFMoTxcuvcbyAwMUjU0Ke3K-O_apAvd3nPOfYmI21rj1nmJUxZnYcTpdyNMD247yHdst1mmua3LRHJX5EG7vM6Zn5fD_Tuo2Ou3di6Nzg8EwEVT0sEQBNCBsi9jdjZYj8qS8gYJVTHeMWgOfmALHDSI9wfVMDdZ:1wI3KE:W0Md28u1BXED4RybkBqjGu_aAa4I3gKxhuSUYXtK3w4','2026-05-13 11:43:30.322794'),('nhkwxvglwub31j0qifa1vwkqk4a6ktrp','.eJxVjEsOwjAMBe-SNYrc1HUTlux7hsqxU1JAqdTPCnF3FKkL2L6ZeW8z8rHn8djSOs5qrqYxl98tsjxTqUAfXO6LlaXs6xxtVexJNzssml630_07yLzlWscJwac-knpyLRMRYHDBC2KHil5IpibFGJi5k9AigBCD1z5B49R8vt9uN9A:1wEmJk:zIvgILE97bUkzF2f1gwz1ExsXnQBH9ht5Z7XUm0xvU4','2026-05-04 10:57:28.672188'),('rh0mkkgerod2aaj7ipi3ywb6lz5jno6l','.eJxVjDsOwjAUBO_iGll2HP8o6TmD9Zx9JgHkSHFSIe4OkVJAuzOzL5FoW8e0NV7SBHEWnRGn3zHT8OC6E9yp3mY5zHVdpix3RR60yesMfl4O9-9gpDZ-a8NeoQe6aIMpjgMr0s71AQTrdHTaR_QUooIqPhD7HH0JNmMggIx4fwADXziD:1wElmA:EgWLDkL9URefU9UQib1p20SK3RKQWHr3eJZCNJurz0g','2026-05-04 10:22:46.276591'),('uj8tagl55ps26u131gfyaemmyfimzm43','.eJxVjEsOwjAMBe-SNYrc1HUTlux7hsqxU1JAqdTPCnF3FKkL2L6ZeW8z8rHn8djSOs5qrqYxl98tsjxTqUAfXO6LlaXs6xxtVexJNzssml630_07yLzlWscJwac-knpyLRMRYHDBC2KHil5IpibFGJi5k9AigBCD1z5B49R8vt9uN9A:1wEiv2:oWt8ZwVX1DdbugsUrCru3wglZWBXt5Elc3x1-lEtKNk','2026-05-04 07:19:44.595933'),('umbyuq4tyu8xtcl1nc770int6y37hsrw','.eJxVjDsOwjAQBe_iGlnOBv8o6TmDtfaucQDZUpxUiLuTSCmgfTPz3iLgupSwdp7DROIirDj9bhHTk-sO6IH13mRqdZmnKHdFHrTLWyN-XQ_376BgL1vtiLy3EVGrbLMbdUYwBrWLnhy44awUAniTGTgNOILxjokITTKbrcTnC-zjN-k:1wEPxb:F4DW1TszwyckKk2gLaDuZmuAe42M1mfWrZ-ax7hswqI','2026-05-03 11:05:07.664835'),('vii3lgvu03rvzxk5q0vxb461bkcms4dx','.eJxVjDsOwyAQRO9CHSF-BjZlep8BLbAEJxGWjF1FuXtsyUVSzrw382YBt7WGrdMSpsyuTLLLbxcxPakdID-w3Wee5rYuU-SHwk_a-Thnet1O9--gYq_72gHCIDz5NKho9qSc8QRGZeEjAYBBaQpZq7TQWupYyDhZfNRkkaRjny_BgTcu:1wivWt:KRRwBVMMk47H-A0ZShwkL47LxsKDZMbERb7Iw1qrD0U','2026-07-26 14:51:39.625580'),('x85fbzs68s8tlvl1ytdtjeewut7xbr5e','.eJxVjMsOwiAUBf-FtSG8Hy7d9xsIXC5SNZCUdmX8d9ukC92emTlvEuK21rANXMKcyZVwTS6_Y4rwxHaQ_Ijt3in0ti5zoodCTzro1DO-bqf7d1DjqHutBKrijFIc0ehYgOXslBVSoJTJO0ArMJudccs0eiF1AvAFimfoHCefLweZOCE:1wETvS:Su1JsD_cOfsyvYSbsWRAOKMWrUHEEceFcTyRA0BA8Yg','2026-05-03 15:19:10.412802'),('xxhrg4utyucdpceqensk2zfzk2ha6v10','.eJxVjMsOwiAQRf-FtSG8BMal-34DGQaQqoGktCvjv2uTLnR7zzn3xQJuaw3byEuYE7swxU6_W0R65LaDdMd265x6W5c58l3hBx186ik_r4f7d1Bx1G8NXhVH1ibQqkRtvCVnNAFGIYvyXkSSqJW2ucSzcEAOpAEjCaw0KQn2_gDOujch:1wEZJy:IU3_LIajacE6ZBLtz18M-QGWlrGlFUyqncNm1wfiSnQ','2026-05-03 21:04:50.429291');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `education_details`
--

DROP TABLE IF EXISTS `education_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `education_details` (
  `education_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `institute_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `degree_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_of_study` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_year` smallint unsigned DEFAULT NULL,
  `end_year` smallint unsigned DEFAULT NULL,
  `grade_or_cgpa` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`education_id`),
  KEY `idx_education_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `education_details`
--

LOCK TABLES `education_details` WRITE;
/*!40000 ALTER TABLE `education_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `education_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_notification_logs`
--

DROP TABLE IF EXISTS `email_notification_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_notification_logs` (
  `email_log_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `notification_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `email_to` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body_preview` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `send_status` enum('queued','sent','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'queued',
  `error_message` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`email_log_id`),
  KEY `idx_email_log_status` (`send_status`),
  KEY `idx_email_log_user_id` (`user_id`),
  KEY `fk_email_log_notification` (`notification_id`),
  CONSTRAINT `fk_email_log_notification` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`notification_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_notification_logs`
--

LOCK TABLES `email_notification_logs` WRITE;
/*!40000 ALTER TABLE `email_notification_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_notification_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_verification_tokens`
--

DROP TABLE IF EXISTS `email_verification_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_verification_tokens` (
  `token_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `token` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`token_id`),
  UNIQUE KEY `uq_email_verification_token` (`token`),
  KEY `idx_email_verification_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_verification_tokens`
--

LOCK TABLES `email_verification_tokens` WRITE;
/*!40000 ALTER TABLE `email_verification_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_verification_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employer_profiles`
--

DROP TABLE IF EXISTS `employer_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employer_profiles` (
  `employer_profile_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `company_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `website_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `industry` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_size` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `headquarters` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_description` text COLLATE utf8mb4_unicode_ci,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`employer_profile_id`),
  UNIQUE KEY `uq_employer_profiles_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employer_profiles`
--

LOCK TABLES `employer_profiles` WRITE;
/*!40000 ALTER TABLE `employer_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `employer_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experience_details`
--

DROP TABLE IF EXISTS `experience_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `experience_details` (
  `experience_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `company_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_title` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `employment_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_current_job` tinyint(1) NOT NULL DEFAULT '0',
  `location` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`experience_id`),
  KEY `idx_experience_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experience_details`
--

LOCK TABLES `experience_details` WRITE;
/*!40000 ALTER TABLE `experience_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `experience_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback_tickets`
--

DROP TABLE IF EXISTS `feedback_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback_tickets` (
  `feedback_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `category` enum('bug','feature_request','general','abuse_report') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'general',
  `subject` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('open','in_progress','resolved','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `admin_response` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`feedback_id`),
  KEY `idx_feedback_user_id` (`user_id`),
  KEY `idx_feedback_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback_tickets`
--

LOCK TABLES `feedback_tickets` WRITE;
/*!40000 ALTER TABLE `feedback_tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_applications`
--

DROP TABLE IF EXISTS `job_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_applications` (
  `application_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `job_id` bigint unsigned NOT NULL,
  `applicant_user_id` bigint unsigned NOT NULL,
  `resume_id` bigint unsigned DEFAULT NULL,
  `cover_letter` text COLLATE utf8mb4_unicode_ci,
  `current_status` enum('applied','shortlisted','interview_scheduled','selected','rejected','withdrawn') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'applied',
  `applied_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`application_id`),
  UNIQUE KEY `uq_job_applications_unique` (`job_id`,`applicant_user_id`),
  KEY `idx_job_applications_applicant` (`applicant_user_id`),
  KEY `idx_job_applications_status` (`current_status`),
  KEY `fk_job_applications_resume` (`resume_id`),
  CONSTRAINT `fk_job_applications_job` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_job_applications_resume` FOREIGN KEY (`resume_id`) REFERENCES `resume_documents` (`resume_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_applications`
--

LOCK TABLES `job_applications` WRITE;
/*!40000 ALTER TABLE `job_applications` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_bookmarks`
--

DROP TABLE IF EXISTS `job_bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_bookmarks` (
  `bookmark_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `job_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`bookmark_id`),
  UNIQUE KEY `uq_job_bookmark` (`user_id`,`job_id`),
  KEY `idx_job_bookmarks_job_id` (`job_id`),
  CONSTRAINT `fk_job_bookmarks_job` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_bookmarks`
--

LOCK TABLES `job_bookmarks` WRITE;
/*!40000 ALTER TABLE `job_bookmarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_bookmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_matches`
--

DROP TABLE IF EXISTS `job_matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_matches` (
  `match_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `job_id` bigint unsigned NOT NULL,
  `match_score` decimal(5,2) NOT NULL,
  `match_level` enum('low','moderate','strong') COLLATE utf8mb4_unicode_ci NOT NULL,
  `match_reason` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `computed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`match_id`),
  UNIQUE KEY `uq_job_matches_user_job` (`user_id`,`job_id`),
  KEY `idx_job_matches_score` (`match_score`),
  KEY `fk_job_matches_job` (`job_id`),
  CONSTRAINT `fk_job_matches_job` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_matches`
--

LOCK TABLES `job_matches` WRITE;
/*!40000 ALTER TABLE `job_matches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_matches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_skills`
--

DROP TABLE IF EXISTS `job_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_skills` (
  `job_skill_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `job_id` bigint unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `required_level` enum('beginner','intermediate','advanced') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'beginner',
  `weight` tinyint unsigned NOT NULL DEFAULT '5',
  PRIMARY KEY (`job_skill_id`),
  UNIQUE KEY `uq_job_skill` (`job_id`,`skill_id`),
  KEY `idx_job_skills_skill_id` (`skill_id`),
  CONSTRAINT `fk_job_skills_job` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_job_skills_skill` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`skill_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_skills`
--

LOCK TABLES `job_skills` WRITE;
/*!40000 ALTER TABLE `job_skills` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `job_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `posted_by_user_id` bigint unsigned DEFAULT NULL,
  `posted_by_type` enum('alumni','employer','admin') COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `location_city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_state` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_remote` tinyint(1) NOT NULL DEFAULT '0',
  `job_type` enum('full_time','part_time','internship','contract') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'full_time',
  `experience_min_years` decimal(4,1) DEFAULT NULL,
  `experience_max_years` decimal(4,1) DEFAULT NULL,
  `salary_min` decimal(12,2) DEFAULT NULL,
  `salary_max` decimal(12,2) DEFAULT NULL,
  `currency_code` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USD',
  `required_qualification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `application_deadline` date DEFAULT NULL,
  `status` enum('pending','approved','rejected','open','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  `approved_by_user_id` bigint unsigned DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`job_id`),
  KEY `idx_jobs_posted_by` (`posted_by_user_id`),
  KEY `idx_jobs_status` (`status`),
  KEY `idx_jobs_deadline` (`application_deadline`),
  KEY `idx_jobs_job_type` (`job_type`),
  KEY `idx_jobs_city` (`location_city`),
  KEY `fk_jobs_approved_by_user` (`approved_by_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs_jobbookmark`
--

DROP TABLE IF EXISTS `jobs_jobbookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs_jobbookmark` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `job_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jobs_jobbookmark_user_id_job_id_dbf6d42e_uniq` (`user_id`,`job_id`),
  KEY `jobs_jobbookmark_job_id_a16de06d_fk_jobs_jobpost_id` (`job_id`),
  CONSTRAINT `jobs_jobbookmark_job_id_a16de06d_fk_jobs_jobpost_id` FOREIGN KEY (`job_id`) REFERENCES `jobs_jobpost` (`id`),
  CONSTRAINT `jobs_jobbookmark_user_id_d169671f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs_jobbookmark`
--

LOCK TABLES `jobs_jobbookmark` WRITE;
/*!40000 ALTER TABLE `jobs_jobbookmark` DISABLE KEYS */;
INSERT INTO `jobs_jobbookmark` VALUES (1,'2026-04-19 15:32:11.971303',8,22),(3,'2026-04-20 11:05:20.051336',5,9);
/*!40000 ALTER TABLE `jobs_jobbookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs_jobpost`
--

DROP TABLE IF EXISTS `jobs_jobpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs_jobpost` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `required_skills` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `posted_by_id` int DEFAULT NULL,
  `approval_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_jobpost_posted_by_id_d7bcbbe7_fk_auth_user_id` (`posted_by_id`),
  CONSTRAINT `jobs_jobpost_posted_by_id_d7bcbbe7_fk_auth_user_id` FOREIGN KEY (`posted_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs_jobpost`
--

LOCK TABLES `jobs_jobpost` WRITE;
/*!40000 ALTER TABLE `jobs_jobpost` DISABLE KEYS */;
INSERT INTO `jobs_jobpost` VALUES (1,'Python Intern','Tech Bridge','Lahore','internship','python,django','Internship role for django project',1,'2026-04-19 11:29:39.857486','2026-04-19 11:29:39.857486',NULL,'approved'),(2,'Backend Django Intern','Future Labs','Karachi','internship','django,python,api','Work on backend APIs and dashboards.',1,'2026-04-19 15:17:47.656415','2026-04-19 15:17:47.656415',11,'approved'),(3,'Data Analyst Intern','Insight Works','Islamabad','internship','sql,excel','Analyze hiring data and support reporting tasks.',1,'2026-04-19 15:19:10.295866','2026-04-19 15:19:10.295866',NULL,'approved'),(4,'Data Analyst Intern','Insight Works','Islamabad','internship','sql,excel','Analyze data',1,'2026-04-19 15:20:42.642121','2026-04-19 15:20:42.642121',16,'approved'),(5,'Platform Engineer Intern Updated','Nova Systems','Karachi','remote','python,django,api','Build backend services and APIs.',1,'2026-04-19 15:31:01.373607','2026-04-19 15:31:01.449148',NULL,'approved'),(6,'Data Analyst Intern','Insight Labs','Lahore','internship','excel,sql','Assist analytics team.',1,'2026-04-19 15:31:01.385971','2026-04-19 15:31:01.385971',NULL,'approved'),(7,'QA Trainee','QualityHub','Karachi','full_time','testing','Manual testing tasks.',0,'2026-04-19 15:31:01.385971','2026-04-19 15:31:01.449148',NULL,'approved'),(8,'Platform Engineer Intern Updated','Nova Systems','Karachi','remote','python,django,api','Build backend services and APIs.',1,'2026-04-19 15:32:11.860665','2026-04-19 15:32:11.923788',21,'approved'),(9,'Data Analyst Intern','Insight Labs','Lahore','internship','excel,sql','Assist analytics team.',1,'2026-04-19 15:32:11.860665','2026-04-19 15:32:11.860665',21,'approved'),(10,'QA Trainee','QualityHub','Karachi','full_time','testing','Manual testing tasks.',0,'2026-04-19 15:32:11.876447','2026-04-19 15:32:11.923788',21,'approved'),(11,'Cloud Intern','Nebula Tech','Karachi','internship','python,aws','Cloud support role.',1,'2026-04-19 20:40:26.756183','2026-04-19 20:40:26.756183',24,'approved'),(12,'Support Intern','Assist Corp','Lahore','internship','communication','Support role.',1,'2026-04-19 20:40:53.428150','2026-04-19 20:40:53.428150',26,'approved'),(13,'Admin Moderated Intern','Phase6 Labs','Karachi','internship','python','Phase 6 moderation test job.',1,'2026-04-19 20:54:00.614731','2026-04-19 20:54:00.792840',29,'approved'),(14,'front end','xeven','lahore','full_time','css, bootstrap','this is full time job',1,'2026-04-24 11:21:56.618228','2026-04-24 11:24:47.316009',6,'approved'),(15,'.NET CORE ASAP DEV','Globe Techfy','Gulberg','part_time','.net c# SQL','Freshes can apply',1,'2026-07-12 15:18:21.013589','2026-07-12 15:19:21.076815',39,'approved');
/*!40000 ALTER TABLE `jobs_jobpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_thread_participants`
--

DROP TABLE IF EXISTS `message_thread_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_thread_participants` (
  `participant_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `thread_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `last_read_at` datetime DEFAULT NULL,
  `joined_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`participant_id`),
  UNIQUE KEY `uq_thread_participant` (`thread_id`,`user_id`),
  KEY `idx_thread_participants_user_id` (`user_id`),
  CONSTRAINT `fk_thread_participants_thread` FOREIGN KEY (`thread_id`) REFERENCES `message_threads` (`thread_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_thread_participants`
--

LOCK TABLES `message_thread_participants` WRITE;
/*!40000 ALTER TABLE `message_thread_participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_thread_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_threads`
--

DROP TABLE IF EXISTS `message_threads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_threads` (
  `thread_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `subject` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_user_id` bigint unsigned DEFAULT NULL,
  `related_job_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`thread_id`),
  KEY `idx_threads_created_by` (`created_by_user_id`),
  KEY `fk_threads_related_job` (`related_job_id`),
  CONSTRAINT `fk_threads_related_job` FOREIGN KEY (`related_job_id`) REFERENCES `jobs` (`job_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_threads`
--

LOCK TABLES `message_threads` WRITE;
/*!40000 ALTER TABLE `message_threads` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_threads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `message_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `thread_id` bigint unsigned NOT NULL,
  `sender_user_id` bigint unsigned DEFAULT NULL,
  `message_body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `sent_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`),
  KEY `idx_messages_thread_sent` (`thread_id`,`sent_at`),
  KEY `fk_messages_sender` (`sender_user_id`),
  CONSTRAINT `fk_messages_thread` FOREIGN KEY (`thread_id`) REFERENCES `message_threads` (`thread_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messaging_message`
--

DROP TABLE IF EXISTS `messaging_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messaging_message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `sender_id` int NOT NULL,
  `thread_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `messaging_message_sender_id_7a7088e6_fk_auth_user_id` (`sender_id`),
  KEY `messaging_message_thread_id_f689027f_fk_messaging` (`thread_id`),
  CONSTRAINT `messaging_message_sender_id_7a7088e6_fk_auth_user_id` FOREIGN KEY (`sender_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `messaging_message_thread_id_f689027f_fk_messaging` FOREIGN KEY (`thread_id`) REFERENCES `messaging_messagethread` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messaging_message`
--

LOCK TABLES `messaging_message` WRITE;
/*!40000 ALTER TABLE `messaging_message` DISABLE KEYS */;
INSERT INTO `messaging_message` VALUES (1,'hi there',0,'2026-04-24 11:26:58.835042',9,1),(2,'HI ! , there',0,'2026-06-02 10:12:09.664295',9,2);
/*!40000 ALTER TABLE `messaging_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messaging_messagethread`
--

DROP TABLE IF EXISTS `messaging_messagethread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messaging_messagethread` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `application_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `application_id` (`application_id`),
  CONSTRAINT `messaging_messagethr_application_id_645965ff_fk_applicati` FOREIGN KEY (`application_id`) REFERENCES `applications_jobapplication` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messaging_messagethread`
--

LOCK TABLES `messaging_messagethread` WRITE;
/*!40000 ALTER TABLE `messaging_messagethread` DISABLE KEYS */;
INSERT INTO `messaging_messagethread` VALUES (1,'2026-04-24 11:26:54.555945','2026-04-24 11:26:58.839249',8),(2,'2026-06-02 10:12:00.806288','2026-06-02 10:12:09.676822',9);
/*!40000 ALTER TABLE `messaging_messagethread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_preferences`
--

DROP TABLE IF EXISTS `notification_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_preferences` (
  `preference_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `email_new_jobs` tinyint(1) NOT NULL DEFAULT '1',
  `email_application_updates` tinyint(1) NOT NULL DEFAULT '1',
  `email_admin_alerts` tinyint(1) NOT NULL DEFAULT '1',
  `inapp_new_jobs` tinyint(1) NOT NULL DEFAULT '1',
  `inapp_application_updates` tinyint(1) NOT NULL DEFAULT '1',
  `inapp_messages` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`preference_id`),
  UNIQUE KEY `uq_notification_preferences_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_preferences`
--

LOCK TABLES `notification_preferences` WRITE;
/*!40000 ALTER TABLE `notification_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notification_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `recipient_user_id` bigint unsigned NOT NULL,
  `notification_type` enum('job_posted','application_update','new_match','system_alert','message','admin_alert') COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `related_entity_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_entity_id` bigint unsigned DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `read_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notification_id`),
  KEY `idx_notifications_recipient_read` (`recipient_user_id`,`is_read`),
  KEY `idx_notifications_type` (`notification_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications_notification`
--

DROP TABLE IF EXISTS `notifications_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications_notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `notification_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `read_at` datetime(6) DEFAULT NULL,
  `actor_id` int DEFAULT NULL,
  `recipient_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notification_actor_id_ec6170c3_fk_auth_user_id` (`actor_id`),
  KEY `notifications_notification_recipient_id_d055f3f0_fk_auth_user_id` (`recipient_id`),
  CONSTRAINT `notifications_notification_actor_id_ec6170c3_fk_auth_user_id` FOREIGN KEY (`actor_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `notifications_notification_recipient_id_d055f3f0_fk_auth_user_id` FOREIGN KEY (`recipient_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications_notification`
--

LOCK TABLES `notifications_notification` WRITE;
/*!40000 ALTER TABLE `notifications_notification` DISABLE KEYS */;
INSERT INTO `notifications_notification` VALUES (1,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,2),(2,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,3),(3,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,4),(4,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,5),(5,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,6),(6,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,7),(7,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,8),(8,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,9),(9,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,10),(10,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,11),(11,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,12),(12,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,13),(13,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,16),(14,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,17),(15,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,21),(16,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',0,'2026-04-19 20:40:26.905944',NULL,24,22),(17,'New job posted: Cloud Intern','Nebula Tech posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/11/',1,'2026-04-19 20:40:26.905944','2026-04-19 20:40:27.085638',24,25),(18,'New application received: Cloud Intern','nfy_student applied to your job post.','application_submitted','/job_portal/applications/manage/',0,'2026-04-19 20:40:26.991593',NULL,25,24),(19,'Application submitted: Cloud Intern','Your application has been submitted successfully and is now being reviewed.','application_submitted','/job_portal/applications/',1,'2026-04-19 20:40:26.995607','2026-04-19 20:40:27.084641',25,25),(20,'Application status updated: Cloud Intern','Your application is now marked as Shortlisted.','application_status','/job_portal/applications/',0,'2026-04-19 20:40:27.124959',NULL,24,25),(21,'New job posted: Support Intern','Assist Corp posted a new Internship opportunity in Lahore.','new_job','/job_portal/jobs/12/',0,'2026-04-19 20:40:53.488379',NULL,26,2),(22,'New job posted: Support Intern','Assist Corp posted a new Internship opportunity in Lahore.','new_job','/job_portal/jobs/12/',0,'2026-04-19 20:40:53.488379',NULL,26,3),(23,'New job posted: Support Intern','Assist Corp posted a new Internship opportunity in Lahore.','new_job','/job_portal/jobs/12/',0,'2026-04-19 20:40:53.488379',NULL,26,4),(24,'New job posted: Support Intern','Assist Corp posted a new Internship opportunity in Lahore.','new_job','/job_portal/jobs/12/',0,'2026-04-19 20:40:53.488379',NULL,26,5),(25,'New job posted: Support Intern','Assist Corp posted a new Internship opportunity in Lahore.','new_job','/job_portal/jobs/12/',0,'2026-04-19 20:40:53.488379',NULL,26,7),(26,'New job posted: Support Intern','Assist Corp posted a new Internship opportunity in Lahore.','new_job','/job_portal/jobs/12/',0,'2026-04-19 20:40:53.488379',NULL,26,9),(27,'New job posted: Support Intern','Assist Corp posted a new Internship opportunity in Lahore.','new_job','/job_portal/jobs/12/',0,'2026-04-19 20:40:53.488379',NULL,26,10),(28,'New job posted: Support Intern','Assist Corp posted a new Internship opportunity in Lahore.','new_job','/job_portal/jobs/12/',0,'2026-04-19 20:40:53.488379',NULL,26,12),(29,'New job posted: Support Intern','Assist Corp posted a new Internship opportunity in Lahore.','new_job','/job_portal/jobs/12/',0,'2026-04-19 20:40:53.488379',NULL,26,13),(30,'New job posted: Support Intern','Assist Corp posted a new Internship opportunity in Lahore.','new_job','/job_portal/jobs/12/',0,'2026-04-19 20:40:53.488379',NULL,26,17),(31,'New job posted: Support Intern','Assist Corp posted a new Internship opportunity in Lahore.','new_job','/job_portal/jobs/12/',0,'2026-04-19 20:40:53.488379',NULL,26,22),(32,'New job posted: Support Intern','Assist Corp posted a new Internship opportunity in Lahore.','new_job','/job_portal/jobs/12/',0,'2026-04-19 20:40:53.488379',NULL,26,25),(33,'New job posted: Support Intern','Assist Corp posted a new Internship opportunity in Lahore.','new_job','/job_portal/jobs/12/',0,'2026-04-19 20:40:53.488379',NULL,26,27),(34,'Job submitted for approval','Your job post has been submitted and is waiting for admin approval.','system','/job_portal/jobs/manage/',0,'2026-04-19 20:54:00.630468',NULL,29,29),(35,'Job approved: Admin Moderated Intern','Your job post is approved and now visible to candidates.','system','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.795565',NULL,28,29),(36,'New job posted: Admin Moderated Intern','Phase6 Labs posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.855866',NULL,28,2),(37,'New job posted: Admin Moderated Intern','Phase6 Labs posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.855866',NULL,28,3),(38,'New job posted: Admin Moderated Intern','Phase6 Labs posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.855866',NULL,28,4),(39,'New job posted: Admin Moderated Intern','Phase6 Labs posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.855866',NULL,28,5),(40,'New job posted: Admin Moderated Intern','Phase6 Labs posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.855866',NULL,28,7),(41,'New job posted: Admin Moderated Intern','Phase6 Labs posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.855866',NULL,28,9),(42,'New job posted: Admin Moderated Intern','Phase6 Labs posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.855866',NULL,28,10),(43,'New job posted: Admin Moderated Intern','Phase6 Labs posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.855866',NULL,28,12),(44,'New job posted: Admin Moderated Intern','Phase6 Labs posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.855866',NULL,28,13),(45,'New job posted: Admin Moderated Intern','Phase6 Labs posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.855866',NULL,28,17),(46,'New job posted: Admin Moderated Intern','Phase6 Labs posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.855866',NULL,28,22),(47,'New job posted: Admin Moderated Intern','Phase6 Labs posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.855866',NULL,28,25),(48,'New job posted: Admin Moderated Intern','Phase6 Labs posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.855866',NULL,28,27),(49,'New job posted: Admin Moderated Intern','Phase6 Labs posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.855866',NULL,28,30),(50,'New job posted: Admin Moderated Intern','Phase6 Labs posted a new Internship opportunity in Karachi.','new_job','/job_portal/jobs/13/',0,'2026-04-19 20:54:00.855866',NULL,28,31),(51,'Account access disabled','Your account access was disabled by admin moderation.','system','/job_portal/accounts/login/',0,'2026-04-19 20:54:00.870501',NULL,28,31),(52,'Account approved','Your account is approved. You can now use all portal features.','system','/job_portal/dashboard/',0,'2026-04-19 20:54:00.884188',NULL,28,31),(53,'New application received: Admin Moderated Intern','phase6_student applied to your job post.','application_submitted','/job_portal/applications/manage/',0,'2026-04-19 20:54:00.943513',NULL,30,29),(54,'Application submitted: Admin Moderated Intern','Your application has been submitted successfully and is now being reviewed.','application_submitted','/job_portal/applications/',0,'2026-04-19 20:54:00.948510',NULL,30,30),(55,'Account access disabled','Your account access was disabled by admin moderation.','system','/job_portal/accounts/login/',0,'2026-04-19 20:54:21.868092',NULL,32,33),(56,'Account approved','Your account is approved. You can now use all portal features.','system','/job_portal/dashboard/',0,'2026-04-19 20:54:21.903846',NULL,32,33),(57,'Account approved','Your account is approved. You can now use all portal features.','system','/job_portal/dashboard/',0,'2026-04-19 21:04:28.533939',NULL,1,34),(58,'Account pending review','Your account is now pending admin review.','system','/job_portal/accounts/login/',0,'2026-04-19 21:04:28.580067',NULL,1,34),(59,'Account access disabled','Your account access was disabled by admin moderation.','system','/job_portal/accounts/login/',0,'2026-04-19 21:04:28.594131',NULL,1,34),(60,'Account approved','Your account is approved. You can now use all portal features.','system','/job_portal/dashboard/',0,'2026-04-20 10:32:00.289609',NULL,1,35),(61,'Account approved','Your account is approved by admin. Please verify your email to activate login access.','system','/job_portal/dashboard/',0,'2026-04-20 10:32:58.800520',NULL,1,36),(62,'Job submitted for approval','Your job post has been submitted and is waiting for admin approval.','system','/job_portal/jobs/manage/',0,'2026-04-24 11:21:56.622258',NULL,6,6),(63,'Job approved: front end','Your job post is approved and now visible to candidates.','system','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.329242',NULL,1,6),(64,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,2),(65,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,3),(66,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,4),(67,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,5),(68,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,7),(69,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',1,'2026-04-24 11:24:47.395039','2026-07-11 17:30:18.224798',1,9),(70,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,10),(71,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,12),(72,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,13),(73,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,17),(74,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,22),(75,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,25),(76,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,27),(77,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,30),(78,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,31),(79,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,33),(80,'New job posted: front end','xeven posted a new Full Time opportunity in lahore.','new_job','/job_portal/jobs/14/',0,'2026-04-24 11:24:47.395039',NULL,1,35),(81,'New application received: front end','student 1 applied to your job post.','application_submitted','/job_portal/applications/manage/',0,'2026-04-24 11:26:48.932759',NULL,9,6),(82,'Application submitted: front end','Your application has been submitted successfully and is now being reviewed.','application_submitted','/job_portal/applications/',0,'2026-04-24 11:26:48.939875',NULL,9,9),(83,'New message: front end','student 1 sent you a message about your application conversation.','system','/job_portal/messages/thread/1/',0,'2026-04-24 11:26:58.842253',NULL,9,6),(84,'New application received: Admin Moderated Intern','student 1 applied to your job post.','application_submitted','/job_portal/applications/manage/',0,'2026-06-02 10:11:58.416803',NULL,9,29),(85,'Application submitted: Admin Moderated Intern','Your application has been submitted successfully and is now being reviewed.','application_submitted','/job_portal/applications/',0,'2026-06-02 10:11:58.457707',NULL,9,9),(86,'New message: Admin Moderated Intern','student 1 sent you a message about your application conversation.','system','/job_portal/messages/thread/2/',0,'2026-06-02 10:12:09.687874',NULL,9,29),(87,'Account approved','Your account is approved by admin. Please verify your email to activate login access.','system','/job_portal/dashboard/',0,'2026-07-12 14:52:36.535177',NULL,1,38),(88,'Account approved','Your account is approved by admin. Please verify your email to activate login access.','system','/job_portal/dashboard/',0,'2026-07-12 14:52:42.191241',NULL,1,37),(89,'Account pending review','Your account is now pending admin review.','system','/job_portal/accounts/login/',0,'2026-07-12 14:55:50.265394',NULL,1,38),(90,'Account approved','Your account is approved by admin. Please verify your email to activate login access.','system','/job_portal/dashboard/',0,'2026-07-12 14:55:51.666150',NULL,1,38),(91,'Account access disabled','Your account access was disabled by admin moderation.','system','/job_portal/accounts/login/',0,'2026-07-12 15:10:34.700656',NULL,1,26),(92,'Account access disabled','Your account access was disabled by admin moderation.','system','/job_portal/accounts/login/',0,'2026-07-12 15:10:38.201536',NULL,1,26),(93,'Job submitted for approval','Your job post has been submitted and is waiting for admin approval.','system','/job_portal/jobs/manage/',0,'2026-07-12 15:18:21.017381',NULL,39,39),(94,'Job approved: .NET CORE ASAP DEV','Your job post is approved and now visible to candidates.','system','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.080854',NULL,1,39),(95,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,2),(96,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,3),(97,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,4),(98,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,5),(99,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,7),(100,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,9),(101,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,10),(102,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,12),(103,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,13),(104,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,17),(105,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,22),(106,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,25),(107,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,27),(108,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,30),(109,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,31),(110,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,33),(111,'New job posted: .NET CORE ASAP DEV','Globe Techfy posted a new Part Time opportunity in Gulberg.','new_job','/job_portal/jobs/15/',0,'2026-07-12 15:19:21.157057',NULL,1,35);
/*!40000 ALTER TABLE `notifications_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications_notificationpreference`
--

DROP TABLE IF EXISTS `notifications_notificationpreference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications_notificationpreference` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email_notifications_enabled` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_notifi_user_id_7cfb3d3a_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications_notificationpreference`
--

LOCK TABLES `notifications_notificationpreference` WRITE;
/*!40000 ALTER TABLE `notifications_notificationpreference` DISABLE KEYS */;
INSERT INTO `notifications_notificationpreference` VALUES (1,1,'2026-04-19 20:40:26.640859',24),(2,1,'2026-04-19 20:40:26.644815',25),(3,1,'2026-04-19 20:40:26.774554',2),(4,1,'2026-04-19 20:40:26.796579',3),(5,1,'2026-04-19 20:40:26.803577',4),(6,1,'2026-04-19 20:40:26.808575',5),(7,1,'2026-04-19 20:40:26.814574',6),(8,1,'2026-04-19 20:40:26.821575',7),(9,1,'2026-04-19 20:40:26.828575',8),(10,1,'2026-04-19 20:40:26.836576',9),(11,1,'2026-04-19 20:40:26.842571',10),(12,1,'2026-04-19 20:40:26.848884',11),(13,1,'2026-04-19 20:40:26.859046',12),(14,1,'2026-04-19 20:40:26.868223',13),(15,1,'2026-04-19 20:40:26.874255',16),(16,1,'2026-04-19 20:40:26.882157',17),(17,1,'2026-04-19 20:40:26.891963',21),(18,1,'2026-04-19 20:40:26.896944',22),(19,1,'2026-04-19 20:40:53.480380',27),(20,1,'2026-04-19 20:54:00.799564',29),(21,1,'2026-04-19 20:54:00.844489',30),(22,1,'2026-04-19 20:54:00.850858',31),(23,1,'2026-04-19 20:54:21.868092',33),(24,1,'2026-04-19 21:04:28.533939',34),(25,1,'2026-04-20 10:32:00.304358',35),(26,1,'2026-04-20 10:32:58.802297',36),(27,1,'2026-07-12 14:52:36.554731',38),(28,1,'2026-07-12 14:52:42.195803',37),(29,1,'2026-07-12 15:10:34.707239',26),(30,1,'2026-07-12 15:19:21.085882',39);
/*!40000 ALTER TABLE `notifications_notificationpreference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `token_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `token` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`token_id`),
  UNIQUE KEY `uq_password_reset_token` (`token`),
  KEY `idx_password_reset_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles_resumedocument`
--

DROP TABLE IF EXISTS `profiles_resumedocument`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles_resumedocument` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profiles_resumedocument_user_id_c902ad1a_fk_auth_user_id` (`user_id`),
  CONSTRAINT `profiles_resumedocument_user_id_c902ad1a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles_resumedocument`
--

LOCK TABLES `profiles_resumedocument` WRITE;
/*!40000 ALTER TABLE `profiles_resumedocument` DISABLE KEYS */;
INSERT INTO `profiles_resumedocument` VALUES (1,'resumes/resume.pdf',1,'2026-04-19 11:29:40.046235',10),(2,'resumes/resume_M8oAyJ7.pdf',1,'2026-04-19 15:17:47.595248',12),(4,'resumes/resume_6W1ZHo3.pdf',1,'2026-04-19 15:20:42.639069',17),(6,'resumes/resume_6YQY0qL.pdf',1,'2026-04-19 15:32:11.812642',22),(7,'resumes/resume_diyeB8p.pdf',1,'2026-04-19 20:40:26.625985',25),(8,'resumes/resume_ajtKmc5.pdf',1,'2026-04-19 20:40:53.352830',27),(9,'resumes/resume_gK8UwLx.pdf',1,'2026-04-19 20:54:00.567286',30),(10,'resumes/waste_managment_prototype_question.pdf',1,'2026-04-24 11:26:38.974115',9);
/*!40000 ALTER TABLE `profiles_resumedocument` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles_userprofile`
--

DROP TABLE IF EXISTS `profiles_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles_userprofile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `education_summary` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `skills_text` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `experience_summary` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `visibility` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `profiles_userprofile_user_id_616bed88_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles_userprofile`
--

LOCK TABLES `profiles_userprofile` WRITE;
/*!40000 ALTER TABLE `profiles_userprofile` DISABLE KEYS */;
INSERT INTO `profiles_userprofile` VALUES (1,'','','','','','private','2026-04-19 11:29:39.981483',10),(2,'','','','','','private','2026-04-19 15:11:37.232008',9),(4,'','Karachi','','python,django,sql','6 month internship','public','2026-04-19 15:32:11.796825',22),(5,'','','','','','private','2026-07-11 17:15:35.595809',4);
/*!40000 ALTER TABLE `profiles_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports_adminactionlog`
--

DROP TABLE IF EXISTS `reports_adminactionlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports_adminactionlog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `admin_user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reports_adminactionlog_admin_user_id_22cda749_fk_auth_user_id` (`admin_user_id`),
  CONSTRAINT `reports_adminactionlog_admin_user_id_22cda749_fk_auth_user_id` FOREIGN KEY (`admin_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports_adminactionlog`
--

LOCK TABLES `reports_adminactionlog` WRITE;
/*!40000 ALTER TABLE `reports_adminactionlog` DISABLE KEYS */;
INSERT INTO `reports_adminactionlog` VALUES (1,'job_approved','JobPost','14','Approved job: front end','2026-04-24 11:24:47.400012',1),(2,'user_approved','User','38','Approved user: alumni','2026-07-12 14:52:36.559953',1),(3,'user_approved','User','37','Approved user: S3','2026-07-12 14:52:42.199340',1),(4,'user_pending','User','38','Set user pending: alumni','2026-07-12 14:55:50.272452',1),(5,'user_approved','User','38','Approved user: alumni','2026-07-12 14:55:51.672668',1),(6,'user_rejected','User','26','Rejected user: nfy2_alumni','2026-07-12 15:10:34.720753',1),(7,'user_rejected','User','26','Rejected user: nfy2_alumni','2026-07-12 15:10:38.212574',1),(8,'job_approved','JobPost','15','Approved job: .NET CORE ASAP DEV','2026-07-12 15:19:21.162092',1);
/*!40000 ALTER TABLE `reports_adminactionlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports_databasebackup`
--

DROP TABLE IF EXISTS `reports_databasebackup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports_databasebackup` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size_bytes` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `created_by_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename` (`filename`),
  KEY `reports_databasebackup_created_by_id_1be00d55_fk_auth_user_id` (`created_by_id`),
  CONSTRAINT `reports_databasebackup_created_by_id_1be00d55_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports_databasebackup`
--

LOCK TABLES `reports_databasebackup` WRITE;
/*!40000 ALTER TABLE `reports_databasebackup` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports_databasebackup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports_feedbackticket`
--

DROP TABLE IF EXISTS `reports_feedbackticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports_feedbackticket` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `subject` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_notes` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reports_feedbackticket_user_id_245d0fe9_fk_auth_user_id` (`user_id`),
  CONSTRAINT `reports_feedbackticket_user_id_245d0fe9_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports_feedbackticket`
--

LOCK TABLES `reports_feedbackticket` WRITE;
/*!40000 ALTER TABLE `reports_feedbackticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports_feedbackticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports_generated`
--

DROP TABLE IF EXISTS `reports_generated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports_generated` (
  `report_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `generated_by_user_id` bigint unsigned DEFAULT NULL,
  `report_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `report_format` enum('csv','pdf') COLLATE utf8mb4_unicode_ci NOT NULL,
  `filters_json` json DEFAULT NULL,
  `file_path` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`report_id`),
  KEY `idx_reports_generated_by` (`generated_by_user_id`),
  KEY `idx_reports_format` (`report_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports_generated`
--

LOCK TABLES `reports_generated` WRITE;
/*!40000 ALTER TABLE `reports_generated` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports_generated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resume_documents`
--

DROP TABLE IF EXISTS `resume_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resume_documents` (
  `resume_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'application/pdf',
  `file_size_kb` int unsigned DEFAULT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `uploaded_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`resume_id`),
  KEY `idx_resume_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resume_documents`
--

LOCK TABLES `resume_documents` WRITE;
/*!40000 ALTER TABLE `resume_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `resume_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `uq_roles_role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'student','Current student user','2026-04-18 23:14:49'),(2,'alumni','Alumni user','2026-04-18 23:14:49'),(3,'employer','Employer or recruiter user','2026-04-18 23:14:49'),(4,'admin','System administrator','2026-04-18 23:14:49');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills`
--

DROP TABLE IF EXISTS `skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills` (
  `skill_id` int unsigned NOT NULL AUTO_INCREMENT,
  `skill_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `skill_category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`skill_id`),
  UNIQUE KEY `uq_skills_skill_name` (`skill_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills`
--

LOCK TABLES `skills` WRITE;
/*!40000 ALTER TABLE `skills` DISABLE KEYS */;
/*!40000 ALTER TABLE `skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_activity_logs`
--

DROP TABLE IF EXISTS `user_activity_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_activity_logs` (
  `activity_log_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `activity_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activity_description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`activity_log_id`),
  KEY `idx_activity_user_id` (`user_id`),
  KEY `idx_activity_type` (`activity_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_activity_logs`
--

LOCK TABLES `user_activity_logs` WRITE;
/*!40000 ALTER TABLE `user_activity_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_activity_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profiles`
--

DROP TABLE IF EXISTS `user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profiles` (
  `profile_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `headline` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `about_me` text COLLATE utf8mb4_unicode_ci,
  `contact_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_phone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linkedin_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `github_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `portfolio_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `graduation_year` smallint unsigned DEFAULT NULL,
  `department` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_company` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_position` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_experience_years` decimal(4,1) DEFAULT NULL,
  `visibility` enum('public','private') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'public',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `uq_user_profiles_user_id` (`user_id`),
  KEY `idx_user_profiles_visibility` (`visibility`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profiles`
--

LOCK TABLES `user_profiles` WRITE;
/*!40000 ALTER TABLE `user_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_skills`
--

DROP TABLE IF EXISTS `user_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_skills` (
  `user_skill_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `skill_level` enum('beginner','intermediate','advanced') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'beginner',
  `years_of_experience` decimal(4,1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_skill_id`),
  UNIQUE KEY `uq_user_skill` (`user_id`,`skill_id`),
  KEY `idx_user_skills_skill_id` (`skill_id`),
  CONSTRAINT `fk_user_skills_skill` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`skill_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_skills`
--

LOCK TABLES `user_skills` WRITE;
/*!40000 ALTER TABLE `user_skills` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_skills` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-12 21:05:43
