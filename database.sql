CREATE DATABASE  IF NOT EXISTS `ugel04_activos_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ugel04_activos_db`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: ugel04_activos_db
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `activos`
--

DROP TABLE IF EXISTS `activos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activos` (
  `id_activo` int NOT NULL AUTO_INCREMENT,
  `codigo_patrimonial` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria` enum('Cómputo','Proyección','Multimedia y Audio','Redes') COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_equipo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `marca` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modelo` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_serie` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accesorios` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_ie_asignada` int DEFAULT NULL,
  `estado` enum('En Almacén','En Tránsito','Asignado','En Retorno','En Mantenimiento','De Baja') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'En Almacén',
  `observaciones` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_activo`),
  UNIQUE KEY `codigo_patrimonial` (`codigo_patrimonial`),
  UNIQUE KEY `numero_serie` (`numero_serie`),
  KEY `id_ie_asignada` (`id_ie_asignada`),
  CONSTRAINT `activos_ibfk_1` FOREIGN KEY (`id_ie_asignada`) REFERENCES `instituciones_educativas` (`id_ie`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activos`
--

LOCK TABLES `activos` WRITE;
/*!40000 ALTER TABLE `activos` DISABLE KEYS */;
INSERT INTO `activos` VALUES (1,'7408-9500-0142','Cómputo','Laptop','Lenovo','ThinkPad E14 Gen 4','PF-3X99201','Cargador 65W, mochila antirrobo',1,'Asignado','Operativo sin observaciones','2026-10-20 02:06:31'),(2,'7408-9500-0143','Proyección','Proyector','Epson','PowerLite X49','X4LK-900123','Cable HDMI, control remoto, maletín',NULL,'En Almacén','Operativo sin observaciones','2026-10-20 02:06:31'),(3,'7408-9500-0201','Cómputo','Tablet','Lenovo','Tab M10 Plus','HA1R-T45677','Cargador USB-C, funda protectora',2,'En Tránsito','Despachado con guía de remisión interna','2026-10-20 02:06:31'),(4,'7408-9500-0202','Cómputo','Laptop','HP','ProBook 450 G9','5CD2-345XYZ','Cargador 65W, mouse inalámbrico',3,'Asignado','Operativo sin observaciones','2026-10-20 02:06:31'),(5,'7408-9500-0310','Multimedia y Audio','Parlante','JBL','PartyBox 110','JBL1-10A778','Cable de poder, micrófono alámbrico',NULL,'En Almacén','Operativo sin observaciones','2026-10-20 02:06:31'),(6,'7408-9500-0311','Cómputo','PC Escritorio','Dell','OptiPlex 3080 SFF','DL30-80B912','Teclado, mouse, cable de poder',4,'En Retorno','Retorna a la UGEL por falla en la fuente de poder','2026-10-20 02:06:31'),(7,'7408-9500-0420','Redes','Access Point','Ubiquiti','UniFi U6-Lite','UBQ6-L55120','Inyector PoE, kit de montaje en techo',NULL,'En Mantenimiento','En revisión técnica por reinicios constantes','2026-10-20 02:06:31'),(8,'7408-9400-0087','Cómputo','Laptop','Toshiba','Satellite Pro C50','TSB5-0C3341','Sin accesorios',NULL,'De Baja','Baja por obsolescencia - R.D. N.° 0145-2025-UGEL04','2026-10-20 02:06:31'),(9,'7408-9500-0455','Cómputo','Laptop','Lenovo','ThinkPad L14 Gen 3','PF-4M7C09','Cargador 65W',7,'Asignado','Operativo sin observaciones','2026-10-20 02:06:31'),(10,'7408-9500-0456','Proyección','Proyector','Epson','PowerLite E20','X5MN-200456','Cable HDMI, cable VGA, control remoto',6,'En Tránsito','Despachado hacia el distrito de Ancón','2026-10-20 02:06:31');
/*!40000 ALTER TABLE `activos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instituciones_educativas`
--

DROP TABLE IF EXISTS `instituciones_educativas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instituciones_educativas` (
  `id_ie` int NOT NULL AUTO_INCREMENT,
  `codigo_modular` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_ie` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `distrito` enum('Comas','Carabayllo','Puente Piedra','Ancón','Santa Rosa') COLLATE utf8mb4_unicode_ci NOT NULL,
  `director_responsable` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono_contacto` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_ie`),
  UNIQUE KEY `codigo_modular` (`codigo_modular`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instituciones_educativas`
--

LOCK TABLES `instituciones_educativas` WRITE;
/*!40000 ALTER TABLE `instituciones_educativas` DISABLE KEYS */;
INSERT INTO `instituciones_educativas` VALUES (1,'0345612','I.E. Santo Domingo','Comas','Lic. Carlos Alberto Mendoza','987654321'),(2,'0348901','I.E. 3047 Estados Unidos','Comas','Mg. Rosa María Vargas','987112233'),(3,'0412390','I.E. Esther Festini de Ramos Ocampo','Comas','Dr. Jorge Luis Quispe','991223344'),(4,'0523104','I.E. 2025 Raúl Porras Barrenechea','Carabayllo','Lic. Carmen Rosa Pineda','984556677'),(5,'0619823','I.E. Augusto B. Leguía','Puente Piedra','Mg. Pedro Pablo Huamán','975331122'),(6,'0710455','I.E. Carlos Gutiérrez Merino','Ancón','Lic. Elena Beatriz Soto','966448899'),(7,'0811209','I.E. Divino Maestro','Santa Rosa','Mg. Raúl Ernesto Paredes','955887711');
/*!40000 ALTER TABLE `instituciones_educativas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-20  6:01:34
