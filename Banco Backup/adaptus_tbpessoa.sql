-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: adaptus
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `tbpessoa`
--

DROP TABLE IF EXISTS `tbpessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbpessoa` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `Nome_razao_social` varchar(180) DEFAULT NULL,
  `Nome_fantasia` varchar(180) DEFAULT NULL,
  `CNPJ_CPF` varchar(14) DEFAULT NULL,
  `inscricao_estadual` varchar(13) DEFAULT NULL,
  `dt_nascimento` datetime DEFAULT NULL,
  `CEP` char(8) DEFAULT NULL,
  `Logradouro` varchar(180) DEFAULT NULL,
  `Bairro` varchar(180) DEFAULT NULL,
  `Cidade` varchar(180) DEFAULT NULL,
  `UF` char(2) DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `complemento` varchar(180) DEFAULT NULL,
  `telefone` char(10) DEFAULT NULL,
  `celular` char(11) DEFAULT NULL,
  `email` varchar(180) DEFAULT NULL,
  `flag_pessoa` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbpessoa`
--

LOCK TABLES `tbpessoa` WRITE;
/*!40000 ALTER TABLE `tbpessoa` DISABLE KEYS */;
INSERT INTO `tbpessoa` VALUES (1,'Luis Felipe de Oliveira Franco',NULL,'11748894625',NULL,'1994-04-14 00:00:00','38414505','Avenida Américo Attiê','Mansour','Uberlândia','MG',121,'bloco 14 apto 203','3432346687','34996335196','luisfelipeo.f@hotmail.com','F'),(2,'Adaptus','adaptus','99999999999999',NULL,'2020-08-31 00:00:00','38414505','Avenida Américo Attiê','Mansour','Uberlândia','MG',121,NULL,'9999999999','99999999999','adaptus@gmail.com','J');
/*!40000 ALTER TABLE `tbpessoa` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-25  7:59:50
