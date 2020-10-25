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
-- Table structure for table `tbmodulo`
--

DROP TABLE IF EXISTS `tbmodulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbmodulo` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `descr_modulo` varchar(180) DEFAULT NULL,
  `caminho` varchar(180) DEFAULT NULL,
  `id_grupo_usuario_fk` int(11) DEFAULT NULL,
  `id_secao_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_grupo_usuario` (`id_grupo_usuario_fk`),
  KEY `fk_secao` (`id_secao_fk`),
  CONSTRAINT `fk_grupo_usuario` FOREIGN KEY (`id_grupo_usuario_fk`) REFERENCES `tbgrupo_usuario` (`id`),
  CONSTRAINT `fk_secao` FOREIGN KEY (`id_secao_fk`) REFERENCES `tbsecao` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbmodulo`
--

LOCK TABLES `tbmodulo` WRITE;
/*!40000 ALTER TABLE `tbmodulo` DISABLE KEYS */;
INSERT INTO `tbmodulo` VALUES (1,'Pessoa','~/Paginas/CadPessoa.aspx',1,1),(2,'Seção','~/Paginas/CadSecao.aspx',1,2),(3,'Usuário','~/Paginas/CadUsuario.aspx',1,2),(4,'Grupo Usuário','~/Paginas/CadGrupoUser.aspx',1,2),(5,'Módulos','~/Paginas/CadModulos.aspx',1,2),(6,'Parâmetro','~/Paginas/CadParametro.aspx',1,2);
/*!40000 ALTER TABLE `tbmodulo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-25  7:59:49
