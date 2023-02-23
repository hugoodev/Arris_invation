-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-02-2023 a las 19:35:10
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `lipems3`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `cacular_compra` (IN `_id_producto` INT)   begin
select producto.nombre,sum(detalle_de_compras.cantidad) as cantidadtotal,
sum(detalle_de_compras.subtotal) as subtotal,proveedores.nombre_de_proveedor 
from  producto join detalle_de_compras on  producto.id_producto=detalle_de_compras.id_producto
 join compras on detalle_de_compras.id_compras=compras.id_compras
 join  proveedores on compras.id_proveedor=proveedores.id_proveedor
 where producto.id_producto=_id_producto;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cacular_compra` (IN `_id_producto` INT)   begin
select producto.nombre,sum(detalle_de_compras.cantidad) as cantidadtotal,
sum(detalle_de_compras.subtotal) as subtotal,proveedores.nombre_de_proveedor 
from  producto join detalle_de_compras on  producto.id_producto=detalle_de_compras.id_producto
 join compras on detalle_de_compras.id_compras=compras.id_compras
 join  proveedores on compras.id_proveedor=proveedores.id_proveedor
 where producto.id_producto=_id_producto;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_EnviosClientes` (IN `_id_usuario` INT)   BEGIN
SELECT Usuarios.nombre,Pedido.fecha,Venta.producto,Envios.fecha_de_entrega,Envios.estado FROM Usuarios
JOIN Pedido ON Usuarios.id_usuario=Pedido.cliente
Join Venta ON Pedido.id_pedido=Venta.id_pedido
Join Envios ON Venta.id_venta=Envios.id_venta
Where Usuarios.id_usuario=_id_usuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fecha_envio` (IN `fecha1` DATE, IN `fecha2` DATE)   BEGIN
Select Envios.fecha_de_entrega,Envios.estado,Venta.producto,Venta.impuesto From Venta
Join envios ON Venta.id_venta=Envios.id_venta WHERE fecha1 AND fecha2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_calificacion` (IN `descripcion` VARCHAR(100), IN `valoracion` INT, IN `idpedido` INT)   begin
insert into calificacion (descripcion,valoracion,id_pedido) values (descripcion,valoracion,idpedido);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_pedido` (`_id_cliente` INT, `_id_empleado` INT)   BEGIN
INSERT INTO pedido(fecha,cliente,id_empleado) VALUES (NOW(), _id_cliente, _id_empleado);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_pqrs_cliente` (IN `tipo` VARCHAR(50), IN `descripcion` VARCHAR(100), IN `fecha` DATE, IN `idventa` INT)   begin
insert into pqrs (tipo_pqrs,descripcion_pqrs,fecha,id_venta) values (tipo,descripcion,fecha,idventa);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_envio` (IN `_estado` VARCHAR(20))   BEGIN
Select Venta.Producto, Envios.Estado FROM envios JOIN venta
ON Envios.id_venta=Venta.id_venta where estado=_estado;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_pqrs_y_venta` ()   begin
select pqrs.id_pqrs,pqrs.tipo_pqrs,pqrs.fecha,pqrs.descripcion_pqrs,pqrs.estado_pqrs,venta.id_venta,venta.producto,venta.fecha
from pqrs 
inner join venta 
on pqrs.id_venta=venta.id_venta;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pqrs_por_fecha` (IN `fecha1` DATE, IN `fecha2` DATE)   begin
select * from pqrs where fecha between fecha1 and fecha2;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ProductoVenta` (IN `_id_venta` INT)   BEGIN
SELECT Venta.producto, Envios.id_envio FROM venta
JOIN envios ON Venta.id_venta=Envios.id_venta
WHERE 
Venta.id_venta=_id_venta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_total_de_un_pedido` (IN `_cantidad` INT, IN `_id_producto` INT, IN `_id_pedido` INT)   BEGIN
DECLARE valor_producto float;
DECLARE _total float;
SET valor_producto = (SELECT precio FROM producto WHERE id_producto = _id_producto);
SET _total = valor_producto*_cantidad;
INSERT INTO detalle_de_pedido(cantidad,precio,total,id_producto,id_pedido) VALUES (_cantidad, valor_producto, _total, _id_producto, _id_pedido);
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_contar_estado_pqrs` (`_estado_pqrs` VARCHAR(45)) RETURNS INT(11) DETERMINISTIC BEGIN

RETURN (select count(*) FROM pqrs where estado_pqrs = _estado_pqrs);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_listarEnvios` () RETURNS INT(11) DETERMINISTIC Begin
Return(select count(*) FROM envios);
End$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_total_pedidos` () RETURNS VARCHAR(45) CHARSET utf8 COLLATE utf8_bin DETERMINISTIC BEGIN
DECLARE total_pedidos int;
DECLARE a varchar(45);
SET total_pedidos = (SELECT COUNT(id_pedido) FROM pedido);
RETURN total_pedidos;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificacion`
--

CREATE TABLE `calificacion` (
  `id_calificacion` int(11) NOT NULL,
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `calificacion`
--

INSERT INTO `calificacion` (`id_calificacion`, `descripcion`) VALUES
(7010, 'mal servicio'),
(7011, 'regular servicio'),
(7012, 'sobresaliente servicio'),
(7013, 'buen servicio'),
(7014, 'excelente servicio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compras` int(11) NOT NULL,
  `fecha` datetime DEFAULT NULL,
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_proveedor` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id_compras`, `fecha`, `descripcion`, `id_proveedor`) VALUES
(303010, '2022-05-07 19:47:43', '', 404010),
(303011, '2022-05-08 19:47:43', '', 404011),
(303012, '2022-05-09 19:47:43', '', 404010),
(303013, '2022-05-10 18:42:48', '', 404011),
(303014, '2022-05-11 18:42:48', '', 404010),
(303015, '2022-05-12 18:42:48', '', 404011),
(303016, '2022-05-13 18:42:48', '', 404010),
(303017, '2022-10-12 15:12:21', 'hola mundo', 404011),
(303018, '2022-10-12 15:14:21', 'nueva compra', 404010),
(303019, '2022-10-12 15:16:19', 'nueva compra2', 404010),
(303020, '2022-10-12 19:47:35', 'laksdflksda', 404011),
(303021, '2022-10-27 21:35:50', '', 404012),
(303022, '2022-10-27 21:36:33', 'ropa', 404012);

--
-- Disparadores `compras`
--
DELIMITER $$
CREATE TRIGGER `insertar_hora_en_compra` BEFORE INSERT ON `compras` FOR EACH ROW begin
   SET new.fecha = NOW(); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_de_compras`
--

CREATE TABLE `detalle_de_compras` (
  `id_detalle_compras` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `subtotal` float DEFAULT NULL,
  `id_producto` int(11) NOT NULL,
  `id_compras` int(11) NOT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `detalle_de_compras`
--

INSERT INTO `detalle_de_compras` (`id_detalle_compras`, `cantidad`, `subtotal`, `id_producto`, `id_compras`, `fecha`) VALUES
(202010, 5, 200000, 9010, 303010, NULL),
(202011, 8, 240000, 9012, 303011, NULL),
(202012, 20, 1700000, 9013, 303012, NULL),
(202013, 10, 200000, 9014, 303013, NULL),
(202014, 8, 256000, 9015, 303014, NULL),
(202015, 9, 162000, 9016, 303015, NULL),
(202016, 5, 140000, 9017, 303016, NULL),
(202017, 3, 120000, 9018, 303011, NULL),
(202018, 7, 280000, 9018, 303019, NULL),
(202019, 2, 50000, 9011, 303020, NULL),
(202020, 3, 255000, 9013, 303020, NULL),
(202021, 2, 80000, 9018, 303017, NULL),
(202022, 1, 40000, 9018, 303016, NULL),
(202023, 2, 80000, 9018, 303013, NULL),
(202024, 2, 80000, 9018, 303014, NULL),
(202025, 2, 80000, 9018, 303014, NULL),
(202026, 2, 80000, 9018, 303014, NULL),
(202027, 2, 80000, 9018, 303014, NULL),
(202028, 2, 80000, 9018, 303014, NULL),
(202029, 2, 80000, 9018, 303014, NULL),
(202030, 2, 80000, 9018, 303014, NULL),
(202031, 2, 80000, 9018, 303013, NULL),
(202032, 1, 40000, 9010, 303011, NULL),
(202033, 5, 200000, 9010, 303020, NULL),
(202034, 3, 120000, 9010, 303022, NULL),
(202035, 10, 400000, 9010, 303022, NULL),
(202036, 2, 50000, 9011, 303012, NULL),
(202037, 10, 400000, 9010, 303014, NULL),
(202038, 2, 40000, 9014, 303022, NULL),
(202039, 2, 40000, 9014, 303014, NULL),
(202040, 5, 200000, 9010, 303011, NULL),
(202041, 10, 400000, 9010, 303010, NULL),
(202042, 10, 400000, 9010, 303022, NULL),
(202043, 10, 400000, 9010, 303011, NULL),
(202044, 10, 400000, 9010, 303010, NULL),
(202045, 10, 250000, 9011, 303011, NULL),
(202046, 10, 400000, 9010, 303010, NULL),
(202047, 3, 120000, 9010, 303010, NULL),
(202048, 3, 231000, 9058, 303013, '2023-02-16 10:47:27'),
(202049, 5, 475000, 9057, 303010, '2023-02-20 07:06:20');

--
-- Disparadores `detalle_de_compras`
--
DELIMITER $$
CREATE TRIGGER `aumentar_cantidad_disponibilidad_productos` AFTER INSERT ON `detalle_de_compras` FOR EACH ROW UPDATE producto SET producto.disponibles = producto.disponibles + new.cantidad WHERE producto.id_producto = new.id_producto
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insertar_subtotal_en_detalleCompra` BEFORE INSERT ON `detalle_de_compras` FOR EACH ROW begin
   SET new.subtotal = new.cantidad*(SELECT precio FROM producto WHERE new.id_producto = producto.id_producto);
   SET new.fecha = NOW();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_de_pedido`
--

CREATE TABLE `detalle_de_pedido` (
  `id_detalle_pedido` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `id_producto` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `estado` varchar(45) NOT NULL,
  `envio` varchar(45) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `calificacion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `detalle_de_pedido`
--

INSERT INTO `detalle_de_pedido` (`id_detalle_pedido`, `cantidad`, `precio`, `total`, `id_producto`, `id_pedido`, `estado`, `envio`, `fecha`, `calificacion`) VALUES
(8010, 4, 40000, 160000, 9010, 4010, 'Error en la venta', NULL, NULL, NULL),
(8011, 6, 25000, 150000, 9011, 4010, 'Activo', '', NULL, NULL),
(8012, 2, 30000, 60000, 9012, 4011, 'Activo', '', NULL, NULL),
(8013, 7, 85000, 595000, 9013, 4011, 'Error en la venta', '', NULL, NULL),
(8014, 3, 20000, 60000, 9014, 4012, 'Activo', '', NULL, NULL),
(8015, 4, 32000, 128000, 9015, 4013, 'Activo', '', NULL, NULL),
(8016, 1, 18000, 18000, 9016, 4014, 'Activo', '', NULL, NULL),
(8017, 2, 28000, 56000, 9017, 4015, 'Activo', '', NULL, NULL),
(8024, 3, 32000, 96000, 9015, 4012, 'Activo', '', NULL, NULL),
(8025, 2, 30000, 60000, 9012, 4011, 'Activo', '', NULL, NULL),
(8026, 10, 40000, 400000, 9010, 4014, 'Activo', '', NULL, NULL),
(8027, 3, 40000, 120000, 9010, 4019, 'Error en la venta', '', NULL, NULL),
(8028, 6, 32000, 192000, 9015, 4024, 'Error en la venta', '', NULL, NULL),
(8029, 10, 25000, 250000, 9011, 4011, 'Activo', '', NULL, NULL),
(8030, 2, 25000, 50000, 9011, 4024, 'Activo', '', NULL, NULL),
(8031, 5, 30000, 150000, 9012, 4017, 'Activo', '', NULL, NULL),
(8032, 2, 18000, 36000, 9016, 4013, 'Activo', '', NULL, NULL),
(8033, 9, 40000, 360000, 9010, 4010, 'Activo', '', NULL, NULL),
(8034, 8, 25000, 200000, 9011, 4011, 'Activo', '', NULL, NULL),
(8035, 7, 25000, 175000, 9011, 4010, 'Activo', '', NULL, NULL),
(8036, 7, 40000, 280000, 9010, 4026, 'Activo', '', NULL, NULL),
(8037, 3, 30000, 90000, 9012, 4026, 'Activo', '', NULL, NULL),
(8038, 3, 18000, 54000, 9016, 4028, 'Activo', '', NULL, NULL),
(8039, 10, 85000, 850000, 9013, 4028, 'Error en la venta', '', NULL, NULL),
(8040, 1, 40000, 40000, 9018, 4011, 'Activo', '', NULL, NULL),
(8048, 4, 20000, 80000, 9014, 4013, 'Activo', '', NULL, NULL),
(8054, 4, 20000, 80000, 9014, 4011, 'Activo', '', NULL, NULL),
(8074, 1, 20000, 20000, 9014, 4011, 'Activo', '', NULL, NULL),
(8076, 1, 20000, 20000, 9014, 4011, 'Activo', '', NULL, NULL),
(8077, 2, 18000, 36000, 9016, 4012, 'Activo', '', NULL, NULL),
(8078, 3, 40000, 120000, 9010, 4012, 'Activo', '', NULL, NULL),
(8079, 3, 85000, 255000, 9013, 4015, 'Activo', '', NULL, NULL),
(8080, 1, 40000, 40000, 9018, 4028, 'Activo', '', NULL, NULL),
(8081, 2, 40000, 80000, 9018, 4010, 'Activo', '', NULL, NULL),
(8082, 2, 40000, 80000, 9018, 4010, 'Activo', '', NULL, NULL),
(8086, 2, 40000, 80000, 9018, 4013, 'Activo', '', NULL, NULL),
(8090, 4, 40000, 160000, 9018, 4014, 'Activo', '', NULL, NULL),
(8091, 2, 40000, 80000, 9018, 4014, 'Activo', '', NULL, NULL),
(8092, 2, 40000, 80000, 9018, 4014, 'Activo', '', NULL, NULL),
(8093, 2, 40000, 80000, 9018, 4014, 'Activo', '', NULL, NULL),
(8094, 2, 40000, 80000, 9018, 4013, 'Activo', '', NULL, NULL),
(8095, 2, 40000, 80000, 9018, 4012, 'Activo', '', NULL, NULL),
(8096, 1, 40000, 40000, 9010, 4012, 'Activo', '', NULL, NULL),
(8097, 2, 40000, 80000, 9010, 4033, 'Activo', '', NULL, NULL),
(8098, 1, 40000, 40000, 9010, 4033, 'Error en la venta', '', NULL, NULL),
(8099, 1, 40000, 40000, 9010, 4034, 'Activo', '', NULL, NULL),
(8100, 1, 40000, 40000, 9010, 4034, 'Activo', '', NULL, NULL),
(8101, 1, 40000, 40000, 9010, 4034, 'Activo', '', NULL, NULL),
(8103, 1, 40000, 40000, 9010, 4034, 'Activo', 'si', NULL, NULL),
(8104, 1, 40000, 40000, 9010, 4033, 'Activo', 'no', NULL, NULL),
(8105, 1, 40000, 40000, 9010, 4034, 'Activo', 'si', NULL, NULL),
(8106, 1, 40000, 40000, 9010, 4035, 'Activo', 'si', NULL, NULL),
(8107, 1, 40000, 40000, 9010, 4015, 'Activo', 'no', NULL, NULL),
(8108, 1, 40000, 40000, 9010, 4011, 'Activo', 'no', NULL, NULL),
(8109, 1, 40000, 40000, 9010, 4014, 'Activo', 'si', NULL, NULL),
(8110, 1, 40000, 40000, 9010, 4016, 'Activo', 'si', NULL, NULL),
(8111, 1, 40000, 40000, 9010, 4010, 'Activo', 'no', NULL, NULL),
(8112, 1, 40000, 40000, 9010, 4025, 'Activo', 'no', NULL, NULL),
(8113, 1, 40000, 40000, 9010, 4018, 'Activo', 'no', NULL, NULL),
(8114, 1, 40000, 40000, 9010, 4017, 'Activo', 'no', NULL, NULL),
(8115, 1, 25000, 25000, 9011, 4035, 'Error en la venta', 'si', NULL, NULL),
(8116, 1, 25000, 25000, 9011, 4034, 'Activo', 'no', NULL, NULL),
(8117, 1, 40000, 40000, 9010, 4033, 'Activo', 'si', NULL, NULL),
(8118, 2, 40000, 80000, 9010, 4032, 'Activo', 'si', NULL, NULL),
(8119, 1, 40000, 40000, 9010, 4031, 'Activo', 'si', NULL, NULL),
(8120, 1, 40000, 40000, 9010, 4030, 'Activo', 'no', NULL, NULL),
(8121, 1, 40000, 40000, 9010, 4016, 'Activo', 'si', NULL, NULL),
(8122, 2, 20000, 40000, 9014, 4020, 'Activo', 'si', NULL, NULL),
(8123, 2, 20000, 40000, 9014, 4036, 'Activo', 'no', NULL, NULL),
(8124, 1, 40000, 40000, 9010, 4011, 'Activo', 'no', NULL, NULL),
(8125, 1, 40000, 40000, 9010, 4014, 'Activo', 'no', NULL, NULL),
(8126, 1, 40000, 40000, 9010, 4014, 'Activo,Activo', 'no,si', NULL, NULL),
(8127, 1, 40000, 40000, 9010, 4010, 'Activo', 'no', NULL, NULL),
(8128, 1, 40000, 40000, 9010, 4011, 'Activo', 'si,no', NULL, NULL),
(8129, 1, 40000, 40000, 9010, 4024, 'Activo,Activo', 'no,no', NULL, NULL),
(8130, 1, 40000, 40000, 9010, 4010, 'Activo,Activo', 'si,no', NULL, NULL),
(8131, 1, 40000, 40000, 9010, 4010, 'Activo', 'si', NULL, NULL),
(8132, 1, 40000, 40000, 9010, 4010, 'Activo', 'no', NULL, NULL),
(8133, 1, 40000, 40000, 9010, 4011, 'Activo', 'si', NULL, NULL),
(8134, 1, 40000, 40000, 9010, 4017, 'Activo', 'si', NULL, NULL),
(8135, 1, 40000, 40000, 9010, 4018, 'Activo', NULL, NULL, NULL),
(8136, 1, 40000, 40000, 9010, 4010, 'Activo', NULL, NULL, NULL),
(8137, 1, 40000, 40000, 9010, 4013, 'Activo', 'si', NULL, NULL),
(8138, 1, 40000, 40000, 9010, 4018, 'Activo', NULL, NULL, NULL),
(8139, 1, 40000, 40000, 9010, 4020, 'Activo', 'no', NULL, NULL),
(8140, 1, 40000, 40000, 9010, 4010, 'Activo', 'no', NULL, NULL),
(8141, 1, 40000, 40000, 9010, 4010, 'Activo', 'si', NULL, NULL),
(8142, 1, 40000, 40000, 9010, 4024, 'Activo', 'si', '2023-01-09 21:22:17', NULL),
(8143, 1, 0, 0, 9010, 4031, 'Activo', 'no', NULL, NULL),
(8144, 2, 0, 0, 9010, 4032, 'Activo', 'si', NULL, NULL),
(8145, 1, 0, 0, 9010, 4033, 'Activo', 'no', NULL, NULL),
(8146, 2, 0, 0, 9010, 4034, 'Activo', 'si', NULL, NULL),
(8147, 1, 0, 0, 9010, 4035, 'Activo', 'no', NULL, NULL),
(8148, 2, 0, 0, 9010, 4036, 'Activo', 'si', NULL, NULL),
(8149, 1, 0, 0, 9010, 4030, 'Activo', 'si', NULL, NULL),
(8150, 2, 40000, 80000, 9010, 4031, 'Activo', 'no', '2023-01-09 21:33:02', NULL),
(8151, 1, 40000, 40000, 9010, 4032, 'Activo', 'si', '2023-01-09 21:33:02', NULL),
(8152, 2, 40000, 80000, 9010, 4032, 'Activo', 'no', '2023-01-09 21:33:02', NULL),
(8153, 1, 40000, 40000, 9010, 4033, 'Activo', 'si', '2023-01-09 21:33:02', NULL),
(8154, 2, 40000, 80000, 9010, 4034, 'Activo', 'no', '2023-01-09 21:33:03', NULL),
(8155, 1, 40000, 40000, 9010, 4036, 'Activo', 'si', '2023-01-11 10:30:24', NULL),
(8156, 1, 40000, 40000, 9010, 4035, 'Activo', 'no', '2023-01-11 10:30:30', NULL),
(8157, 1, 40000, 40000, 9010, 4010, 'Activo', 'si', '2023-01-11 11:51:08', NULL),
(8158, 1, 40000, 40000, 9010, 4011, 'Activo', 'si', '2023-01-11 11:51:13', NULL),
(8159, 1, 40000, 40000, 9010, 4014, 'Activo', 'si', '2023-01-11 11:52:08', NULL),
(8160, 2, 40000, 80000, 9010, 4036, 'Activo', 'no', '2023-01-11 11:55:30', NULL),
(8161, 3, 40000, 120000, 9010, 4010, 'Activo', 'si', '2023-01-19 10:35:49', NULL),
(8162, 2, 40000, 80000, 9010, 4010, 'Activo', 'si', '2023-01-19 10:35:54', NULL),
(8163, 2, 25000, 50000, 9011, 4010, 'Activo', 'si', '2023-01-19 10:35:58', NULL),
(8164, 1, 40000, 40000, 9010, 4010, 'Activo', 'si', '2023-01-22 19:56:02', NULL),
(8165, 2, 40000, 80000, 9010, 4010, 'Activo', 'si', '2023-01-22 19:59:29', NULL),
(8166, 1, 40000, 40000, 9010, 4010, 'Activo', 'si', '2023-01-22 20:07:08', NULL),
(8167, 1, 40000, 40000, 9010, 4036, 'Activo', 'si', '2023-01-22 20:10:33', NULL),
(8168, 1, 40000, 47600, 9010, 4010, 'Activo', 'si', '2023-02-16 10:49:52', NULL),
(8169, 1, 25000, 29750, 9011, 4021, 'Activo', 'si', '2023-02-16 11:12:27', NULL),
(8170, 1, 40000, 47600, 9010, 4034, 'Activo', 'si', '2023-02-16 11:14:18', NULL),
(8171, 1, 77000, 91630, 9058, 4024, 'Activo', 'si', '2023-02-17 07:17:48', NULL),
(8172, 1, 40000, 47600, 9010, 4027, 'Activo', 'si', '2023-02-17 07:31:00', NULL),
(8173, 1, 40000, 47600, 9010, 4021, 'Activo', 'si', '2023-02-17 08:26:10', NULL),
(8174, 1, 25000, 29750, 9011, 4013, 'Activo', 'si', '2023-02-17 09:28:38', NULL),
(8175, 1, 40000, 47600, 9010, 4016, 'Activo', 'si', '2023-02-17 09:35:31', NULL),
(8176, 1, 25000, 29750, 9011, 4011, 'Activo', 'si', '2023-02-17 09:41:53', NULL),
(8177, 1, 25000, 29750, 9011, 4015, 'Activo', 'si', '2023-02-17 09:54:32', NULL),
(8178, 1, 25000, 29750, 9011, 4023, 'Activo', 'si', '2023-02-17 09:56:57', NULL),
(8179, 1, 25000, 29750, 9011, 4010, 'Activo', 'si', '2023-02-20 07:00:56', NULL),
(8180, 1, 25000, 29750, 9011, 4020, 'Error en la venta', 'si', NULL, NULL),
(8181, 1, 77000, 91630, 9058, 4012, 'Activo', 'si', '2023-02-20 18:26:21', NULL),
(8182, 1, 25000, 29750, 9011, 4035, 'Activo', 'si', '2023-02-23 12:34:07', NULL),
(8183, 1, 95000, 113050, 9057, 4035, 'Activo', 'si', '2023-02-23 12:45:37', NULL),
(8184, 1, 77000, 91630, 9058, 4035, 'Activo', 'si', '2023-02-23 13:19:26', NULL);

--
-- Disparadores `detalle_de_pedido`
--
DELIMITER $$
CREATE TRIGGER `agregar_envio` AFTER INSERT ON `detalle_de_pedido` FOR EACH ROW IF new.envio = "si" THEN
INSERT INTO envios (envios.id_venta, envios.estado) VALUES (new.id_detalle_pedido, "En proceso");
END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `disminuir_cantidad_disponibilidad_productos` BEFORE INSERT ON `detalle_de_pedido` FOR EACH ROW BEGIN
declare msg varchar(255);
 IF (SELECT disponibles FROM producto WHERE id_producto = new.id_producto) > 0 THEN
  UPDATE producto SET producto.disponibles = producto.disponibles - new.cantidad WHERE producto.id_producto = new.id_producto;

 ELSE
 set msg = concat('Este producto no esta disponible en stock, comuniquese con su administrador'); signal sqlstate '45000' set message_text = msg;
 END IF;
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `error_disponibilidad_producto` BEFORE INSERT ON `detalle_de_pedido` FOR EACH ROW BEGIN
 declare msg varchar(255);
 IF (SELECT producto.estado FROM producto WHERE id_producto = new.id_producto) <> 'Activo' THEN
   set msg = concat('El estado actual del producto es diferente a "Activo", comuniquese con su administrador'); signal sqlstate '45000' set message_text = msg;

 END IF;
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insertar_fecha_pedido` BEFORE INSERT ON `detalle_de_pedido` FOR EACH ROW BEGIN
SET new.fecha = NOW();
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insertar_total_precio_detalle_venta` BEFORE INSERT ON `detalle_de_pedido` FOR EACH ROW begin
   set new.precio = (SELECT precio from producto where id_producto = new.id_producto), new.total = new.precio*new.cantidad + (new.precio*new.cantidad*0.19); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `envios`
--

CREATE TABLE `envios` (
  `id_envio` int(11) NOT NULL,
  `fecha_de_ingreso` datetime DEFAULT NULL,
  `fecha_de_entrega` datetime DEFAULT NULL,
  `estado` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_venta` int(11) DEFAULT NULL,
  `empresa` varchar(245) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `envios`
--

INSERT INTO `envios` (`id_envio`, `fecha_de_ingreso`, `fecha_de_entrega`, `estado`, `id_venta`, `empresa`) VALUES
(6010, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'Entregado', 8010, 'cooperativa'),
(6011, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'Entregado', 8010, 'servientrega'),
(6012, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'Entregado', 8010, ''),
(6013, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'Error de entrega', 8010, ''),
(6014, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'Error de entrega', 8010, 'cooperativa'),
(6015, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'Error de entrega', 8010, 'cooperativa'),
(6016, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6017, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6018, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6019, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, 'iyuujk'),
(6020, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6021, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6022, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6023, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6024, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6025, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6026, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6027, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6028, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6029, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6030, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6031, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6032, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6033, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6034, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6035, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6036, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6037, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6038, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6039, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6040, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6041, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6042, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6043, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6044, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'Entregado', 8010, 'cooperativa'),
(6045, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'Error de entrega', 8010, 'cooperativa'),
(6046, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'Entregado', 8010, 'servientrega'),
(6047, '2023-02-23 10:59:00', '0000-00-00 00:00:00', 'Entregado', 8010, 'cooperativa'),
(6048, '2023-02-23 10:59:01', '0000-00-00 00:00:00', 'Entregado', 8010, 'servientrega'),
(6049, '2023-02-23 10:59:01', '0000-00-00 00:00:00', 'Entregado', 8010, 'cooperativa'),
(6050, '2023-02-23 10:59:01', '0000-00-00 00:00:00', 'Error de entrega', 8010, 'cooperativa'),
(6051, '2023-02-23 10:59:01', '0000-00-00 00:00:00', 'Entregado', 8010, 'servientrega'),
(6052, '2023-02-23 10:59:01', '0000-00-00 00:00:00', 'Entregado', 8010, 'cooperativa'),
(6053, '2023-02-23 10:59:01', '0000-00-00 00:00:00', 'Entregado', 8010, 'cooperativa'),
(6054, '2023-02-23 10:59:01', '0000-00-00 00:00:00', 'Entregado', 8010, 'servientrega'),
(6055, '2023-02-23 10:59:01', '0000-00-00 00:00:00', 'Entregado', 8010, 'cooperativa'),
(6056, '2023-02-23 10:59:01', '0000-00-00 00:00:00', 'Entregado', 8010, 'cooperativa'),
(6057, '2023-02-23 10:59:01', '0000-00-00 00:00:00', 'Entregado', 8010, 'cooperativa'),
(6058, '2023-02-23 10:59:01', '0000-00-00 00:00:00', 'Entregado', 8010, 'servientrega'),
(6059, '2023-02-23 10:59:01', '0000-00-00 00:00:00', 'Entregado', 8010, 'cooperativa'),
(6060, '2023-02-23 10:59:01', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6061, '2023-02-23 10:59:01', '0000-00-00 00:00:00', 'Entregado', 8010, 'cooperativa'),
(6062, '2023-02-23 10:59:01', '0000-00-00 00:00:00', 'En proceso', 8010, ''),
(6064, '2023-02-23 12:45:37', '2023-02-23 12:51:13', 'Entregado', 8183, 'cooperativa'),
(6065, '2023-02-23 13:19:26', '2023-02-23 13:20:31', 'Entregado', 8184, 'servientrega');

--
-- Disparadores `envios`
--
DELIMITER $$
CREATE TRIGGER `ingresar_fecha_entrega` BEFORE UPDATE ON `envios` FOR EACH ROW BEGIN
 IF new.estado = "Entregado" THEN
	SET new.fecha_de_entrega = NOW();
    SET new.fecha_de_ingreso = old.fecha_de_ingreso;
    ELSE
    SET new.fecha_de_ingreso = old.fecha_de_ingreso;
    SET new.fecha_de_entrega = NOW();
 END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ingresar_fecha_ingreso` BEFORE INSERT ON `envios` FOR EACH ROW BEGIN
 SET new.fecha_de_ingreso = NOW();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id_inventario` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `cantidad` int(11) NOT NULL,
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_movimiento` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id_inventario`, `fecha`, `cantidad`, `descripcion`, `id_movimiento`, `id_producto`) VALUES
(101010, '2022-03-22 19:33:31', 4, '', 1, 9010),
(101011, '2022-03-23 19:33:31', 6, '', 1, 9011),
(101012, '2022-03-24 19:33:31', 2, '', 1, 9012),
(101013, '2022-03-25 19:33:31', 7, '', 1, 9013),
(101014, '2022-03-26 19:33:31', 5, '', 2, 9010),
(101015, '2022-03-27 19:33:31', 8, '', 2, 9012),
(101016, '2022-03-28 19:33:31', 20, '', 2, 9013),
(101017, '2022-04-08 18:36:55', 10, '', 2, 9014),
(101018, '2022-04-09 18:36:55', 8, '', 2, 9015),
(101019, '2022-04-10 18:36:55', 9, '', 2, 9016),
(101020, '2022-04-11 18:36:55', 5, '', 2, 9017),
(101021, '2022-05-13 18:36:55', 3, '', 1, 9014),
(101022, '2022-05-14 18:36:55', 4, '', 1, 9015),
(101023, '2022-05-15 18:36:55', 1, '', 1, 9016),
(101024, '2022-05-16 18:36:55', 2, '', 1, 9017);

--
-- Disparadores `inventario`
--
DELIMITER $$
CREATE TRIGGER `registrar_invertario` BEFORE INSERT ON `inventario` FOR EACH ROW begin
insert into producto(nombre,categoria,precio) values(nombre,categoria,precio);
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos`
--

CREATE TABLE `movimientos` (
  `id_movimiento` int(11) NOT NULL,
  `tipo_de_movimiento` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `movimientos`
--

INSERT INTO `movimientos` (`id_movimiento`, `tipo_de_movimiento`) VALUES
(1, 'salida'),
(2, 'entrada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `id_pedido` int(11) NOT NULL,
  `fecha` datetime DEFAULT NULL,
  `cliente` bigint(20) NOT NULL,
  `id_empleado` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `fecha`, `cliente`, `id_empleado`) VALUES
(4010, '2022-03-24 18:59:50', 8784646411, 1006518913),
(4011, '2022-03-25 01:59:50', 5416541968, 1006518913),
(4012, '2022-04-10 18:17:09', 76307332, 1006518913),
(4013, '2022-04-22 18:17:09', 10547808, 1006518913),
(4014, '2022-05-08 18:17:09', 34532270, 1006518913),
(4015, '2022-05-09 18:17:09', 34537236, 1006518913),
(4016, NULL, 5416541968, 1006518913),
(4017, '2022-10-04 00:00:00', 5416541968, 1006518913),
(4018, NULL, 34532270, 1006518913),
(4019, '2022-10-06 00:00:00', 8784646411, 1006518913),
(4020, '2022-10-06 00:00:00', 76307332, 1006518913),
(4021, '2022-10-06 00:00:00', 34532270, 1006518913),
(4022, '2022-10-06 00:00:00', 34532270, 1006518913),
(4023, '2022-10-07 00:00:00', 34537236, 1006518913),
(4024, '2022-10-10 00:00:00', 1069742621, 1006518913),
(4025, '2022-10-10 00:00:00', 76767, 1006518913),
(4026, '2022-10-10 00:00:00', 2222, 1006518913),
(4027, '2022-10-13 00:00:00', 651651, 1006518913),
(4028, '2022-10-13 00:00:00', 651651, 1006518913),
(4029, '2022-10-15 00:00:00', 5416541968, 1006518913),
(4030, '2022-10-15 00:00:00', 8784646411, 1006518913),
(4031, '2022-10-27 00:00:00', 8784646426, 8784646425),
(4032, '2022-10-27 00:00:00', 8784646426, 8784646425),
(4033, '2022-10-27 00:00:00', 8784646426, 8784646425),
(4034, '2022-10-28 00:00:00', 8784646423, 1006518913),
(4035, '2022-11-14 00:00:00', 323232, 8784646425),
(4036, '2022-12-18 00:00:00', 8784646426, 1006518913);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pqrs`
--

CREATE TABLE `pqrs` (
  `id_pqrs` int(11) NOT NULL,
  `tipo_pqrs` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion_pqrs` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `estado_pqrs` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fecha_ingresada` datetime DEFAULT NULL,
  `fecha_respuesta` datetime DEFAULT NULL,
  `id_venta` int(11) NOT NULL,
  `respuesta` varchar(245) DEFAULT NULL,
  `encargado_res` varchar(50) DEFAULT NULL,
  `calificacion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `pqrs`
--

INSERT INTO `pqrs` (`id_pqrs`, `tipo_pqrs`, `descripcion_pqrs`, `estado_pqrs`, `fecha_ingresada`, `fecha_respuesta`, `id_venta`, `respuesta`, `encargado_res`, `calificacion`) VALUES
(1, 'Queja', 'no me resolvieron el problema jovenes', 'respondido', '2023-02-23 11:57:39', '2023-02-23 12:28:29', 8167, 'ya se resolvió', 'f@f.com', NULL),
(2, 'Queja', 'sdf', 'respondido', '2023-02-23 12:01:08', '2023-02-23 13:01:37', 8097, 'fds', 'j@j.com', NULL);

--
-- Disparadores `pqrs`
--
DELIMITER $$
CREATE TRIGGER `ingresar_fecha_estado_pqrs` BEFORE INSERT ON `pqrs` FOR EACH ROW BEGIN
SET new.fecha_ingresada = NOW();
SET new.estado_pqrs = "pendiente";
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `respuesta_pqrs_AFTER_INSERT` BEFORE UPDATE ON `pqrs` FOR EACH ROW begin
 IF new.respuesta = '' THEN	
    SET new.estado_pqrs = "pendiente";
    ELSE
    SET new.estado_pqrs = "respondido";
    SET new.fecha_respuesta = NOW();
    SET new.fecha_ingresada = old.fecha_ingresada;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `categoria` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `precio` float NOT NULL,
  `estado` varchar(245) DEFAULT NULL,
  `disponibles` int(11) DEFAULT NULL,
  `imagen` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `nombre`, `categoria`, `precio`, `estado`, `disponibles`, `imagen`) VALUES
(9010, 'camisa hombre', 'hombre', 40000, 'Activo', 0, NULL),
(9011, 'pantalon niño', 'niño', 25000, 'Activo', 0, NULL),
(9012, 'short mujer', 'mujer', 30000, 'Descontinuado', 0, NULL),
(9013, 'chaqueta unisex', 'unisex', 85000, 'Agotado', 0, NULL),
(9014, 'blusa blanca', 'mujer', 20000, 'Activo', 0, NULL),
(9015, 'camiseta de cuadros', 'hombre', 32000, 'Activo', 0, NULL),
(9016, 'buso pequeño', 'niño', 18000, 'Activo', 0, NULL),
(9017, 'jogger rojo', 'unisex', 28000, 'Activo', 0, NULL),
(9018, 'falda', 'mujer', 40000, 'Activo', 0, NULL),
(9019, 'blusa manga corta', 'mujer', 65000, 'Activo', 0, NULL),
(9022, 'dril en tela', 'hombre', 66000, 'Activo', 0, NULL),
(9023, 'levis', 'unisex', 33000, 'Activo', NULL, NULL),
(9024, '', '', 0, 'Agotado', NULL, NULL),
(9025, '', '', 0, NULL, 0, NULL),
(9026, '', '', 0, NULL, NULL, NULL),
(9027, '', '', 0, NULL, NULL, NULL),
(9028, '', '', 0, NULL, NULL, NULL),
(9029, '', '', 0, NULL, NULL, NULL),
(9030, '', '', 0, NULL, NULL, NULL),
(9031, '', '', 0, NULL, NULL, NULL),
(9032, '', '', 0, NULL, NULL, NULL),
(9033, '', '', 0, NULL, NULL, NULL),
(9034, '', '', 0, NULL, NULL, NULL),
(9035, '', '', 0, NULL, NULL, NULL),
(9036, '', '', 0, NULL, NULL, NULL),
(9037, 'gaban', 'unisex', 70000, 'Activo', NULL, NULL),
(9038, '', '', 0, 'Activo', NULL, NULL),
(9039, '', '', 0, 'Activo', NULL, NULL),
(9040, '', '', 0, 'Activo', NULL, NULL),
(9041, '', '', 0, 'Activo', NULL, NULL),
(9042, '', '', 0, 'Activo', NULL, NULL),
(9043, '', '', 0, 'Activo', NULL, NULL),
(9044, '', '', 0, 'Activo', NULL, NULL),
(9045, '', '', 0, 'Activo', NULL, NULL),
(9046, '', '', 0, 'Activo', NULL, NULL),
(9047, '', '', 0, 'Activo', NULL, NULL),
(9048, '', '', 0, 'Activo', NULL, NULL),
(9049, '', '', 0, 'Activo', NULL, NULL),
(9050, '', '', 0, 'Activo', NULL, NULL),
(9051, '', '', 0, 'Activo', NULL, NULL),
(9052, '', '', 0, 'Activo', NULL, NULL),
(9053, '', '', 0, 'Activo', NULL, NULL),
(9054, 'Gorro Niño', 'niño', 33900, 'Activo', 0, 'gorro_niño.jpeg'),
(9055, 'Saco Hombre', 'hombre', 82000, 'Activo', 0, 'saco-hombre.jpg'),
(9056, 'Jean Unisex', 'unisex', 110000, 'Activo', 0, 'jean_unisex.jpg'),
(9057, 'Ruana Blanca', 'mujer', 95000, 'Activo', 4, 'Ruana-blanca-2.jpg'),
(9058, 'Ruana Capota Cafe', 'unisex', 77000, 'Activo', 0, 'ruana-capota-cafe-3.jpg');

--
-- Disparadores `producto`
--
DELIMITER $$
CREATE TRIGGER `activo_cuando_ingresa_nuevo_productos` BEFORE INSERT ON `producto` FOR EACH ROW BEGIN
 SET new.estado = "Activo";
 SET new.disponibles = 0;
 END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` bigint(20) NOT NULL,
  `nombre_de_proveedor` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` bigint(20) NOT NULL,
  `direccion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nombre_de_proveedor`, `telefono`, `direccion`) VALUES
(404010, 'Jaime gonzales', 3203586789, 'calle 26 #68-34'),
(404011, 'Carlos ramirez', 3123608123, 'diagonal 19d #45-67'),
(404012, 'oracio ignacio celestino', 3204813733, 'Calle 5 # 3 - 20');

--
-- Disparadores `proveedores`
--
DELIMITER $$
CREATE TRIGGER `pro_com` AFTER INSERT ON `proveedores` FOR EACH ROW begin
insert into compras(fecha,descripcion,id_proveedor) values(now(),descripcion,new.id_proveedor);
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre_de_rol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre_de_rol`) VALUES
(1010, 'ROLE_CLIENTE'),
(1011, 'ROLE_ADMIN'),
(1012, 'ROLE_EMPLEADO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles_usuarios`
--

CREATE TABLE `roles_usuarios` (
  `id_rol_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `id_usuario` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `roles_usuarios`
--

INSERT INTO `roles_usuarios` (`id_rol_usuario`, `id_rol`, `id_usuario`) VALUES
(2010, 1011, 1000939256),
(2011, 1012, 1006518913),
(2012, 1010, 5416541968),
(2013, 1010, 8784646411),
(2014, 1010, 76307332),
(2015, 1010, 10547808),
(2016, 1010, 34532270),
(2017, 1010, 34537236),
(2019, 1010, 9999),
(2023, 1010, 47417),
(2024, 1010, 8784646416),
(2025, 1010, 2222),
(2026, 1010, 3333),
(2028, 1010, 8784646417),
(2029, 1010, 76767),
(2030, 1010, 2315487),
(2031, 1010, 1069742621),
(2032, 1010, 1031296),
(2033, 1010, 1651561),
(2034, 1010, 12651),
(2035, 1010, 651651),
(2036, 1010, 1000625803),
(2037, 1010, 8784646423),
(2038, 1011, 8784646424),
(2039, 1012, 8784646425),
(2040, 1010, 8784646426),
(2041, 1010, 8784646430),
(2042, 1010, 8784646433),
(2056, 1010, 8784646412),
(2057, 1010, 8784646413),
(2058, 1010, 8784646414),
(2070, 1010, 777),
(2072, 1010, 323232);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` bigint(20) NOT NULL,
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` bigint(20) NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `direccion` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `telefono`, `email`, `direccion`, `password`) VALUES
(777, '77a', 777, '77@gm.com', '777', '$2a$10$2e87mziXjmx4boHvfJ0S.efyscw9/UP9JMT4jWYywkF5bvK9UV0Bu'),
(2222, '222', 2222, '22@gmail.com', '222', '1'),
(3333, '333', 3333, '333@gmail.com', '333', '1'),
(9999, 'luis', 11111, 'luis@gmail.com', 'calle falsa', '1'),
(12651, 'gasd', 12651, 'dsaf@gm.com', 'sdafsda1132 ', '12651'),
(47417, 'kali', 474747, 'kali@gmail.com', 'calle47474', '1'),
(76767, '7677', 7677, '76767@s.com', '76767', '1'),
(323232, 'zzzx', 323232787, 'z@z.com', 'zzzzzzz', '$2a$10$l.BumQXMv3iZcVDuBy9Uou9IkmPDsh0FV81gi8rTo1N3wwx7OOpJC'),
(651651, 'francisco', 351651, 'mierderos@gmail.com', 'calle falsa mierderos', '651651'),
(1031296, 'maria fernanda garcia calvo', 3015555799, 'mafe_8075@gmail.com', 'calle 136a # 102a - 42', '1031296'),
(1651561, 'aurora rivera', 31306548, 'aurora@gmail.com', 'calle 136 # 101b-56', '1651561'),
(2315487, 'maco', 2315487, '2315487@s.com', '2315487', '2315487'),
(10547808, 'ACOSTA FAUSTO JOSE', 6700555, 'acostafausto@gmail.com', 'A Calle 100 # 11B-27 Bogotá\r\n', 'fausto123'),
(34532270, 'ACOSTA ARAGON MARIA AMPARO', 7229393, 'acostaaraagon@gmail.com', 'Carrera 20 B # 29-18. Barrio Pie de la Popa.\r\n', 'aragon123'),
(34537236, 'BUCHELI LOPEZ ADRIANA', 3178503333, 'bucheli@gmail.com', 'Calle 20 # 24-05 Barrio Centro\r\n', 'lopez123'),
(76307332, 'ABELLA HERRERA WILLIAM EFRAIN', 3455500, 'abella@gmail.com', 'Carrera 21 # 17 -63\r\n', 'herrera123'),
(1000625803, 'TYAKEMICHE FRANCISCO', 2312156165, 'FCISNER@HORMAIL.COM', 'DIAGONAL 14', '1000625803'),
(1000939256, 'hugo armando garcia\r\n', 2147483647, 'hugo@gmail.com\r\n', 'Cll 136a # 102a - 42\r\n', '$2a$10$W/23QQMz9WDugq6M5iuA1O3quXjtvcyrnOzRVnTQji5Um.wqfV9Uq'),
(1006518913, 'fiorella sanchez rocha\r\n', 3156604832, 'fiorella@gmail.com\r\n', 'Calle 10 # 5-51\r\n', 'fio123'),
(1069742621, 'lorena', 32136512, 'lorena@gmail.com', 'callesubia123', '1069742621'),
(5416541968, 'francisco cisneros\r\n', 3842166687, 'francisco@gmail.com\r\n', 'Avenida 19 No. 98-03, sexto piso, Edificio Torre 100\r\n', 'fran123'),
(8784646411, 'mauricio gomez', 3002583165, 'mauricio@gmail.com', 'Calle 53 No 10-60/46, Piso 2.\r\n', '$2a$10$lmKijVVzssUjKnCCZhO3Ben6unWC5XC.MRis24a8Nfa/Vx04HyOE.'),
(8784646412, 'maicol', 304564, 'maicol@gmail.com', 'calle123', '1'),
(8784646413, 'xdfg', 35412, 'ds@gmail.com', 'dfxg', '1'),
(8784646414, 'xdfg', 35412, 'dss@gmail.com', 'dfxg', '1'),
(8784646416, 'hugo', 1111, 'info@conluzmeditacion.com', 'calle1111', '1'),
(8784646417, '00', 0, '000@d.com', '000', '1'),
(8784646423, 'fa', 123, 'fa@hot.com', '123', '$2a$10$J2tHRXcljqPjyWzWGGdzx.6jsePx2a2meYHOgdWTh34LzShYRD2SK'),
(8784646424, 'f', 123, 'f@f.com', 'f12', '$2a$10$QM3Q.E5W.BVPqno9f7zEg.Kn9bO7qyw9T4/uWHiBdGafsVU6ZE2aq'),
(8784646425, 'j', 123, 'j@j.com', 'j123', '$2a$10$kL4t8GRifjorwFCaQNHR4OBvjJpsFN0MRweUvEkPH/H5QAjKQwCIK'),
(8784646426, 't', 123, 't@t.com', '1234 falsa', '$2a$10$W/23QQMz9WDugq6M5iuA1O3quXjtvcyrnOzRVnTQji5Um.wqfV9Uq'),
(8784646430, 'lusa', 555, 'lusa@lusa.com', 'calle lusa', '$2a$10$H8hxdaZ4QuhJ0mOLSjpJc.jxKpjjTpmcfOBtjQ54B8Obwcy7b7THq'),
(8784646433, 'r', 202020, 'r@r.com', 'r #', '$2a$10$khRo/xQ9I.raA4pWT40Dn.jvtpasVev/XiOa/8AejfpiUDbx5hhqy');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD PRIMARY KEY (`id_calificacion`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compras`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `detalle_de_compras`
--
ALTER TABLE `detalle_de_compras`
  ADD PRIMARY KEY (`id_detalle_compras`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_compras` (`id_compras`);

--
-- Indices de la tabla `detalle_de_pedido`
--
ALTER TABLE `detalle_de_pedido`
  ADD PRIMARY KEY (`id_detalle_pedido`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `calificacion` (`calificacion`);

--
-- Indices de la tabla `envios`
--
ALTER TABLE `envios`
  ADD PRIMARY KEY (`id_envio`),
  ADD KEY `id_venta` (`id_venta`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id_inventario`),
  ADD KEY `id_movimiento` (`id_movimiento`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD PRIMARY KEY (`id_movimiento`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `cliente` (`cliente`),
  ADD KEY `id_empleado` (`id_empleado`),
  ADD KEY `id_pedido` (`id_pedido`);

--
-- Indices de la tabla `pqrs`
--
ALTER TABLE `pqrs`
  ADD PRIMARY KEY (`id_pqrs`),
  ADD KEY `id_venta` (`id_venta`),
  ADD KEY `calificacion` (`calificacion`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `roles_usuarios`
--
ALTER TABLE `roles_usuarios`
  ADD PRIMARY KEY (`id_rol_usuario`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  MODIFY `id_calificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7015;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compras` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=303023;

--
-- AUTO_INCREMENT de la tabla `detalle_de_compras`
--
ALTER TABLE `detalle_de_compras`
  MODIFY `id_detalle_compras` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=202050;

--
-- AUTO_INCREMENT de la tabla `detalle_de_pedido`
--
ALTER TABLE `detalle_de_pedido`
  MODIFY `id_detalle_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8185;

--
-- AUTO_INCREMENT de la tabla `envios`
--
ALTER TABLE `envios`
  MODIFY `id_envio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6066;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id_inventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101025;

--
-- AUTO_INCREMENT de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  MODIFY `id_movimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4037;

--
-- AUTO_INCREMENT de la tabla `pqrs`
--
ALTER TABLE `pqrs`
  MODIFY `id_pqrs` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9059;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=404013;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1013;

--
-- AUTO_INCREMENT de la tabla `roles_usuarios`
--
ALTER TABLE `roles_usuarios`
  MODIFY `id_rol_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2073;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8784646434;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`);

--
-- Filtros para la tabla `detalle_de_compras`
--
ALTER TABLE `detalle_de_compras`
  ADD CONSTRAINT `detalle_de_compras_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  ADD CONSTRAINT `detalle_de_compras_ibfk_2` FOREIGN KEY (`id_compras`) REFERENCES `compras` (`id_compras`);

--
-- Filtros para la tabla `detalle_de_pedido`
--
ALTER TABLE `detalle_de_pedido`
  ADD CONSTRAINT `detalle_de_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`),
  ADD CONSTRAINT `detalle_de_pedido_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  ADD CONSTRAINT `detalle_de_pedido_ibfk_3` FOREIGN KEY (`calificacion`) REFERENCES `calificacion` (`id_calificacion`);

--
-- Filtros para la tabla `envios`
--
ALTER TABLE `envios`
  ADD CONSTRAINT `envios_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `detalle_de_pedido` (`id_detalle_pedido`);

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_movimiento`) REFERENCES `movimientos` (`id_movimiento`),
  ADD CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`);

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `pqrs`
--
ALTER TABLE `pqrs`
  ADD CONSTRAINT `pqrs_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `detalle_de_pedido` (`id_detalle_pedido`),
  ADD CONSTRAINT `pqrs_ibfk_2` FOREIGN KEY (`calificacion`) REFERENCES `calificacion` (`id_calificacion`);

--
-- Filtros para la tabla `roles_usuarios`
--
ALTER TABLE `roles_usuarios`
  ADD CONSTRAINT `roles_usuarios_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`),
  ADD CONSTRAINT `roles_usuarios_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
