-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: lipems3
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `calificacion`
--

DROP TABLE IF EXISTS `calificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calificacion` (
  `id_calificacion` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_calificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=7015 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificacion`
--

LOCK TABLES `calificacion` WRITE;
/*!40000 ALTER TABLE `calificacion` DISABLE KEYS */;
INSERT INTO `calificacion` VALUES (7010,'mal servicio'),(7011,'regular servicio'),(7012,'sobresaliente servicio'),(7013,'buen servicio'),(7014,'excelente servicio');
/*!40000 ALTER TABLE `calificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras` (
  `id_compras` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_proveedor` bigint NOT NULL,
  PRIMARY KEY (`id_compras`),
  KEY `id_proveedor` (`id_proveedor`),
  CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=303023 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` VALUES (303010,'2022-05-07 19:47:43','',404010),(303011,'2022-05-08 19:47:43','',404011),(303012,'2022-05-09 19:47:43','',404010),(303013,'2022-05-10 18:42:48','',404011),(303014,'2022-05-11 18:42:48','',404010),(303015,'2022-05-12 18:42:48','',404011),(303016,'2022-05-13 18:42:48','',404010),(303017,'2022-10-12 15:12:21','hola mundo',404011),(303018,'2022-10-12 15:14:21','nueva compra',404010),(303019,'2022-10-12 15:16:19','nueva compra2',404010),(303020,'2022-10-12 19:47:35','laksdflksda',404011),(303021,'2022-10-27 21:35:50','',404012),(303022,'2022-10-27 21:36:33','ropa',404012);
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insertar_hora_en_compra` BEFORE INSERT ON `compras` FOR EACH ROW begin
   SET new.fecha = NOW(); 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `detalle_de_compras`
--

DROP TABLE IF EXISTS `detalle_de_compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_de_compras` (
  `id_detalle_compras` int NOT NULL AUTO_INCREMENT,
  `cantidad` int NOT NULL,
  `subtotal` float DEFAULT NULL,
  `id_producto` int NOT NULL,
  `id_compras` int NOT NULL,
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id_detalle_compras`),
  KEY `id_producto` (`id_producto`),
  KEY `id_compras` (`id_compras`),
  CONSTRAINT `detalle_de_compras_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  CONSTRAINT `detalle_de_compras_ibfk_2` FOREIGN KEY (`id_compras`) REFERENCES `compras` (`id_compras`)
) ENGINE=InnoDB AUTO_INCREMENT=202050 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_de_compras`
--

LOCK TABLES `detalle_de_compras` WRITE;
/*!40000 ALTER TABLE `detalle_de_compras` DISABLE KEYS */;
INSERT INTO `detalle_de_compras` VALUES (202010,5,200000,9010,303010,NULL),(202011,8,240000,9012,303011,NULL),(202012,20,1700000,9013,303012,NULL),(202013,10,200000,9014,303013,NULL),(202014,8,256000,9015,303014,NULL),(202015,9,162000,9016,303015,NULL),(202016,5,140000,9017,303016,NULL),(202017,3,120000,9018,303011,NULL),(202018,7,280000,9018,303019,NULL),(202019,2,50000,9011,303020,NULL),(202020,3,255000,9013,303020,NULL),(202021,2,80000,9018,303017,NULL),(202022,1,40000,9018,303016,NULL),(202023,2,80000,9018,303013,NULL),(202024,2,80000,9018,303014,NULL),(202025,2,80000,9018,303014,NULL),(202026,2,80000,9018,303014,NULL),(202027,2,80000,9018,303014,NULL),(202028,2,80000,9018,303014,NULL),(202029,2,80000,9018,303014,NULL),(202030,2,80000,9018,303014,NULL),(202031,2,80000,9018,303013,NULL),(202032,1,40000,9010,303011,NULL),(202033,5,200000,9010,303020,NULL),(202034,3,120000,9010,303022,NULL),(202035,10,400000,9010,303022,NULL),(202036,2,50000,9011,303012,NULL),(202037,10,400000,9010,303014,NULL),(202038,2,40000,9014,303022,NULL),(202039,2,40000,9014,303014,NULL),(202040,5,200000,9010,303011,NULL),(202041,10,400000,9010,303010,NULL),(202042,10,400000,9010,303022,NULL),(202043,10,400000,9010,303011,NULL),(202044,10,400000,9010,303010,NULL),(202045,10,250000,9011,303011,NULL),(202046,10,400000,9010,303010,NULL),(202047,3,120000,9010,303010,NULL),(202048,3,231000,9058,303013,'2023-02-16 10:47:27'),(202049,5,475000,9057,303010,'2023-02-20 07:06:20');
/*!40000 ALTER TABLE `detalle_de_compras` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insertar_subtotal_en_detalleCompra` BEFORE INSERT ON `detalle_de_compras` FOR EACH ROW begin
   SET new.subtotal = new.cantidad*(SELECT precio FROM producto WHERE new.id_producto = producto.id_producto);
   SET new.fecha = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `aumentar_cantidad_disponibilidad_productos` AFTER INSERT ON `detalle_de_compras` FOR EACH ROW UPDATE producto SET producto.disponibles = producto.disponibles + new.cantidad WHERE producto.id_producto = new.id_producto */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `detalle_de_pedido`
--

DROP TABLE IF EXISTS `detalle_de_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_de_pedido` (
  `id_detalle_pedido` int NOT NULL AUTO_INCREMENT,
  `cantidad` int NOT NULL,
  `precio` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `id_producto` int NOT NULL,
  `id_pedido` int NOT NULL,
  `estado` varchar(45) COLLATE utf8mb3_bin NOT NULL,
  `envio` varchar(45) COLLATE utf8mb3_bin DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `calificacion` int DEFAULT NULL,
  `encargado` varchar(55) COLLATE utf8mb3_bin DEFAULT NULL,
  `tipo_de_pago` int DEFAULT NULL,
  `id_detalle_transaccion` int DEFAULT NULL,
  PRIMARY KEY (`id_detalle_pedido`),
  KEY `id_producto` (`id_producto`),
  KEY `id_pedido` (`id_pedido`),
  KEY `calificacion` (`calificacion`),
  KEY `tipo_de_pago` (`tipo_de_pago`),
  KEY `id_detalle_transaccion` (`id_detalle_transaccion`),
  CONSTRAINT `detalle_de_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`),
  CONSTRAINT `detalle_de_pedido_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  CONSTRAINT `detalle_de_pedido_ibfk_3` FOREIGN KEY (`calificacion`) REFERENCES `calificacion` (`id_calificacion`),
  CONSTRAINT `detalle_de_pedido_ibfk_4` FOREIGN KEY (`tipo_de_pago`) REFERENCES `tipo_de_pago` (`id_tipo_de_pago`),
  CONSTRAINT `detalle_de_pedido_ibfk_5` FOREIGN KEY (`id_detalle_transaccion`) REFERENCES `detalle_transaccion` (`id_detalle_transaccion`)
) ENGINE=InnoDB AUTO_INCREMENT=8238 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_de_pedido`
--

LOCK TABLES `detalle_de_pedido` WRITE;
/*!40000 ALTER TABLE `detalle_de_pedido` DISABLE KEYS */;
INSERT INTO `detalle_de_pedido` VALUES (8010,4,40000,160000,9010,4010,'Error en la venta',NULL,NULL,NULL,NULL,NULL,NULL),(8011,6,25000,150000,9011,4010,'Error en la venta','',NULL,NULL,'f@f.com',NULL,NULL),(8012,2,30000,60000,9012,4011,'Error en la venta','',NULL,NULL,'f@f.com',NULL,NULL),(8013,7,85000,595000,9013,4011,'Error en la venta','',NULL,NULL,NULL,NULL,NULL),(8014,3,20000,60000,9014,4012,'Error en la venta','',NULL,NULL,'f@f.com',NULL,NULL),(8015,4,32000,128000,9015,4013,'Error en la venta',NULL,NULL,NULL,'j@j.com',NULL,NULL),(8016,1,18000,18000,9016,4014,'Activo','',NULL,NULL,NULL,NULL,NULL),(8017,2,28000,56000,9017,4015,'Activo','',NULL,NULL,NULL,NULL,NULL),(8024,3,32000,96000,9015,4012,'Activo','',NULL,NULL,NULL,NULL,NULL),(8025,2,30000,60000,9012,4011,'Error en la venta','',NULL,NULL,'f@f.com',NULL,NULL),(8026,10,40000,400000,9010,4014,'Activo','',NULL,NULL,NULL,NULL,NULL),(8027,3,40000,120000,9010,4019,'Error en la venta','',NULL,NULL,NULL,NULL,NULL),(8028,6,32000,192000,9015,4024,'Error en la venta','',NULL,NULL,NULL,NULL,NULL),(8029,10,25000,250000,9011,4011,'Activo','',NULL,NULL,NULL,NULL,NULL),(8030,2,25000,50000,9011,4024,'Activo','',NULL,NULL,NULL,NULL,NULL),(8031,5,30000,150000,9012,4017,'Activo','',NULL,NULL,NULL,NULL,NULL),(8032,2,18000,36000,9016,4013,'Activo','',NULL,NULL,NULL,NULL,NULL),(8033,9,40000,360000,9010,4010,'Activo','',NULL,NULL,NULL,NULL,NULL),(8034,8,25000,200000,9011,4011,'Activo','',NULL,NULL,NULL,NULL,NULL),(8035,7,25000,175000,9011,4010,'Activo','',NULL,NULL,NULL,NULL,NULL),(8036,7,40000,280000,9010,4026,'Activo','',NULL,NULL,NULL,NULL,NULL),(8037,3,30000,90000,9012,4026,'Activo','',NULL,NULL,NULL,NULL,NULL),(8038,3,18000,54000,9016,4028,'Error en la venta',NULL,NULL,NULL,'j@j.com',NULL,NULL),(8039,10,85000,850000,9013,4028,'Error en la venta',NULL,NULL,NULL,'j@j.com',NULL,NULL),(8040,1,40000,40000,9018,4011,'Activo','',NULL,NULL,NULL,NULL,NULL),(8048,4,20000,80000,9014,4013,'Activo','',NULL,NULL,NULL,NULL,NULL),(8054,4,20000,80000,9014,4011,'Activo','',NULL,NULL,NULL,NULL,NULL),(8074,1,20000,20000,9014,4011,'Activo','',NULL,NULL,NULL,NULL,NULL),(8076,1,20000,20000,9014,4011,'Activo','',NULL,NULL,NULL,NULL,NULL),(8077,2,18000,36000,9016,4012,'Activo','',NULL,NULL,NULL,NULL,NULL),(8078,3,40000,120000,9010,4012,'Activo','',NULL,NULL,NULL,NULL,NULL),(8079,3,85000,255000,9013,4015,'Activo','',NULL,NULL,NULL,NULL,NULL),(8080,1,40000,40000,9018,4028,'Activo','',NULL,NULL,NULL,NULL,NULL),(8081,2,40000,80000,9018,4010,'Activo','',NULL,NULL,NULL,NULL,NULL),(8082,2,40000,80000,9018,4010,'Error en la venta',NULL,NULL,NULL,'j@j.com',NULL,NULL),(8086,2,40000,80000,9018,4013,'Activo','',NULL,NULL,NULL,NULL,NULL),(8090,4,40000,160000,9018,4014,'Activo','',NULL,NULL,NULL,NULL,NULL),(8091,2,40000,80000,9018,4014,'Activo','',NULL,NULL,NULL,NULL,NULL),(8092,2,40000,80000,9018,4014,'Activo','',NULL,NULL,NULL,NULL,NULL),(8093,2,40000,80000,9018,4014,'Activo','',NULL,NULL,NULL,NULL,NULL),(8094,2,40000,80000,9018,4013,'Activo','',NULL,NULL,NULL,NULL,NULL),(8095,2,40000,80000,9018,4012,'Activo','',NULL,NULL,NULL,NULL,NULL),(8096,1,40000,40000,9010,4012,'Activo','',NULL,NULL,NULL,NULL,NULL),(8097,2,40000,80000,9010,4033,'Activo','',NULL,7011,NULL,NULL,NULL),(8098,1,40000,40000,9010,4033,'Error en la venta','',NULL,NULL,NULL,NULL,NULL),(8099,1,40000,40000,9010,4034,'Activo','',NULL,NULL,NULL,NULL,NULL),(8100,1,40000,40000,9010,4034,'Activo','',NULL,NULL,NULL,NULL,NULL),(8101,1,40000,40000,9010,4034,'Activo','',NULL,NULL,NULL,NULL,NULL),(8103,1,40000,40000,9010,4034,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8104,1,40000,40000,9010,4033,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8105,1,40000,40000,9010,4034,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8106,1,40000,40000,9010,4035,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8107,1,40000,40000,9010,4015,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8108,1,40000,40000,9010,4011,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8109,1,40000,40000,9010,4014,'Error en la venta',NULL,NULL,NULL,'j@j.com',NULL,NULL),(8110,1,40000,40000,9010,4016,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8111,1,40000,40000,9010,4010,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8112,1,40000,40000,9010,4025,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8113,1,40000,40000,9010,4018,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8114,1,40000,40000,9010,4017,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8115,1,25000,25000,9011,4035,'Error en la venta','si',NULL,NULL,NULL,NULL,NULL),(8116,1,25000,25000,9011,4034,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8117,1,40000,40000,9010,4033,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8118,2,40000,80000,9010,4032,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8119,1,40000,40000,9010,4031,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8120,1,40000,40000,9010,4030,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8121,1,40000,40000,9010,4016,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8122,2,20000,40000,9014,4020,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8123,2,20000,40000,9014,4036,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8124,1,40000,40000,9010,4011,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8125,1,40000,40000,9010,4014,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8126,1,40000,40000,9010,4014,'Activo,Activo','no,si',NULL,NULL,NULL,NULL,NULL),(8127,1,40000,40000,9010,4010,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8128,1,40000,40000,9010,4011,'Activo','si,no',NULL,NULL,NULL,NULL,NULL),(8129,1,40000,40000,9010,4024,'Activo,Activo','no,no',NULL,NULL,NULL,NULL,NULL),(8130,1,40000,40000,9010,4010,'Activo,Activo','si,no',NULL,NULL,NULL,NULL,NULL),(8131,1,40000,40000,9010,4010,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8132,1,40000,40000,9010,4010,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8133,1,40000,40000,9010,4011,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8134,1,40000,40000,9010,4017,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8135,1,40000,40000,9010,4018,'Activo',NULL,NULL,NULL,NULL,NULL,NULL),(8136,1,40000,40000,9010,4010,'Activo',NULL,NULL,NULL,NULL,NULL,NULL),(8137,1,40000,40000,9010,4013,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8138,1,40000,40000,9010,4018,'Activo',NULL,NULL,NULL,NULL,NULL,NULL),(8139,1,40000,40000,9010,4020,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8140,1,40000,40000,9010,4010,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8141,1,40000,40000,9010,4010,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8142,1,40000,40000,9010,4024,'Activo','si','2023-01-09 21:22:17',NULL,NULL,NULL,NULL),(8143,1,0,0,9010,4031,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8144,2,0,0,9010,4032,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8145,1,0,0,9010,4033,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8146,2,0,0,9010,4034,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8147,1,0,0,9010,4035,'Activo','no',NULL,NULL,NULL,NULL,NULL),(8148,2,0,0,9010,4036,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8149,1,0,0,9010,4030,'Activo','si',NULL,NULL,NULL,NULL,NULL),(8150,2,40000,80000,9010,4031,'Activo','no','2023-01-09 21:33:02',NULL,NULL,NULL,NULL),(8151,1,40000,40000,9010,4032,'Activo','si','2023-01-09 21:33:02',NULL,NULL,NULL,NULL),(8152,2,40000,80000,9010,4032,'Activo','no','2023-01-09 21:33:02',NULL,NULL,NULL,NULL),(8153,1,40000,40000,9010,4033,'Activo','si','2023-01-09 21:33:02',NULL,NULL,NULL,NULL),(8154,2,40000,80000,9010,4034,'Activo','no','2023-01-09 21:33:03',NULL,NULL,NULL,NULL),(8155,1,40000,40000,9010,4036,'Activo','si','2023-01-11 10:30:24',7010,NULL,NULL,NULL),(8156,1,40000,40000,9010,4035,'Activo','no','2023-01-11 10:30:30',NULL,NULL,NULL,NULL),(8157,1,40000,40000,9010,4010,'Activo','si','2023-01-11 11:51:08',NULL,NULL,NULL,NULL),(8158,1,40000,40000,9010,4011,'Activo','si','2023-01-11 11:51:13',NULL,NULL,NULL,NULL),(8159,1,40000,40000,9010,4014,'Activo','si','2023-01-11 11:52:08',NULL,NULL,NULL,NULL),(8160,2,40000,80000,9010,4036,'Activo','no','2023-01-11 11:55:30',7011,NULL,NULL,NULL),(8161,3,40000,120000,9010,4010,'Activo','si','2023-01-19 10:35:49',NULL,NULL,NULL,NULL),(8162,2,40000,80000,9010,4010,'Activo','si','2023-01-19 10:35:54',NULL,NULL,NULL,NULL),(8163,2,25000,50000,9011,4010,'Activo','si','2023-01-19 10:35:58',NULL,NULL,NULL,NULL),(8164,1,40000,40000,9010,4010,'Activo','si','2023-01-22 19:56:02',NULL,NULL,NULL,NULL),(8165,2,40000,80000,9010,4010,'Activo','si','2023-01-22 19:59:29',NULL,NULL,NULL,NULL),(8166,1,40000,40000,9010,4010,'Activo','si','2023-01-22 20:07:08',NULL,NULL,NULL,NULL),(8167,1,40000,40000,9010,4036,'Activo','si',NULL,7013,NULL,NULL,NULL),(8168,1,40000,47600,9010,4010,'Activo','si','2023-02-16 10:49:52',NULL,NULL,NULL,NULL),(8169,1,25000,29750,9011,4021,'Activo','si','2023-02-16 11:12:27',NULL,NULL,NULL,NULL),(8170,1,40000,47600,9010,4034,'Activo','si','2023-02-16 11:14:18',NULL,NULL,NULL,NULL),(8171,1,77000,91630,9058,4024,'Activo','si','2023-02-17 07:17:48',NULL,NULL,NULL,NULL),(8172,1,40000,47600,9010,4027,'Activo','si','2023-02-17 07:31:00',NULL,NULL,NULL,NULL),(8173,1,40000,47600,9010,4021,'Activo','si','2023-02-17 08:26:10',NULL,NULL,NULL,NULL),(8174,1,25000,29750,9011,4013,'Activo','si','2023-02-17 09:28:38',NULL,NULL,NULL,NULL),(8175,1,40000,47600,9010,4016,'Activo','si','2023-02-17 09:35:31',NULL,NULL,NULL,NULL),(8176,1,25000,29750,9011,4011,'Activo','si','2023-02-17 09:41:53',NULL,NULL,NULL,NULL),(8177,1,25000,29750,9011,4015,'Activo','si','2023-02-17 09:54:32',NULL,NULL,NULL,NULL),(8178,1,25000,29750,9011,4023,'Activo','si','2023-02-17 09:56:57',NULL,NULL,NULL,NULL),(8179,1,25000,29750,9011,4010,'Activo','si','2023-02-20 07:00:56',NULL,NULL,NULL,NULL),(8180,1,25000,29750,9011,4020,'Error en la venta','si',NULL,NULL,NULL,NULL,NULL),(8181,1,77000,91630,9058,4012,'Activo','si','2023-02-20 18:26:21',NULL,NULL,NULL,NULL),(8182,1,25000,29750,9011,4035,'Activo','si','2023-02-23 12:34:07',NULL,NULL,NULL,NULL),(8183,1,95000,113050,9057,4035,'Activo','si','2023-02-23 12:45:37',NULL,NULL,NULL,NULL),(8184,1,77000,91630,9058,4035,'Activo','si','2023-02-23 13:19:26',NULL,NULL,NULL,NULL),(8185,1,95000,113050,9057,4031,'Error en la venta','si','2023-02-24 16:16:31',NULL,NULL,NULL,NULL),(8186,2,40000,95200,9018,4015,'Error en la venta','si','2023-02-27 15:59:45',NULL,'f@f.com',NULL,NULL),(8187,1,25000,29750,9011,4026,'Error en la venta','si','2023-02-27 16:20:44',NULL,'f@f.com',NULL,NULL),(8188,1,25000,29750,9011,4024,'Error en la venta','si','2023-02-27 16:26:55',NULL,'f@f.com',NULL,NULL),(8189,1,25000,29750,9011,4018,'Error en la venta','si','2023-02-27 16:29:57',NULL,'f@f.com',NULL,NULL),(8190,1,40000,47600,9010,4023,'Activo','si','2023-02-27 16:39:39',NULL,NULL,NULL,NULL),(8191,1,40000,47600,9018,4025,'Activo','si','2023-02-27 16:39:43',NULL,NULL,NULL,NULL),(8192,1,110000,130900,9056,4050,'Activo','si','2023-03-05 21:31:36',NULL,NULL,2,2),(8193,1,0,0,9056,4051,'Activo','si','2023-03-06 07:18:50',NULL,NULL,2,3),(8194,1,0,0,9056,4052,'Activo','si','2023-03-06 07:29:07',NULL,NULL,2,4),(8195,1,110000,130900,9056,4054,'Activo','si','2023-03-06 07:35:10',NULL,NULL,2,6),(8196,1,110000,130900,9056,4055,'Activo','si','2023-03-06 07:39:29',NULL,NULL,2,7),(8197,1,110000,130900,9056,4056,'Activo','si','2023-03-06 07:42:21',NULL,NULL,2,8),(8198,1,0,0,9056,4063,'Activo','si','2023-03-06 12:05:33',NULL,NULL,2,15),(8199,1,0,0,9056,4065,'Activo','si','2023-03-06 12:12:33',NULL,NULL,2,17),(8200,2,40000,95200,9018,4066,'Activo','si','2023-03-06 12:17:15',NULL,NULL,2,18),(8201,1,95000,113050,9057,4066,'Activo','si','2023-03-06 12:17:15',NULL,NULL,2,18),(8202,1,32000,38080,9015,4066,'Activo','si','2023-03-06 12:17:15',NULL,NULL,2,18),(8203,1,18000,21420,9016,4066,'Activo','si','2023-03-06 12:17:15',NULL,NULL,2,18),(8204,1,25000,29750,9011,4066,'Activo','si','2023-03-06 12:17:15',NULL,NULL,2,18),(8205,1,28000,33320,9017,4066,'Activo','si','2023-03-06 12:17:15',NULL,NULL,2,18),(8206,1,85000,101150,9013,4066,'Activo','si','2023-03-06 12:17:15',NULL,NULL,2,18),(8207,1,82000,97580,9055,4066,'Activo','si','2023-03-06 12:17:15',NULL,NULL,2,18),(8208,1,110000,130900,9056,4066,'Activo','si','2023-03-06 12:17:15',NULL,NULL,2,18),(8209,1,95000,113050,9057,4067,'Activo','si','2023-03-06 12:19:53',NULL,NULL,2,19),(8210,1,32000,38080,9015,4067,'Activo','si','2023-03-06 12:19:53',NULL,NULL,2,19),(8211,1,18000,21420,9016,4067,'Activo','si','2023-03-06 12:19:53',NULL,NULL,2,19),(8212,1,25000,29750,9011,4067,'Activo','si','2023-03-06 12:19:53',NULL,NULL,2,19),(8213,1,28000,33320,9017,4067,'Activo','si','2023-03-06 12:19:53',NULL,NULL,2,19),(8214,1,85000,101150,9013,4067,'Activo','si','2023-03-06 12:19:53',NULL,NULL,2,19),(8215,1,82000,97580,9055,4067,'Activo','si','2023-03-06 12:19:53',NULL,NULL,2,19),(8216,1,110000,130900,9056,4067,'Activo','si','2023-03-06 12:19:53',NULL,NULL,2,19),(8217,1,95000,113050,9057,4068,'Activo','si','2023-03-06 12:24:55',NULL,NULL,2,20),(8218,1,32000,38080,9015,4068,'Activo','si','2023-03-06 12:24:55',NULL,NULL,2,20),(8219,1,18000,21420,9016,4068,'Activo','si','2023-03-06 12:24:55',NULL,NULL,2,20),(8220,1,25000,29750,9011,4068,'Activo','si','2023-03-06 12:24:55',NULL,NULL,2,20),(8221,1,28000,33320,9017,4068,'Activo','si','2023-03-06 12:24:55',NULL,NULL,2,20),(8222,1,85000,101150,9013,4068,'Activo','si','2023-03-06 12:24:55',NULL,NULL,2,20),(8223,1,82000,97580,9055,4068,'Activo','si','2023-03-06 12:24:55',NULL,NULL,2,20),(8224,1,110000,130900,9056,4068,'Activo','si','2023-03-06 12:24:55',NULL,NULL,2,20),(8225,1,85000,101150,9013,4069,'Activo','si','2023-03-06 12:44:05',NULL,NULL,2,21),(8226,1,32000,38080,9015,4069,'Activo','si','2023-03-06 12:44:05',NULL,NULL,2,21),(8227,1,32000,38080,9015,4070,'Activo','si','2023-03-06 13:11:41',NULL,NULL,2,22),(8228,1,85000,101150,9013,4070,'Activo','si','2023-03-06 13:11:45',NULL,NULL,2,22),(8229,1,28000,33320,9017,4070,'Activo','si','2023-03-06 13:11:49',NULL,NULL,2,22),(8230,1,82000,97580,9055,4071,'Activo','si','2023-03-06 13:15:39',NULL,NULL,2,23),(8231,1,82000,97580,9055,4072,'Activo','si','2023-03-06 17:11:35',NULL,NULL,2,24),(8232,1,85000,101150,9013,4072,'Activo','si','2023-03-06 17:11:40',NULL,NULL,2,24),(8233,1,32000,38080,9015,4072,'Activo','si','2023-03-06 17:11:44',NULL,NULL,2,24),(8234,1,25000,29750,9011,4073,'Activo','no','2023-03-06 17:15:44',NULL,NULL,NULL,NULL),(8235,1,110000,130900,9056,4074,'Activo','si','2023-03-06 17:23:57',NULL,NULL,2,25),(8236,3,85000,303450,9013,4075,'Activo','si','2023-03-08 17:16:39',NULL,NULL,2,26),(8237,4,85000,404600,9013,4076,'Activo','si','2023-03-08 17:18:29',7010,NULL,NULL,NULL);
/*!40000 ALTER TABLE `detalle_de_pedido` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `disminuir_cantidad_disponibilidad_productos` BEFORE INSERT ON `detalle_de_pedido` FOR EACH ROW BEGIN
declare msg varchar(255);
 IF (SELECT disponibles FROM producto WHERE id_producto = new.id_producto) > 0 THEN
  UPDATE producto SET producto.disponibles = producto.disponibles - new.cantidad WHERE producto.id_producto = new.id_producto;

 ELSE
 set msg = concat('Este producto no esta disponible en stock, comuniquese con su administrador'); signal sqlstate '45000' set message_text = msg;
 END IF;
 END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `error_disponibilidad_producto` BEFORE INSERT ON `detalle_de_pedido` FOR EACH ROW BEGIN
 declare msg varchar(255);
 IF (SELECT producto.estado FROM producto WHERE id_producto = new.id_producto) <> 'Activo' THEN
   set msg = concat('El estado actual del producto es diferente a "Activo", comuniquese con su administrador'); signal sqlstate '45000' set message_text = msg;

 END IF;
 END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insertar_fecha_pedido` BEFORE INSERT ON `detalle_de_pedido` FOR EACH ROW BEGIN
SET new.fecha = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insertar_total_precio_detalle_venta` BEFORE INSERT ON `detalle_de_pedido` FOR EACH ROW begin
   set new.precio = (SELECT precio from producto where id_producto = new.id_producto), new.total = new.precio*new.cantidad + (new.precio*new.cantidad*0.19); 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `agregar_envio` AFTER INSERT ON `detalle_de_pedido` FOR EACH ROW IF new.envio = "si" THEN
INSERT INTO envios (envios.id_venta, envios.estado) VALUES (new.id_detalle_pedido, "En proceso");
END IF */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insertar_fecha_actualizar` BEFORE UPDATE ON `detalle_de_pedido` FOR EACH ROW SET new.fecha = old.fecha */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `cambio_estado_cantidad` AFTER UPDATE ON `detalle_de_pedido` FOR EACH ROW UPDATE producto SET producto.disponibles = producto.disponibles + new.cantidad WHERE producto.id_producto = new.id_producto */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `inactivar_envio_error_entrega` AFTER UPDATE ON `detalle_de_pedido` FOR EACH ROW IF new.estado = "Error en la venta" THEN
UPDATE envios SET envios.estado = "Error de entrega" WHERE envios.id_venta = old.id_detalle_pedido;
END IF */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `detalle_transaccion`
--

DROP TABLE IF EXISTS `detalle_transaccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_transaccion` (
  `id_detalle_transaccion` int NOT NULL AUTO_INCREMENT,
  `tipo_tarjeta` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `numero_tarjeta` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fecha_caducidad` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cod_seguridad` int DEFAULT NULL,
  PRIMARY KEY (`id_detalle_transaccion`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_transaccion`
--

LOCK TABLES `detalle_transaccion` WRITE;
/*!40000 ALTER TABLE `detalle_transaccion` DISABLE KEYS */;
INSERT INTO `detalle_transaccion` VALUES (1,NULL,'111111111','2023-03',NULL),(2,NULL,'111111111','2023-03',123),(3,NULL,'2222222','2023-02',222),(4,NULL,'333333333','2023-04',333),(5,NULL,'333333333','2023-04',333),(6,NULL,'1212','2023-04',121),(7,NULL,'212121','2023-03',111),(8,NULL,'1111','2023-04',111),(9,NULL,'1111','2023-04',111),(10,NULL,'1212','2023-04',221),(11,NULL,'1212','2023-04',221),(12,NULL,'1212','2023-04',221),(13,NULL,'1212','2023-04',221),(14,NULL,'1212','2023-04',221),(15,NULL,'22','2023-08',222),(16,NULL,'22','2023-08',222),(17,NULL,'12','2023-12',12),(18,NULL,'12','2023-12',12),(19,NULL,'11','2023-08',11),(20,NULL,'11','2023-08',11),(21,NULL,'6666666666666666','2023-04',123),(22,NULL,'4444444444444444','2023-10',123),(23,NULL,'2121212121212121','2023-11',211),(24,NULL,'2222232332323233','2025-12',213),(25,NULL,'5555555555555555','2023-05',555),(26,NULL,'4234234234234234','2023-12',243),(27,NULL,'3213123123123123','2023-11',132);
/*!40000 ALTER TABLE `detalle_transaccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `envios`
--

DROP TABLE IF EXISTS `envios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `envios` (
  `id_envio` int NOT NULL AUTO_INCREMENT,
  `fecha_de_ingreso` datetime DEFAULT NULL,
  `fecha_de_entrega` datetime DEFAULT NULL,
  `estado` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_venta` int DEFAULT NULL,
  `empresa` varchar(245) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id_envio`),
  KEY `id_venta` (`id_venta`),
  CONSTRAINT `envios_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `detalle_de_pedido` (`id_detalle_pedido`)
) ENGINE=InnoDB AUTO_INCREMENT=6118 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envios`
--

LOCK TABLES `envios` WRITE;
/*!40000 ALTER TABLE `envios` DISABLE KEYS */;
INSERT INTO `envios` VALUES (6010,'2023-02-23 10:59:00','0000-00-00 00:00:00','Entregado',8010,'cooperativa'),(6011,'2023-02-23 10:59:00','0000-00-00 00:00:00','Entregado',8010,'servientrega'),(6012,'2023-02-23 10:59:00','0000-00-00 00:00:00','Entregado',8010,''),(6013,'2023-02-23 10:59:00','0000-00-00 00:00:00','Error de entrega',8010,''),(6014,'2023-02-23 10:59:00','0000-00-00 00:00:00','Error de entrega',8010,'cooperativa'),(6015,'2023-02-23 10:59:00','0000-00-00 00:00:00','Error de entrega',8010,'cooperativa'),(6016,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6017,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6018,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6019,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,'iyuujk'),(6020,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6021,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6022,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6023,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6024,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6025,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6026,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6027,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6028,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6029,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6030,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6031,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6032,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6033,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6034,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6035,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6036,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6037,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6038,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6039,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6040,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6041,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6042,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6043,'2023-02-23 10:59:00','0000-00-00 00:00:00','En proceso',8010,''),(6044,'2023-02-23 10:59:00','0000-00-00 00:00:00','Entregado',8010,'cooperativa'),(6045,'2023-02-23 10:59:00','0000-00-00 00:00:00','Error de entrega',8010,'cooperativa'),(6046,'2023-02-23 10:59:00','0000-00-00 00:00:00','Entregado',8010,'servientrega'),(6047,'2023-02-23 10:59:00','0000-00-00 00:00:00','Entregado',8010,'cooperativa'),(6048,'2023-02-23 10:59:01','0000-00-00 00:00:00','Entregado',8010,'servientrega'),(6049,'2023-02-23 10:59:01','0000-00-00 00:00:00','Entregado',8010,'cooperativa'),(6050,'2023-02-23 10:59:01','0000-00-00 00:00:00','Error de entrega',8010,'cooperativa'),(6051,'2023-02-23 10:59:01','0000-00-00 00:00:00','Entregado',8010,'servientrega'),(6052,'2023-02-23 10:59:01','0000-00-00 00:00:00','Entregado',8010,'cooperativa'),(6053,'2023-02-23 10:59:01','0000-00-00 00:00:00','Entregado',8010,'cooperativa'),(6054,'2023-02-23 10:59:01','0000-00-00 00:00:00','Entregado',8010,'servientrega'),(6055,'2023-02-23 10:59:01','0000-00-00 00:00:00','Entregado',8010,'cooperativa'),(6056,'2023-02-23 10:59:01','0000-00-00 00:00:00','Entregado',8010,'cooperativa'),(6057,'2023-02-23 10:59:01','0000-00-00 00:00:00','Entregado',8010,'cooperativa'),(6058,'2023-02-23 10:59:01','0000-00-00 00:00:00','Entregado',8010,'servientrega'),(6059,'2023-02-23 10:59:01','0000-00-00 00:00:00','Entregado',8010,'cooperativa'),(6060,'2023-02-23 10:59:01','0000-00-00 00:00:00','En proceso',8010,''),(6061,'2023-02-23 10:59:01','0000-00-00 00:00:00','Entregado',8010,'cooperativa'),(6062,'2023-02-23 10:59:01','0000-00-00 00:00:00','En proceso',8010,''),(6064,'2023-02-23 12:45:37','2023-02-23 12:51:13','Entregado',8183,'cooperativa'),(6065,'2023-02-23 13:19:26','2023-02-23 13:20:31','Entregado',8184,'servientrega'),(6066,'2023-02-24 16:16:31',NULL,'En proceso',8185,NULL),(6067,'2023-02-27 15:59:45','2023-02-27 16:01:08','Error de entrega',8186,''),(6068,'2023-02-27 16:20:44','2023-02-27 16:24:12','Error de entrega',8187,''),(6069,'2023-02-27 16:26:55','2023-02-27 16:28:42','Error de entrega',8188,NULL),(6070,'2023-02-27 16:29:57','2023-02-27 16:33:15','Error de entrega',8189,NULL),(6071,'2023-02-27 16:39:39',NULL,'En proceso',8190,NULL),(6072,'2023-02-27 16:39:43',NULL,'En proceso',8191,NULL),(6073,'2023-03-05 21:31:36',NULL,'En proceso',8192,NULL),(6074,'2023-03-06 07:18:50',NULL,'En proceso',8193,NULL),(6075,'2023-03-06 07:29:07',NULL,'En proceso',8194,NULL),(6076,'2023-03-06 07:35:10',NULL,'En proceso',8195,NULL),(6077,'2023-03-06 07:39:29',NULL,'En proceso',8196,NULL),(6078,'2023-03-06 07:42:21',NULL,'En proceso',8197,NULL),(6079,'2023-03-06 12:05:33',NULL,'En proceso',8198,NULL),(6080,'2023-03-06 12:12:33',NULL,'En proceso',8199,NULL),(6081,'2023-03-06 12:17:15',NULL,'En proceso',8200,NULL),(6082,'2023-03-06 12:17:15',NULL,'En proceso',8201,NULL),(6083,'2023-03-06 12:17:15',NULL,'En proceso',8202,NULL),(6084,'2023-03-06 12:17:15',NULL,'En proceso',8203,NULL),(6085,'2023-03-06 12:17:15',NULL,'En proceso',8204,NULL),(6086,'2023-03-06 12:17:15',NULL,'En proceso',8205,NULL),(6087,'2023-03-06 12:17:15',NULL,'En proceso',8206,NULL),(6088,'2023-03-06 12:17:15',NULL,'En proceso',8207,NULL),(6089,'2023-03-06 12:17:15',NULL,'En proceso',8208,NULL),(6090,'2023-03-06 12:19:53',NULL,'En proceso',8209,NULL),(6091,'2023-03-06 12:19:53',NULL,'En proceso',8210,NULL),(6092,'2023-03-06 12:19:53',NULL,'En proceso',8211,NULL),(6093,'2023-03-06 12:19:53',NULL,'En proceso',8212,NULL),(6094,'2023-03-06 12:19:53',NULL,'En proceso',8213,NULL),(6095,'2023-03-06 12:19:53',NULL,'En proceso',8214,NULL),(6096,'2023-03-06 12:19:53',NULL,'En proceso',8215,NULL),(6097,'2023-03-06 12:19:53',NULL,'En proceso',8216,NULL),(6098,'2023-03-06 12:24:55',NULL,'En proceso',8217,NULL),(6099,'2023-03-06 12:24:55',NULL,'En proceso',8218,NULL),(6100,'2023-03-06 12:24:55',NULL,'En proceso',8219,NULL),(6101,'2023-03-06 12:24:55',NULL,'En proceso',8220,NULL),(6102,'2023-03-06 12:24:55',NULL,'En proceso',8221,NULL),(6103,'2023-03-06 12:24:55',NULL,'En proceso',8222,NULL),(6104,'2023-03-06 12:24:55',NULL,'En proceso',8223,NULL),(6105,'2023-03-06 12:24:55',NULL,'En proceso',8224,NULL),(6106,'2023-03-06 12:44:05',NULL,'En proceso',8225,NULL),(6107,'2023-03-06 12:44:05',NULL,'En proceso',8226,NULL),(6108,'2023-03-06 13:11:41',NULL,'En proceso',8227,NULL),(6109,'2023-03-06 13:11:45',NULL,'En proceso',8228,NULL),(6110,'2023-03-06 13:11:49',NULL,'En proceso',8229,NULL),(6111,'2023-03-06 13:15:39',NULL,'En proceso',8230,NULL),(6112,'2023-03-06 17:11:35',NULL,'En proceso',8231,NULL),(6113,'2023-03-06 17:11:40',NULL,'En proceso',8232,NULL),(6114,'2023-03-06 17:11:44',NULL,'En proceso',8233,NULL),(6115,'2023-03-06 17:23:57',NULL,'En proceso',8235,NULL),(6116,'2023-03-08 17:16:39',NULL,'En proceso',8236,NULL),(6117,'2023-03-08 17:18:29','2023-03-08 17:23:57','Entregado',8237,'servientrega');
/*!40000 ALTER TABLE `envios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ingresar_fecha_ingreso` BEFORE INSERT ON `envios` FOR EACH ROW BEGIN
 SET new.fecha_de_ingreso = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ingresar_fecha_entrega` BEFORE UPDATE ON `envios` FOR EACH ROW BEGIN
 IF new.estado = "Entregado" THEN
	SET new.fecha_de_entrega = NOW();
    SET new.fecha_de_ingreso = old.fecha_de_ingreso;
    ELSE
    SET new.fecha_de_ingreso = old.fecha_de_ingreso;
    SET new.fecha_de_entrega = NOW();
 END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario` (
  `id_inventario` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `cantidad` int NOT NULL,
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_movimiento` int NOT NULL,
  `id_producto` int NOT NULL,
  PRIMARY KEY (`id_inventario`),
  KEY `id_movimiento` (`id_movimiento`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_movimiento`) REFERENCES `movimientos` (`id_movimiento`),
  CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=101025 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (101010,'2022-03-22 19:33:31',4,'',1,9010),(101011,'2022-03-23 19:33:31',6,'',1,9011),(101012,'2022-03-24 19:33:31',2,'',1,9012),(101013,'2022-03-25 19:33:31',7,'',1,9013),(101014,'2022-03-26 19:33:31',5,'',2,9010),(101015,'2022-03-27 19:33:31',8,'',2,9012),(101016,'2022-03-28 19:33:31',20,'',2,9013),(101017,'2022-04-08 18:36:55',10,'',2,9014),(101018,'2022-04-09 18:36:55',8,'',2,9015),(101019,'2022-04-10 18:36:55',9,'',2,9016),(101020,'2022-04-11 18:36:55',5,'',2,9017),(101021,'2022-05-13 18:36:55',3,'',1,9014),(101022,'2022-05-14 18:36:55',4,'',1,9015),(101023,'2022-05-15 18:36:55',1,'',1,9016),(101024,'2022-05-16 18:36:55',2,'',1,9017);
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `registrar_invertario` BEFORE INSERT ON `inventario` FOR EACH ROW begin
insert into producto(nombre,categoria,precio) values(nombre,categoria,precio);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `items_carrito`
--

DROP TABLE IF EXISTS `items_carrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_carrito` (
  `id_item` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `usuario` bigint NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id_item`),
  KEY `id_producto` (`id_producto`),
  KEY `usuario` (`usuario`),
  CONSTRAINT `items_carrito_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  CONSTRAINT `items_carrito_ibfk_2` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_carrito`
--

LOCK TABLES `items_carrito` WRITE;
/*!40000 ALTER TABLE `items_carrito` DISABLE KEYS */;
/*!40000 ALTER TABLE `items_carrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos`
--

DROP TABLE IF EXISTS `movimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientos` (
  `id_movimiento` int NOT NULL AUTO_INCREMENT,
  `tipo_de_movimiento` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_movimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos`
--

LOCK TABLES `movimientos` WRITE;
/*!40000 ALTER TABLE `movimientos` DISABLE KEYS */;
INSERT INTO `movimientos` VALUES (1,'salida'),(2,'entrada');
/*!40000 ALTER TABLE `movimientos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `cliente` bigint NOT NULL,
  `id_empleado` bigint DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `cliente` (`cliente`),
  KEY `id_empleado` (`id_empleado`),
  KEY `id_pedido` (`id_pedido`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4077 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (4010,'2022-03-24 18:59:50',8784646411,1006518913),(4011,'2022-03-25 01:59:50',5416541968,1006518913),(4012,'2022-04-10 18:17:09',76307332,1006518913),(4013,'2022-04-22 18:17:09',10547808,1006518913),(4014,'2022-05-08 18:17:09',34532270,1006518913),(4015,'2022-05-09 18:17:09',34537236,1006518913),(4016,NULL,5416541968,1006518913),(4017,'2022-10-04 00:00:00',5416541968,1006518913),(4018,NULL,34532270,1006518913),(4019,'2022-10-06 00:00:00',8784646411,1006518913),(4020,'2022-10-06 00:00:00',76307332,1006518913),(4021,'2022-10-06 00:00:00',34532270,1006518913),(4022,'2022-10-06 00:00:00',34532270,1006518913),(4023,'2022-10-07 00:00:00',34537236,1006518913),(4024,'2022-10-10 00:00:00',1069742621,1006518913),(4025,'2022-10-10 00:00:00',76767,1006518913),(4026,'2022-10-10 00:00:00',2222,1006518913),(4027,'2022-10-13 00:00:00',651651,1006518913),(4028,'2022-10-13 00:00:00',651651,1006518913),(4029,'2022-10-15 00:00:00',5416541968,1006518913),(4030,'2022-10-15 00:00:00',8784646411,1006518913),(4031,'2022-10-27 00:00:00',8784646426,8784646425),(4032,'2022-10-27 00:00:00',8784646426,8784646425),(4033,'2022-10-27 00:00:00',8784646426,8784646425),(4034,'2022-10-28 00:00:00',8784646423,1006518913),(4035,'2022-11-14 00:00:00',323232,8784646425),(4036,'2022-12-18 00:00:00',8784646426,1006518913),(4037,NULL,8784646426,NULL),(4038,NULL,8784646426,NULL),(4039,NULL,8784646426,NULL),(4040,NULL,8784646426,NULL),(4041,NULL,8784646426,NULL),(4042,NULL,8784646426,NULL),(4043,NULL,8784646426,NULL),(4044,NULL,8784646426,NULL),(4045,NULL,8784646426,NULL),(4046,NULL,8784646426,NULL),(4047,NULL,8784646426,NULL),(4048,NULL,8784646426,NULL),(4049,NULL,8784646426,NULL),(4050,NULL,8784646426,NULL),(4051,NULL,8784646426,NULL),(4052,NULL,8784646426,NULL),(4053,NULL,8784646426,NULL),(4054,NULL,8784646426,NULL),(4055,NULL,8784646426,NULL),(4056,NULL,8784646426,NULL),(4057,NULL,8784646426,NULL),(4058,NULL,8784646426,NULL),(4059,NULL,8784646426,NULL),(4060,NULL,8784646426,NULL),(4061,NULL,8784646426,NULL),(4062,NULL,8784646426,NULL),(4063,NULL,8784646426,NULL),(4064,NULL,8784646426,NULL),(4065,NULL,8784646426,NULL),(4066,NULL,8784646426,NULL),(4067,NULL,8784646426,NULL),(4068,NULL,8784646426,NULL),(4069,NULL,8784646426,NULL),(4070,NULL,8784646426,NULL),(4071,NULL,8784646426,NULL),(4072,NULL,8784646426,NULL),(4073,'2023-03-06 00:00:00',1651561,8784646425),(4074,NULL,1000939256,NULL),(4075,NULL,8784646424,NULL),(4076,NULL,8784646436,NULL);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pqrs`
--

DROP TABLE IF EXISTS `pqrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pqrs` (
  `id_pqrs` int NOT NULL AUTO_INCREMENT,
  `tipo_pqrs` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion_pqrs` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `estado_pqrs` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fecha_ingresada` datetime DEFAULT NULL,
  `fecha_respuesta` datetime DEFAULT NULL,
  `id_venta` int NOT NULL,
  `respuesta` varchar(245) COLLATE utf8mb3_bin DEFAULT NULL,
  `encargado_res` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL,
  `calificacion` int DEFAULT NULL,
  PRIMARY KEY (`id_pqrs`),
  KEY `id_venta` (`id_venta`),
  KEY `calificacion` (`calificacion`),
  CONSTRAINT `pqrs_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `detalle_de_pedido` (`id_detalle_pedido`),
  CONSTRAINT `pqrs_ibfk_2` FOREIGN KEY (`calificacion`) REFERENCES `calificacion` (`id_calificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pqrs`
--

LOCK TABLES `pqrs` WRITE;
/*!40000 ALTER TABLE `pqrs` DISABLE KEYS */;
INSERT INTO `pqrs` VALUES (2,'Queja','sdf','respondido','2023-02-23 12:01:08','2023-02-23 18:55:06',8097,'fds','j@j.com',7010),(3,'Reclamo','sss','respondido','2023-02-23 18:56:20','2023-02-23 19:02:01',8123,'sss','f@f.com',7014),(4,'Queja','aaa','respondido','2023-02-23 19:03:24','2023-02-23 19:05:42',8098,'aaa','f@f.com',7011),(5,'Pregunta','qqq','respondido','2023-02-23 19:15:49','2023-02-23 19:27:34',8123,'qqq','f@f.com',7014),(6,'Sugerencia','rrr','respondido','2023-02-23 19:28:35','2023-02-23 19:30:07',8097,'rrr','f@f.com',7010),(8,'Reclamo','adsfsd','respondido','2023-02-23 19:39:19','2023-02-23 19:45:10',8118,'asdfsd','f@f.com',7014),(9,'Queja','sdaf','respondido','2023-02-23 19:39:26','2023-02-23 19:46:22',8098,'sdaf','f@f.com',7011),(10,'Pregunta','tttt','respondido','2023-02-23 19:45:25','2023-02-23 19:48:56',8123,'tttt','f@f.com',7013),(11,'Queja','sss','respondido','2023-02-23 19:47:23','2023-02-23 20:30:01',8097,'qqq','f@f.com',7010),(13,'Reclamo','cccxxccx','respondido','2023-02-23 20:13:11','2023-02-23 20:36:52',8167,'ya se resolvió','f@f.com',7012),(14,'Sugerencia','sss','respondido','2023-02-23 20:37:18','2023-02-23 20:37:41',8097,'fds','f@f.com',7012),(25,'Pregunta','dsfs','respondido','2023-02-23 21:19:31','2023-02-23 21:20:48',8097,'ya se resolvió','f@f.com',7014),(26,'Queja','sdaf','respondido','2023-02-23 21:21:05','2023-02-23 21:21:34',8097,'sadf','f@f.com',7013),(29,'Queja','sdaf','respondido','2023-02-23 21:27:16','2023-02-23 21:27:44',8117,'jhh','f@f.com',7012),(30,'Sugerencia','holaa','respondido','2023-02-23 21:32:06','2023-02-23 21:32:18',8123,'hola','f@f.com',7014),(31,'Queja','sadf','respondido','2023-02-23 21:38:20','2023-02-23 21:38:42',8097,'aaa','f@f.com',NULL),(32,'Queja','sdaf','respondido','2023-02-23 21:38:25','2023-02-23 21:38:47',8104,'aaa','f@f.com',NULL),(33,'Pregunta','sdf','respondido','2023-02-23 22:12:02','2023-02-23 22:12:33',8097,'g','f@f.com',7010),(34,'Queja','sdaf','respondido','2023-02-24 16:50:09','2023-02-24 16:50:44',8098,'www','j@j.com',7014),(35,'Pregunta','sadf','respondido','2023-02-25 08:42:23','2023-02-25 08:45:52',8097,'dddddddd','f@f.com',NULL),(36,'Reclamo','dsdsd','respondido','2023-02-25 08:44:28','2023-02-25 08:46:46',8119,'qqqqqq','j@j.com',NULL),(37,'Pregunta','wwww','respondido','2023-02-25 10:43:46','2023-02-25 10:48:27',8185,'si señor','fiorella@gmail.com',NULL),(38,'Pregunta','new?','respondido','2023-03-06 12:55:44','2023-03-06 13:01:45',8226,'yes','f@f.com',NULL),(39,'Queja','hueles a loco','respondido','2023-03-08 17:18:51','2023-03-08 17:22:36',8237,'mentira','f@f.com',NULL);
/*!40000 ALTER TABLE `pqrs` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ingresar_fecha_estado_pqrs` BEFORE INSERT ON `pqrs` FOR EACH ROW BEGIN
SET new.fecha_ingresada = NOW();
SET new.estado_pqrs = "pendiente";
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `respuesta_pqrs_AFTER_INSERT` BEFORE UPDATE ON `pqrs` FOR EACH ROW begin
 IF new.respuesta = '' THEN	
    SET new.estado_pqrs = "pendiente";
 ELSE
 IF old.respuesta != "pendiente" THEN
    SET new.estado_pqrs = "respondido";
    SET new.fecha_respuesta = old.fecha_respuesta;
    SET new.fecha_ingresada = old.fecha_ingresada;
    ELSE
    SET new.estado_pqrs = "respondido";
    SET new.fecha_respuesta = now();
    SET new.fecha_ingresada = old.fecha_ingresada;
    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `categoria` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `precio` float NOT NULL,
  `estado` varchar(245) COLLATE utf8mb3_bin DEFAULT NULL,
  `disponibles` int DEFAULT NULL,
  `imagen` varchar(250) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=9059 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (9010,'camisa hombre','hombre',40000,'Activo',0,''),(9011,'pantalon niño','niño',25000,'Activo',6,NULL),(9012,'short mujer','mujer',30000,'Activo',0,NULL),(9013,'chaqueta unisex','unisex',85000,'Activo',16,NULL),(9014,'blusa blanca','mujer',20000,'Activo',3,NULL),(9015,'camiseta de cuadros','hombre',32000,'Activo',2,NULL),(9016,'buso pequeño','niño',18000,'Activo',4,NULL),(9017,'jogger rojo','unisex',28000,'Activo',10,NULL),(9018,'falda','mujer',40000,'Activo',2,NULL),(9019,'blusa manga corta','mujer',65000,'Activo',0,NULL),(9022,'dril en tela','hombre',66000,'Activo',0,NULL),(9023,'levis','unisex',33000,'Activo',NULL,NULL),(9024,'','',0,'Agotado',NULL,NULL),(9025,'','',0,NULL,0,NULL),(9026,'','',0,NULL,NULL,NULL),(9027,'','',0,NULL,NULL,NULL),(9028,'','',0,NULL,NULL,NULL),(9029,'','',0,NULL,NULL,NULL),(9030,'','',0,NULL,NULL,NULL),(9031,'','',0,NULL,NULL,NULL),(9032,'','',0,NULL,NULL,NULL),(9033,'','',0,NULL,NULL,NULL),(9034,'','',0,NULL,NULL,NULL),(9035,'','',0,NULL,NULL,NULL),(9036,'','',0,NULL,NULL,NULL),(9037,'gaban','unisex',70000,'Activo',NULL,NULL),(9038,'','',0,'Activo',NULL,NULL),(9039,'','',0,'Activo',NULL,NULL),(9040,'','',0,'Activo',NULL,NULL),(9041,'','',0,'Activo',NULL,NULL),(9042,'','',0,'Activo',NULL,NULL),(9043,'','',0,'Activo',NULL,NULL),(9044,'','',0,'Activo',NULL,NULL),(9045,'','',0,'Activo',NULL,NULL),(9046,'','',0,'Activo',NULL,NULL),(9047,'','',0,'Activo',NULL,NULL),(9048,'','',0,'Activo',NULL,NULL),(9049,'','',0,'Activo',NULL,NULL),(9050,'','',0,'Activo',NULL,NULL),(9051,'','',0,'Activo',NULL,NULL),(9052,'','',0,'Activo',NULL,NULL),(9053,'','',0,'Activo',NULL,NULL),(9054,'Gorro Niño','niño',33900,'Activo',0,'gorro_niño.jpeg'),(9055,'Saco Hombre','hombre',82000,'Activo',9,'saco-hombre.jpg'),(9056,'Jean Unisex','unisex',110000,'Activo',1,'jean_unisex.jpg'),(9057,'Ruana Blanca','mujer',95000,'Activo',5,'Ruana-blanca-2.jpg'),(9058,'Ruana Capota Cafe','unisex',77000,'Activo',0,'ruana-capota-cafe-3.jpg');
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `activo_cuando_ingresa_nuevo_productos` BEFORE INSERT ON `producto` FOR EACH ROW BEGIN
 SET new.estado = "Activo";
 SET new.disponibles = 0;
 END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `id_proveedor` bigint NOT NULL AUTO_INCREMENT,
  `nombre_de_proveedor` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` bigint NOT NULL,
  `direccion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=404013 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (404010,'Jaime gonzales',3203586789,'calle 26 #68-34'),(404011,'Carlos ramirez',3123608123,'diagonal 19d #45-67'),(404012,'oracio ignacio celestino',3204813733,'Calle 5 # 3 - 20');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pro_com` AFTER INSERT ON `proveedores` FOR EACH ROW begin
insert into compras(fecha,descripcion,id_proveedor) values(now(),descripcion,new.id_proveedor);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre_de_rol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=1013 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1010,'ROLE_CLIENTE'),(1011,'ROLE_ADMIN'),(1012,'ROLE_EMPLEADO');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_usuarios`
--

DROP TABLE IF EXISTS `roles_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles_usuarios` (
  `id_rol_usuario` int NOT NULL AUTO_INCREMENT,
  `id_rol` int NOT NULL,
  `id_usuario` bigint NOT NULL,
  PRIMARY KEY (`id_rol_usuario`),
  KEY `id_rol` (`id_rol`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `roles_usuarios_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`),
  CONSTRAINT `roles_usuarios_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2083 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_usuarios`
--

LOCK TABLES `roles_usuarios` WRITE;
/*!40000 ALTER TABLE `roles_usuarios` DISABLE KEYS */;
INSERT INTO `roles_usuarios` VALUES (2012,1010,5416541968),(2013,1010,8784646411),(2014,1010,76307332),(2015,1010,10547808),(2016,1010,34532270),(2017,1010,34537236),(2019,1010,9999),(2023,1010,47417),(2024,1010,8784646416),(2025,1010,2222),(2026,1010,3333),(2028,1010,8784646417),(2029,1010,76767),(2030,1010,2315487),(2031,1010,1069742621),(2032,1010,1031296),(2033,1010,1651561),(2034,1010,12651),(2035,1010,651651),(2036,1010,1000625803),(2037,1010,8784646423),(2038,1011,8784646424),(2039,1012,8784646425),(2040,1010,8784646426),(2041,1010,8784646430),(2042,1010,8784646433),(2056,1010,8784646412),(2057,1010,8784646413),(2058,1010,8784646414),(2072,1010,323232),(2074,1012,1006518913),(2078,1011,1000939256),(2079,1010,8784646434),(2080,1010,8784646435),(2081,1010,8784646436),(2082,1010,777);
/*!40000 ALTER TABLE `roles_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_de_pago`
--

DROP TABLE IF EXISTS `tipo_de_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_de_pago` (
  `id_tipo_de_pago` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(11) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_tipo_de_pago`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_de_pago`
--

LOCK TABLES `tipo_de_pago` WRITE;
/*!40000 ALTER TABLE `tipo_de_pago` DISABLE KEYS */;
INSERT INTO `tipo_de_pago` VALUES (1,'efectivo'),(2,'tarjeta');
/*!40000 ALTER TABLE `tipo_de_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` bigint NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `direccion` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(200) COLLATE utf8mb3_bin NOT NULL,
  `reset_password_token` varchar(45) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8784646437 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (777,'77a',777,'77@gm.com','777','$2a$10$2e87mziXjmx4boHvfJ0S.efyscw9/UP9JMT4jWYywkF5bvK9UV0Bu',NULL),(2222,'222',2222,'22@gmail.com','222','1',NULL),(3333,'333',3333,'333@gmail.com','333','1',NULL),(9999,'luis',11111,'luis@gmail.com','calle falsa','1',NULL),(12651,'gasd',12651,'dsaf@gm.com','sdafsda1132 ','12651',NULL),(47417,'kali',474747,'kali@gmail.com','calle47474','1',NULL),(76767,'7677',7677,'76767@s.com','76767','1',NULL),(323232,'zzzx',323232787,'z@z.com','zzzzzzz','$2a$10$l.BumQXMv3iZcVDuBy9Uou9IkmPDsh0FV81gi8rTo1N3wwx7OOpJC',NULL),(651651,'francisco',351651,'mierderos@gmail.com','calle falsa mierderos','651651',NULL),(1031296,'maria fernanda garcia calvo',3015555799,'mafe_8075@gmail.com','calle 136a # 102a - 42','1031296',NULL),(1651561,'aurora rivera',31306548,'aurora@gmail.com','calle 136 # 101b-56','1651561',NULL),(2315487,'maco',2315487,'2315487@s.com','2315487','2315487',NULL),(10547808,'ACOSTA FAUSTO JOSE',6700555,'acostafausto@gmail.com','A Calle 100 # 11B-27 Bogotá\r\n','fausto123',NULL),(34532270,'ACOSTA ARAGON MARIA AMPARO',7229393,'acostaaraagon@gmail.com','Carrera 20 B # 29-18. Barrio Pie de la Popa.\r\n','aragon123',NULL),(34537236,'BUCHELI LOPEZ ADRIANA',3178503333,'bucheli@gmail.com','Calle 20 # 24-05 Barrio Centro\r\n','lopez123',NULL),(76307332,'ABELLA HERRERA WILLIAM EFRAIN',3455500,'abella@gmail.com','Carrera 21 # 17 -63\r\n','herrera123',NULL),(1000625803,'TYAKEMICHE FRANCISCO',2312156165,'FCISNER@HORMAIL.COM','DIAGONAL 14','1000625803',NULL),(1000939256,'hugo armando garcia',2147483647,'hugo@gmail.com','Cll 136a # 102a - 42','$2a$10$QM3Q.E5W.BVPqno9f7zEg.Kn9bO7qyw9T4/uWHiBdGafsVU6ZE2aq',NULL),(1006518913,'fiorella sanchez rocha',3156604832,'fiorella@gmail.com','Calle 10 # 5-51','$2a$10$l.BumQXMv3iZcVDuBy9Uou9IkmPDsh0FV81gi8rTo1N3wwx7OOpJC',NULL),(1069742621,'lorena',32136512,'lorena@gmail.com','callesubia123','1069742621',NULL),(5416541968,'francisco cisneros\r\n',3842166687,'francisco@gmail.com\r\n','Avenida 19 No. 98-03, sexto piso, Edificio Torre 100\r\n','fran123',NULL),(8784646411,'mauricio gomez',3002583165,'mauricio@gmail.com','Calle 53 No 10-60/46, Piso 2.\r\n','$2a$10$lmKijVVzssUjKnCCZhO3Ben6unWC5XC.MRis24a8Nfa/Vx04HyOE.',NULL),(8784646412,'maicol',304564,'maicol@gmail.com','calle123','1',NULL),(8784646413,'xdfg',35412,'ds@gmail.com','dfxg','1',NULL),(8784646414,'xdfg',35412,'dss@gmail.com','dfxg','1',NULL),(8784646416,'hugo',1111,'info@conluzmeditacion.com','calle1111','1',NULL),(8784646417,'00',0,'000@d.com','000','1',NULL),(8784646423,'fa',123,'fa@hot.com','123','$2a$10$J2tHRXcljqPjyWzWGGdzx.6jsePx2a2meYHOgdWTh34LzShYRD2SK',NULL),(8784646424,'f',123,'f@f.com','f12','$2a$10$QM3Q.E5W.BVPqno9f7zEg.Kn9bO7qyw9T4/uWHiBdGafsVU6ZE2aq',NULL),(8784646425,'j',123,'j@j.com','j123','$2a$10$kL4t8GRifjorwFCaQNHR4OBvjJpsFN0MRweUvEkPH/H5QAjKQwCIK',NULL),(8784646426,'t',123,'t@t.com','1234 falsa','$2a$10$W/23QQMz9WDugq6M5iuA1O3quXjtvcyrnOzRVnTQji5Um.wqfV9Uq',NULL),(8784646430,'lusa',555,'lusa@lusa.com','calle lusa','$2a$10$H8hxdaZ4QuhJ0mOLSjpJc.jxKpjjTpmcfOBtjQ54B8Obwcy7b7THq',NULL),(8784646433,'r',202020,'r@r.com','r #','$2a$10$khRo/xQ9I.raA4pWT40Dn.jvtpasVev/XiOa/8AejfpiUDbx5hhqy',NULL),(8784646434,'francisco',121212121,'fcisneros872@gmail.com','dkfjsdk','$2a$10$RpkeIV5CJ4gioqcAv7psle3fq19WeN3TJhNZq4tW2WZTnA0U70ACe',NULL),(8784646435,'fasdfads',3232323,'l@l.com','sdkjfkas','$2a$10$qPEraZtq3i9yH0fm3ZTyAOZ/lsVGhAlBYcFpHMbqV1KI68p2VmKei',NULL),(8784646436,'fdsafasd',4243242332,'fcisneros872@hotmail.com','fdasfdas','$2a$10$I5XBFluVha/p4VuZ0WT.yeIetTcrVu761naTtXJ5RmM/v6DvXZWMS',NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `usuarios_AFTER_INSERT` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
declare _id_usuario bigint;
set _id_usuario=new.id_usuario;
insert into roles_usuarios (id_rol,id_usuario) values
(1010,_id_usuario);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-08 17:24:53