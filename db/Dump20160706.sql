CREATE DATABASE  IF NOT EXISTS `forum_db` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `forum_db`;
-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: forum_db
-- ------------------------------------------------------
-- Server version	5.6.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` varchar(20) NOT NULL DEFAULT '',
  `value` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES ('postsPageSize','15'),('rootPassword','root'),('threadsPageSize','20');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum`
--

DROP TABLE IF EXISTS `forum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL DEFAULT '',
  `description` varchar(500) DEFAULT '',
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `position` int(10) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `topic_count` int(11) NOT NULL DEFAULT '0',
  `post_count` int(11) NOT NULL DEFAULT '0',
  `total_post_count` int(11) NOT NULL DEFAULT '0',
  `total_topic_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `forum_forum_id_fk` (`parent_id`),
  CONSTRAINT `forum_forum_id_fk` FOREIGN KEY (`parent_id`) REFERENCES `forum` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum`
--

LOCK TABLES `forum` WRITE;
/*!40000 ALTER TABLE `forum` DISABLE KEYS */;
INSERT INTO `forum` VALUES (0,'ROOT','ROOT',0,'2015-07-01 20:29:53',0,0,0,0,0,0),(1,'hardver','neki forum, bem li ga',0,'2015-05-20 16:25:50',1,0,-1,0,0,0),(2,'softver','forum o nekim tamo programimam',0,'2015-05-20 16:26:14',2,0,0,0,0,0),(3,'procesori','ona sokoćala što obrađuju neke instrukcije',1,'2015-05-20 16:28:41',3,0,23,78,78,24),(4,'monitori','za sve gledaoce na malim ekranima, velkim flet ekranima',1,'2015-05-20 16:29:35',1,0,3,24,24,3),(5,'operativni sistemi','ajksdfhak hdaks hdaksjdh ',2,'2015-05-20 16:29:50',1,0,3,19,19,3),(6,'aplikativni softver','adashdaj jaksdh kashdk ha',2,'2015-05-20 16:30:02',0,0,2,10,10,2),(7,'Grafičke karte',NULL,1,'2015-07-28 18:02:16',2,0,1,1,1,1),(9,'Opušteno',NULL,0,'2015-07-29 08:50:56',3,0,0,0,0,0),(11,'Brobljaonica',NULL,9,'2015-07-29 08:58:51',0,0,0,0,0,0),(12,'otpad',NULL,9,'2015-09-26 19:44:10',1,0,0,0,0,0),(13,'to sunce ti',NULL,1,'2016-06-26 14:13:43',0,0,0,0,0,0);
/*!40000 ALTER TABLE `forum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_code_uindex` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'admin_operations','Admin operations'),(2,'forum_create','Create forum'),(3,'forum_delete','Delete forum'),(4,'forum_edit','Edit forum'),(5,'post_create','Create posts'),(6,'post_delete_own','Delete own posts'),(7,'post_delete_any','Delete any post'),(8,'post_edit_own','Edit own posts'),(9,'post_edit_any','Edit any post'),(10,'post_move','Move posts'),(11,'post_revive_own','Revive own posts'),(12,'post_revive_any','Revive any post'),(13,'post_see_deleted_own','See own deleted posts'),(14,'post_see_deleted_any','See any deleted posts'),(15,'role_change_permissions','Edit role permissions'),(16,'thread_create','Create thread'),(17,'thread_delete','Delete thread'),(18,'thread_edit','Edit thread'),(19,'thread_lock','Lock thread'),(20,'thread_move','Move threda'),(21,'thread_see_deleted','See deleted threads');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(11) unsigned NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `topic_id` bigint(11) unsigned NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `topic_id` (`topic_id`),
  KEY `post_user` (`user_id`),
  CONSTRAINT `post_topic` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`),
  CONSTRAINT `post_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (3,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',3,'2015-05-23 13:17:56',0),(4,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',4,'2015-05-23 13:18:14',0),(5,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',3,'2015-05-23 13:23:00',0),(6,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',4,'2015-05-23 13:23:00',0),(7,3,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',5,'2015-05-23 13:23:00',0),(8,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',6,'2015-05-23 13:23:00',0),(9,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',7,'2015-05-23 13:23:00',0),(10,3,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',8,'2015-05-23 13:23:00',0),(11,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',9,'2015-05-23 13:23:00',0),(12,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',10,'2015-05-23 13:23:00',0),(13,3,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',11,'2015-05-23 13:23:00',0),(14,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',12,'2015-05-23 13:23:00',0),(15,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',13,'2015-05-23 13:23:00',0),(16,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',3,'2015-05-23 13:23:00',0),(17,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',4,'2015-05-23 13:23:00',0),(18,3,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',5,'2015-05-23 13:23:00',0),(19,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',6,'2015-05-23 13:23:00',0),(20,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',7,'2015-05-23 13:23:00',0),(21,3,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',8,'2015-05-23 13:23:00',0),(22,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',9,'2015-05-23 13:23:00',0),(23,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',10,'2015-05-23 13:23:00',0),(24,3,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',11,'2015-05-23 13:23:00',0),(25,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',12,'2015-05-23 13:23:00',0),(26,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',13,'2015-05-23 13:23:00',0),(27,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',3,'2015-05-23 13:23:00',0),(28,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',4,'2015-05-23 13:23:00',0),(29,3,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',5,'2015-05-23 13:23:00',0),(30,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',6,'2015-05-23 13:23:00',0),(31,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',7,'2015-05-23 13:23:00',0),(32,3,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',8,'2015-05-23 13:23:00',0),(33,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',9,'2015-05-23 13:23:00',0),(34,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',10,'2015-05-23 13:23:00',0),(35,3,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',11,'2015-05-23 13:23:00',0),(36,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',12,'2015-05-23 13:23:00',0),(37,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',13,'2015-05-23 13:23:00',0),(38,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',3,'2015-05-23 13:23:00',0),(39,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',4,'2015-05-23 13:23:00',0),(40,3,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',5,'2015-05-23 13:23:00',0),(41,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',6,'2015-05-23 13:23:00',0),(42,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',7,'2015-05-23 13:23:00',0),(43,3,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',8,'2015-05-23 13:23:00',0),(44,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',9,'2015-05-23 13:23:00',0),(45,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',10,'2015-05-23 13:23:00',0),(46,3,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',11,'2015-05-23 13:23:00',0),(47,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',12,'2015-05-23 13:23:00',0),(48,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',13,'2015-05-23 13:23:00',0),(49,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',3,'2015-05-23 13:23:00',0),(50,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',4,'2015-05-23 13:23:00',0),(51,3,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',5,'2015-05-23 13:23:00',0),(52,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',6,'2015-05-23 13:23:00',0),(53,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',7,'2015-05-23 13:23:00',0),(54,3,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',8,'2015-05-23 13:23:00',0),(55,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',9,'2015-05-23 13:23:00',0),(56,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',10,'2015-05-23 13:23:00',0),(57,3,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',11,'2015-05-23 13:23:00',0),(58,1,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',12,'2015-05-23 13:23:00',0),(59,2,' asdkjfads jadjs asdf asdf hadksfh aksd haksdfh kasdhfkasdjfh dkls\nasd fjhasdkfh kladsfh lkadshf kladhsfkladhsf klasdhf klahsdfkl hasdfklj h\nasdjk fhasdk adksfh aksdjhf kasdhfk asdhfk jahsdklfh ladksfh lkadjshfh ',13,'2015-05-23 13:23:00',0),(60,1,'sdfasdfasdfasd asd fsadf adsf ',11,'2015-05-23 15:04:48',0),(61,1,'sdfadsfas asfd asdf asdf asdfasdf ',12,'2015-05-23 15:19:20',0),(62,1,'cfÅ¡Å¾sdp asdafkp4 0a9Å¡WFJRU4RF0U',12,'2015-05-23 15:21:18',0),(63,3,' asdf09u ads78fy asdfy as78ddfsy8 ',12,'2015-05-23 15:21:50',0),(64,1,'asdasdjgasjd ajsdg jahgsdfjahs dgfj akhdsgfjkhasadghsjfghjk asdgf j',9,'2015-05-23 17:27:17',0),(65,3,'dsfa sdfa sdfa sdf ',9,'2015-05-23 17:27:34',0),(66,7,'test post',8,'2015-05-24 16:06:20',0),(67,3,'akdhjf aksf dhlksadjhf lajksdfh asl',7,'2015-05-30 10:43:22',0),(68,8,'sa ćee čika admin da vas nauči pameti',4,'2015-07-26 16:54:06',0),(69,8,'da probamo joÅ¡ jednom',4,'2015-07-26 16:57:07',0),(70,8,'ÄÅ¡ÄÅ¾ÄÄÅ¾Å¡Å¾ÄÄ',4,'2015-07-26 17:01:30',0),(71,8,'ÄÅ¡ÄÅ¾ÄÄÄÅ¡ÄÅ¾ÄÄÅ¡Ä',4,'2015-07-26 17:04:40',0),(72,8,'sadfsadfl asdfasÄd asdflasdfÄlasÄfasÅ¡dfÅ¡Å¡Äc aÄÅ¡sdlÅ¾',7,'2015-07-27 09:53:38',0),(73,8,'aj joÅ¡ jednom',7,'2015-07-27 11:35:36',0),(74,8,'aj joÅ¡ jednom',7,'2015-07-27 11:36:59',0),(75,8,'ÄÅ¡ÄÄÅ¡lp',7,'2015-07-27 11:41:17',0),(76,8,'asdfashdfk asdf Å¡asdf asdf ÄasdfÄ ',7,'2015-07-27 12:15:33',0),(77,8,'adskfhadsf asÅ¡dfpl asdpof Å¡sadÅ¡pfoasÅ¡dp',5,'2015-07-27 16:00:38',0),(78,8,'sadf šsadf časđšdfč sadfč ',5,'2015-07-27 16:02:56',0),(79,8,'Intel je najbolji, nema rasprave, pišite vaše hvalospeve u ovoj temi.',14,'2015-07-31 10:16:33',0),(80,8,'bla bla bla lba asjkd aksdf lkjasdlf kjahsdkjfh laskjhf ',3,'2015-07-31 11:24:43',0),(81,8,'hs jsf asdhf kasdhflkasdjhfk asdjhf aksjdf ',14,'2015-07-31 11:25:23',0),(82,8,'aj još jedan post za test',3,'2015-08-01 07:15:35',0),(83,8,'Ma intel je najbolje i lockujem temu.',14,'2015-08-01 09:58:14',0),(84,8,'još jedan za probu',14,'2015-08-01 21:31:18',0),(85,8,'aj jopet',14,'2015-08-01 21:39:33',0),(86,8,'ajmo opet sa lekcijama',14,'2015-08-01 22:37:07',0),(87,8,'Dakle krucijalno pitanje. Dali je bolja nVidia ili ATI i zašto je nVidia. bla bla',15,'2015-08-03 12:03:08',0),(88,8,'sadf asdf asdf asdf asdf asdf sf ',16,'2015-08-09 07:20:40',0),(89,8,'sg dfgsdfg dsfg ',14,'2015-08-16 11:42:58',0),(90,8,'dsfg dsfg sdfg erth 4h 4h rth dfg ',14,'2015-08-16 11:43:01',0),(91,8,'h fgh dfgh fgb dfgb dfgb dfgb dfg dfgh',14,'2015-08-16 11:43:02',0),(92,8,'fdg hdfgh dfgh dfghdfghb dfgh sfghdh fghs fgh ',14,'2015-08-16 11:43:02',0),(93,8,'sf gh fgh rth bfgb fgb srtbs bg sfgbs dfgb ',14,'2015-08-16 11:43:03',0),(94,8,'s gbtbrtb gfb sfgb sfgb rtb fsgbsdb ',14,'2015-08-16 11:43:04',0),(95,8,'efrgergdfg dsfg sdfg dshrwtb rwtb wtgwe rg ewrfgew r',14,'2015-08-16 11:43:38',0),(96,8,'efrgergdfg dsfg sdfg dshrwtb rwtb wtgwe rg ewrfgew r',14,'2015-08-16 11:43:39',0),(97,8,'efrgergdfg dsfg sdfg dshrwtb rwtb wtgwe rg ewrfgew r',14,'2015-08-16 11:43:39',0),(98,8,'efrgergdfg dsfg sdfg dshrwtb rwtb wtgwe rg ewrfgew r',14,'2015-08-16 11:43:40',0),(99,8,'efrgergdfg dsfg sdfg dshrwtb rwtb wtgwe rg ewrfgew r',14,'2015-08-16 11:43:41',0),(100,8,'efrgergdfg dsfg sdfg dshrwtb rwtb wtgwe rg ewrfgew r',14,'2015-08-16 11:43:51',0),(101,8,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',14,'2015-08-16 13:41:29',0),(102,8,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',14,'2015-08-16 13:41:30',0),(103,8,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',14,'2015-08-16 13:41:30',0),(104,8,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',14,'2015-08-16 13:41:31',0),(105,8,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',14,'2015-08-16 13:41:31',0),(106,8,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',14,'2015-08-16 13:41:32',0),(107,8,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',14,'2015-08-16 13:41:32',0),(108,8,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',14,'2015-08-16 13:41:33',0),(109,8,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',14,'2015-08-16 13:42:01',0),(110,8,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',14,'2015-08-16 13:42:02',0),(111,8,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',14,'2015-08-16 13:42:02',0),(112,8,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',14,'2015-08-16 13:42:03',0),(113,8,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',14,'2015-08-16 13:42:03',0),(114,8,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',14,'2015-08-16 13:42:04',0),(115,8,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',14,'2015-08-16 13:42:05',0),(118,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',17,'2015-08-16 14:09:54',0),(119,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',18,'2015-08-16 14:10:00',0),(120,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',19,'2015-08-16 14:10:14',0),(121,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',20,'2015-08-16 14:10:15',0),(122,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',21,'2015-08-16 14:10:15',0),(123,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',22,'2015-08-16 14:10:16',0),(124,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',23,'2015-08-16 14:10:16',0),(125,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',24,'2015-08-16 14:10:17',0),(126,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',25,'2015-08-16 14:10:17',0),(127,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',26,'2015-08-16 14:10:18',0),(128,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',27,'2015-08-16 14:10:18',0),(129,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',28,'2015-08-16 14:10:19',0),(130,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',29,'2015-08-16 14:10:19',0),(131,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',30,'2015-08-16 14:10:20',0),(132,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv 			',31,'2015-08-16 14:10:20',0),(133,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',32,'2015-08-16 14:10:20',0),(134,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',33,'2015-08-16 14:10:21',0),(135,2,'sdf asf wefiueryfg9 q384fh 98wdhvn3g9vy24f8yivn dsfhv iashdv 9e8rv p9q348f djfvi efhvihq3p4fq3hfo erhoeyfv iq3fy4fy eirchv ',34,'2015-08-16 14:10:22',0),(136,7,'5ethy hdfgsdf sdfg ',0,'2015-08-20 21:05:35',0),(137,8,'r edg df gsdgh dao fgdslfkgjčdslkfgdskfghjwg aešor',23,'2015-09-26 19:45:23',0);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `code` varchar(50) NOT NULL,
  `show_admin_tools` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_code_index` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Admin','admin',1),(2,'Moderator','mod',1),(3,'Noob','noob',0);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_permission` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_permission_id_uindex` (`id`),
  KEY `role_permission_role_id_fk` (`role_id`),
  KEY `permissions_id_fk` (`permission_id`),
  CONSTRAINT `permissions_id_fk` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  CONSTRAINT `role_permission_role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES (1,3,3),(1,4,4),(1,5,5),(1,6,6),(1,7,7),(1,8,8),(1,9,9),(1,10,10),(1,11,11),(1,12,12),(1,13,13),(1,14,14),(1,15,15),(1,17,17),(1,18,18),(1,19,19),(1,20,20),(1,21,21),(2,5,23),(2,6,24),(2,7,25),(2,8,26),(2,9,27),(2,10,28),(2,11,29),(2,12,30),(2,13,31),(2,14,32),(2,16,33),(2,17,34),(2,18,35),(2,19,36),(2,20,37),(2,21,38),(3,5,39),(3,16,40),(1,1,42),(1,2,43),(1,16,44);
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic`
--

DROP TABLE IF EXISTS `topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `forum_id` bigint(11) unsigned NOT NULL,
  `pinned` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `post_count` int(11) NOT NULL DEFAULT '0',
  `total_post_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `topic_forum` (`forum_id`),
  CONSTRAINT `topic_forum` FOREIGN KEY (`forum_id`) REFERENCES `forum` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
INSERT INTO `topic` VALUES (0,'nulta tema',3,0,0,0,1,1),(3,'Test 1',3,0,1,0,8,8),(4,'Test 2',4,0,0,0,10,10),(5,'Windows',5,0,0,0,7,7),(6,'Test 4',6,0,0,0,5,5),(7,'Test 5',3,0,0,0,11,11),(8,'Test 6',4,0,0,0,6,6),(9,'Linux',5,0,0,0,7,7),(10,'Test 8',6,0,0,0,5,5),(11,'Test 9',3,0,0,0,6,6),(12,'Test 10',4,0,0,0,8,8),(13,'Mac OS X',5,0,0,0,5,5),(14,'Zašto je Intel najbolji',3,0,0,1,33,33),(15,'nVidia ili ATI i zašto nVidia',7,0,0,0,1,1),(16,'joasd asš jedna',3,0,0,0,1,1),(17,'procesori tema 1',3,0,0,0,1,1),(18,'procesori tema 2',3,0,0,0,1,1),(19,'procesori tema 3',3,0,0,0,1,1),(20,'procesori tema 4',3,0,0,0,1,1),(21,'procesori tema 5',3,0,0,0,1,1),(22,'procesori tema 6',3,0,0,0,1,1),(23,'procesori tema 7',3,0,0,0,2,2),(24,'procesori tema 8',3,0,0,0,1,1),(25,'procesori tema 9',3,0,0,0,1,1),(26,'procesori tema 10',3,0,0,0,1,1),(27,'procesori tema 11',3,0,0,0,1,1),(28,'procesori tema 12',3,0,0,0,1,1),(29,'procesori tema 13',3,0,0,0,1,1),(30,'procesori tema 14',3,0,0,0,1,1),(31,'procesori tema 15',3,0,0,0,1,1),(32,'procesori tema 16',3,0,0,0,1,1),(33,'procesori tema 17',3,0,0,0,1,1),(34,'procesori tema 18',3,0,0,0,1,1);
/*!40000 ALTER TABLE `topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(50) NOT NULL DEFAULT '',
  `role_id` bigint(20) NOT NULL,
  `join_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_of_birth` timestamp NULL DEFAULT NULL,
  `post_count` int(11) NOT NULL DEFAULT '0',
  `deleted_post_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `user_role` (`role_id`),
  CONSTRAINT `user_role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (0,'nulti user','bla',3,'2015-08-16 14:09:19','1999-12-31 23:00:00',0,0),(1,'th','th',3,'2015-07-01 20:27:31','2000-01-01 23:00:00',19,0),(2,'einstein','emc2',3,'2015-05-24 15:56:41','1989-12-31 23:00:00',39,0),(3,'papak','rog',3,'2015-05-24 15:56:41',NULL,18,0),(7,'irpbc','bla',2,'2015-05-24 16:01:12',NULL,2,0),(8,'admin','admin',1,'2015-06-30 05:51:06','1987-12-31 23:00:00',47,0),(9,'test','test',3,'2015-09-26 15:25:37',NULL,0,0),(10,'test2','test2',3,'2015-09-27 14:05:37',NULL,0,0),(11,'test3','test3',3,'2016-07-04 20:19:18',NULL,0,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-07-06 20:14:54
