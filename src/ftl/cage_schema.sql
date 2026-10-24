-- MySQL dump 10.13  Distrib 5.7.32, for Linux (x86_64)
--
-- Host: localhost    Database: gtrd_current
-- ------------------------------------------------------
-- Server version	5.7.32-0ubuntu0.18.04.1

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
-- Table structure for table `cage_enhancers`
--

DROP TABLE IF EXISTS `cage_enhancers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cage_enhancers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `chrom` varchar(10) DEFAULT NULL,
  `start` int(10) unsigned NOT NULL,
  `end` int(10) unsigned NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `name` mediumtext,
  PRIMARY KEY (`id`),
  KEY `name` (`name`(10))
) ENGINE=MyISAM AUTO_INCREMENT=116199 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cage_enhancers2genes`
--

DROP TABLE IF EXISTS `cage_enhancers2genes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cage_enhancers2genes` (
  `enhancer_id` int(10) unsigned NOT NULL,
  `ensembl_gene_id` varchar(20) DEFAULT NULL,
  `type` enum('corr','prox') DEFAULT NULL,
  `corr` float DEFAULT NULL,
  `padj` float DEFAULT NULL,
  KEY `enhancer_id` (`enhancer_id`),
  KEY `ensembl_gene_id` (`ensembl_gene_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cage_experiments`
--

DROP TABLE IF EXISTS `cage_experiments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cage_experiments` (
  `id` varchar(10) NOT NULL,
  `treatment` text,
  `cell_id` int(100) DEFAULT NULL,
  `species` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `species` (`species`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cage_expr_table_edl`
--

DROP TABLE IF EXISTS `cage_expr_table_edl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cage_expr_table_edl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CEXP000001` float DEFAULT NULL,
  `CEXP000002` float DEFAULT NULL,
  `CEXP000003` float DEFAULT NULL,
  `CEXP000005` float DEFAULT NULL,
  `CEXP000006` float DEFAULT NULL,
  `CEXP000004` float DEFAULT NULL,
  `CEXP000009` float DEFAULT NULL,
  `CEXP000008` float DEFAULT NULL,
  `CEXP000007` float DEFAULT NULL,
  `CEXP000010` float DEFAULT NULL,
  `CEXP000011` float DEFAULT NULL,
  `CEXP000012` float DEFAULT NULL,
  `CEXP000014` float DEFAULT NULL,
  `CEXP000015` float DEFAULT NULL,
  `CEXP000013` float DEFAULT NULL,
  `CEXP000017` float DEFAULT NULL,
  `CEXP000018` float DEFAULT NULL,
  `CEXP000016` float DEFAULT NULL,
  `CEXP000019` float DEFAULT NULL,
  `CEXP000020` float DEFAULT NULL,
  `CEXP000021` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=424586 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cage_expr_table_sol`
--

DROP TABLE IF EXISTS `cage_expr_table_sol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cage_expr_table_sol` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CEXP000022` float DEFAULT NULL,
  `CEXP000023` float DEFAULT NULL,
  `CEXP000024` float DEFAULT NULL,
  `CEXP000025` float DEFAULT NULL,
  `CEXP000026` float DEFAULT NULL,
  `CEXP000027` float DEFAULT NULL,
  `CEXP000029` float DEFAULT NULL,
  `CEXP000030` float DEFAULT NULL,
  `CEXP000028` float DEFAULT NULL,
  `CEXP000031` float DEFAULT NULL,
  `CEXP000032` float DEFAULT NULL,
  `CEXP000033` float DEFAULT NULL,
  `CEXP000035` float DEFAULT NULL,
  `CEXP000036` float DEFAULT NULL,
  `CEXP000034` float DEFAULT NULL,
  `CEXP000039` float DEFAULT NULL,
  `CEXP000037` float DEFAULT NULL,
  `CEXP000038` float DEFAULT NULL,
  `CEXP000040` float DEFAULT NULL,
  `CEXP000041` float DEFAULT NULL,
  `CEXP000042` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=595461 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cage_peaks`
--

DROP TABLE IF EXISTS `cage_peaks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cage_peaks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `chrom` varchar(10) DEFAULT NULL,
  `start` int(10) unsigned NOT NULL,
  `end` int(10) unsigned NOT NULL,
  `strand` char(1) DEFAULT NULL,
  `abs_summit` int(10) unsigned DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `name` mediumtext,
  `organism` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`(10))
) ENGINE=MyISAM AUTO_INCREMENT=2663543 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cage_peaks_annot`
--

DROP TABLE IF EXISTS `cage_peaks_annot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cage_peaks_annot` (
  `peak_id` int(10) unsigned NOT NULL,
  `name` varchar(30) NOT NULL,
  `val` mediumtext
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cage_peaks_expression`
--

DROP TABLE IF EXISTS `cage_peaks_expression`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cage_peaks_expression` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `peak_id` int(10) unsigned NOT NULL,
  `exp_id` varchar(10) DEFAULT NULL,
  `value` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `peak_id` (`peak_id`),
  KEY `exp_id` (`exp_id`)
) ENGINE=MyISAM AUTO_INCREMENT=257333690 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-19 14:29:48
