-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bd_nanas
-- ------------------------------------------------------
-- Server version	9.5.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '7644eef9-cb4b-11f0-9833-00ff08df17aa:1-1052';

--
-- Table structure for table `nanas`
--

DROP TABLE IF EXISTS `nanas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nanas` (
  `id_nana` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_universidad` int NOT NULL,
  `codigo_universitario` varchar(255) NOT NULL,
  `carrera` varchar(255) NOT NULL,
  `ciclo` int NOT NULL,
  `descripcion` tinytext,
  `experiencia` tinytext,
  `tarifa_hora` decimal(38,2) NOT NULL,
  `disponibilidad` varchar(255) DEFAULT NULL,
  `verificado` tinyint(1) DEFAULT '0',
  `rating_promedio` decimal(38,2) DEFAULT NULL,
  `cantidad_reviews` int DEFAULT '0',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_nana`),
  UNIQUE KEY `id_usuario` (`id_usuario`),
  KEY `id_universidad` (`id_universidad`),
  KEY `idx_nanas_rating` (`rating_promedio`),
  CONSTRAINT `nanas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `nanas_ibfk_2` FOREIGN KEY (`id_universidad`) REFERENCES `universidades` (`id_universidad`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nanas`
--

LOCK TABLES `nanas` WRITE;
/*!40000 ALTER TABLE `nanas` DISABLE KEYS */;
INSERT INTO `nanas` VALUES (6,6,1,'u23257527','Ingenierpia de sistemas',7,'fdfsfds','dfsds',40.00,'DISPONIBLE',0,0.00,0,'2026-07-02 10:24:19'),(7,8,1,'u23257529','Marketing',6,'fdsdsfd','dnfn',35.00,'DISPONIBLE',0,0.00,0,'2026-07-02 14:18:21'),(8,10,1,'u23262502','Marketing',6,'fdsfsdf','dsaddf',35.00,'DISPONIBLE',0,0.00,0,'2026-07-02 14:31:31'),(9,11,1,'u21247855','Ingeniería de sistemas',6,'dfdwfwds','cdsvdsds',40.00,'DISPONIBLE',0,0.00,0,'2026-07-02 14:55:48'),(10,12,1,'u23625489','Diseño gráfico',8,'fgtyrbgf','dsfvf',50.00,'DISPONIBLE',0,0.00,0,'2026-07-02 15:17:18'),(11,13,1,'u263352236','Ingeniería de sistemas',8,'Me considero muy amable con los niños','He cuidado niños de 1 a 3 años',60.00,'DISPONIBLE',0,0.00,0,'2026-07-02 16:51:01');
/*!40000 ALTER TABLE `nanas` ENABLE KEYS */;
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

-- Dump completed on 2026-07-18 15:46:34
