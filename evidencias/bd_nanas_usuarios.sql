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
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `correo` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  `dni` char(8) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `foto_perfil` varchar(255) DEFAULT NULL,
  `estado_cuenta` varchar(255) DEFAULT NULL,
  `ultimo_login` datetime DEFAULT NULL,
  `tipo_usuario` varchar(255) NOT NULL,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo` (`correo`),
  UNIQUE KEY `telefono` (`telefono`),
  UNIQUE KEY `dni` (`dni`),
  KEY `idx_usuarios_correotipo_usuario` (`correo`),
  KEY `idx_usuarios_dni` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (6,'carlos','Bendezu','carlbendezu5@gmail.com','980655110','75498883','carlos123','2005-01-28',NULL,'ACTIVA','2026-07-02 15:01:56','NANA','2026-07-02 10:24:19'),(7,'Luis','mollo','luis123@gmail.com','985632326','78454512','luis123','2004-06-08',NULL,'ACTIVA','2026-07-02 14:22:35','CLIENTE','2026-07-02 11:29:36'),(8,'martin','mendoza','martin123@gmail.com','985665362','78544523','martin123','2005-02-01',NULL,'ACTIVA','2026-07-02 14:22:21','NANA','2026-07-02 14:18:21'),(9,'gustavo','barrientos','gustavo123@gmail.com','985652336','78456253','gustavo123','2004-09-06',NULL,'ACTIVA','2026-07-02 16:48:17','CLIENTE','2026-07-02 14:28:31'),(10,'paolo','pelaes','paolo123@gmail.com','985465223','85544126','paolo123','2002-09-05',NULL,'ACTIVA',NULL,'NANA','2026-07-02 14:31:31'),(11,'pedro','paz','pedro123@gmail.com','985122003','75488885','pedro123','2006-05-25',NULL,'ACTIVA','2026-07-02 16:06:11','NANA','2026-07-02 14:55:48'),(12,'ana','mendoza','anam123@gmail.com','985662362','45123665','ana123','2005-10-20',NULL,'ACTIVA',NULL,'NANA','2026-07-02 15:17:18'),(13,'maria','montes','maria41@gmail.com','985663201','74523662','maria41','2003-02-21',NULL,'ACTIVA','2026-07-02 16:51:21','NANA','2026-07-02 16:51:01');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
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

-- Dump completed on 2026-07-18 15:46:35
