-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-01-2025 a las 01:55:48
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `implantacion`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrativo`
--

CREATE TABLE `administrativo` (
  `id_administrativo` int(11) NOT NULL,
  `usuario` varchar(250) DEFAULT NULL,
  `contraseña` varchar(250) DEFAULT NULL,
  `Nombre1` varchar(250) DEFAULT NULL,
  `Nombre2` varchar(250) DEFAULT NULL,
  `Apellido1` varchar(250) DEFAULT NULL,
  `Apellido2` varchar(250) DEFAULT NULL,
  `foto` blob DEFAULT NULL,
  `tipo_doc` enum('V','E','J','P') NOT NULL,
  `num_doc` varchar(12) NOT NULL,
  `correo` varchar(70) NOT NULL,
  `Fecha_Nac` date NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `status` enum('activo','inactivo') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `administrativo`
--

INSERT INTO `administrativo` (`id_administrativo`, `usuario`, `contraseña`, `Nombre1`, `Nombre2`, `Apellido1`, `Apellido2`, `foto`, `tipo_doc`, `num_doc`, `correo`, `Fecha_Nac`, `telefono`, `status`) VALUES
(1, 'ana12322', '202cb962ac59075b964b07152d234b70', 'Marcelis', 'Anais', 'Dun', 'Suarez', NULL, 'V', '12345678', 'anais.asdm@gmail.com', '1995-07-05', '04120515005', 'activo'),
(2, 'michi12322', '202cb962ac59075b964b07152d234b70', 'Michelle', 'Veruska', 'Camacaro', 'Daza', NULL, 'V', '29795906', 'michi@gmail.com', '2001-12-21', '04125555555', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agenda`
--

CREATE TABLE `agenda` (
  `id_agenda` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_final` time NOT NULL,
  `contador_cita` int(11) DEFAULT NULL,
  `id_paciente` int(11) DEFAULT NULL,
  `status` enum('Pendiente','Confirmada','Completada','Cancelada','Reprogramada') NOT NULL,
  `link_meet` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `agenda`
--

INSERT INTO `agenda` (`id_agenda`, `fecha`, `hora_inicio`, `hora_final`, `contador_cita`, `id_paciente`, `status`, `link_meet`) VALUES
(74, '2025-01-18', '22:00:00', '22:45:00', 1, 2, 'Pendiente', NULL),
(75, '2025-01-18', '17:00:00', '17:45:00', 2, 2, 'Pendiente', 'https://meet.google.com/qea-qkqg-tfu'),
(76, '2025-01-20', '22:00:00', '22:45:00', 1, 4, 'Pendiente', NULL),
(77, '2025-01-20', '01:00:00', '01:45:00', 1, 2, 'Pendiente', NULL),
(78, '2025-01-20', '03:00:00', '03:45:00', 1, 6, 'Pendiente', 'https://meet.google.com/jyo-emfb-qmb'),
(91, '2025-01-29', '01:00:00', '01:45:00', 1, 11, 'Pendiente', NULL),
(92, '2025-01-31', '10:00:00', '10:45:00', 1, 9, 'Pendiente', 'https://meet.google.com/dyu-zryj-jwj'),
(93, '2025-02-02', '22:00:00', '22:45:00', 1, 2, 'Pendiente', 'https://meet.google.com/kqy-uhiy-kpy');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `antecedentes_familiares`
--

CREATE TABLE `antecedentes_familiares` (
  `id_antecedentes_familiares` int(11) NOT NULL,
  `abuelo_p` varchar(70) NOT NULL,
  `abuela_p` varchar(70) NOT NULL,
  `padre` varchar(70) NOT NULL,
  `tios_p` text NOT NULL,
  `abuelo_m` varchar(70) NOT NULL,
  `abuela_m` varchar(70) NOT NULL,
  `madre` varchar(70) NOT NULL,
  `tios_m` text NOT NULL,
  `hermanos` text NOT NULL,
  `esposo(a)` text NOT NULL,
  `hijos` text NOT NULL,
  `colaterales` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `id_cita` int(11) NOT NULL,
  `id_agenda` int(11) NOT NULL,
  `id_psicologo` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `id_tipo_cita` int(10) NOT NULL,
  `fecha` datetime NOT NULL,
  `motivo` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`id_cita`, `id_agenda`, `id_psicologo`, `id_paciente`, `id_tipo_cita`, `fecha`, `motivo`) VALUES
(81, 74, 7, 2, 123, '2025-01-18 00:00:00', 'Consulta'),
(82, 75, 7, 2, 124, '2025-01-18 00:00:00', 'ConsultaOnline'),
(83, 76, 7, 4, 135, '2025-01-20 00:00:00', 'Consulta'),
(84, 77, 7, 2, 136, '2025-01-20 00:00:00', 'Test10'),
(85, 78, 7, 6, 138, '2025-01-20 00:00:00', 'Test50'),
(89, 91, 7, 11, 159, '2025-01-29 00:00:00', 'test9'),
(90, 92, 7, 9, 160, '2025-01-31 00:00:00', 'Test10'),
(91, 93, 7, 2, 161, '2025-02-02 00:00:00', 'ConsultaPareja');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudades`
--

CREATE TABLE `ciudades` (
  `id_ciudad` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL,
  `ciudad` varchar(200) NOT NULL,
  `capital` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ciudades`
--

INSERT INTO `ciudades` (`id_ciudad`, `id_estado`, `ciudad`, `capital`) VALUES
(1, 1, 'Maroa', 0),
(2, 1, 'Puerto Ayacucho', 1),
(3, 1, 'San Fernando de Atabapo', 0),
(4, 2, 'Anaco', 0),
(5, 2, 'Aragua de Barcelona', 0),
(6, 2, 'Barcelona', 1),
(7, 2, 'Boca de Uchire', 0),
(8, 2, 'Cantaura', 0),
(9, 2, 'Clarines', 0),
(10, 2, 'El Chaparro', 0),
(11, 2, 'El Pao Anzoátegui', 0),
(12, 2, 'El Tigre', 0),
(13, 2, 'El Tigrito', 0),
(14, 2, 'Guanape', 0),
(15, 2, 'Guanta', 0),
(16, 2, 'Lechería', 0),
(17, 2, 'Onoto', 0),
(18, 2, 'Pariaguán', 0),
(19, 2, 'Píritu', 0),
(20, 2, 'Puerto La Cruz', 0),
(21, 2, 'Puerto Píritu', 0),
(22, 2, 'Sabana de Uchire', 0),
(23, 2, 'San Mateo Anzoátegui', 0),
(24, 2, 'San Pablo Anzoátegui', 0),
(25, 2, 'San Tomé', 0),
(26, 2, 'Santa Ana de Anzoátegui', 0),
(27, 2, 'Santa Fe Anzoátegui', 0),
(28, 2, 'Santa Rosa', 0),
(29, 2, 'Soledad', 0),
(30, 2, 'Urica', 0),
(31, 2, 'Valle de Guanape', 0),
(43, 3, 'Achaguas', 0),
(44, 3, 'Biruaca', 0),
(45, 3, 'Bruzual', 0),
(46, 3, 'El Amparo', 0),
(47, 3, 'El Nula', 0),
(48, 3, 'Elorza', 0),
(49, 3, 'Guasdualito', 0),
(50, 3, 'Mantecal', 0),
(51, 3, 'Puerto Páez', 0),
(52, 3, 'San Fernando de Apure', 1),
(53, 3, 'San Juan de Payara', 0),
(54, 4, 'Barbacoas', 0),
(55, 4, 'Cagua', 0),
(56, 4, 'Camatagua', 0),
(58, 4, 'Choroní', 0),
(59, 4, 'Colonia Tovar', 0),
(60, 4, 'El Consejo', 0),
(61, 4, 'La Victoria', 0),
(62, 4, 'Las Tejerías', 0),
(63, 4, 'Magdaleno', 0),
(64, 4, 'Maracay', 1),
(65, 4, 'Ocumare de La Costa', 0),
(66, 4, 'Palo Negro', 0),
(67, 4, 'San Casimiro', 0),
(68, 4, 'San Mateo', 0),
(69, 4, 'San Sebastián', 0),
(70, 4, 'Santa Cruz de Aragua', 0),
(71, 4, 'Tocorón', 0),
(72, 4, 'Turmero', 0),
(73, 4, 'Villa de Cura', 0),
(74, 4, 'Zuata', 0),
(75, 5, 'Barinas', 1),
(76, 5, 'Barinitas', 0),
(77, 5, 'Barrancas', 0),
(78, 5, 'Calderas', 0),
(79, 5, 'Capitanejo', 0),
(80, 5, 'Ciudad Bolivia', 0),
(81, 5, 'El Cantón', 0),
(82, 5, 'Las Veguitas', 0),
(83, 5, 'Libertad de Barinas', 0),
(84, 5, 'Sabaneta', 0),
(85, 5, 'Santa Bárbara de Barinas', 0),
(86, 5, 'Socopó', 0),
(87, 6, 'Caicara del Orinoco', 0),
(88, 6, 'Canaima', 0),
(89, 6, 'Ciudad Bolívar', 1),
(90, 6, 'Ciudad Piar', 0),
(91, 6, 'El Callao', 0),
(92, 6, 'El Dorado', 0),
(93, 6, 'El Manteco', 0),
(94, 6, 'El Palmar', 0),
(95, 6, 'El Pao', 0),
(96, 6, 'Guasipati', 0),
(97, 6, 'Guri', 0),
(98, 6, 'La Paragua', 0),
(99, 6, 'Matanzas', 0),
(100, 6, 'Puerto Ordaz', 0),
(101, 6, 'San Félix', 0),
(102, 6, 'Santa Elena de Uairén', 0),
(103, 6, 'Tumeremo', 0),
(104, 6, 'Unare', 0),
(105, 6, 'Upata', 0),
(106, 7, 'Bejuma', 0),
(107, 7, 'Belén', 0),
(108, 7, 'Campo de Carabobo', 0),
(109, 7, 'Canoabo', 0),
(110, 7, 'Central Tacarigua', 0),
(111, 7, 'Chirgua', 0),
(112, 7, 'Ciudad Alianza', 0),
(113, 7, 'El Palito', 0),
(114, 7, 'Guacara', 0),
(115, 7, 'Guigue', 0),
(116, 7, 'Las Trincheras', 0),
(117, 7, 'Los Guayos', 0),
(118, 7, 'Mariara', 0),
(119, 7, 'Miranda', 0),
(120, 7, 'Montalbán', 0),
(121, 7, 'Morón', 0),
(122, 7, 'Naguanagua', 0),
(123, 7, 'Puerto Cabello', 0),
(124, 7, 'San Joaquín', 0),
(125, 7, 'Tocuyito', 0),
(126, 7, 'Urama', 0),
(127, 7, 'Valencia', 1),
(128, 7, 'Vigirimita', 0),
(129, 8, 'Aguirre', 0),
(130, 8, 'Apartaderos Cojedes', 0),
(131, 8, 'Arismendi', 0),
(132, 8, 'Camuriquito', 0),
(133, 8, 'El Baúl', 0),
(134, 8, 'El Limón', 0),
(135, 8, 'El Pao Cojedes', 0),
(136, 8, 'El Socorro', 0),
(137, 8, 'La Aguadita', 0),
(138, 8, 'Las Vegas', 0),
(139, 8, 'Libertad de Cojedes', 0),
(140, 8, 'Mapuey', 0),
(141, 8, 'Piñedo', 0),
(142, 8, 'Samancito', 0),
(143, 8, 'San Carlos', 1),
(144, 8, 'Sucre', 0),
(145, 8, 'Tinaco', 0),
(146, 8, 'Tinaquillo', 0),
(147, 8, 'Vallecito', 0),
(148, 9, 'Tucupita', 1),
(149, 24, 'Caracas', 1),
(150, 24, 'El Junquito', 0),
(151, 10, 'Adícora', 0),
(152, 10, 'Boca de Aroa', 0),
(153, 10, 'Cabure', 0),
(154, 10, 'Capadare', 0),
(155, 10, 'Capatárida', 0),
(156, 10, 'Chichiriviche', 0),
(157, 10, 'Churuguara', 0),
(158, 10, 'Coro', 1),
(159, 10, 'Cumarebo', 0),
(160, 10, 'Dabajuro', 0),
(161, 10, 'Judibana', 0),
(162, 10, 'La Cruz de Taratara', 0),
(163, 10, 'La Vela de Coro', 0),
(164, 10, 'Los Taques', 0),
(165, 10, 'Maparari', 0),
(166, 10, 'Mene de Mauroa', 0),
(167, 10, 'Mirimire', 0),
(168, 10, 'Pedregal', 0),
(169, 10, 'Píritu Falcón', 0),
(170, 10, 'Pueblo Nuevo Falcón', 0),
(171, 10, 'Puerto Cumarebo', 0),
(172, 10, 'Punta Cardón', 0),
(173, 10, 'Punto Fijo', 0),
(174, 10, 'San Juan de Los Cayos', 0),
(175, 10, 'San Luis', 0),
(176, 10, 'Santa Ana Falcón', 0),
(177, 10, 'Santa Cruz De Bucaral', 0),
(178, 10, 'Tocopero', 0),
(179, 10, 'Tocuyo de La Costa', 0),
(180, 10, 'Tucacas', 0),
(181, 10, 'Yaracal', 0),
(182, 11, 'Altagracia de Orituco', 0),
(183, 11, 'Cabruta', 0),
(184, 11, 'Calabozo', 0),
(185, 11, 'Camaguán', 0),
(196, 11, 'Chaguaramas Guárico', 0),
(197, 11, 'El Socorro', 0),
(198, 11, 'El Sombrero', 0),
(199, 11, 'Las Mercedes de Los Llanos', 0),
(200, 11, 'Lezama', 0),
(201, 11, 'Onoto', 0),
(202, 11, 'Ortíz', 0),
(203, 11, 'San José de Guaribe', 0),
(204, 11, 'San Juan de Los Morros', 1),
(205, 11, 'San Rafael de Laya', 0),
(206, 11, 'Santa María de Ipire', 0),
(207, 11, 'Tucupido', 0),
(208, 11, 'Valle de La Pascua', 0),
(209, 11, 'Zaraza', 0),
(210, 12, 'Aguada Grande', 0),
(211, 12, 'Atarigua', 0),
(212, 12, 'Barquisimeto', 1),
(213, 12, 'Bobare', 0),
(214, 12, 'Cabudare', 0),
(215, 12, 'Carora', 0),
(216, 12, 'Cubiro', 0),
(217, 12, 'Cují', 0),
(218, 12, 'Duaca', 0),
(219, 12, 'El Manzano', 0),
(220, 12, 'El Tocuyo', 0),
(221, 12, 'Guaríco', 0),
(222, 12, 'Humocaro Alto', 0),
(223, 12, 'Humocaro Bajo', 0),
(224, 12, 'La Miel', 0),
(225, 12, 'Moroturo', 0),
(226, 12, 'Quíbor', 0),
(227, 12, 'Río Claro', 0),
(228, 12, 'Sanare', 0),
(229, 12, 'Santa Inés', 0),
(230, 12, 'Sarare', 0),
(231, 12, 'Siquisique', 0),
(232, 12, 'Tintorero', 0),
(233, 13, 'Apartaderos Mérida', 0),
(234, 13, 'Arapuey', 0),
(235, 13, 'Bailadores', 0),
(236, 13, 'Caja Seca', 0),
(237, 13, 'Canaguá', 0),
(238, 13, 'Chachopo', 0),
(239, 13, 'Chiguara', 0),
(240, 13, 'Ejido', 0),
(241, 13, 'El Vigía', 0),
(242, 13, 'La Azulita', 0),
(243, 13, 'La Playa', 0),
(244, 13, 'Lagunillas Mérida', 0),
(245, 13, 'Mérida', 1),
(246, 13, 'Mesa de Bolívar', 0),
(247, 13, 'Mucuchíes', 0),
(248, 13, 'Mucujepe', 0),
(249, 13, 'Mucuruba', 0),
(250, 13, 'Nueva Bolivia', 0),
(251, 13, 'Palmarito', 0),
(252, 13, 'Pueblo Llano', 0),
(253, 13, 'Santa Cruz de Mora', 0),
(254, 13, 'Santa Elena de Arenales', 0),
(255, 13, 'Santo Domingo', 0),
(256, 13, 'Tabáy', 0),
(257, 13, 'Timotes', 0),
(258, 13, 'Torondoy', 0),
(259, 13, 'Tovar', 0),
(260, 13, 'Tucani', 0),
(261, 13, 'Zea', 0),
(262, 14, 'Araguita', 0),
(263, 14, 'Carrizal', 0),
(264, 14, 'Caucagua', 0),
(265, 14, 'Chaguaramas Miranda', 0),
(266, 14, 'Charallave', 0),
(267, 14, 'Chirimena', 0),
(268, 14, 'Chuspa', 0),
(269, 14, 'Cúa', 0),
(270, 14, 'Cupira', 0),
(271, 14, 'Curiepe', 0),
(272, 14, 'El Guapo', 0),
(273, 14, 'El Jarillo', 0),
(274, 14, 'Filas de Mariche', 0),
(275, 14, 'Guarenas', 0),
(276, 14, 'Guatire', 0),
(277, 14, 'Higuerote', 0),
(278, 14, 'Los Anaucos', 0),
(279, 14, 'Los Teques', 1),
(280, 14, 'Ocumare del Tuy', 0),
(281, 14, 'Panaquire', 0),
(282, 14, 'Paracotos', 0),
(283, 14, 'Río Chico', 0),
(284, 14, 'San Antonio de Los Altos', 0),
(285, 14, 'San Diego de Los Altos', 0),
(286, 14, 'San Fernando del Guapo', 0),
(287, 14, 'San Francisco de Yare', 0),
(288, 14, 'San José de Los Altos', 0),
(289, 14, 'San José de Río Chico', 0),
(290, 14, 'San Pedro de Los Altos', 0),
(291, 14, 'Santa Lucía', 0),
(292, 14, 'Santa Teresa', 0),
(293, 14, 'Tacarigua de La Laguna', 0),
(294, 14, 'Tacarigua de Mamporal', 0),
(295, 14, 'Tácata', 0),
(296, 14, 'Turumo', 0),
(297, 15, 'Aguasay', 0),
(298, 15, 'Aragua de Maturín', 0),
(299, 15, 'Barrancas del Orinoco', 0),
(300, 15, 'Caicara de Maturín', 0),
(301, 15, 'Caripe', 0),
(302, 15, 'Caripito', 0),
(303, 15, 'Chaguaramal', 0),
(305, 15, 'Chaguaramas Monagas', 0),
(307, 15, 'El Furrial', 0),
(308, 15, 'El Tejero', 0),
(309, 15, 'Jusepín', 0),
(310, 15, 'La Toscana', 0),
(311, 15, 'Maturín', 1),
(312, 15, 'Miraflores', 0),
(313, 15, 'Punta de Mata', 0),
(314, 15, 'Quiriquire', 0),
(315, 15, 'San Antonio de Maturín', 0),
(316, 15, 'San Vicente Monagas', 0),
(317, 15, 'Santa Bárbara', 0),
(318, 15, 'Temblador', 0),
(319, 15, 'Teresen', 0),
(320, 15, 'Uracoa', 0),
(321, 16, 'Altagracia', 0),
(322, 16, 'Boca de Pozo', 0),
(323, 16, 'Boca de Río', 0),
(324, 16, 'El Espinal', 0),
(325, 16, 'El Valle del Espíritu Santo', 0),
(326, 16, 'El Yaque', 0),
(327, 16, 'Juangriego', 0),
(328, 16, 'La Asunción', 1),
(329, 16, 'La Guardia', 0),
(330, 16, 'Pampatar', 0),
(331, 16, 'Porlamar', 0),
(332, 16, 'Puerto Fermín', 0),
(333, 16, 'Punta de Piedras', 0),
(334, 16, 'San Francisco de Macanao', 0),
(335, 16, 'San Juan Bautista', 0),
(336, 16, 'San Pedro de Coche', 0),
(337, 16, 'Santa Ana de Nueva Esparta', 0),
(338, 16, 'Villa Rosa', 0),
(339, 17, 'Acarigua', 0),
(340, 17, 'Agua Blanca', 0),
(341, 17, 'Araure', 0),
(342, 17, 'Biscucuy', 0),
(343, 17, 'Boconoito', 0),
(344, 17, 'Campo Elías', 0),
(345, 17, 'Chabasquén', 0),
(346, 17, 'Guanare', 1),
(347, 17, 'Guanarito', 0),
(348, 17, 'La Aparición', 0),
(349, 17, 'La Misión', 0),
(350, 17, 'Mesa de Cavacas', 0),
(351, 17, 'Ospino', 0),
(352, 17, 'Papelón', 0),
(353, 17, 'Payara', 0),
(354, 17, 'Pimpinela', 0),
(355, 17, 'Píritu de Portuguesa', 0),
(356, 17, 'San Rafael de Onoto', 0),
(357, 17, 'Santa Rosalía', 0),
(358, 17, 'Turén', 0),
(359, 18, 'Altos de Sucre', 0),
(360, 18, 'Araya', 0),
(361, 18, 'Cariaco', 0),
(362, 18, 'Carúpano', 0),
(363, 18, 'Casanay', 0),
(364, 18, 'Cumaná', 1),
(365, 18, 'Cumanacoa', 0),
(366, 18, 'El Morro Puerto Santo', 0),
(367, 18, 'El Pilar', 0),
(368, 18, 'El Poblado', 0),
(369, 18, 'Guaca', 0),
(370, 18, 'Guiria', 0),
(371, 18, 'Irapa', 0),
(372, 18, 'Manicuare', 0),
(373, 18, 'Mariguitar', 0),
(374, 18, 'Río Caribe', 0),
(375, 18, 'San Antonio del Golfo', 0),
(376, 18, 'San José de Aerocuar', 0),
(377, 18, 'San Vicente de Sucre', 0),
(378, 18, 'Santa Fe de Sucre', 0),
(379, 18, 'Tunapuy', 0),
(380, 18, 'Yaguaraparo', 0),
(381, 18, 'Yoco', 0),
(382, 19, 'Abejales', 0),
(383, 19, 'Borota', 0),
(384, 19, 'Bramon', 0),
(385, 19, 'Capacho', 0),
(386, 19, 'Colón', 0),
(387, 19, 'Coloncito', 0),
(388, 19, 'Cordero', 0),
(389, 19, 'El Cobre', 0),
(390, 19, 'El Pinal', 0),
(391, 19, 'Independencia', 0),
(392, 19, 'La Fría', 0),
(393, 19, 'La Grita', 0),
(394, 19, 'La Pedrera', 0),
(395, 19, 'La Tendida', 0),
(396, 19, 'Las Delicias', 0),
(397, 19, 'Las Hernández', 0),
(398, 19, 'Lobatera', 0),
(399, 19, 'Michelena', 0),
(400, 19, 'Palmira', 0),
(401, 19, 'Pregonero', 0),
(402, 19, 'Queniquea', 0),
(403, 19, 'Rubio', 0),
(404, 19, 'San Antonio del Tachira', 0),
(405, 19, 'San Cristobal', 1),
(406, 19, 'San José de Bolívar', 0),
(407, 19, 'San Josecito', 0),
(408, 19, 'San Pedro del Río', 0),
(409, 19, 'Santa Ana Táchira', 0),
(410, 19, 'Seboruco', 0),
(411, 19, 'Táriba', 0),
(412, 19, 'Umuquena', 0),
(413, 19, 'Ureña', 0),
(414, 20, 'Batatal', 0),
(415, 20, 'Betijoque', 0),
(416, 20, 'Boconó', 0),
(417, 20, 'Carache', 0),
(418, 20, 'Chejende', 0),
(419, 20, 'Cuicas', 0),
(420, 20, 'El Dividive', 0),
(421, 20, 'El Jaguito', 0),
(422, 20, 'Escuque', 0),
(423, 20, 'Isnotú', 0),
(424, 20, 'Jajó', 0),
(425, 20, 'La Ceiba', 0),
(426, 20, 'La Concepción de Trujllo', 0),
(427, 20, 'La Mesa de Esnujaque', 0),
(428, 20, 'La Puerta', 0),
(429, 20, 'La Quebrada', 0),
(430, 20, 'Mendoza Fría', 0),
(431, 20, 'Meseta de Chimpire', 0),
(432, 20, 'Monay', 0),
(433, 20, 'Motatán', 0),
(434, 20, 'Pampán', 0),
(435, 20, 'Pampanito', 0),
(436, 20, 'Sabana de Mendoza', 0),
(437, 20, 'San Lázaro', 0),
(438, 20, 'Santa Ana de Trujillo', 0),
(439, 20, 'Tostós', 0),
(440, 20, 'Trujillo', 1),
(441, 20, 'Valera', 0),
(442, 21, 'Carayaca', 0),
(443, 21, 'Litoral', 0),
(444, 25, 'Archipiélago Los Roques', 0),
(445, 22, 'Aroa', 0),
(446, 22, 'Boraure', 0),
(447, 22, 'Campo Elías de Yaracuy', 0),
(448, 22, 'Chivacoa', 0),
(449, 22, 'Cocorote', 0),
(450, 22, 'Farriar', 0),
(451, 22, 'Guama', 0),
(452, 22, 'Marín', 0),
(453, 22, 'Nirgua', 0),
(454, 22, 'Sabana de Parra', 0),
(455, 22, 'Salom', 0),
(456, 22, 'San Felipe', 1),
(457, 22, 'San Pablo de Yaracuy', 0),
(458, 22, 'Urachiche', 0),
(459, 22, 'Yaritagua', 0),
(460, 22, 'Yumare', 0),
(461, 23, 'Bachaquero', 0),
(462, 23, 'Bobures', 0),
(463, 23, 'Cabimas', 0),
(464, 23, 'Campo Concepción', 0),
(465, 23, 'Campo Mara', 0),
(466, 23, 'Campo Rojo', 0),
(467, 23, 'Carrasquero', 0),
(468, 23, 'Casigua', 0),
(469, 23, 'Chiquinquirá', 0),
(470, 23, 'Ciudad Ojeda', 0),
(471, 23, 'El Batey', 0),
(472, 23, 'El Carmelo', 0),
(473, 23, 'El Chivo', 0),
(474, 23, 'El Guayabo', 0),
(475, 23, 'El Mene', 0),
(476, 23, 'El Venado', 0),
(477, 23, 'Encontrados', 0),
(478, 23, 'Gibraltar', 0),
(479, 23, 'Isla de Toas', 0),
(480, 23, 'La Concepción del Zulia', 0),
(481, 23, 'La Paz', 0),
(482, 23, 'La Sierrita', 0),
(483, 23, 'Lagunillas del Zulia', 0),
(484, 23, 'Las Piedras de Perijá', 0),
(485, 23, 'Los Cortijos', 0),
(486, 23, 'Machiques', 0),
(487, 23, 'Maracaibo', 1),
(488, 23, 'Mene Grande', 0),
(489, 23, 'Palmarejo', 0),
(490, 23, 'Paraguaipoa', 0),
(491, 23, 'Potrerito', 0),
(492, 23, 'Pueblo Nuevo del Zulia', 0),
(493, 23, 'Puertos de Altagracia', 0),
(494, 23, 'Punta Gorda', 0),
(495, 23, 'Sabaneta de Palma', 0),
(496, 23, 'San Francisco', 0),
(497, 23, 'San José de Perijá', 0),
(498, 23, 'San Rafael del Moján', 0),
(499, 23, 'San Timoteo', 0),
(500, 23, 'Santa Bárbara Del Zulia', 0),
(501, 23, 'Santa Cruz de Mara', 0),
(502, 23, 'Santa Cruz del Zulia', 0),
(503, 23, 'Santa Rita', 0),
(504, 23, 'Sinamaica', 0),
(505, 23, 'Tamare', 0),
(506, 23, 'Tía Juana', 0),
(507, 23, 'Villa del Rosario', 0),
(508, 21, 'La Guaira', 1),
(509, 21, 'Catia La Mar', 0),
(510, 21, 'Macuto', 0),
(511, 21, 'Naiguatá', 0),
(512, 25, 'Archipiélago Los Monjes', 0),
(513, 25, 'Isla La Tortuga y Cayos adyacentes', 0),
(514, 25, 'Isla La Sola', 0),
(515, 25, 'Islas Los Testigos', 0),
(516, 25, 'Islas Los Frailes', 0),
(517, 25, 'Isla La Orchila', 0),
(518, 25, 'Archipiélago Las Aves', 0),
(519, 25, 'Isla de Aves', 0),
(520, 25, 'Isla La Blanquilla', 0),
(521, 25, 'Isla de Patos', 0),
(522, 25, 'Islas Los Hermanos', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conducta`
--

CREATE TABLE `conducta` (
  `id_conducta` int(11) NOT NULL,
  `proble_afectivo_conducta_niñez` text NOT NULL,
  `proble_afectivo_pubertad` text NOT NULL,
  `particularidades_adole` text NOT NULL,
  `proble_afectivo_adole` text NOT NULL,
  `grado_armonia_madurez_bio_psico` text NOT NULL,
  `desarrollo_voluntad` text NOT NULL,
  `grado_autonomía_deliberación_acción:` text NOT NULL,
  `persistencia_esfuerzo` text NOT NULL,
  `jerarvalores_estilovida_sexaceina` text NOT NULL,
  `norma_nivel_familiar` text NOT NULL,
  `prefe_smo` text NOT NULL,
  `habitos_intereses` text NOT NULL,
  `enfermedad_accidente` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conductas_pareja`
--

CREATE TABLE `conductas_pareja` (
  `id_conductas_pareja` int(11) NOT NULL,
  `conducta_sexual` text NOT NULL,
  `elegir_pareja` text NOT NULL,
  `fiel_exigente` text NOT NULL,
  `noviazgo` text NOT NULL,
  `matrimonio` text NOT NULL,
  `opinion_matrimonio` text NOT NULL,
  `particularidades_dia_boda` text NOT NULL,
  `vida_matrimonial` text NOT NULL,
  `separacion` text NOT NULL,
  `divorcio` text NOT NULL,
  `proble_peri_criti_particu_climaterio_menopausia_edadcriti` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `diag_resul_trata_evo`
--

CREATE TABLE `diag_resul_trata_evo` (
  `id_diag_resul_trata_evo` int(11) NOT NULL,
  `signos_sintoma` text NOT NULL,
  `patologia_sindrome` text NOT NULL,
  `trastorno` text NOT NULL,
  `nivel_afectacion` text NOT NULL,
  `conclusion_diag` text NOT NULL,
  `exa_conductual_facultades_psiquicas` text NOT NULL,
  `eva_psico` text NOT NULL,
  `programa_trata_propuesto` text NOT NULL,
  `evolucion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direccion`
--

CREATE TABLE `direccion` (
  `id_direccion` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL,
  `id_ciudad` int(11) NOT NULL,
  `id_municipio` int(11) NOT NULL,
  `id_parroquia` int(11) NOT NULL,
  `descripcion` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `direccion`
--

INSERT INTO `direccion` (`id_direccion`, `id_estado`, `id_ciudad`, `id_municipio`, `id_parroquia`, `descripcion`) VALUES
(1, 12, 212, 146, 463, ''),
(5, 4, 58, 38, 116, 'FGFGFG'),
(6, 4, 60, 39, 119, 'dfdfdf'),
(7, 3, 47, 31, 88, 'dfdfdf'),
(8, 12, 212, 146, 468, 'Casa 10'),
(9, 12, 212, 146, 468, 'Carrera 5 entre calles 4 y 5'),
(10, 12, 212, 146, 468, 'Carrera 5 entre calles 4 y 5'),
(11, 12, 212, 146, 468, 'Carrera 5 entre calles 4 y 5'),
(12, 12, 212, 146, 468, 'test4'),
(13, 12, 212, 146, 468, 'Test4');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `id_empresa` int(1) NOT NULL,
  `razon_social` varchar(200) NOT NULL,
  `tipo_documento` enum('V','J') DEFAULT NULL,
  `n_documeto` varchar(15) NOT NULL,
  `dirreccion` varchar(150) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `tlf_local` varchar(150) NOT NULL,
  `tlf_celular` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`id_empresa`, `razon_social`, `tipo_documento`, `n_documeto`, `dirreccion`, `correo`, `tlf_local`, `tlf_celular`) VALUES
(1, 'Traumados C.A', 'J', '13456807-6', 'carrera 25 con calle 54, barquisimeto edo lara', 'trauamados24/7@gmail.com', '02512323456', '04145678743');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escolaridad`
--

CREATE TABLE `escolaridad` (
  `id_escolaridad` int(11) NOT NULL,
  `adaptacion_ingreso_escu` text NOT NULL,
  `integracion_condiscipulos` text NOT NULL,
  `comportamiento_salon_clase` text NOT NULL,
  `compor_recreo` text NOT NULL,
  `relacion_demas` text NOT NULL,
  `aislamiento` text NOT NULL,
  `descrip_aislamiento` text NOT NULL,
  `experiencia_estudio_primarios` text NOT NULL,
  `experiencia_estudio_segundario` text NOT NULL,
  `experiencia_estudio_superior` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad`
--

CREATE TABLE `especialidad` (
  `id_especialidad` int(10) NOT NULL,
  `Tipo_Esp` enum('Infantil','Empresarial','Motivacional','') NOT NULL,
  `Descripcion` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especialidad`
--

INSERT INTO `especialidad` (`id_especialidad`, `Tipo_Esp`, `Descripcion`) VALUES
(3, 'Infantil', ''),
(4, 'Infantil', 'Especialidad en niños');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad_psicologo`
--

CREATE TABLE `especialidad_psicologo` (
  `id_espe_psicologo` int(10) NOT NULL,
  `id_especialidad` int(10) NOT NULL,
  `id_psicologo` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especialidad_psicologo`
--

INSERT INTO `especialidad_psicologo` (`id_espe_psicologo`, `id_especialidad`, `id_psicologo`) VALUES
(6, 3, 10),
(7, 4, 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

CREATE TABLE `estados` (
  `id_estado` int(11) NOT NULL,
  `estado` varchar(250) NOT NULL,
  `iso_3166-2` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estados`
--

INSERT INTO `estados` (`id_estado`, `estado`, `iso_3166-2`) VALUES
(1, 'Amazonas', 'VE-X'),
(2, 'Anzoátegui', 'VE-B'),
(3, 'Apure', 'VE-C'),
(4, 'Aragua', 'VE-D'),
(5, 'Barinas', 'VE-E'),
(6, 'Bolívar', 'VE-F'),
(7, 'Carabobo', 'VE-G'),
(8, 'Cojedes', 'VE-H'),
(9, 'Delta Amacuro', 'VE-Y'),
(10, 'Falcón', 'VE-I'),
(11, 'Guárico', 'VE-J'),
(12, 'Lara', 'VE-K'),
(13, 'Mérida', 'VE-L'),
(14, 'Miranda', 'VE-M'),
(15, 'Monagas', 'VE-N'),
(16, 'Nueva Esparta', 'VE-O'),
(17, 'Portuguesa', 'VE-P'),
(18, 'Sucre', 'VE-R'),
(19, 'Táchira', 'VE-S'),
(20, 'Trujillo', 'VE-T'),
(21, 'La Guaira', 'VE-W'),
(22, 'Yaracuy', 'VE-U'),
(23, 'Zulia', 'VE-V'),
(24, 'Distrito Capital', 'VE-A'),
(25, 'Dependencias Federales', 'VE-Z');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id_factura` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `id_pago_cita` int(10) NOT NULL,
  `status` enum('Realizado','Pendiente') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial`
--

CREATE TABLE `historial` (
  `id_historial` int(11) NOT NULL,
  `motivo` text NOT NULL,
  `inicio_curso` text NOT NULL,
  `tiempo_proble` text NOT NULL,
  `suceso_dia` text NOT NULL,
  `dia_anterior` text NOT NULL,
  `que_hizo` text NOT NULL,
  `como_se_calmo` text NOT NULL,
  `hablo_alguien_del_problema` text NOT NULL,
  `factores_desenca_del_proble` text NOT NULL,
  `ultimo_trata_fisi_psico` text NOT NULL,
  `autodescrpi_perso` text NOT NULL,
  `filosofia_vida` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_medico`
--

CREATE TABLE `historial_medico` (
  `ID_HistorialM` int(11) NOT NULL,
  `ID_Psicologo` int(11) NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `instruccion` varchar(100) NOT NULL,
  `ocupacion` int(100) NOT NULL,
  `edo_civil` enum('SOLTERO','DIVORCIADO','CASADO') NOT NULL,
  `religion` varchar(100) NOT NULL,
  `id_paciente_relacion` int(11) NOT NULL,
  `id_historial` int(11) NOT NULL,
  `id_historia_perso_social` int(11) NOT NULL,
  `id_relacion_social_niñez` int(11) NOT NULL,
  `id_escolaridad` int(11) NOT NULL,
  `id_conducta` int(11) NOT NULL,
  `ID_Personalidad_Conducta` int(11) NOT NULL,
  `id_traba_social` int(11) NOT NULL,
  `id_conductas_pareja` int(11) NOT NULL,
  `id_antecedentes_familiares` int(11) NOT NULL,
  `id_diag_resul_trata_evo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historia_perso_social`
--

CREATE TABLE `historia_perso_social` (
  `id_historia_perso_social` int(11) NOT NULL,
  `edad_madre_nacer` int(11) NOT NULL,
  `parto` text NOT NULL,
  `tipo_atencion_parto` enum('eutocico','distocico') NOT NULL,
  `descrip_tipo_atencion` text NOT NULL,
  `termino` enum('Si','No') NOT NULL,
  `postnatalidad` text NOT NULL,
  `estatura al nacer` decimal(10,0) NOT NULL,
  `peso` decimal(10,0) NOT NULL,
  `perimetro cefalico` decimal(10,0) NOT NULL,
  `taraxico` decimal(10,0) NOT NULL,
  `llorró` enum('si','no') NOT NULL,
  `reflejos` varchar(150) NOT NULL,
  `lenguaje` text NOT NULL,
  `juego` text NOT NULL,
  `edad_camino` int(11) NOT NULL,
  `encopresis` tinyint(1) NOT NULL,
  `edad_control_enco` int(11) NOT NULL,
  `enuresis` tinyint(1) NOT NULL,
  `edad_control_enu` int(11) NOT NULL,
  `motroci_fina` text NOT NULL,
  `motrici_gruesa` text NOT NULL,
  `movimi_pinza` text NOT NULL,
  `alimentacion_infancia` text NOT NULL,
  `crianza` enum('Madre y Padre','Madre','Padre','Otros parientes') NOT NULL,
  `juego infantil` text NOT NULL,
  `caracter y comportamiento primero años` text NOT NULL,
  `id_relacion_social_niñez` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impresion_psicologa`
--

CREATE TABLE `impresion_psicologa` (
  `ID_Impresion` int(11) NOT NULL,
  `Opinion` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `municipios`
--

CREATE TABLE `municipios` (
  `id_municipio` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL,
  `municipio` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `municipios`
--

INSERT INTO `municipios` (`id_municipio`, `id_estado`, `municipio`) VALUES
(1, 1, 'Alto Orinoco'),
(2, 1, 'Atabapo'),
(3, 1, 'Atures'),
(4, 1, 'Autana'),
(5, 1, 'Manapiare'),
(6, 1, 'Maroa'),
(7, 1, 'Río Negro'),
(8, 2, 'Anaco'),
(9, 2, 'Aragua'),
(10, 2, 'Manuel Ezequiel Bruzual'),
(11, 2, 'Diego Bautista Urbaneja'),
(12, 2, 'Fernando Peñalver'),
(13, 2, 'Francisco Del Carmen Carvajal'),
(14, 2, 'General Sir Arthur McGregor'),
(15, 2, 'Guanta'),
(16, 2, 'Independencia'),
(17, 2, 'José Gregorio Monagas'),
(18, 2, 'Juan Antonio Sotillo'),
(19, 2, 'Juan Manuel Cajigal'),
(20, 2, 'Libertad'),
(21, 2, 'Francisco de Miranda'),
(22, 2, 'Pedro María Freites'),
(23, 2, 'Píritu'),
(24, 2, 'San José de Guanipa'),
(25, 2, 'San Juan de Capistrano'),
(26, 2, 'Santa Ana'),
(27, 2, 'Simón Bolívar'),
(28, 2, 'Simón Rodríguez'),
(29, 3, 'Achaguas'),
(30, 3, 'Biruaca'),
(31, 3, 'Muñóz'),
(32, 3, 'Páez'),
(33, 3, 'Pedro Camejo'),
(34, 3, 'Rómulo Gallegos'),
(35, 3, 'San Fernando'),
(36, 4, 'Atanasio Girardot'),
(37, 4, 'Bolívar'),
(38, 4, 'Camatagua'),
(39, 4, 'Francisco Linares Alcántara'),
(40, 4, 'José Ángel Lamas'),
(41, 4, 'José Félix Ribas'),
(42, 4, 'José Rafael Revenga'),
(43, 4, 'Libertador'),
(44, 4, 'Mario Briceño Iragorry'),
(45, 4, 'Ocumare de la Costa de Oro'),
(46, 4, 'San Casimiro'),
(47, 4, 'San Sebastián'),
(48, 4, 'Santiago Mariño'),
(49, 4, 'Santos Michelena'),
(50, 4, 'Sucre'),
(51, 4, 'Tovar'),
(52, 4, 'Urdaneta'),
(53, 4, 'Zamora'),
(54, 5, 'Alberto Arvelo Torrealba'),
(55, 5, 'Andrés Eloy Blanco'),
(56, 5, 'Antonio José de Sucre'),
(57, 5, 'Arismendi'),
(58, 5, 'Barinas'),
(59, 5, 'Bolívar'),
(60, 5, 'Cruz Paredes'),
(61, 5, 'Ezequiel Zamora'),
(62, 5, 'Obispos'),
(63, 5, 'Pedraza'),
(64, 5, 'Rojas'),
(65, 5, 'Sosa'),
(66, 6, 'Caroní'),
(67, 6, 'Cedeño'),
(68, 6, 'El Callao'),
(69, 6, 'Gran Sabana'),
(70, 6, 'Heres'),
(71, 6, 'Piar'),
(72, 6, 'Angostura (Raúl Leoni)'),
(73, 6, 'Roscio'),
(74, 6, 'Sifontes'),
(75, 6, 'Sucre'),
(76, 6, 'Padre Pedro Chien'),
(77, 7, 'Bejuma'),
(78, 7, 'Carlos Arvelo'),
(79, 7, 'Diego Ibarra'),
(80, 7, 'Guacara'),
(81, 7, 'Juan José Mora'),
(82, 7, 'Libertador'),
(83, 7, 'Los Guayos'),
(84, 7, 'Miranda'),
(85, 7, 'Montalbán'),
(86, 7, 'Naguanagua'),
(87, 7, 'Puerto Cabello'),
(88, 7, 'San Diego'),
(89, 7, 'San Joaquín'),
(90, 7, 'Valencia'),
(91, 8, 'Anzoátegui'),
(92, 8, 'Tinaquillo'),
(93, 8, 'Girardot'),
(94, 8, 'Lima Blanco'),
(95, 8, 'Pao de San Juan Bautista'),
(96, 8, 'Ricaurte'),
(97, 8, 'Rómulo Gallegos'),
(98, 8, 'San Carlos'),
(99, 8, 'Tinaco'),
(100, 9, 'Antonio Díaz'),
(101, 9, 'Casacoima'),
(102, 9, 'Pedernales'),
(103, 9, 'Tucupita'),
(104, 10, 'Acosta'),
(105, 10, 'Bolívar'),
(106, 10, 'Buchivacoa'),
(107, 10, 'Cacique Manaure'),
(108, 10, 'Carirubana'),
(109, 10, 'Colina'),
(110, 10, 'Dabajuro'),
(111, 10, 'Democracia'),
(112, 10, 'Falcón'),
(113, 10, 'Federación'),
(114, 10, 'Jacura'),
(115, 10, 'José Laurencio Silva'),
(116, 10, 'Los Taques'),
(117, 10, 'Mauroa'),
(118, 10, 'Miranda'),
(119, 10, 'Monseñor Iturriza'),
(120, 10, 'Palmasola'),
(121, 10, 'Petit'),
(122, 10, 'Píritu'),
(123, 10, 'San Francisco'),
(124, 10, 'Sucre'),
(125, 10, 'Tocópero'),
(126, 10, 'Unión'),
(127, 10, 'Urumaco'),
(128, 10, 'Zamora'),
(129, 11, 'Camaguán'),
(130, 11, 'Chaguaramas'),
(131, 11, 'El Socorro'),
(132, 11, 'José Félix Ribas'),
(133, 11, 'José Tadeo Monagas'),
(134, 11, 'Juan Germán Roscio'),
(135, 11, 'Julián Mellado'),
(136, 11, 'Las Mercedes'),
(137, 11, 'Leonardo Infante'),
(138, 11, 'Pedro Zaraza'),
(139, 11, 'Ortíz'),
(140, 11, 'San Gerónimo de Guayabal'),
(141, 11, 'San José de Guaribe'),
(142, 11, 'Santa María de Ipire'),
(143, 11, 'Sebastián Francisco de Miranda'),
(144, 12, 'Andrés Eloy Blanco'),
(145, 12, 'Crespo'),
(146, 12, 'Iribarren'),
(147, 12, 'Jiménez'),
(148, 12, 'Morán'),
(149, 12, 'Palavecino'),
(150, 12, 'Simón Planas'),
(151, 12, 'Torres'),
(152, 12, 'Urdaneta'),
(179, 13, 'Alberto Adriani'),
(180, 13, 'Andrés Bello'),
(181, 13, 'Antonio Pinto Salinas'),
(182, 13, 'Aricagua'),
(183, 13, 'Arzobispo Chacón'),
(184, 13, 'Campo Elías'),
(185, 13, 'Caracciolo Parra Olmedo'),
(186, 13, 'Cardenal Quintero'),
(187, 13, 'Guaraque'),
(188, 13, 'Julio César Salas'),
(189, 13, 'Justo Briceño'),
(190, 13, 'Libertador'),
(191, 13, 'Miranda'),
(192, 13, 'Obispo Ramos de Lora'),
(193, 13, 'Padre Noguera'),
(194, 13, 'Pueblo Llano'),
(195, 13, 'Rangel'),
(196, 13, 'Rivas Dávila'),
(197, 13, 'Santos Marquina'),
(198, 13, 'Sucre'),
(199, 13, 'Tovar'),
(200, 13, 'Tulio Febres Cordero'),
(201, 13, 'Zea'),
(223, 14, 'Acevedo'),
(224, 14, 'Andrés Bello'),
(225, 14, 'Baruta'),
(226, 14, 'Brión'),
(227, 14, 'Buroz'),
(228, 14, 'Carrizal'),
(229, 14, 'Chacao'),
(230, 14, 'Cristóbal Rojas'),
(231, 14, 'El Hatillo'),
(232, 14, 'Guaicaipuro'),
(233, 14, 'Independencia'),
(234, 14, 'Lander'),
(235, 14, 'Los Salias'),
(236, 14, 'Páez'),
(237, 14, 'Paz Castillo'),
(238, 14, 'Pedro Gual'),
(239, 14, 'Plaza'),
(240, 14, 'Simón Bolívar'),
(241, 14, 'Sucre'),
(242, 14, 'Urdaneta'),
(243, 14, 'Zamora'),
(258, 15, 'Acosta'),
(259, 15, 'Aguasay'),
(260, 15, 'Bolívar'),
(261, 15, 'Caripe'),
(262, 15, 'Cedeño'),
(263, 15, 'Ezequiel Zamora'),
(264, 15, 'Libertador'),
(265, 15, 'Maturín'),
(266, 15, 'Piar'),
(267, 15, 'Punceres'),
(268, 15, 'Santa Bárbara'),
(269, 15, 'Sotillo'),
(270, 15, 'Uracoa'),
(271, 16, 'Antolín del Campo'),
(272, 16, 'Arismendi'),
(273, 16, 'García'),
(274, 16, 'Gómez'),
(275, 16, 'Maneiro'),
(276, 16, 'Marcano'),
(277, 16, 'Mariño'),
(278, 16, 'Península de Macanao'),
(279, 16, 'Tubores'),
(280, 16, 'Villalba'),
(281, 16, 'Díaz'),
(282, 17, 'Agua Blanca'),
(283, 17, 'Araure'),
(284, 17, 'Esteller'),
(285, 17, 'Guanare'),
(286, 17, 'Guanarito'),
(287, 17, 'Monseñor José Vicente de Unda'),
(288, 17, 'Ospino'),
(289, 17, 'Páez'),
(290, 17, 'Papelón'),
(291, 17, 'San Genaro de Boconoíto'),
(292, 17, 'San Rafael de Onoto'),
(293, 17, 'Santa Rosalía'),
(294, 17, 'Sucre'),
(295, 17, 'Turén'),
(296, 18, 'Andrés Eloy Blanco'),
(297, 18, 'Andrés Mata'),
(298, 18, 'Arismendi'),
(299, 18, 'Benítez'),
(300, 18, 'Bermúdez'),
(301, 18, 'Bolívar'),
(302, 18, 'Cajigal'),
(303, 18, 'Cruz Salmerón Acosta'),
(304, 18, 'Libertador'),
(305, 18, 'Mariño'),
(306, 18, 'Mejía'),
(307, 18, 'Montes'),
(308, 18, 'Ribero'),
(309, 18, 'Sucre'),
(310, 18, 'Valdéz'),
(341, 19, 'Andrés Bello'),
(342, 19, 'Antonio Rómulo Costa'),
(343, 19, 'Ayacucho'),
(344, 19, 'Bolívar'),
(345, 19, 'Cárdenas'),
(346, 19, 'Córdoba'),
(347, 19, 'Fernández Feo'),
(348, 19, 'Francisco de Miranda'),
(349, 19, 'García de Hevia'),
(350, 19, 'Guásimos'),
(351, 19, 'Independencia'),
(352, 19, 'Jáuregui'),
(353, 19, 'José María Vargas'),
(354, 19, 'Junín'),
(355, 19, 'Libertad'),
(356, 19, 'Libertador'),
(357, 19, 'Lobatera'),
(358, 19, 'Michelena'),
(359, 19, 'Panamericano'),
(360, 19, 'Pedro María Ureña'),
(361, 19, 'Rafael Urdaneta'),
(362, 19, 'Samuel Darío Maldonado'),
(363, 19, 'San Cristóbal'),
(364, 19, 'Seboruco'),
(365, 19, 'Simón Rodríguez'),
(366, 19, 'Sucre'),
(367, 19, 'Torbes'),
(368, 19, 'Uribante'),
(369, 19, 'San Judas Tadeo'),
(370, 20, 'Andrés Bello'),
(371, 20, 'Boconó'),
(372, 20, 'Bolívar'),
(373, 20, 'Candelaria'),
(374, 20, 'Carache'),
(375, 20, 'Escuque'),
(376, 20, 'José Felipe Márquez Cañizalez'),
(377, 20, 'Juan Vicente Campos Elías'),
(378, 20, 'La Ceiba'),
(379, 20, 'Miranda'),
(380, 20, 'Monte Carmelo'),
(381, 20, 'Motatán'),
(382, 20, 'Pampán'),
(383, 20, 'Pampanito'),
(384, 20, 'Rafael Rangel'),
(385, 20, 'San Rafael de Carvajal'),
(386, 20, 'Sucre'),
(387, 20, 'Trujillo'),
(388, 20, 'Urdaneta'),
(389, 20, 'Valera'),
(390, 21, 'Vargas'),
(391, 22, 'Arístides Bastidas'),
(392, 22, 'Bolívar'),
(407, 22, 'Bruzual'),
(408, 22, 'Cocorote'),
(409, 22, 'Independencia'),
(410, 22, 'José Antonio Páez'),
(411, 22, 'La Trinidad'),
(412, 22, 'Manuel Monge'),
(413, 22, 'Nirgua'),
(414, 22, 'Peña'),
(415, 22, 'San Felipe'),
(416, 22, 'Sucre'),
(417, 22, 'Urachiche'),
(418, 22, 'José Joaquín Veroes'),
(441, 23, 'Almirante Padilla'),
(442, 23, 'Baralt'),
(443, 23, 'Cabimas'),
(444, 23, 'Catatumbo'),
(445, 23, 'Colón'),
(446, 23, 'Francisco Javier Pulgar'),
(447, 23, 'Páez'),
(448, 23, 'Jesús Enrique Losada'),
(449, 23, 'Jesús María Semprún'),
(450, 23, 'La Cañada de Urdaneta'),
(451, 23, 'Lagunillas'),
(452, 23, 'Machiques de Perijá'),
(453, 23, 'Mara'),
(454, 23, 'Maracaibo'),
(455, 23, 'Miranda'),
(456, 23, 'Rosario de Perijá'),
(457, 23, 'San Francisco'),
(458, 23, 'Santa Rita'),
(459, 23, 'Simón Bolívar'),
(460, 23, 'Sucre'),
(461, 23, 'Valmore Rodríguez'),
(462, 24, 'Libertador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE `paciente` (
  `id_paciente` int(10) NOT NULL,
  `num_hijos` int(11) DEFAULT NULL,
  `dispacitado` tinyint(4) DEFAULT NULL,
  `descrip_disca` varchar(250) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_direccion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paciente`
--

INSERT INTO `paciente` (`id_paciente`, `num_hijos`, `dispacitado`, `descrip_disca`, `id_usuario`, `id_direccion`) VALUES
(2, 0, 0, '', 1, 1),
(4, NULL, NULL, NULL, 26, 6),
(5, NULL, NULL, NULL, 27, 7),
(6, NULL, NULL, NULL, 28, 8),
(9, 2, NULL, NULL, 34, 11),
(11, 0, NULL, NULL, 39, 13);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente_relacion`
--

CREATE TABLE `paciente_relacion` (
  `id_paciente_relacion` int(11) NOT NULL,
  `id_paciente` int(10) NOT NULL,
  `relacion_familiar` enum('Pareja','Familiar','Hijo') NOT NULL,
  `relacion_nombre1` varchar(150) NOT NULL,
  `relacion_nombre2` varchar(150) NOT NULL,
  `relacion_apellido1` varchar(150) NOT NULL,
  `relacion_apellido2` varchar(150) NOT NULL,
  `relacion_fecha_nac` date NOT NULL,
  `relacion_tipo_doc` enum('V','E','J','P') NOT NULL,
  `relacion_numero_doc` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paciente_relacion`
--

INSERT INTO `paciente_relacion` (`id_paciente_relacion`, `id_paciente`, `relacion_familiar`, `relacion_nombre1`, `relacion_nombre2`, `relacion_apellido1`, `relacion_apellido2`, `relacion_fecha_nac`, `relacion_tipo_doc`, `relacion_numero_doc`) VALUES
(7, 11, 'Pareja', 'test9', 'test9', 'test9', 'test9', '1999-05-05', 'V', '19853658'),
(8, 9, 'Pareja', 'Test10', 'Test10', 'Test10', 'Test10', '1994-10-16', 'V', '22198821'),
(9, 2, 'Pareja', 'Jose', 'Luis', 'Perez', 'Mendoza', '1996-07-06', 'V', '20145968');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago_cita`
--

CREATE TABLE `pago_cita` (
  `id_pago_cita` int(11) NOT NULL,
  `id_cita` int(10) NOT NULL,
  `tipo_pago` enum('TRANSFERENCIA BANCARIA','PAGO MOVIL','EFECTIVO $') DEFAULT NULL,
  `monto` float NOT NULL,
  `fecha_pago` date NOT NULL,
  `referencia_bancaria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pago_cita`
--

INSERT INTO `pago_cita` (`id_pago_cita`, `id_cita`, `tipo_pago`, `monto`, `fecha_pago`, `referencia_bancaria`) VALUES
(62, 81, 'TRANSFERENCIA BANCARIA', 30, '2025-01-18', 123),
(63, 82, 'TRANSFERENCIA BANCARIA', 30, '2025-01-18', 456),
(64, 83, 'TRANSFERENCIA BANCARIA', 30, '2025-01-20', 454545),
(65, 84, 'TRANSFERENCIA BANCARIA', 30, '2025-01-20', 454545),
(66, 85, 'TRANSFERENCIA BANCARIA', 30, '2025-01-20', 454545),
(79, 89, 'TRANSFERENCIA BANCARIA', 30, '2025-01-21', 4589),
(80, 90, 'TRANSFERENCIA BANCARIA', 30, '2025-01-21', 596347),
(81, 91, 'TRANSFERENCIA BANCARIA', 30, '2025-01-21', 8569);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parroquias`
--

CREATE TABLE `parroquias` (
  `id_parroquia` int(11) NOT NULL,
  `id_municipio` int(11) NOT NULL,
  `parroquia` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `parroquias`
--

INSERT INTO `parroquias` (`id_parroquia`, `id_municipio`, `parroquia`) VALUES
(1, 1, 'Alto Orinoco'),
(2, 1, 'Huachamacare Acanaña'),
(3, 1, 'Marawaka Toky Shamanaña'),
(4, 1, 'Mavaka Mavaka'),
(5, 1, 'Sierra Parima Parimabé'),
(6, 2, 'Ucata Laja Lisa'),
(7, 2, 'Yapacana Macuruco'),
(8, 2, 'Caname Guarinuma'),
(9, 3, 'Fernando Girón Tovar'),
(10, 3, 'Luis Alberto Gómez'),
(11, 3, 'Pahueña Limón de Parhueña'),
(12, 3, 'Platanillal Platanillal'),
(13, 4, 'Samariapo'),
(14, 4, 'Sipapo'),
(15, 4, 'Munduapo'),
(16, 4, 'Guayapo'),
(17, 5, 'Alto Ventuari'),
(18, 5, 'Medio Ventuari'),
(19, 5, 'Bajo Ventuari'),
(20, 6, 'Victorino'),
(21, 6, 'Comunidad'),
(22, 7, 'Casiquiare'),
(23, 7, 'Cocuy'),
(24, 7, 'San Carlos de Río Negro'),
(25, 7, 'Solano'),
(26, 8, 'Anaco'),
(27, 8, 'San Joaquín'),
(28, 9, 'Cachipo'),
(29, 9, 'Aragua de Barcelona'),
(30, 11, 'Lechería'),
(31, 11, 'El Morro'),
(32, 12, 'Puerto Píritu'),
(33, 12, 'San Miguel'),
(34, 12, 'Sucre'),
(35, 13, 'Valle de Guanape'),
(36, 13, 'Santa Bárbara'),
(37, 14, 'El Chaparro'),
(38, 14, 'Tomás Alfaro'),
(39, 14, 'Calatrava'),
(40, 15, 'Guanta'),
(41, 15, 'Chorrerón'),
(42, 16, 'Mamo'),
(43, 16, 'Soledad'),
(44, 17, 'Mapire'),
(45, 17, 'Piar'),
(46, 17, 'Santa Clara'),
(47, 17, 'San Diego de Cabrutica'),
(48, 17, 'Uverito'),
(49, 17, 'Zuata'),
(50, 18, 'Puerto La Cruz'),
(51, 18, 'Pozuelos'),
(52, 19, 'Onoto'),
(53, 19, 'San Pablo'),
(54, 20, 'San Mateo'),
(55, 20, 'El Carito'),
(56, 20, 'Santa Inés'),
(57, 20, 'La Romereña'),
(58, 21, 'Atapirire'),
(59, 21, 'Boca del Pao'),
(60, 21, 'El Pao'),
(61, 21, 'Pariaguán'),
(62, 22, 'Cantaura'),
(63, 22, 'Libertador'),
(64, 22, 'Santa Rosa'),
(65, 22, 'Urica'),
(66, 23, 'Píritu'),
(67, 23, 'San Francisco'),
(68, 24, 'San José de Guanipa'),
(69, 25, 'Boca de Uchire'),
(70, 25, 'Boca de Chávez'),
(71, 26, 'Pueblo Nuevo'),
(72, 26, 'Santa Ana'),
(73, 27, 'Bergantín'),
(74, 27, 'Caigua'),
(75, 27, 'El Carmen'),
(76, 27, 'El Pilar'),
(77, 27, 'Naricual'),
(78, 27, 'San Crsitóbal'),
(79, 28, 'Edmundo Barrios'),
(80, 28, 'Miguel Otero Silva'),
(81, 29, 'Achaguas'),
(82, 29, 'Apurito'),
(83, 29, 'El Yagual'),
(84, 29, 'Guachara'),
(85, 29, 'Mucuritas'),
(86, 29, 'Queseras del medio'),
(87, 30, 'Biruaca'),
(88, 31, 'Bruzual'),
(89, 31, 'Mantecal'),
(90, 31, 'Quintero'),
(91, 31, 'Rincón Hondo'),
(92, 31, 'San Vicente'),
(93, 32, 'Guasdualito'),
(94, 32, 'Aramendi'),
(95, 32, 'El Amparo'),
(96, 32, 'San Camilo'),
(97, 32, 'Urdaneta'),
(98, 33, 'San Juan de Payara'),
(99, 33, 'Codazzi'),
(100, 33, 'Cunaviche'),
(101, 34, 'Elorza'),
(102, 34, 'La Trinidad'),
(103, 35, 'San Fernando'),
(104, 35, 'El Recreo'),
(105, 35, 'Peñalver'),
(106, 35, 'San Rafael de Atamaica'),
(107, 36, 'Pedro José Ovalles'),
(108, 36, 'Joaquín Crespo'),
(109, 36, 'José Casanova Godoy'),
(110, 36, 'Madre María de San José'),
(111, 36, 'Andrés Eloy Blanco'),
(112, 36, 'Los Tacarigua'),
(113, 36, 'Las Delicias'),
(114, 36, 'Choroní'),
(115, 37, 'Bolívar'),
(116, 38, 'Camatagua'),
(117, 38, 'Carmen de Cura'),
(118, 39, 'Santa Rita'),
(119, 39, 'Francisco de Miranda'),
(120, 39, 'Moseñor Feliciano González'),
(121, 40, 'Santa Cruz'),
(122, 41, 'José Félix Ribas'),
(123, 41, 'Castor Nieves Ríos'),
(124, 41, 'Las Guacamayas'),
(125, 41, 'Pao de Zárate'),
(126, 41, 'Zuata'),
(127, 42, 'José Rafael Revenga'),
(128, 43, 'Palo Negro'),
(129, 43, 'San Martín de Porres'),
(130, 44, 'El Limón'),
(131, 44, 'Caña de Azúcar'),
(132, 45, 'Ocumare de la Costa'),
(133, 46, 'San Casimiro'),
(134, 46, 'Güiripa'),
(135, 46, 'Ollas de Caramacate'),
(136, 46, 'Valle Morín'),
(137, 47, 'San Sebastían'),
(138, 48, 'Turmero'),
(139, 48, 'Arevalo Aponte'),
(140, 48, 'Chuao'),
(141, 48, 'Samán de Güere'),
(142, 48, 'Alfredo Pacheco Miranda'),
(143, 49, 'Santos Michelena'),
(144, 49, 'Tiara'),
(145, 50, 'Cagua'),
(146, 50, 'Bella Vista'),
(147, 51, 'Tovar'),
(148, 52, 'Urdaneta'),
(149, 52, 'Las Peñitas'),
(150, 52, 'San Francisco de Cara'),
(151, 52, 'Taguay'),
(152, 53, 'Zamora'),
(153, 53, 'Magdaleno'),
(154, 53, 'San Francisco de Asís'),
(155, 53, 'Valles de Tucutunemo'),
(156, 53, 'Augusto Mijares'),
(157, 54, 'Sabaneta'),
(158, 54, 'Juan Antonio Rodríguez Domínguez'),
(159, 55, 'El Cantón'),
(160, 55, 'Santa Cruz de Guacas'),
(161, 55, 'Puerto Vivas'),
(162, 56, 'Ticoporo'),
(163, 56, 'Nicolás Pulido'),
(164, 56, 'Andrés Bello'),
(165, 57, 'Arismendi'),
(166, 57, 'Guadarrama'),
(167, 57, 'La Unión'),
(168, 57, 'San Antonio'),
(169, 58, 'Barinas'),
(170, 58, 'Alberto Arvelo Larriva'),
(171, 58, 'San Silvestre'),
(172, 58, 'Santa Inés'),
(173, 58, 'Santa Lucía'),
(174, 58, 'Torumos'),
(175, 58, 'El Carmen'),
(176, 58, 'Rómulo Betancourt'),
(177, 58, 'Corazón de Jesús'),
(178, 58, 'Ramón Ignacio Méndez'),
(179, 58, 'Alto Barinas'),
(180, 58, 'Manuel Palacio Fajardo'),
(181, 58, 'Juan Antonio Rodríguez Domínguez'),
(182, 58, 'Dominga Ortiz de Páez'),
(183, 59, 'Barinitas'),
(184, 59, 'Altamira de Cáceres'),
(185, 59, 'Calderas'),
(186, 60, 'Barrancas'),
(187, 60, 'El Socorro'),
(188, 60, 'Mazparrito'),
(189, 61, 'Santa Bárbara'),
(190, 61, 'Pedro Briceño Méndez'),
(191, 61, 'Ramón Ignacio Méndez'),
(192, 61, 'José Ignacio del Pumar'),
(193, 62, 'Obispos'),
(194, 62, 'Guasimitos'),
(195, 62, 'El Real'),
(196, 62, 'La Luz'),
(197, 63, 'Ciudad Bolívia'),
(198, 63, 'José Ignacio Briceño'),
(199, 63, 'José Félix Ribas'),
(200, 63, 'Páez'),
(201, 64, 'Libertad'),
(202, 64, 'Dolores'),
(203, 64, 'Santa Rosa'),
(204, 64, 'Palacio Fajardo'),
(205, 65, 'Ciudad de Nutrias'),
(206, 65, 'El Regalo'),
(207, 65, 'Puerto Nutrias'),
(208, 65, 'Santa Catalina'),
(209, 66, 'Cachamay'),
(210, 66, 'Chirica'),
(211, 66, 'Dalla Costa'),
(212, 66, 'Once de Abril'),
(213, 66, 'Simón Bolívar'),
(214, 66, 'Unare'),
(215, 66, 'Universidad'),
(216, 66, 'Vista al Sol'),
(217, 66, 'Pozo Verde'),
(218, 66, 'Yocoima'),
(219, 66, '5 de Julio'),
(220, 67, 'Cedeño'),
(221, 67, 'Altagracia'),
(222, 67, 'Ascensión Farreras'),
(223, 67, 'Guaniamo'),
(224, 67, 'La Urbana'),
(225, 67, 'Pijiguaos'),
(226, 68, 'El Callao'),
(227, 69, 'Gran Sabana'),
(228, 69, 'Ikabarú'),
(229, 70, 'Catedral'),
(230, 70, 'Zea'),
(231, 70, 'Orinoco'),
(232, 70, 'José Antonio Páez'),
(233, 70, 'Marhuanta'),
(234, 70, 'Agua Salada'),
(235, 70, 'Vista Hermosa'),
(236, 70, 'La Sabanita'),
(237, 70, 'Panapana'),
(238, 71, 'Andrés Eloy Blanco'),
(239, 71, 'Pedro Cova'),
(240, 72, 'Raúl Leoni'),
(241, 72, 'Barceloneta'),
(242, 72, 'Santa Bárbara'),
(243, 72, 'San Francisco'),
(244, 73, 'Roscio'),
(245, 73, 'Salóm'),
(246, 74, 'Sifontes'),
(247, 74, 'Dalla Costa'),
(248, 74, 'San Isidro'),
(249, 75, 'Sucre'),
(250, 75, 'Aripao'),
(251, 75, 'Guarataro'),
(252, 75, 'Las Majadas'),
(253, 75, 'Moitaco'),
(254, 76, 'Padre Pedro Chien'),
(255, 76, 'Río Grande'),
(256, 77, 'Bejuma'),
(257, 77, 'Canoabo'),
(258, 77, 'Simón Bolívar'),
(259, 78, 'Güigüe'),
(260, 78, 'Carabobo'),
(261, 78, 'Tacarigua'),
(262, 79, 'Mariara'),
(263, 79, 'Aguas Calientes'),
(264, 80, 'Ciudad Alianza'),
(265, 80, 'Guacara'),
(266, 80, 'Yagua'),
(267, 81, 'Morón'),
(268, 81, 'Yagua'),
(269, 82, 'Tocuyito'),
(270, 82, 'Independencia'),
(271, 83, 'Los Guayos'),
(272, 84, 'Miranda'),
(273, 85, 'Montalbán'),
(274, 86, 'Naguanagua'),
(275, 87, 'Bartolomé Salóm'),
(276, 87, 'Democracia'),
(277, 87, 'Fraternidad'),
(278, 87, 'Goaigoaza'),
(279, 87, 'Juan José Flores'),
(280, 87, 'Unión'),
(281, 87, 'Borburata'),
(282, 87, 'Patanemo'),
(283, 88, 'San Diego'),
(284, 89, 'San Joaquín'),
(285, 90, 'Candelaria'),
(286, 90, 'Catedral'),
(287, 90, 'El Socorro'),
(288, 90, 'Miguel Peña'),
(289, 90, 'Rafael Urdaneta'),
(290, 90, 'San Blas'),
(291, 90, 'San José'),
(292, 90, 'Santa Rosa'),
(293, 90, 'Negro Primero'),
(294, 91, 'Cojedes'),
(295, 91, 'Juan de Mata Suárez'),
(296, 92, 'Tinaquillo'),
(297, 93, 'El Baúl'),
(298, 93, 'Sucre'),
(299, 94, 'La Aguadita'),
(300, 94, 'Macapo'),
(301, 95, 'El Pao'),
(302, 96, 'El Amparo'),
(303, 96, 'Libertad de Cojedes'),
(304, 97, 'Rómulo Gallegos'),
(305, 98, 'San Carlos de Austria'),
(306, 98, 'Juan Ángel Bravo'),
(307, 98, 'Manuel Manrique'),
(308, 99, 'General en Jefe José Laurencio Silva'),
(309, 100, 'Curiapo'),
(310, 100, 'Almirante Luis Brión'),
(311, 100, 'Francisco Aniceto Lugo'),
(312, 100, 'Manuel Renaud'),
(313, 100, 'Padre Barral'),
(314, 100, 'Santos de Abelgas'),
(315, 101, 'Imataca'),
(316, 101, 'Cinco de Julio'),
(317, 101, 'Juan Bautista Arismendi'),
(318, 101, 'Manuel Piar'),
(319, 101, 'Rómulo Gallegos'),
(320, 102, 'Pedernales'),
(321, 102, 'Luis Beltrán Prieto Figueroa'),
(322, 103, 'San José (Delta Amacuro)'),
(323, 103, 'José Vidal Marcano'),
(324, 103, 'Juan Millán'),
(325, 103, 'Leonardo Ruíz Pineda'),
(326, 103, 'Mariscal Antonio José de Sucre'),
(327, 103, 'Monseñor Argimiro García'),
(328, 103, 'San Rafael (Delta Amacuro)'),
(329, 103, 'Virgen del Valle'),
(330, 10, 'Clarines'),
(331, 10, 'Guanape'),
(332, 10, 'Sabana de Uchire'),
(333, 104, 'Capadare'),
(334, 104, 'La Pastora'),
(335, 104, 'Libertador'),
(336, 104, 'San Juan de los Cayos'),
(337, 105, 'Aracua'),
(338, 105, 'La Peña'),
(339, 105, 'San Luis'),
(340, 106, 'Bariro'),
(341, 106, 'Borojó'),
(342, 106, 'Capatárida'),
(343, 106, 'Guajiro'),
(344, 106, 'Seque'),
(345, 106, 'Zazárida'),
(346, 106, 'Valle de Eroa'),
(347, 107, 'Cacique Manaure'),
(348, 108, 'Norte'),
(349, 108, 'Carirubana'),
(350, 108, 'Santa Ana'),
(351, 108, 'Urbana Punta Cardón'),
(352, 109, 'La Vela de Coro'),
(353, 109, 'Acurigua'),
(354, 109, 'Guaibacoa'),
(355, 109, 'Las Calderas'),
(356, 109, 'Macoruca'),
(357, 110, 'Dabajuro'),
(358, 111, 'Agua Clara'),
(359, 111, 'Avaria'),
(360, 111, 'Pedregal'),
(361, 111, 'Piedra Grande'),
(362, 111, 'Purureche'),
(363, 112, 'Adaure'),
(364, 112, 'Adícora'),
(365, 112, 'Baraived'),
(366, 112, 'Buena Vista'),
(367, 112, 'Jadacaquiva'),
(368, 112, 'El Vínculo'),
(369, 112, 'El Hato'),
(370, 112, 'Moruy'),
(371, 112, 'Pueblo Nuevo'),
(372, 113, 'Agua Larga'),
(373, 113, 'El Paují'),
(374, 113, 'Independencia'),
(375, 113, 'Mapararí'),
(376, 114, 'Agua Linda'),
(377, 114, 'Araurima'),
(378, 114, 'Jacura'),
(379, 115, 'Tucacas'),
(380, 115, 'Boca de Aroa'),
(381, 116, 'Los Taques'),
(382, 116, 'Judibana'),
(383, 117, 'Mene de Mauroa'),
(384, 117, 'San Félix'),
(385, 117, 'Casigua'),
(386, 118, 'Guzmán Guillermo'),
(387, 118, 'Mitare'),
(388, 118, 'Río Seco'),
(389, 118, 'Sabaneta'),
(390, 118, 'San Antonio'),
(391, 118, 'San Gabriel'),
(392, 118, 'Santa Ana'),
(393, 119, 'Boca del Tocuyo'),
(394, 119, 'Chichiriviche'),
(395, 119, 'Tocuyo de la Costa'),
(396, 120, 'Palmasola'),
(397, 121, 'Cabure'),
(398, 121, 'Colina'),
(399, 121, 'Curimagua'),
(400, 122, 'San José de la Costa'),
(401, 122, 'Píritu'),
(402, 123, 'San Francisco'),
(403, 124, 'Sucre'),
(404, 124, 'Pecaya'),
(405, 125, 'Tocópero'),
(406, 126, 'El Charal'),
(407, 126, 'Las Vegas del Tuy'),
(408, 126, 'Santa Cruz de Bucaral'),
(409, 127, 'Bruzual'),
(410, 127, 'Urumaco'),
(411, 128, 'Puerto Cumarebo'),
(412, 128, 'La Ciénaga'),
(413, 128, 'La Soledad'),
(414, 128, 'Pueblo Cumarebo'),
(415, 128, 'Zazárida'),
(416, 113, 'Churuguara'),
(417, 129, 'Camaguán'),
(418, 129, 'Puerto Miranda'),
(419, 129, 'Uverito'),
(420, 130, 'Chaguaramas'),
(421, 131, 'El Socorro'),
(422, 132, 'Tucupido'),
(423, 132, 'San Rafael de Laya'),
(424, 133, 'Altagracia de Orituco'),
(425, 133, 'San Rafael de Orituco'),
(426, 133, 'San Francisco Javier de Lezama'),
(427, 133, 'Paso Real de Macaira'),
(428, 133, 'Carlos Soublette'),
(429, 133, 'San Francisco de Macaira'),
(430, 133, 'Libertad de Orituco'),
(431, 134, 'Cantaclaro'),
(432, 134, 'San Juan de los Morros'),
(433, 134, 'Parapara'),
(434, 135, 'El Sombrero'),
(435, 135, 'Sosa'),
(436, 136, 'Las Mercedes'),
(437, 136, 'Cabruta'),
(438, 136, 'Santa Rita de Manapire'),
(439, 137, 'Valle de la Pascua'),
(440, 137, 'Espino'),
(441, 138, 'San José de Unare'),
(442, 138, 'Zaraza'),
(443, 139, 'San José de Tiznados'),
(444, 139, 'San Francisco de Tiznados'),
(445, 139, 'San Lorenzo de Tiznados'),
(446, 139, 'Ortiz'),
(447, 140, 'Guayabal'),
(448, 140, 'Cazorla'),
(449, 141, 'San José de Guaribe'),
(450, 141, 'Uveral'),
(451, 142, 'Santa María de Ipire'),
(452, 142, 'Altamira'),
(453, 143, 'El Calvario'),
(454, 143, 'El Rastro'),
(455, 143, 'Guardatinajas'),
(456, 143, 'Capital Urbana Calabozo'),
(457, 144, 'Quebrada Honda de Guache'),
(458, 144, 'Pío Tamayo'),
(459, 144, 'Yacambú'),
(460, 145, 'Fréitez'),
(461, 145, 'José María Blanco'),
(462, 146, 'Catedral'),
(463, 146, 'Concepción'),
(464, 146, 'El Cují'),
(465, 146, 'Juan de Villegas'),
(466, 146, 'Santa Rosa'),
(467, 146, 'Tamaca'),
(468, 146, 'Unión'),
(469, 146, 'Aguedo Felipe Alvarado'),
(470, 146, 'Buena Vista'),
(471, 146, 'Juárez'),
(472, 147, 'Juan Bautista Rodríguez'),
(473, 147, 'Cuara'),
(474, 147, 'Diego de Lozada'),
(475, 147, 'Paraíso de San José'),
(476, 147, 'San Miguel'),
(477, 147, 'Tintorero'),
(478, 147, 'José Bernardo Dorante'),
(479, 147, 'Coronel Mariano Peraza '),
(480, 148, 'Bolívar'),
(481, 148, 'Anzoátegui'),
(482, 148, 'Guarico'),
(483, 148, 'Hilario Luna y Luna'),
(484, 148, 'Humocaro Alto'),
(485, 148, 'Humocaro Bajo'),
(486, 148, 'La Candelaria'),
(487, 148, 'Morán'),
(488, 149, 'Cabudare'),
(489, 149, 'José Gregorio Bastidas'),
(490, 149, 'Agua Viva'),
(491, 150, 'Sarare'),
(492, 150, 'Buría'),
(493, 150, 'Gustavo Vegas León'),
(494, 151, 'Trinidad Samuel'),
(495, 151, 'Antonio Díaz'),
(496, 151, 'Camacaro'),
(497, 151, 'Castañeda'),
(498, 151, 'Cecilio Zubillaga'),
(499, 151, 'Chiquinquirá'),
(500, 151, 'El Blanco'),
(501, 151, 'Espinoza de los Monteros'),
(502, 151, 'Lara'),
(503, 151, 'Las Mercedes'),
(504, 151, 'Manuel Morillo'),
(505, 151, 'Montaña Verde'),
(506, 151, 'Montes de Oca'),
(507, 151, 'Torres'),
(508, 151, 'Heriberto Arroyo'),
(509, 151, 'Reyes Vargas'),
(510, 151, 'Altagracia'),
(511, 152, 'Siquisique'),
(512, 152, 'Moroturo'),
(513, 152, 'San Miguel'),
(514, 152, 'Xaguas'),
(515, 179, 'Presidente Betancourt'),
(516, 179, 'Presidente Páez'),
(517, 179, 'Presidente Rómulo Gallegos'),
(518, 179, 'Gabriel Picón González'),
(519, 179, 'Héctor Amable Mora'),
(520, 179, 'José Nucete Sardi'),
(521, 179, 'Pulido Méndez'),
(522, 180, 'La Azulita'),
(523, 181, 'Santa Cruz de Mora'),
(524, 181, 'Mesa Bolívar'),
(525, 181, 'Mesa de Las Palmas'),
(526, 182, 'Aricagua'),
(527, 182, 'San Antonio'),
(528, 183, 'Canagua'),
(529, 183, 'Capurí'),
(530, 183, 'Chacantá'),
(531, 183, 'El Molino'),
(532, 183, 'Guaimaral'),
(533, 183, 'Mucutuy'),
(534, 183, 'Mucuchachí'),
(535, 184, 'Fernández Peña'),
(536, 184, 'Matriz'),
(537, 184, 'Montalbán'),
(538, 184, 'Acequias'),
(539, 184, 'Jají'),
(540, 184, 'La Mesa'),
(541, 184, 'San José del Sur'),
(542, 185, 'Tucaní'),
(543, 185, 'Florencio Ramírez'),
(544, 186, 'Santo Domingo'),
(545, 186, 'Las Piedras'),
(546, 187, 'Guaraque'),
(547, 187, 'Mesa de Quintero'),
(548, 187, 'Río Negro'),
(549, 188, 'Arapuey'),
(550, 188, 'Palmira'),
(551, 189, 'San Cristóbal de Torondoy'),
(552, 189, 'Torondoy'),
(553, 190, 'Antonio Spinetti Dini'),
(554, 190, 'Arias'),
(555, 190, 'Caracciolo Parra Pérez'),
(556, 190, 'Domingo Peña'),
(557, 190, 'El Llano'),
(558, 190, 'Gonzalo Picón Febres'),
(559, 190, 'Jacinto Plaza'),
(560, 190, 'Juan Rodríguez Suárez'),
(561, 190, 'Lasso de la Vega'),
(562, 190, 'Mariano Picón Salas'),
(563, 190, 'Milla'),
(564, 190, 'Osuna Rodríguez'),
(565, 190, 'Sagrario'),
(566, 190, 'El Morro'),
(567, 190, 'Los Nevados'),
(568, 191, 'Andrés Eloy Blanco'),
(569, 191, 'La Venta'),
(570, 191, 'Piñango'),
(571, 191, 'Timotes'),
(572, 192, 'Eloy Paredes'),
(573, 192, 'San Rafael de Alcázar'),
(574, 192, 'Santa Elena de Arenales'),
(575, 193, 'Santa María de Caparo'),
(576, 194, 'Pueblo Llano'),
(577, 195, 'Cacute'),
(578, 195, 'La Toma'),
(579, 195, 'Mucuchíes'),
(580, 195, 'Mucurubá'),
(581, 195, 'San Rafael'),
(582, 196, 'Gerónimo Maldonado'),
(583, 196, 'Bailadores'),
(584, 197, 'Tabay'),
(585, 198, 'Chiguará'),
(586, 198, 'Estánquez'),
(587, 198, 'Lagunillas'),
(588, 198, 'La Trampa'),
(589, 198, 'Pueblo Nuevo del Sur'),
(590, 198, 'San Juan'),
(591, 199, 'El Amparo'),
(592, 199, 'El Llano'),
(593, 199, 'San Francisco'),
(594, 199, 'Tovar'),
(595, 200, 'Independencia'),
(596, 200, 'María de la Concepción Palacios Blanco'),
(597, 200, 'Nueva Bolivia'),
(598, 200, 'Santa Apolonia'),
(599, 201, 'Caño El Tigre'),
(600, 201, 'Zea'),
(601, 223, 'Aragüita'),
(602, 223, 'Arévalo González'),
(603, 223, 'Capaya'),
(604, 223, 'Caucagua'),
(605, 223, 'Panaquire'),
(606, 223, 'Ribas'),
(607, 223, 'El Café'),
(608, 223, 'Marizapa'),
(609, 224, 'Cumbo'),
(610, 224, 'San José de Barlovento'),
(611, 225, 'El Cafetal'),
(612, 225, 'Las Minas'),
(613, 225, 'Nuestra Señora del Rosario'),
(614, 226, 'Higuerote'),
(615, 226, 'Curiepe'),
(616, 226, 'Tacarigua de Brión'),
(617, 227, 'Mamporal'),
(618, 228, 'Carrizal'),
(619, 229, 'Chacao'),
(620, 230, 'Charallave'),
(621, 230, 'Las Brisas'),
(622, 231, 'El Hatillo'),
(623, 232, 'Altagracia de la Montaña'),
(624, 232, 'Cecilio Acosta'),
(625, 232, 'Los Teques'),
(626, 232, 'El Jarillo'),
(627, 232, 'San Pedro'),
(628, 232, 'Tácata'),
(629, 232, 'Paracotos'),
(630, 233, 'Cartanal'),
(631, 233, 'Santa Teresa del Tuy'),
(632, 234, 'La Democracia'),
(633, 234, 'Ocumare del Tuy'),
(634, 234, 'Santa Bárbara'),
(635, 235, 'San Antonio de los Altos'),
(636, 236, 'Río Chico'),
(637, 236, 'El Guapo'),
(638, 236, 'Tacarigua de la Laguna'),
(639, 236, 'Paparo'),
(640, 236, 'San Fernando del Guapo'),
(641, 237, 'Santa Lucía del Tuy'),
(642, 238, 'Cúpira'),
(643, 238, 'Machurucuto'),
(644, 239, 'Guarenas'),
(645, 240, 'San Antonio de Yare'),
(646, 240, 'San Francisco de Yare'),
(647, 241, 'Leoncio Martínez'),
(648, 241, 'Petare'),
(649, 241, 'Caucagüita'),
(650, 241, 'Filas de Mariche'),
(651, 241, 'La Dolorita'),
(652, 242, 'Cúa'),
(653, 242, 'Nueva Cúa'),
(654, 243, 'Guatire'),
(655, 243, 'Bolívar'),
(656, 258, 'San Antonio de Maturín'),
(657, 258, 'San Francisco de Maturín'),
(658, 259, 'Aguasay'),
(659, 260, 'Caripito'),
(660, 261, 'El Guácharo'),
(661, 261, 'La Guanota'),
(662, 261, 'Sabana de Piedra'),
(663, 261, 'San Agustín'),
(664, 261, 'Teresen'),
(665, 261, 'Caripe'),
(666, 262, 'Areo'),
(667, 262, 'Capital Cedeño'),
(668, 262, 'San Félix de Cantalicio'),
(669, 262, 'Viento Fresco'),
(670, 263, 'El Tejero'),
(671, 263, 'Punta de Mata'),
(672, 264, 'Chaguaramas'),
(673, 264, 'Las Alhuacas'),
(674, 264, 'Tabasca'),
(675, 264, 'Temblador'),
(676, 265, 'Alto de los Godos'),
(677, 265, 'Boquerón'),
(678, 265, 'Las Cocuizas'),
(679, 265, 'La Cruz'),
(680, 265, 'San Simón'),
(681, 265, 'El Corozo'),
(682, 265, 'El Furrial'),
(683, 265, 'Jusepín'),
(684, 265, 'La Pica'),
(685, 265, 'San Vicente'),
(686, 266, 'Aparicio'),
(687, 266, 'Aragua de Maturín'),
(688, 266, 'Chaguamal'),
(689, 266, 'El Pinto'),
(690, 266, 'Guanaguana'),
(691, 266, 'La Toscana'),
(692, 266, 'Taguaya'),
(693, 267, 'Cachipo'),
(694, 267, 'Quiriquire'),
(695, 268, 'Santa Bárbara'),
(696, 269, 'Barrancas'),
(697, 269, 'Los Barrancos de Fajardo'),
(698, 270, 'Uracoa'),
(699, 271, 'Antolín del Campo'),
(700, 272, 'Arismendi'),
(701, 273, 'García'),
(702, 273, 'Francisco Fajardo'),
(703, 274, 'Bolívar'),
(704, 274, 'Guevara'),
(705, 274, 'Matasiete'),
(706, 274, 'Santa Ana'),
(707, 274, 'Sucre'),
(708, 275, 'Aguirre'),
(709, 275, 'Maneiro'),
(710, 276, 'Adrián'),
(711, 276, 'Juan Griego'),
(712, 276, 'Yaguaraparo'),
(713, 277, 'Porlamar'),
(714, 278, 'San Francisco de Macanao'),
(715, 278, 'Boca de Río'),
(716, 279, 'Tubores'),
(717, 279, 'Los Baleales'),
(718, 280, 'Vicente Fuentes'),
(719, 280, 'Villalba'),
(720, 281, 'San Juan Bautista'),
(721, 281, 'Zabala'),
(722, 283, 'Capital Araure'),
(723, 283, 'Río Acarigua'),
(724, 284, 'Capital Esteller'),
(725, 284, 'Uveral'),
(726, 285, 'Guanare'),
(727, 285, 'Córdoba'),
(728, 285, 'San José de la Montaña'),
(729, 285, 'San Juan de Guanaguanare'),
(730, 285, 'Virgen de la Coromoto'),
(731, 286, 'Guanarito'),
(732, 286, 'Trinidad de la Capilla'),
(733, 286, 'Divina Pastora'),
(734, 287, 'Monseñor José Vicente de Unda'),
(735, 287, 'Peña Blanca'),
(736, 288, 'Capital Ospino'),
(737, 288, 'Aparición'),
(738, 288, 'La Estación'),
(739, 289, 'Páez'),
(740, 289, 'Payara'),
(741, 289, 'Pimpinela'),
(742, 289, 'Ramón Peraza'),
(743, 290, 'Papelón'),
(744, 290, 'Caño Delgadito'),
(745, 291, 'San Genaro de Boconoito'),
(746, 291, 'Antolín Tovar'),
(747, 292, 'San Rafael de Onoto'),
(748, 292, 'Santa Fe'),
(749, 292, 'Thermo Morles'),
(750, 293, 'Santa Rosalía'),
(751, 293, 'Florida'),
(752, 294, 'Sucre'),
(753, 294, 'Concepción'),
(754, 294, 'San Rafael de Palo Alzado'),
(755, 294, 'Uvencio Antonio Velásquez'),
(756, 294, 'San José de Saguaz'),
(757, 294, 'Villa Rosa'),
(758, 295, 'Turén'),
(759, 295, 'Canelones'),
(760, 295, 'Santa Cruz'),
(761, 295, 'San Isidro Labrador'),
(762, 296, 'Mariño'),
(763, 296, 'Rómulo Gallegos'),
(764, 297, 'San José de Aerocuar'),
(765, 297, 'Tavera Acosta'),
(766, 298, 'Río Caribe'),
(767, 298, 'Antonio José de Sucre'),
(768, 298, 'El Morro de Puerto Santo'),
(769, 298, 'Puerto Santo'),
(770, 298, 'San Juan de las Galdonas'),
(771, 299, 'El Pilar'),
(772, 299, 'El Rincón'),
(773, 299, 'General Francisco Antonio Váquez'),
(774, 299, 'Guaraúnos'),
(775, 299, 'Tunapuicito'),
(776, 299, 'Unión'),
(777, 300, 'Santa Catalina'),
(778, 300, 'Santa Rosa'),
(779, 300, 'Santa Teresa'),
(780, 300, 'Bolívar'),
(781, 300, 'Maracapana'),
(782, 302, 'Libertad'),
(783, 302, 'El Paujil'),
(784, 302, 'Yaguaraparo'),
(785, 303, 'Cruz Salmerón Acosta'),
(786, 303, 'Chacopata'),
(787, 303, 'Manicuare'),
(788, 304, 'Tunapuy'),
(789, 304, 'Campo Elías'),
(790, 305, 'Irapa'),
(791, 305, 'Campo Claro'),
(792, 305, 'Maraval'),
(793, 305, 'San Antonio de Irapa'),
(794, 305, 'Soro'),
(795, 306, 'Mejía'),
(796, 307, 'Cumanacoa'),
(797, 307, 'Arenas'),
(798, 307, 'Aricagua'),
(799, 307, 'Cogollar'),
(800, 307, 'San Fernando'),
(801, 307, 'San Lorenzo'),
(802, 308, 'Villa Frontado (Muelle de Cariaco)'),
(803, 308, 'Catuaro'),
(804, 308, 'Rendón'),
(805, 308, 'San Cruz'),
(806, 308, 'Santa María'),
(807, 309, 'Altagracia'),
(808, 309, 'Santa Inés'),
(809, 309, 'Valentín Valiente'),
(810, 309, 'Ayacucho'),
(811, 309, 'San Juan'),
(812, 309, 'Raúl Leoni'),
(813, 309, 'Gran Mariscal'),
(814, 310, 'Cristóbal Colón'),
(815, 310, 'Bideau'),
(816, 310, 'Punta de Piedras'),
(817, 310, 'Güiria'),
(818, 341, 'Andrés Bello'),
(819, 342, 'Antonio Rómulo Costa'),
(820, 343, 'Ayacucho'),
(821, 343, 'Rivas Berti'),
(822, 343, 'San Pedro del Río'),
(823, 344, 'Bolívar'),
(824, 344, 'Palotal'),
(825, 344, 'General Juan Vicente Gómez'),
(826, 344, 'Isaías Medina Angarita'),
(827, 345, 'Cárdenas'),
(828, 345, 'Amenodoro Ángel Lamus'),
(829, 345, 'La Florida'),
(830, 346, 'Córdoba'),
(831, 347, 'Fernández Feo'),
(832, 347, 'Alberto Adriani'),
(833, 347, 'Santo Domingo'),
(834, 348, 'Francisco de Miranda'),
(835, 349, 'García de Hevia'),
(836, 349, 'Boca de Grita'),
(837, 349, 'José Antonio Páez'),
(838, 350, 'Guásimos'),
(839, 351, 'Independencia'),
(840, 351, 'Juan Germán Roscio'),
(841, 351, 'Román Cárdenas'),
(842, 352, 'Jáuregui'),
(843, 352, 'Emilio Constantino Guerrero'),
(844, 352, 'Monseñor Miguel Antonio Salas'),
(845, 353, 'José María Vargas'),
(846, 354, 'Junín'),
(847, 354, 'La Petrólea'),
(848, 354, 'Quinimarí'),
(849, 354, 'Bramón'),
(850, 355, 'Libertad'),
(851, 355, 'Cipriano Castro'),
(852, 355, 'Manuel Felipe Rugeles'),
(853, 356, 'Libertador'),
(854, 356, 'Doradas'),
(855, 356, 'Emeterio Ochoa'),
(856, 356, 'San Joaquín de Navay'),
(857, 357, 'Lobatera'),
(858, 357, 'Constitución'),
(859, 358, 'Michelena'),
(860, 359, 'Panamericano'),
(861, 359, 'La Palmita'),
(862, 360, 'Pedro María Ureña'),
(863, 360, 'Nueva Arcadia'),
(864, 361, 'Delicias'),
(865, 361, 'Pecaya'),
(866, 362, 'Samuel Darío Maldonado'),
(867, 362, 'Boconó'),
(868, 362, 'Hernández'),
(869, 363, 'La Concordia'),
(870, 363, 'San Juan Bautista'),
(871, 363, 'Pedro María Morantes'),
(872, 363, 'San Sebastián'),
(873, 363, 'Dr. Francisco Romero Lobo'),
(874, 364, 'Seboruco'),
(875, 365, 'Simón Rodríguez'),
(876, 366, 'Sucre'),
(877, 366, 'Eleazar López Contreras'),
(878, 366, 'San Pablo'),
(879, 367, 'Torbes'),
(880, 368, 'Uribante'),
(881, 368, 'Cárdenas'),
(882, 368, 'Juan Pablo Peñalosa'),
(883, 368, 'Potosí'),
(884, 369, 'San Judas Tadeo'),
(885, 370, 'Araguaney'),
(886, 370, 'El Jaguito'),
(887, 370, 'La Esperanza'),
(888, 370, 'Santa Isabel'),
(889, 371, 'Boconó'),
(890, 371, 'El Carmen'),
(891, 371, 'Mosquey'),
(892, 371, 'Ayacucho'),
(893, 371, 'Burbusay'),
(894, 371, 'General Ribas'),
(895, 371, 'Guaramacal'),
(896, 371, 'Vega de Guaramacal'),
(897, 371, 'Monseñor Jáuregui'),
(898, 371, 'Rafael Rangel'),
(899, 371, 'San Miguel'),
(900, 371, 'San José'),
(901, 372, 'Sabana Grande'),
(902, 372, 'Cheregüé'),
(903, 372, 'Granados'),
(904, 373, 'Arnoldo Gabaldón'),
(905, 373, 'Bolivia'),
(906, 373, 'Carrillo'),
(907, 373, 'Cegarra'),
(908, 373, 'Chejendé'),
(909, 373, 'Manuel Salvador Ulloa'),
(910, 373, 'San José'),
(911, 374, 'Carache'),
(912, 374, 'La Concepción'),
(913, 374, 'Cuicas'),
(914, 374, 'Panamericana'),
(915, 374, 'Santa Cruz'),
(916, 375, 'Escuque'),
(917, 375, 'La Unión'),
(918, 375, 'Santa Rita'),
(919, 375, 'Sabana Libre'),
(920, 376, 'El Socorro'),
(921, 376, 'Los Caprichos'),
(922, 376, 'Antonio José de Sucre'),
(923, 377, 'Campo Elías'),
(924, 377, 'Arnoldo Gabaldón'),
(925, 378, 'Santa Apolonia'),
(926, 378, 'El Progreso'),
(927, 378, 'La Ceiba'),
(928, 378, 'Tres de Febrero'),
(929, 379, 'El Dividive'),
(930, 379, 'Agua Santa'),
(931, 379, 'Agua Caliente'),
(932, 379, 'El Cenizo'),
(933, 379, 'Valerita'),
(934, 380, 'Monte Carmelo'),
(935, 380, 'Buena Vista'),
(936, 380, 'Santa María del Horcón'),
(937, 381, 'Motatán'),
(938, 381, 'El Baño'),
(939, 381, 'Jalisco'),
(940, 382, 'Pampán'),
(941, 382, 'Flor de Patria'),
(942, 382, 'La Paz'),
(943, 382, 'Santa Ana'),
(944, 383, 'Pampanito'),
(945, 383, 'La Concepción'),
(946, 383, 'Pampanito II'),
(947, 384, 'Betijoque'),
(948, 384, 'José Gregorio Hernández'),
(949, 384, 'La Pueblita'),
(950, 384, 'Los Cedros'),
(951, 385, 'Carvajal'),
(952, 385, 'Campo Alegre'),
(953, 385, 'Antonio Nicolás Briceño'),
(954, 385, 'José Leonardo Suárez'),
(955, 386, 'Sabana de Mendoza'),
(956, 386, 'Junín'),
(957, 386, 'Valmore Rodríguez'),
(958, 386, 'El Paraíso'),
(959, 387, 'Andrés Linares'),
(960, 387, 'Chiquinquirá'),
(961, 387, 'Cristóbal Mendoza'),
(962, 387, 'Cruz Carrillo'),
(963, 387, 'Matriz'),
(964, 387, 'Monseñor Carrillo'),
(965, 387, 'Tres Esquinas'),
(966, 388, 'Cabimbú'),
(967, 388, 'Jajó'),
(968, 388, 'La Mesa de Esnujaque'),
(969, 388, 'Santiago'),
(970, 388, 'Tuñame'),
(971, 388, 'La Quebrada'),
(972, 389, 'Juan Ignacio Montilla'),
(973, 389, 'La Beatriz'),
(974, 389, 'La Puerta'),
(975, 389, 'Mendoza del Valle de Momboy'),
(976, 389, 'Mercedes Díaz'),
(977, 389, 'San Luis'),
(978, 390, 'Caraballeda'),
(979, 390, 'Carayaca'),
(980, 390, 'Carlos Soublette'),
(981, 390, 'Caruao Chuspa'),
(982, 390, 'Catia La Mar'),
(983, 390, 'El Junko'),
(984, 390, 'La Guaira'),
(985, 390, 'Macuto'),
(986, 390, 'Maiquetía'),
(987, 390, 'Naiguatá'),
(988, 390, 'Urimare'),
(989, 391, 'Arístides Bastidas'),
(990, 392, 'Bolívar'),
(991, 407, 'Chivacoa'),
(992, 407, 'Campo Elías'),
(993, 408, 'Cocorote'),
(994, 409, 'Independencia'),
(995, 410, 'José Antonio Páez'),
(996, 411, 'La Trinidad'),
(997, 412, 'Manuel Monge'),
(998, 413, 'Salóm'),
(999, 413, 'Temerla'),
(1000, 413, 'Nirgua'),
(1001, 414, 'San Andrés'),
(1002, 414, 'Yaritagua'),
(1003, 415, 'San Javier'),
(1004, 415, 'Albarico'),
(1005, 415, 'San Felipe'),
(1006, 416, 'Sucre'),
(1007, 417, 'Urachiche'),
(1008, 418, 'El Guayabo'),
(1009, 418, 'Farriar'),
(1010, 441, 'Isla de Toas'),
(1011, 441, 'Monagas'),
(1012, 442, 'San Timoteo'),
(1013, 442, 'General Urdaneta'),
(1014, 442, 'Libertador'),
(1015, 442, 'Marcelino Briceño'),
(1016, 442, 'Pueblo Nuevo'),
(1017, 442, 'Manuel Guanipa Matos'),
(1018, 443, 'Ambrosio'),
(1019, 443, 'Carmen Herrera'),
(1020, 443, 'La Rosa'),
(1021, 443, 'Germán Ríos Linares'),
(1022, 443, 'San Benito'),
(1023, 443, 'Rómulo Betancourt'),
(1024, 443, 'Jorge Hernández'),
(1025, 443, 'Punta Gorda'),
(1026, 443, 'Arístides Calvani'),
(1027, 444, 'Encontrados'),
(1028, 444, 'Udón Pérez'),
(1029, 445, 'Moralito'),
(1030, 445, 'San Carlos del Zulia'),
(1031, 445, 'Santa Cruz del Zulia'),
(1032, 445, 'Santa Bárbara'),
(1033, 445, 'Urribarrí'),
(1034, 446, 'Carlos Quevedo'),
(1035, 446, 'Francisco Javier Pulgar'),
(1036, 446, 'Simón Rodríguez'),
(1037, 446, 'Guamo-Gavilanes'),
(1038, 448, 'La Concepción'),
(1039, 448, 'San José'),
(1040, 448, 'Mariano Parra León'),
(1041, 448, 'José Ramón Yépez'),
(1042, 449, 'Jesús María Semprún'),
(1043, 449, 'Barí'),
(1044, 450, 'Concepción'),
(1045, 450, 'Andrés Bello'),
(1046, 450, 'Chiquinquirá'),
(1047, 450, 'El Carmelo'),
(1048, 450, 'Potreritos'),
(1049, 451, 'Libertad'),
(1050, 451, 'Alonso de Ojeda'),
(1051, 451, 'Venezuela'),
(1052, 451, 'Eleazar López Contreras'),
(1053, 451, 'Campo Lara'),
(1054, 452, 'Bartolomé de las Casas'),
(1055, 452, 'Libertad'),
(1056, 452, 'Río Negro'),
(1057, 452, 'San José de Perijá'),
(1058, 453, 'San Rafael'),
(1059, 453, 'La Sierrita'),
(1060, 453, 'Las Parcelas'),
(1061, 453, 'Luis de Vicente'),
(1062, 453, 'Monseñor Marcos Sergio Godoy'),
(1063, 453, 'Ricaurte'),
(1064, 453, 'Tamare'),
(1065, 454, 'Antonio Borjas Romero'),
(1066, 454, 'Bolívar'),
(1067, 454, 'Cacique Mara'),
(1068, 454, 'Carracciolo Parra Pérez'),
(1069, 454, 'Cecilio Acosta'),
(1070, 454, 'Cristo de Aranza'),
(1071, 454, 'Coquivacoa'),
(1072, 454, 'Chiquinquirá'),
(1073, 454, 'Francisco Eugenio Bustamante'),
(1074, 454, 'Idelfonzo Vásquez'),
(1075, 454, 'Juana de Ávila'),
(1076, 454, 'Luis Hurtado Higuera'),
(1077, 454, 'Manuel Dagnino'),
(1078, 454, 'Olegario Villalobos'),
(1079, 454, 'Raúl Leoni'),
(1080, 454, 'Santa Lucía'),
(1081, 454, 'Venancio Pulgar'),
(1082, 454, 'San Isidro'),
(1083, 455, 'Altagracia'),
(1084, 455, 'Faría'),
(1085, 455, 'Ana María Campos'),
(1086, 455, 'San Antonio'),
(1087, 455, 'San José'),
(1088, 456, 'Donaldo García'),
(1089, 456, 'El Rosario'),
(1090, 456, 'Sixto Zambrano'),
(1091, 457, 'San Francisco'),
(1092, 457, 'El Bajo'),
(1093, 457, 'Domitila Flores'),
(1094, 457, 'Francisco Ochoa'),
(1095, 457, 'Los Cortijos'),
(1096, 457, 'Marcial Hernández'),
(1097, 458, 'Santa Rita'),
(1098, 458, 'El Mene'),
(1099, 458, 'Pedro Lucas Urribarrí'),
(1100, 458, 'José Cenobio Urribarrí'),
(1101, 459, 'Rafael Maria Baralt'),
(1102, 459, 'Manuel Manrique'),
(1103, 459, 'Rafael Urdaneta'),
(1104, 460, 'Bobures'),
(1105, 460, 'Gibraltar'),
(1106, 460, 'Heras'),
(1107, 460, 'Monseñor Arturo Álvarez'),
(1108, 460, 'Rómulo Gallegos'),
(1109, 460, 'El Batey'),
(1110, 461, 'Rafael Urdaneta'),
(1111, 461, 'La Victoria'),
(1112, 461, 'Raúl Cuenca'),
(1113, 447, 'Sinamaica'),
(1114, 447, 'Alta Guajira'),
(1115, 447, 'Elías Sánchez Rubio'),
(1116, 447, 'Guajira'),
(1117, 462, 'Altagracia'),
(1118, 462, 'Antímano'),
(1119, 462, 'Caricuao'),
(1120, 462, 'Catedral'),
(1121, 462, 'Coche'),
(1122, 462, 'El Junquito'),
(1123, 462, 'El Paraíso'),
(1124, 462, 'El Recreo'),
(1125, 462, 'El Valle'),
(1126, 462, 'La Candelaria'),
(1127, 462, 'La Pastora'),
(1128, 462, 'La Vega'),
(1129, 462, 'Macarao'),
(1130, 462, 'San Agustín'),
(1131, 462, 'San Bernardino'),
(1132, 462, 'San José'),
(1133, 462, 'San Juan'),
(1134, 462, 'San Pedro'),
(1135, 462, 'Santa Rosalía'),
(1136, 462, 'Santa Teresa'),
(1137, 462, 'Sucre (Catia)'),
(1138, 462, '23 de enero');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pronostico`
--

CREATE TABLE `pronostico` (
  `ID_Pronostico` int(11) NOT NULL,
  `Recomendaciones` varchar(300) NOT NULL,
  `Plan_Psicoterapeutico` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `psicologo`
--

CREATE TABLE `psicologo` (
  `id_psicologo` int(11) NOT NULL,
  `id_administrativo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `psicologo`
--

INSERT INTO `psicologo` (`id_psicologo`, `id_administrativo`) VALUES
(7, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `relacion_social_niñez`
--

CREATE TABLE `relacion_social_niñez` (
  `id_relacion_social_niñez` int(11) NOT NULL,
  `r_s_padres` text NOT NULL,
  `r_s_hermanos` text NOT NULL,
  `r_s_otros_familiares` text NOT NULL,
  `r_s_conocidos` text NOT NULL,
  `r_s_extraños_m_edad_d_edad` text NOT NULL,
  `grado_integracion_a_ellos` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_cita`
--

CREATE TABLE `tipo_cita` (
  `id_tipo_cita` int(10) NOT NULL,
  `tipo_cita` enum('infantil','individual','pareja','adolescente') NOT NULL,
  `modalidad` enum('online','presencial','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_cita`
--

INSERT INTO `tipo_cita` (`id_tipo_cita`, `tipo_cita`, `modalidad`) VALUES
(123, 'individual', 'presencial'),
(124, 'individual', 'online'),
(135, 'individual', 'presencial'),
(136, 'individual', 'presencial'),
(138, 'individual', 'online'),
(159, 'pareja', 'presencial'),
(160, 'pareja', 'online'),
(161, 'pareja', 'online');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `traba_social`
--

CREATE TABLE `traba_social` (
  `id_traba_social` int(11) NOT NULL,
  `eleccion_profesion` text NOT NULL,
  `vivienda` text NOT NULL,
  `economía` text NOT NULL,
  `r_jefe_super_compa_subal` text NOT NULL,
  `crecimiento_psicosocial` text NOT NULL,
  `ambiciones_laboral` text NOT NULL,
  `cambio_profesion` text NOT NULL,
  `cuadro_familiar` text NOT NULL,
  `relaciones_interperso` text NOT NULL,
  `religion` text NOT NULL,
  `recreacion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `tipo_doc` enum('V','E','J','P') NOT NULL,
  `num_doc` varchar(12) NOT NULL,
  `correo` varchar(70) NOT NULL,
  `contraseña` varchar(34) NOT NULL,
  `nombre1` varchar(150) NOT NULL,
  `nombre2` varchar(150) DEFAULT NULL,
  `apellido1` varchar(150) NOT NULL,
  `apellido2` varchar(150) DEFAULT NULL,
  `foto` blob DEFAULT NULL,
  `fecha_nac` date NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `sexo` enum('Masculino','Femenino') NOT NULL,
  `pregunta_s1` enum('NOMBRE DE MI MADRE','NOMBRE DE MI MASCOTA','NOMBRE DE MI PRIMER COLEGIO','NOMBRE DE MI PRIMER TRABAJO','NOMBRE DE MI PADRE') NOT NULL,
  `respuesta_1` varchar(150) NOT NULL,
  `pregunta_s2` enum('NOMBRE DE MI HERMANO MAYOR','DONDE NACIO SU MADRE','NOMBRE DE MEJOR AMIGO DE LA INFANCIA','PELICULA FAVORITA','SEGUNDO APELLIDO DE MI MADRE') NOT NULL,
  `respuesta_2` varchar(150) NOT NULL,
  `status` enum('activo','inactivo') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `usuario`, `tipo_doc`, `num_doc`, `correo`, `contraseña`, `nombre1`, `nombre2`, `apellido1`, `apellido2`, `foto`, `fecha_nac`, `telefono`, `sexo`, `pregunta_s1`, `respuesta_1`, `pregunta_s2`, `respuesta_2`, `status`) VALUES
(1, 'neyli12322', 'V', '20198566', 'anais.asdm@gmail.com', '202cb962ac59075b964b07152d234b70', 'Neylimar', 'Maria', 'Perez', '', 0xffd8ffe000104a46494600010101006000600000ffdb0043000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f171816141812141514ffdb00430103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc0001108028e020803012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00fce66e94d6e945158ea7691b6769a8eac374a8db3b4d1a9046dd29b4ea28d48d46d14ea28d4636807069d4374a5a9659b7bef2d80ad48cfcc9fed573e79abd677de5911d6606c52af5a8a26dfcd494143e85eb4d5eb4e5eb400ea72fde14da28025e68e6a2a72fde1400fe68e68e68e6800e68e68e695739a001739a75145002af5a56e948bd69d40c55fba69291ba522f5a0a1d45145040514abd69d400d5eb4add2968a00652af5a75140c28a28a0a0a28a55fbc280128a93715e6919772eea00652afde142fde14fe682439a39a39a39a0a0e68e68e68e6800e68e68e695739a0805ce69cdd2968a0631739a7374a31bb8a431ed19a0a1a73522fdda62e734fa00285eb42f5a75040514514c055eb4edc5791d69abd69d5a6a02ec67e4f4a29ac370c5146a070edd29b52b74a6d1a92328a7d146a031ba5339a95ba5368d406734734f6e94ce68d4046ced351d4bcd1cd1a81152af5a939a55ce69301f6337ef027bd6d0ff59f8573ec486caf5ad1b5d443c7b4fde15981a545471b6fe6a4a0a05eb4ea6d0bd6801d4e5fbc29b4e5fbc2801fcd1cd1cd1cd001cd1cd2ab1539a7799bb8a0061cd48bf76928a061452af5a7afdea0a18bd69ebd69adf785397ad040add29b4e6e94da0028a2957ad00252af5a56e94dddb79a007d14cf3377146edbcd003e8a6ab6f6c548b17340c6d3e4ed4863db1a9a45fbdd3341425152795245f7d319e948d9da68206afde14fe6a3a55fbc2801fcd1cd1cd2ae7340c4e68e69edd299cd050ab9cd3e98b9cd39ba50486dddc5236251cf414c6ced34e5fbb4143e3897f798ebc7f3a4dde673fdda6162bcd48abe5ae3fbd4002f5a69ff00594ea280153ef0a1bef0a4a17ad003b76de68f3377145140052af5a4a299039ba514c61b971456807227ef0a18165c54b48dd2b2020f2f6f348dd2a46ced34ca0919453e91ba50031ba5369f450031ba5339a95ba5368019cd1cd3e86e94c08db3b4d47f5a979a39ab60496d75242cbfdcef5b71fef155eb9f7c95356ec6fbca654acc0d75eb4ea8d26f3569cbd682875145397ef0a060bf78548b9cd2734734143e86e94ce695739a001739a751450405145140052af5a17ad3a800a2919b68cd355771dd400fa7460b3003ad3695543360f4a00578d95b27a5369cccb22e4755a6d002374a749d5685eb4ee3bf4a006af5a70a19955723ad3564dc7140c99ee36ac6b4fb58946666e8bcfe3daa0dc5791d68f319b83d282895e466b932c83323751ed51c926ee3663de9add2a48feed04047f7686ced3436769a671dfa5002afde14fe699f2f6eb42fde1400fe69c88f23055fbc69b92bcd2ab6f6c50324726153bbef546adbdb3514d1ede6a456dbb4d05060b4800eb560c2fb972322abc331c9c75a51bb6b39e940160b6d5dbb314c6e9491af96318ceeed44d9dcb84c1a6035b1b79e94abb7671d693e6efd296addc028a17ad399b68cd6603685eb42cdcd3bccddc504052afdea4fc71ef4336d19df9f6a062302cd81d68a6f9a7b75a2828e617eed14c0c579a9964dc98a08194d93ee1a931bb8a478f6a9341256a2a55059b14d31ed70680236e94da99b3b4d46dd2801b48dd29cbd695ba500454637714fa46e9400df2f6f34374a28a60339a32c391d69f4374ab604b6b78eb22a9e95b11b6f8c9ae7f696e2af69b70236f2cf435981a74e8fef0a685563b875a750592f34734c5fbc29fcd4941cd1cd192bcd0b26e6c5040ab9cd3a8a46e9400b450dd568aa00a55eb4eff966698dd2801cdd29cbf74d42b9cd3a801f4ab8ddcf4a62f5a566da334012e11b8a89a30b3314fbd4b2767a6afdedf400ee3bfdfa462546475a8de5f9ba67da96694e170983eb400bb9df83d2a58d762e6a35568f783d1a85eb400ad29ddf2f5a9e3fdd2ffb66aae37480648f7152795fedb9f63400af233360f4a6b0dcb8a19368ce71ef44709de1c3e4fa5003d22f969eb1ed6cd364dfe62e4647a51bb6f3b3140c939a39a67983bf4a1644cf1d68287ee2bcd1e5f9dcd2a4bf30a98295e17ab53208245d9228a6c8a5908fa7f3ab50c43cc7cfdea7c910dbcf4ad35029c71ed627e9562652ee40eb561a48a2501ba5431dd75d9d28d4046b778d949e94e54123053d2a192e9f3cf4aaaf73b9b146a32d3ba34c00ea29dbb6f354b696f981c1f5a9519d573bf346a513bcdb549c67daa20c03052980c714c9a693cb6236e7afcdd28b3d48dba19e5ddb4f11edfbb46a05dba8d6ddbca1d40cd434e4bc5ba89e41d699e616e075a4ee005b68cd11c81a3607a51e7b2fcadd3bd48aaac9b875acc08b0adc0eb4549bb6f345007136b3798055a462ac0d60c771e5b86ad3b79bcc5ad1dcc8bfbb7f1479551c6e23f98f4a9a365760475acca1be5ede686e953499da6a1a006374a8d8165c54edd29b4015fcbdbcd153b74a67341247453db3b4d32800a6b7dd34ea46e941445453e8a0918dd299863d3ad4add29b8ddc5005db3be68c88dba1ad256575c8eb580136f3572c6f3682b4166b2fde14fe6ab236f5cd397ad4944fcd1cd2afdda4e68200e6a45fbb4c5ce69d40052af5a4a1ba5003890a32dd2a0694eee06571d29dcd2ae7354016f26e8c0d98e7ad4b5148372114823db1934012b36d19a6348586075a4846e56153b45f32d00575dd919e953c9d569a91850c4f4a5dc89f30193e94006dddc54127fc7c227f9e953fda19b844c37ad33cc569d80ebde8192c71ed5cd36e8336021c37ad2336c5dd5135ce6641fe7a50513baac68195f2c3a8a62c9b8e2a165dce1a95a4dc367ad004fbb6e4fb52c2bba1ddef50b43f32d5c5cfca83a9a6411d1b8af2bd6a7f2dbf8b18f7a46b3963181b36b7a75a006dab097729fbc453638fccda41c6d34f585e13bfd29cb0c932af38f7a0095bc9b565dedbc9ed490afda18848c119fe2a7dad9052497cb7a55e550ebe59c60fad680410db349704b32055fe114f99636cb119db44d3c76f1954d9b3f8b1d6b2e5d42459331d68049cfcd84c2d4727fa915467ba9e56fde7dcef55ae750961c11f7455125f6e9d71ef4c68782fe6562cdac79ff34671b7ad553ad3f9cc9bf3c5401d1ae7770f934ddce92063d2b9e8f5675dc738a5875a70c7e7cd02e73a4fb4eee2a22de63853deb2e3d477ae64fb9de9e9a86d6063a0be62dcc1ad7ef7fab3d69e667555913a0a6457698dafd585452662b838fba528037ade61222e7efd2bc9e5b6ef4ac5b698ae48eb5a1f68130564e8bd6a3502caa339f317ad14c595b61dbd7b51401e6abd6a584ed901a651bb6f346a646c4373e7478f4ab31d60c736d706b52d6e3780293b966a46372e2a378f6b66a28d8ac80d4fe66ee2b3288e86e94fc6ee291e3daa4d0491d14514142374a6735251401136769a654edd2a37ceda00652374a73f6a4a091948dd29edd29b400d57f2ceea7ae2661bba5252336d19a00bf6f70518463eed5e59372e2b0566dac0d695a5c6fc2d0517d7ef0a7f3502f5a917ef0a0091739a56fba69158a9cd47249b8e2a409d71b393b47ad324b858d0803cb3e9fdea8dd436d04647a50366ed9b319aa0258db7ae6a36fbd4e58d54823ad4972c55411d680056da84d470a6f24d3e1469304f4a6ef092480f4a007dba796c4d5869372e2a25548d303ab54b180cb83d29811b7dd350a77ab9b4476ee5065b8c0fc6ab3058c7cc9866ef5a6a0273dbad579b7fa81ee7a513ea9146ce8df76a949aa5be7e5196f4a35035216658f2ce857d0541e5a4bbb1d6b3c6ac8bcf97511d4165d855769f5a350367e586362dd31552dae9761ff9e99f9aa8b5ec370a5649391572186ddadcb2cdb5bb1c66802c2b7990b1dbbba71f8d2dbdd794cf87d9fecd2d859dd2c0e3ed67e6e984c77ab771a5c9e4ef759663edd6ac0586ea0fbd23e7daa44d560da89c6c3d73d2a8c9a3c12edf30dc45f97f5a7369967032edb8981f7d9fd2802e5dea115c8112940a9dc75a8212c2419fde37455f5a921d1ec860c6af316eb9f5a9bc98b4fedb243f796802c5ba9dc1261b19790b45d5d08636d832d5526bb8e18c9f5ac5bad4bcc936ff0005320b93df08df97f39cfe959975ae451e418fe6aa37770ed911807ebd2aa3d88914c934a8a3ba8aa2352cc9ae2dc36445923b5451dc0b8dc206dac7aad55ff4687a1de7b28f5ab0dacbe9c8373c71cbe917f5a0351f0e9b713e647448557a990e14d57b8f274f63bf75d1ff0065f318fad53bad60de13e72ee63d1aa36916688b0eab406a3975391988c227a28eb4efb706e0fdfacf7fbd49406a6bb5d7ee529cb77b57359ebfeae3a5dc579a066c5bdffcc2b556ebed901f615cc452d6858cdc1a82cdcb36f32107fba6b56ddb68cd6069ff0075deb76d64dd1e2828b6ebe59518ceeed4528ced38eb450079a52af5a4a2a3531d47edddc53e398c2e36f5a897ad3a8d466b5bdd895769fbc6af2b6d5cd73b1b6c706b5acee37e052772cd2126e422917ef0a897ef0a957ef0acc06bfdea6b74ab1cd42ff7a8288e8a751400da46e94f6e94da0089b3b4d32ac52374a008291ba548d9da6994123291ba54948cc54657ad00454b9c73536d11c641fbcd4c5fbd40176cae77109eb576b0d890d91d6aedadd36d087a5051a0adb4e69eb889867a1aaa2424e14e0d4eb1881325f2c6800790b361faf6a7a90a996e94c5fbc1f19c55a54574cba617b9a60567ba6954edfba296099f6a55a9210d80bf76a36b7f2c6ead350176b9f9a92dade47932081f5e953fcb85de76afad46d22b308d4794a4fe74017e1b748fe691d0e3d2a48596e98aa8ca8ed55239e2b7662adba4c702a1f31db7e5768c1627e9cff4ab00d43548a1dc90aed65ea6b9dbbd525bb90ec7cb0e82a2bb2f78d180c5a1762ca075cd5efb2c5636e3cc91e5926c06cf6e6824cc8637909f31b6fbd5b16290c64e339fe3abb702d6c235f2ff00d730e2b3669259e3c2f520d0037cc8638dfca8439eec69d1dc6e18f2621f5a58e2b98ed5d08c869071f8542f23c6a7cb8feb4145f8f5030ffab4842f72a326b406af716b6e8cfd4f4f9315cf4734f2c817ca2dec3ad48cb35c4c41df1e3b1a09359b5c9e66f23a62b46292484223a18147271deb26cecef66c0964c463d2b4ec74d8e0902958d189c91fc4c3bd3289619278cb0883c7b98f07a353d61134cbe6fdfce6b42688dbab328596e25c2c68dd234a67daa1d36333b7ef597e43fdd5aa018a5228d9c7566c563ea57c1b723671edd6b335af17fda895b30d23ef23ed1275fa0ac9b7f32e1f2ef954e5a820d8f3bfb43fbfb17d683b211c556b362cc587dd5a592f8c72100a838232dd3a1a08d486e6f61b691c2863291c05ea4d645e4ad83f68da256eb0c7d17eb57edade799a416b80cabfbdba6fb91e4e3f5e9f8d52d52da0d2ff00760b5c5c75dd274fc280d4ce92e9f6948d319ef55955955831219bd3ad5a493e6df215d9dd14e0fe742df4d6aade42c6a0f7c65bf3a0cc6476772cbb9609245f5a6fcd0c833be37f4353497d34db7cc7cfb55769373628025fb4c6dc49097ff68535c40ca5919d5bb29a89b1b4ee191fecf5a985acd1c71cacaea1fa13400aff00ea63fad393eed37cd7fb9e6628f39fee15dc0ff15003d7ad5fb76daa0d6706da7356ade4dcc0541aadcdcb193746457451ff00ab4fa573362a19941e9ffd6ad8b77548980eb41a9ab6ac17712703ff00ad4554dcd247185fbd4500710bd69d4ca2a3531d47d14ca28d4351f4e8db638351af5a751a8cd7b5b8dc00ab51c9b9c0ac08e4f29c37a56adbcde628a4ee59a4bf78549f5e95593eed4f1fddacca17e5edd686ced34bb8af351349b9b14008dd29b4e6e94dc6ee28006e94c6e94ff2f6f3450044b9cd2c9f70d48dd2a03f785003553cc6db4fff0053df1460b71522c7b573401132890659f23d289a23b463eed3e4059481d691a3656527a50057e3eeb74a9a284f6fbb4c6c6ff98e07ad1e732fcaaf95f4a60598dc2300718f738ab6b2132207d99ed87cd54f32265009c37ad4d66f1dbb60c9c3569a81a515befe738f7a9562131e5f2076a8a230c9d1d89f45eb53c30a348a3e5ff817dea350268e30abb51b6b7634d9310c21d93cc607834f65549980eb50ccb230222c6fed9fd680332f2f2479955df667a2d5cb71147b4166666ecbd4fb54124ff67e6358e79fa6efeef6a66dbd5c833a5b09072c3b5684934cdb250648fc939c2c3fc409e01a99f4eb89ed5e161b1f76e99a4fba17ad49696f67a5ed9123f32e593ef7a93c669d15c26d92167593bcb237423d2a80cd8ed6367716d08f25b03cc6eb2107b5364d90cac83f7d276f6ad54bb37313f931b792bc2bafddaaa9a5ca5cb33f96add5a80335b4e371229793cb466008fa9a5be84cd7ed676b0ec85404ddeb8e4d6d9b54ff0044b7b64daaad976f5ef534d6b0e98d71387f2e6b8f977ff747f11fc0668039fd62d99f71833e446c10e3ae76d67d9e9ad23658391ef5bfa5c6354016441140e4b053dd17f87fe05d6ac5f2ac50bdb060bb7e79993a839f953f2a00c9591615f954ab2f190b93f955ab3b49265320b37889380f31c373c640fc6990a968de43b628947c9bbef1ed5afa6ca96709777cc9b3e51400b2d8456eab6f13e12319924fef39ed4db18521dce07dd39dfe9447a96f81cd51b8d4956cdd9ce1473525136b9e2a82cd33bb73b0c015c16a5ac5d6a4e24b993f7633b52a2d4b5079e4dfbf21ce00aa888d23027a55184b71f1abde6c8d3a21cd6a5ba855f2cfde354e393cb18a9add5dbe64fbd9e2a0a2d35d344bb13ef76a961851b1f68fb8df7a9ccf1464b4c017c743d2964dd2e36c69e577c505916a1aa96115bda2f970c79d8bfdce39ac39f336ec2ee3ddab61d7cc6f2e34c21fbd4e874ddf205a0be43122b58bf8bef53dad372e3f83bd74f65a089db61e8793f873566eb47326dd9fea9385acf98bf62716d60db7e5fbb4efb0c823241c57a059f8415b74f723cb8147c91ff7bb5237864cdb9047f21e947307b091c1c322da90f042ad329c8661919fa54fa84336edd7570d24d8c1491b04679e0575f2f84eeace36f2d319ef5cfdd787e6b566692853899ca8496b630d624cd4b1c0ace00383eb565ac76b66a2fb3859013d335a19f295dd36cc177e7daa48e3dae0d5c9214327e14834e91be61f768117ac7ee8ad4865f3b03f0aceb3819300f4c1fe55ada7a88e3563d334166ada41f678fed120cbb7c8a3e9454b6ea91ae0100b77345051e6abd69d45151a98ea1451451a86a14514abd68d435129d192ac0af5a1ba522f5a3519b7657227400fde156d5b6b035ce231460cbd4569dade0b8c29fbc2932cd959372e295739aab1b6d19ab51c9b9715980add29bcd3e91ba549431b3b4d44cbb862a6dc1396e94924c6491547dd354040cd81b69abd6acf9751b47b5b34011b7dda7c736d5db4302c30a707d69eb1a85cb3e5a80216937360d4124b24adfec0eb53b4d1eed84e3351ee68d19962c8fefd30209182a127a5529255ddc024fa0eb56a4b8666c31c0a6314dbfeb71ef5a6a036398a8c84707d4d5cb72f2b0a8636551959816f43576d9a4760a244cfb75a3519a76724919005598ef563dcccc158773551219997065c0a6c71c8b9513027d0d0513cb788fc85463fde1d6a3fb605e586454922489b59d90a8ea075acfb8ba8e663bba2d5904d25f9cf0bb57d6aa4d7e7071273546e2f36b154e95456ea5dc76f5a0936bedc5a32225da4f064f4ad0b386796148dd8a5b0e8a3ab66b1ecf4b598af9d26c0dc91ff003d7ffd5d7f0add8ee60b455c9658d06495eb401bb7491587eecb3cd2aed2b19e91f150bdc2dbc2d71331566e5547b564c7aac92ee4c2c51b7ce3cbe87eb59d79a86f727ccfba73401a51cf3fef255dff00689b9e7d0f07f435575ebe9bf7b0c5fc2022ff00df3cd558eee59a68d1643b5be7e3af4a8566964be62cee557d6803a5d26375b5311ec14b7e5552f2ebcfbc30c7f73386a6497de5db91ed542d428866b87fbabd7f1e2802fdf4f1b3f911ff00075aaf25d7958fa5430cc2487e5fbb9a8a6556b84ddf7739a00bd14b98d50ff1573fad5c49777021fe08fad5dd46f0c2b238fbec30b5cdf30c2dbbab9cd0219b77163fdda1739a6b49b9714d41b980a09d49aa7858ab02bd692384b0c0eb56e1b675209e9416a3a92d9b2c12b97192474ab6b06f541b311b753518b7f32445addb6b40cab19e86b9e523aa312a456e5e3c8fbab5afa6e99e6ede33ed52dadaac12291d735d1e9b69e7c930e7eef6fa563ce7546043a7e8e761da9835bb0f86d63dacc0127b1ad5b0b7025311b793042fcfe9c56fe9ba679b332c0b2203d5bd2b094cefa70d0c4b5f0ba5d323ec8c6dff000ab71785215b85312a39ee075aeb74bd0dd647313b4bcf2edd16baed3fc1fbf264646dd8e075ae79ccec8523cca4f04a8c1783e56eb585ac78015e190ac185afa3a3f091f2ca6cc211cd675ef84d36b2573fb492d4e8f6309687c81af780658d95963f94573573e179e12711f22bebfd53c06b323e17771d2bcdfc45e0796d728d07ccdf76bb69628f2ebe052d627cf31e9ea6421130cbd4d4335bbac9b6bd62ff00c1d2aae5e1c2f3935cbdd78727857f771f7af4a35398f1ea51e4671715bbadc21f7adcb38cac84cfd71c54f269d2a70c986aa6b6322b920e0d59cd2dcd38d8ab020e17e99a2a2fb3ccbb498430fef1e945581c0af5a750dd29abd6a3531d475145146a1a851454a3fd5d1a86a46bd69d4abf7853db3b4d1a86a47402472bd68a296a335ac6e86d087ef55d59be615ceab6d606b4ed6fb7613d6b32cd9590b2103ad26d2dc37dda8619b18353adc65b14143599154a8eb4ce3bf4a26fdce7dea1f3a802e47b36d4725c2a70bd6abf99bb8a5e3bf4a6027da9fcc19e948d70b23ed6195f4a82e2e1235200cd40be64adf7309dcd69a81764ba8a243b576b7ad675d4fbd49df9a86e18ab6d1d6a161230c038a35017cca7249b980233ed5108d41cb49cd598a6503687c9f4a092c5bb4aac0ac7f2d68dbcd73b8792bb4773595f6dd9c6edbef522df6e4c6cdffed55946ac893c8d979b61fef559568d76acb2799ef5cfb5d7cbf7314f8ef0aae475a00d6cc6bb8a74a82eae84b1a64640ed59724cd275e94cdc5790bb8fa5004f2488c71b31ef53d92c4ea4374aa732ba28170ec88dced4ea7daa1378f22958c1118fe05e8bf5a083566d6bc9cac63763802b367d4995f2ede64adf78ff0076b3ccce37549696ad9f9ba35049a904fb533eb504d71be4da29b7130823da9f7aa082d46d2ffc64f14166946d1ac2c7f8f69c7e5496336d507daa1489b736efbb8a8da4589be5eb4016eeaeb3201ebc52b4dbe1483d39acc9257ddbea7b56791d49e9401b56f27950d2a9125c12df740c9fc056734c42ed1d6ab5e4fe62f951ff00175a00afa85eadd5d1913fd5670b55994b2e475ab3069aeea49e95721d376f39c7bd27b17c854b4b169719e957174d08d93d2afc567e547bb7e71da890b053b464d63cc6f1a453d88bf281935a16762656181b0ff7aad59e933b206f2c1ddd8f4ad98f4a9e64501d108fe11d6b3948ea8d132e3b10ac155770fe26adab3d36778f6c6fe5e47defc2afe93e183260b36e6eb8aee743d04c7b5946c2c08ddf8573ca475c30e725a6f87dd001245cb281fef735d6683a0c7e7659f64a3e465fa73563fb35a6baf220fbcbd64f4adcb2d12285550aee75232d59391d91a16d4b7a1e8c92dec9825caff08aecb4cd0dae976cccea0745355b48d2e48dd52200ee1c67e95d86916b3c6a7cf8d33db15c9291d51891e97a2c31dd3a0193b0715d7697a72a4780983eb59d6f195d59884c1f24735d358b32a827a54965cb3d355e3dac32a7b5171a2c041fddd5db59376056846030c1e9401cadd787e2b8e5631903bf4ae5f56f071923ff005487d96bd39a1566c0eb55e6b4dd915051f3f6b5e038a3dfba05dc7a798703f3af3dd63c2d3c6c115b6b672cb1a16181cf515f51eb5a29b8c81d4d79f6bde159599c28cb63a574c2a729c7568c667cc3e24d056d7722ac8ccdf391b9c77f435c94c86de4c06753fdd35ef1e23f0caac722b45997b0af24f1169bf66931e4e3debd4a556eac78788a3ca602b34a7696da0f7ce28a8e4711aa831f145746a79fca79d374a6d49e5ede69ac370c51a98ea368a3cbdbcd146a1a853a3fbe29b4abd68d4351cdf7aa68f18e7a544aa19803d2a69245b8db18eb46a3236dbbc63ad387bf4a4dbe5f1436769a352c7fcbdbad2f3fc3d6a05fbc29ed9da68d40d4b3987087ef55c460ac09ae763628e08eb5a96f7219707ef527702f334970e0ff0000a6b36d9996a1f38ae4a9c1c75a80315870b21f358f18a802792e7cb35526bcf332b50c96b3cd9f2e191fd5a99e44a9c181c37a9ad35024593e6149717c23204270ddcd559229bbc7c547e5baf3e59fc28d4a1649cbf2cf96a8fccddc5482d649bfe59b9faf4ab3168776e3222f2d3fbde941253a6b3f96bb88ce2b523f0fee70247abd169b15bf0902c8dd8b74ab030a15b8b820431f26adb58b065f3a7f3dbfe79d6a30b98a15d9e4463d075a8bcb964e5a5556f55eb401044aa9c08067dea4da1b867541fdd5eb4ffb2aff0018794fbf4a46574188e20bee68288a57d88465dd3ba9ef55cde48c33143b36f7ab4c9e62ed7280fa8eb49188e36197c8a0933da39247defd6868f8abd34d0ae48eb54a5b857f9475a006ac614e4f4a771fc1f7a945b19138eb522da342bb98e00a80208200cc58fdeabbbca4640a58ede39173bf350dc5c6f531dbf6eb5600acf23384ff0057b06efceab33799b8ff0076a692336f0244df7bfd67e7551fef500382ee38ab11ca615e3ad568db6b03576c2c64d4a45862fbee78fe749bb2b82bb7a12d9dab5db7ccc554f522b56db465dc30aec7fbc6bb4d1bc131c11a1232e4722ba9b1f07aba8023e6b867883d6a18476e691e64ba31dbc0c9f4ab11e8efff003cb35ecb67e090a8094e2afc7e078d86e68f8ae6f6e7a51c2d8f1287c3cef203e56df7ad3b2f0cb48a55beed7b22781c6df9633b7daad5af844c7e58891f6721b2323a547b736f6113c9e0d06354e99dbdab4ad746e0799113dc63ad7a83784e245da530c9ce7662a6b6f0c20653bb6fbd67ed0bf6670fa7dab47875824dadc75c7eb5d0e9ba3dc5e2fef653696e7eec702e4b7d4d6fae8ab1b4802ee3fdead3b7b22b0ed5ebc7f3a8e634e530e1d345b910428542f567ea6b774ff0eadc148c0caa905856ac3a5067dc7ef62b674fd2c6f5dc703ffad51cc5f2905869ed1dc88d530a18f3f81ad758191b0738f6a7adb87215a3c463ac9e9e95246ccae2368b83f75fd2a0a24d3e3c5cca70e7e51c1e9d6b7adee0233029815936ba7a47973febcfdeabf1ff00737ecff6a80362d6e55a4503ad6bc736d8f35cd47195190779fef568daefe33d280379bf7ca29bfec55349f6aeda9d1772eece28247c96ff006953ed5cfea5a2fce5b19adeff0081e7da90aeee2803c8bc4de145baf30c4801ef9af0ef1b782d23925693671e9d6beb5d534d32480ae33efd2bccbc69e18593cd918464827f8f6feb5b539f2bb18d4a719a67c73ad692230ccbd14ff5a2bd0fc71e198618fcc8910190f386dc7afad15ebc6ae8783530f6958f99d7ef0a939ed51afde152735d1a9e3ea0a1d9b1c7e34f10bb71ba25f73d299cd1cd1a86a5a5b38d97067877ff00b3d6a092ce443bb6ee4eed55dbef52ab18db72b6d3eb46a1a8d66dadb69cbf78548b70aedb5d771fef532488c4dc7dd346a1a8fe68e6a35fbc29ed9da68d460d9da6957eed2a00c30dd29de595e47dda352c664af34090e78eb4fc3370bd6a45b299d725b68f5a350163b99586c5ea6abc9bfcc1fdfed5347672dc6e5847ca3abd5eb7d2638e1469246de3fbbd68d4a32d6dd9db2c70deb57acac2e6ed4ec62c0761d6b4a1bab1b3ff005702c8e3a97eb4e6d61da2509b231e83ad1a8125af86c950d713bc6a3a83d2a7d96363c13bf1fc55913eae23058be5ab2ae356691be5fbd46a074771ab4292288ce2aac9acf3f7c9f615cdc934d2373d29b82dc374a3503a09759fdd9e631eff00c555ff00b6bfdb3f8566a46aab91d69f1b1560475a3524bcda9175c88df3fdf3daa48efd7f88027d0d52f2da5fbdd28db1af07a51a94692df465b05500f514c90c5237cbf7aa87daa18fb6697edcedc22607ad1a816da3daa4e715564ceee1f355e5b895fe56fbb51ee2bc8eb46a496d7ca27e642edfddce3f5a735f431aec02343fdd8573f99aad216930a7a1a62db1cf1d68d40b2d7d1b70c580f7ab36f79f6a98ac71061fde3d2a0b5d2da665cf4abd1dbbc8e22b7e9d0d05adc82f2f0ef11428818f0714efb0cf05bb4d3fee8f64fef569c56b6fa6fef24ff5fdab2351d48dc484bf51f76a398d5c742b4926ee2ab30dcc052487cc3927156f4bb19f507091a2a8ff009e8fd00ef56621a7e9b36ad7914302ef958e157f0af60f08f8322d1506f1bef1c7cedfddae7343ba8bc3e8b15840b34cdf7e793ab7d2ba3d37c4b7925d1536ea5bd17ad72d5949e88f4b0f18c3591dfe9ba565907bd77163e1fcc88d8cf1fd2b86f0ff008aa3740bf6593cc1d6bd0fc3fae473e64458e40bd4c5fc3f5af365191edc6513774ef0c890a929819ad41e1e0b76020cb761f856a68b730cd1ab3a617ae6baab2b58ae144abf75b8accdb98e457425652ed1f2c31503682984fddf7af409b4f4650075a87fb2c77e95259c2cfa0aed184c1f5aa4da4f96f8af473a4ac8368eb55a6d0ca6581c102a0b3816d17e5df5a31e9bb6106b7adec5a48c9963f2994fcbef5692c3e5a0d0e7a2b4317cc0038ec6a68e3789c6c44119fbc456db69e58601c1ed53ff0067796158be66fe2a04ccf5873b5aa54b5f983e338abab60fbb79e8298f6bf374cd419927d8f7056d98f7c66a6452cbb8755ff63155e1b6612295939ec95695a6438ab015376e1b8e07ad4e8d2a3060db97d2a16b9130c11b9876a48da3560636f33d4ff76802f4774dbc65303d6af46dbd7359adf795fd2ac473714017531b867a54be72fdd1d6ab46bb97753d7ad048eba5fb4608fe115cdeb5a5453a00df78f4ae92a2beb513467774c500781fc40f081bd8cb463330fbdf9d15e8be27d19a6b628a5829fee920f5f6a2ad4a5621c62ddcfcc0e68e6953a53abe8b53e1b519cd1cd3e8a350d46735111b9f15628a350d483cbdbcd0bf7854b27dc351c60b300bd68d462b6edbc75a922cff0017dda5da13e63f78527999e28d4b24dc8bc8eb42cdb4e719f6a92087710d4acbb1f346a508ac1d8131f15694c4172c98155cc831cf4aab35e2ae42f5a3503526d51b037745e959b71a9ee6c5566371743787d88bd5a9ab1c4a72877b776a009d672ed91d6a39266cf3d28f38fdc1d68daedc558159d7736ea002c71567c96efd28f2f6f341242b17cd4f58be6a538efd28b892389437614087ac6a0e5feed2b5df90328700566c976656da3ee9a4a08d4d06ba79072f91e94cf303707a552a541b980a065b76555257ef546b2be6a4588ede3ad5886dd9f0a7a546a595848c786195f4a9ad2d6399b98eafc76031cf4ab22c504648ddff0001eb417ca55933161026169f676fe636738f7ad19ecd42c73ca56188a8d88df79bd6a29b54e02449e4c23eefbd2d4be506558c619f2be94cfed58e1f953ef76aa97133c8a72f91e950cebbc2ae76e7bd662d7a0cbcbf9267355b62c9cb0dcde95d1699e0dbdd4155d2dbca88f57f5ae9b4ff0008c1a4e1f67da5c756f4a39e313a6142a54d59c65878726bb01e65f262feeff7aba05b59aced5225388bbd6e95f2dc0202479e54f4ad2b5b08379fb9f37a75ae59553b6385b1c7c3a5ca645db1905bfe5a0ea2b72db4594b26d9a58e5ecc3ad7636ba0c7347f21018f427a55fb7f0cb21cb1475fee8a9f6a6bf57399b45bdd3fe6fb5dd49b41f951883d3d4735bda4f89a6b8746fb75d46f18044d1c61c47cf56cf38a7de69a2de15648fcb6560437e22b32fe07b5ba678d8dbcdbbcd520e3342945e81ece513d6fc37f13afec66f21cd9ead09c3b7d9d76bffbea3d7d7db35edbe13f1859eb56f986750d8f9a16fbc2be34b5bc9e5bc926c6e94e1dd6293f789e847e35dff847e215d699771ee2b332101e676dd7183c608fc6a2712e9cf95d99f5cc33209117fbdfe1571614438fef579f7857c5561ac6e7867532c6a0b46cd8639f6aee2def15ed723af1fceb9394ef52d4b7e4a521851811502dd1f31b1d7145bb33ed2dd39a836226b3560e075c547f67dd83fdd5abade66eff0063bd4bf2edf9beed4145258728450b06c6cd5d3242cec83a9c53258d57791d78a00acff74d549613cb860a7d4d5c2bb8639fc2a3998075521c83d8d46a33396e1e356055187f7852ccdbd41ce29f710a24ce02005bb9aa8fbb76c4085bb01416ee4f18668d42be5bd298c258db730ca8ed55e484b290cbb4fad3a2889f904bb4fad5999712f36ae7662acdbdc05601ba3567ac926e033bf6ff00154dc45236ce87ef5006c08ccc9c7dda961fdde2b36da6daea6b4a3fde8a00bb149bb8a6cb1f9b95f5a8ed1b692b52bfdea0931f50d3cb46e075c515aaf6de629a2803f20b9a39a39a55ce6be9753e101739a7af5a4ddb79a04818e0f4a352c7d3a38c4b2056e869eb0a32eeab112a47f37a51a815db4f669982fdda996d62850e7ef55b9b6fd9d1c75155b687e4f4a3502a47b7cc38eb52eef2fe63d2a568d76f1d698d6ab18f9fee9e4d1a94356e25760abf769a5433807ef546f7059b111c638cd31f7c2a7e7cb9e828d4059fee94c6735523568e6564450ddb774abf6b0c93c643bec53d5aa7f211380779fef51a81419048b9964697fddfba2a6788451855fbad565576366abbcbc351a81108f6906924ff0058b5196323855eb4924822439fbd40093315048eb506f66e1beed479f36414b236d8cad59039ae1635217ef55490bc8dcf4a7af5a72aef3b68235228e2f9854be496e075ab50d986c03d2aec7671af27a50351d4ce8ed5f1572df4b92661eb579248625e84fd2a746775ca2ba8fef1e959ea6ca3a90c56296fcc8718ef52ab2a9cab6e5f4a77c9fc6f934ab711c6711825fb01506dca0ab231dc176a773491c91daee1bb7bb7007d6a4b3d3eff0058980862918f602badd2fe136ada80479956d0e78dcb927f0aca552313a234672f851cdeb0ccdf6099176b4b6c0e7e8f20aa9a6e8f77ab484436e645ee457b7e9bf09aca186ce3bb125dcb0218f7eec28c9c9e2ba73a2dbe936eb14117d9e2c7c8beb5cd2c52e875c304e5ac8f12d3fe14ea179b5ae9e3b38ffbbfc46ba9b1f0469ba3f96520fb44cbfc55d5dd48636503ad52999ae324f415cb2ad39bd4ed861e10d8cd10863205e40ede95567b3dc08ad476daa56a161b971527419d6f6ab82ac32a7ad6ad9e931315658f9a8a34dac0d6e69b0962acbd6a9ec32ce9b6a222f9400019c9e9c5741a4c963ac5b65366fce0e2ab5bd9c7709e5ca33b8735ada4e8f0595a9302e0679358f315ca54bed1434122a9c2918ae366d25e187ecf2c3bc44d90d5e90d1fca6b36eacd5b2cdd29c661c87966b1606c640ef1988ca0e1876e2b31ae808d1d8310abf7dba0aefb55b18665da17713dab86f1369274bd9796a793c14faf1fd6bae9d4bbb1c55a91d2f847e225c68b710b5c4cd3db21e76ae655f42a3d01c67db35f48782fe222eaf60844b1ddc2ade519a038238dd861f857c576f7612668f60176a432657393d718f7ae9fc39e329747d485c5bcd25bb484059506645f542bdc6eada7479b53969d674da4cfb87fb54c90878f7fe3d2a4875267c2afddfe2af27f01fc42b7d5b4e5432a194b7cdb576967ef91f4cd77475a0aad222798c07ddaf3e51e53d684a323b0fed04b7b64924fb83ad5ab3d422960775195c5717fdb9136c30bee1b46f5f4ab314c7cf8dd7a9cff002ac8e836e6863fb5adc6364ca9f237e18fe5565755e045fea9ca8c7bf358eb71e6301ff2d2ae2eddcdbbef546a69a9a724abe617693e6c54135d47b63cc5b87f7aaac7b370a94c88c3cbf5a035219a7fb464eddae3eeb55269530a8e779feed599a448f2376ded9aa923166f2dc72bcabfa5586a2b332ae55b6aff0076a368d245cc671ea6868770c6fcfb5342b2901065bb501a9346c47caaf93e956566f3173fc6bd2a99becbb074c11567623ed9075a04c9ede4918115a56f28957e4e83ad6741d455c83abd06668c6db79ab51b6ff96b3e1ea2aca36c60d4105bf2a8a856e771c633ec7a514127e40ae734f5fbc2a46b1995727a53d2d5f6d7d2ea7c50d5019b0c703d69cd6242950f956e714efb2bf7e957adedf6ae68d4ae52a423a7fb34f8bf8aaeb47b466abbaee6c51a8728da1a118dc7a52ee2bf28eb5135acf2b7ef3f0a3500370b18217ad57937cc6ae43a7b798bbba568476b6d08deea188ec68d40c6b5d3249647c1c55d934f116df9f2fdaad5d5d79b8cb88c0e813ad55866dac4e15867ef37dea350092d58e377dda864b85b78c81d69d717535e4ce88bb87a55392d7fe7a394ff006475a35019e64732b64e1ea292d659645512614d4aab6f1b60c6d8fefb74a8e5be923e238d624ff67a9a350245b331ae22033ddcf4a824d2e495be79620bdf3522c777749970cde81ba539b4ff00997cc641fec8eb46a041fd9e91f1e7c3ff0001eb4e4d221918179895ee075ab2f0c316dc0c9a4f93fe79d1a8f948ff00b3eca3fe291bdaa655b445c244e5bb67a531a6451b4260fad33cc27a75a0a2e2f97b398401ea7a5206841cf9519f6c03fce96df4c96e97e53827bd6ee9be1169d94193e63594aa46274c68ce7f0a32a2bd923e228953d195101fd2a68f43d53549018e177ddfc46bd0349f0a5adbed2220c47563d3a574b68d6f6380a880fb5724f10fa1e8d3c13b7bccf3dd37e155f5e2ab5c3f969dc5777a2fc2dd3ed577328651f798d690d693ee0eb56a0d50e46064fa5714eb4e7b9e8d3c34206d693a15a59c6b15a4496ebdd877ae82d6d63857e45dc3bb57356da9c85400bb4fad5f82696465dcf919e9581d1cb636e2f2b9c8c8f4a8ae2c96e95942ed43dea3b36daac7fdaab0d37cb480e17c45a1ba798d6799187f08efcd71171accd66ecb287475fe135ebfaa3968c81d715e6de29d3de760319ad60652308f89e13f7c807d4d5db5d66d66c7ef139f4ae3354b17b794931f02b216e21462241e59fef7a574721cd2adcacf62b592dae3015f24f6ad7b5b590e3ca04fa01d6bc7348b8819808ee30fdabb1d16f758b0c35bdc2c91e7eeb1c03f8d653a76d4d635232d4f45b7b87b56512238f735d05bea28e8a3d6b92d3fc756e196df59b0f24b71e66dcafe75d7c3a2dbea50a5c69376b3646762f515ce6dcc5e170926d154ee829240eb4d4b799434526fde3d694ef8baf4a0b30752b32c19875ae4f5ab1f3ade45fe3c647e0735dcde2ee0cd5cc6a0bbe46154b7135ccac7916bd64eb324ff0051546d669a4e50b065391b7af15dc78934bf3b6571b2db7937817d8ff235ead291e0d6a7cb2b1d1e8fe24b9d2665bfb6758e52409638fa37d6bdd7c1ff00100ea968b239c330c31af99ec6e3f72d1ffcf335d5683a90d2f524c920328e475a8ab0e6d4787a92a72b1f57585e07b52caf96619c56bda6a4cd6e8cc32abdabcb7c2fad192dd5dddc9c0c66badb7d4b7ee35e6ca27d0465cc91dd0bc578c10983572dee8ede0e0fad7236b7ede57ef9432f606b6ad6f835980cc8adfc2a3ad65a9a9b4ad24873bf344370aac557eeff00156625d7cbd71565a3f315640f9f6a0b343e5fbe3a8aade6062c1ba510cf12c8558e1bd692e662b2290f95ab2351376d453cecef8a9a3911948f9fa77aaacdb46dc03bbb1e948b3c8ac164441e8475a0352c2491b46233dcd4cac51703eed529f679dbe3edd6a7662aa241d40a04cbab2fdeabd6b26e005665bc8c61563d2ad5aa86cb1e94199a3cf6eb532ccf2c899e82a9472b4b1b6e3865fbb4f80b492ab97c85ff000a0835e3c77e94532da5fddb514127e55f965796fbd460b71c7e3557ed2cdc2c7f352ac9331c6cc57d2ea7c796a3841600ecc7b54a6c5547980804773d2a935c428b80707bd33ed88bc87e68d40b1259176cac899f6eb5247a78dbcc9f3d555bf6cfc8f96ec298da81ddf3920fb75a3502d341146f8698237f78f6a72c4dfc32248bea2aac3e219121f2f7b943d8f4a57d70b290064d1a90588e431ee112ee3dc5115a4b365a63f3764aa5fdaf349f2c6843f6229d36a17181bc3b1f4346a32f359045258ac2bdddba0a8dde04522de2695ffe7a2fddace926b9954f9cde60ec7fbb48a032907a51a944970f33ab0de13fd9350dad9a3659e44cfb75a72ac68771a5690b2903eed1a81235bc28370704fa1a6ee55e41407daa066da335566b809927a51a816a49477938a899d5948127359935faf3b7ad44b78cedb4f4a352398bb24c15b697c8f4a699571c75acf99b7fcb56218f6a668015a62af91d6b5f47d34dd3891feef7aa76165f6ab82beb5e85e1fd0c2c684f4ac2bcf9558eac3d195495c9747d1be55fee57476b64b6e015fbc2a68e358610abf7ab42cf4d6ba2a4f4af26750fa4a74f9628a71c6f74e3daaf47a1492630335d2e9ba01640075ae8acfc3ae23048c8ae6e73b231393d3fc383e5ca61ab5a3f0eed19aeb2d747e89b31ef5b70f87635db2632e3a0a8e635e5384b7f0f191828eb5a36fa03c6c057736fa37cc3e4c7bd5f8f43f306dc67da8e60e53828f4d74602a5fb2bfdc3d2bb68b432970c163e6997da385e4a61a98729e71aa58ede6b92d52d7ef57acdde9639dc323d2b91d6b4a36bbd847f29ab8ec61289e55a969ab22b17195ee2b99d73c270ddc2be526243d0d7a3ea561e4c85f66066aa49636f2a3e503b71f29e879ae884ce4a94633478549a4dc58ccf1a920e7a8ad4b0d72f7460a37b9f63d2bb7f137871ade63790dba471263730f738feb5c878d258ed6c63c8cb91d2bd08be73c7ab174753b8f0df8eacefa4862ba0a5882087e98c1ce6bb6d2ad5ace413f876f0c576c72d6abfea644f41ef5f30279d0c4b322ed19eb5d9f82fc7f71a2dc08ddb7293823fad454a1a1747189e923e9cd23c5d6de202d677b0b58ea90f0d149d7ea2aecb1a43f2bf1bba49e95e7ccd6de28b48253330bd8c6e8ae93aeef4fe9f8d6b786bc5126a0d269ba9a98b538386dfd5d7b579928f2bb1eac25196a68ea1bfe6d8bb87f7ab99d42105031fbd5d0df4c7ce741f74d605efde352741cf5edbfda158ff0074571bafd8fcd07d6bbbb960a496e98ae7b50b576f24274627f95755191c75e1ccae71b1c261bb918759315674f98062b825fcced56752b416aad9fbc6b28b6d8d0fa1cfeb5dbcd7d0f29c6cee7aa783f567b7701257f2f77cc87e95eaba66a1d0ff00785782e8373e65c39ff9e91815e8de15d4a468cf99fc3f20fc2b8aac4f570f23d3ecaf81520f4adab195372b8ea2b89d16ff00ad7476d3191411d7ad729ea44eba1bafddd4725e98cee5c647ad61c7a808c6e4e8dc1ab71dd79b5059d1d8dcfdb1437c9bc7a548b72d14d26e191e95cfdbdf797328dbbb9e95a325d6242fbb6ffb35604ef31f382bc632dd33d2a4440ec014403daa286612633d29ecc1666299dd8e31419ea58b78d241311d57fc6a610fc954a35dc11b0e5fd0f4ab9180c308981de83327871c21e95630f13b347d05451c6546475ab4bf79bccfb9de9904693b5bb023ee9fbd5a11fef591f6eef6fc2a8dd2bae233f75ba5269f71b64f2bd723f4aa24e82cb1b4e5b68feed154fe75802a0cb27228a00fcb65ceee3ad39c332907a552fed6997e549081ea28fb716f99a5766f435f45a9f1a4ad0e6251517f66193a75a725f1660075ab715e347f337dda3528a5fd93247f3633534760ff00f3cea69355456c8eb52c5ac16e075a35020fecf91b8d83f1a3fb319792b1a8f5a99b5372d8a8dae247841071ef46a027d97ec7fc6873d854124c7b75a45c6d662f96f4aad24be52aa7f7a8d409fe6fbc7a0a85a62ad91d6a16906d39e954ae2f1554a8eb46a05c92eca9cbfddef5526be66e17eed412b17c11d698a199b07a50439134d23a000f46aa5349bb22acb46d22979ba2f4aa92673c7ddab31d48e945006ee2ac4717140d6e3ade1f983d685b43f68d91fad578e0de315d3787748f3190e33cf4aca53b2b9d14a9f3c8d6f0ce82b95771951dabbbb5b7c2ac51a6334dd274d65501130d8eb5dcf877c2e768761963dabc2af5799dcfaac3d0e58997a1f86e59983374ef5db699e18daaa6ba1d1f40f2a10db31ef5d559e8de56cf7ae1954be87a31a76d4e6b4ff0d86da1864574ba7f87cb60f97f22f5ae874fd243002b62d747916453fc1dea4d4e76db4458d8304c11deb4a2d0f7f35d247a66de6a68ec4ab023ad501ce43a16d901ab96da3edc9ade8b4f669031e953b5998d4b0ed401cd0d2ff7b2557bad2fe46aea2dedc5c4b7847dc571b7f2aad7163b589a00f3ed434edbb9bd2b9bd434f13ee8d86430c115e937f6bf28ae5b51b3dd2114d6e271d0f15f1568afa2c83098b57e95ccdb4be5dc04fe06af76d4b4b8b52b5961993cc8d860aff5fc3afe15e1be2cf0f5cf85afbfe7a5bc8d98e5f5f6adce6e52f18639a1786e465141207f2af10f881a348d7d1ca71140c48dc7a0f4af5e82f3ed16f9c02ea3806b0b5cb18b51b3786689087e38fd3f5aeea356cd23cdc551e689e47a3cc2df36b294703a30eb591ac471dbdf3080e02f26b52f349fecbbeb9b4b83b1f3ba29bfbd839c7e9546de45b8be692e0ef970416fc2bd789f3528d9b89d5fc3bf1a4b67702de76dc8c718f6af4dd6a57d4238af6ddbfd32d4ef8a4fef26391f966be7c91cd85d896238f9abd7bc31adb5c69a9b9f2db718fc2b83110b3b9eae0a7cda1dc69fe211e20d2e2b8f33f78bf2b54734db7277e6b8cd26e9f4cd725847fa99d72bfceb7649fcc6cd797289ee4762d39f31aa29a0f32265a48e4dc31563fe599a453d74397d434ffbd580f6a77b22f56e2bbabbb612c6f9e9589259c71b2b1f7fcf1c577539687054a5a90e8d621668c9fbcbf27e4335d9f87ee0f9b3cc0e0b624fc8edfeb5ccdb426dbcb8e43b5a4e1cff00b3dff4adeb3c32838f2e03f320fef28e07eb4a722a9c795a3b8d05d96de52d26033f995d0dacd37cb320d81b8c7f7ab92d27cdbb68ae251e4c4bc450fe1d6ba9865925dbce107535c12dcf4e07476b7470dbbef62b46cee37a95f5ac1b36da41df9f6ad0b79cc732b2f5a9d4d4db0db509ab30c85a1503ad660be0d1e0fdea963276951d585006c42ceb827a54b0c9b988c13ec3ad67db48fbd5b38dab8cfe9577cb7c4797c86ab3377352c523915976387c719e95269d10df221e95169cc150ab74a9fece76951f75883f91cd3332411aab151d7356f3e6053fdda64cbb9849ed8a5d9f698c9feef35440ebc98793b0f4e3f9d323d9b5f1d7151de5bb490f9eadb5b8c1fc69dbb82eebb8b0c6ea09342397cd863e718ef45555953eca28a08d4fca4f9e9d1da3dc48055e860769144ade48ed57bcbfdd948f3239e8457d29f1e54da96bb40ff59daab7ef26dd86dbef571edf6b65d1c1f7a59b6da018ea6a350208edc47c95dcc3f8aa4ddb79aaed76656da3a9a4ded1f27a51a8161a6da33443334d2045ea7f977aaaf37d9d49c641ea2927ba16f6aaca77dccdfc3ff3cd3b501cc3af2f97ce748ffd58e9f5acf92e4b1c0eb507396ddf79a95739ab239892e259365323c45d7ef1a1f3b4e3ad46a594e4f4a08d4b2b2166c2f5a7854b5f9e4aaa26dbcd5595b7c80d302ccd742ee4c2f414df2a9d6a0348a0f4ad88ecd5e22475a996e69187318a23dbcd58552cb81d6b41ac76a9356b4cd37cc70719a8e73654b524d274b927d8319cf6af4bf0e682218510a619bbd55f0de8242c6ee9893f84d7abf85fc34c92ab11907fc2bcac4553ddc261796d22cf863c3224c13d2bd3345f0fc71c6a0d2e87a588601ba3c8aea6c6cbcc555dd88fbad78929731f4118f291dbd91919147dd15b567a685c12322ac5a5998e4207ddad6b5b5fde2d66682d9d8aac6084c1f5ad5b6b5f94524167b9947bd6a2daf9d27d2b45b92320b4dc40c67dab4e1b01e5f316e1e94b05b109b475ad1b75911702b53096e67496691c6582ed23f86ab9b30c3714c0f5adc92349176c99ce474ebd6aa6ab66cd0845477799f6853fddfe2fd335a6a339bb1b656b7120eadba5ff00be8fff005a92684b02075c56ecf649d106c0c32abfec8e2b2ee2df6b11499a2dce5ae6dd9465beee6b0352b358d582f56aecee9b6e56b0af977b15accd4e36e2d996205ba573fad69b6da8da4d6d3c6258a41b594fd6bb0beb7da49ac4bab32d961d6999ca27cffe28f095df84646b8b7ccda713b431fbd1ff00bd5cf6d8f54e6419f6af7ad5236cb232ee53c15f5af31f13782d1ae1aeb4a6f2241cb45fde35d1091c9381c46bbe11b7d734f30e364d18ca357913e837d6b74f6c13ccf9b0a6bda7edd25acc61bc8fca941c3fbd45a968515fc26683fd68e56bd1a75b9558f1abe1e32773cf34af02cb7004972db586485fc2ad686cba66a125b0ea4d5f9b57b8b191a09ba8e056035c336a818f466ad2529495c8a718d3691d2ea136dbeb693d185744b379b27e3fd2b99be8fcc8613fed8ae82c57749bbfba2bce91eb40d287b569430ee8f755186b52d14c9851d6b2674104f096858019358f7169216e1769f5aea1ad5b1cf4a8e4d34ba134e3233940e622b310c8b24accd3487e50bd4d6f5a5b2accb24ea9311d235e91fd6a7b5d3624c93f7ab4adeda35606b572d09f676d4bba6dc6e2ac8ad205eebf756ba1b2b8776505302b26de32aa08195ad88feeafc98f7ac4e8817e16db203577cdfddd642a966001c1ad1b791f6862f90b51a9a97e39034441381eb572de68e40b993ee91fcea85bb6d671fdea9f715e475a35035e30f333b46f9dad5ada6cfb54ac9d6b9982e248d8329c115716f8cd31667c9181fd2833773a8b199be6cfdecfcb57a36db319304b8f4ac1b098b5bb460e0abeecd6c59cc3cc288f9046f35a1997a18a4da7f78fc9cec352c76a0cc664e8dc1a65b01365c9c05a99a464fdec6c58b71201d7daa881b3c4773edeb50184377c3f5abb74af1aab18dc83ebd2a8b1f21b3bb6e7f868248cca63f359e4f91b00fe74550bab9dd2636eef6a2803f359ae971c260fad31af368cd6535f6e18a635e6d19afa53e3398bf25f13c0eb5133961b9feef7aa5e7f99cd234995a08e62dfda9bee2fdda5f31ea1b6846e0edd2a3bbbc6932abf7450048f2b6ee7a542d26e6c5411c8ccc01e952edddc5046a0dd299cd3f76df96991f7a03511b3b4d3376de6a49db6c4c6a38a4dd814c351cadbdb151c917352b6769a655190fb17d9262ba2b39b6c7f8572ccdb58135a1a7f9d3c8889d18d6533ae8cf9743a18616d40c70c3f754f35def86bc30159643f78541e0bf0b920337535ebde1ff0be307e95e2e22b6bca7d261f0dccd4c67877c35b9636af4fd0347f257f0a8b45d1bc95fc2ba5b38444467a5797391ef528f2a2fd858ed00d6ddac262c32f5aa9a6ecda71d6b423731b065eb5cfa9d05a854472420fde6cff002ad087fd62d542c245527ef55c82e3cb4c52036f4d5dca45695bbecc8ac3b6baf9455e8ee80e4f4ad2273c8db8e62bc8193e956a2b891b03663deb017545dc1075ab71ea000e6b62394dc7ba16a573b83b7036f51ef59f6376d7d7934d110208d8a5bf95dc63e763f53c5675e5f4de4ada42cab3cfc316e98eff00a559b3db6768b179ccdb7e5024eb9f6ad352794b0d0a4724cdbdc93d73d3ad55be81197754f1dd61873492e24ce7a52d4d16e61ccab700a8ea2b16f2c4ef38eb5d4b42adb40eb55e6b356043fddc73599a9c1dc583ed7cf4ac3bed3ff735de5e580e36f4ac8b8d3f2d8a9347b1e737d6664568fd6b98d4b438a40ca4e1abd5753d172775735a868df7aba23239251d4f1bd7bc3e970a04f0ef51d1ab90bad0e4b79775bb2ae3f85ba57b7df68c371cf4ae7afb45dcc427dead4c2503c9f55f0fc3afc4229ade4f37a7991f41ef5e71e25f08ea1e19d42359333da31cc732f43ec6bdfaf34b9617fdc1c3679a47b737d1fd96fedfcd005691ab65639654a2ddcf36d07447d4f4d0766300735ad0692f6a4257a5f857c3715ac32f951f9687b5589b45b7691830cb7a565291ac627056ba7b30c1e95b5a5e975bd1e8416752a981eb5b565e1f31b285ead591bc63639e1a4ee8f152c5a496fddaf535dc5b68236f3f7aa0b8d018b7c9f7bb5056a7153e94b1a9ddd6a9885629463ad7617b65f67215fad645c449baac82bc0de5aeeab42e372629b1c681723ad4724dfc1eb41a1721b8f2f0d56527ded9f63fcab1836cf9aacc775918a0b35ade61e58cf4cd5f565936a8eb586b1f98b9ab10dc06c29e82a3523537a1ba618d9f787156a165f3001d53935830cc90c81738dddeadadd0ddf2c9cd00747a7c9ba5036eee7a56f58aee6886ec7cbf77fe042b86d36495ae18abe4e40fcce2ba8b57469b85dc412a47d066b41729d7d991247313d149a9adb77983242b6de09f4eff00a573fa0ea0e6f1d0bec8e4e0afd39fe95b3e6fef24f2e41bfb66a8c2459b86921955576448df731dfd6b2350b831ee6593e503e6a92e1cb290f22673dbaf5ac2b8d415564c3e4ab6282482e6e246b666918b73c01f5a2b1354d43c9473c73ebf5a2a0be53f38b715e69557736ea8b715e475a3ce6efd2beacf83d49db1b79e94f8595391d6aaf99bb8a280d4b125c6ee2ab349b9b14c6fbc29cabb980a80d4b11aeee29d2b6232b42b6d5db50bf5a035117ef0a9173b8546bf7855a87fe3e0fd280d4553891be98aad343e4becf4e6ac85dcc4512666538ea280d4afff002ccd576fbc2a78dde3dc0f4a8a452cdb875cd30f5045f3182e339af4ff0087be13f3423ecc64f5ae6fc19e1b6d62f159bee835f49f82fc2a96d020c678e95e6e32b722b1ee65d84e67cef62cf877c37e5ec15e89a3e91b78f6a5d3f4b48624c260fad741676fb10357ceca5ccee7d5c63ca3ad6d3cbc5695bc3b980a8a3abcbfc3526a4d1831602f5cd5b59035c007efe2ab0ff574ddde5fcd51a9a6a69a36d604f41537da3ece7cd8fee49f7ab312e372e29f1cdf30a0353623bcde3356a3b9dc302b9e694efe1f61fef51e74bfc2fcff007cd581d146d1dd48e76abbae3e56e9d6a79756746315be4f182dfc2b5c9b06f399ccd2161dbf86b42d6f1d46d2f91562e53a0d3ee05b2be644f9fef62b5a39d1e2243e4d72905e1568c85dc79e3f0a9e1bf3b8f94fb0f75ab2794ea925f969e8e19803d2b02df502ac0abe57f8ab421ba136371c0f5ad351729a4ec970bb7d299711aaa851d6abe5d64628f91e94d9ae86f543f7a932049221b0e7a5664f0a33e2b41e6f969b32ee018f4accb32ae2d578dbd7159d71a6472423232fe95b98467c0eb50cd185c93d280e639393c3b048ae7661fb1ac1b8f072cacd8eb5e866dd2419aa9716eaaac40c9f4a083caef7c1203127a566cbe188adce5864035ea175a789a1194c0acb9749173f2a7de1d2a798392271ada7f97e588d31ef51ff0063cd24832322bb7fec3548c86fbd56a0d2d76ec1d68e623d9db538987417e32981eb5d058e823c919191e95d1c3a3722b6acf48091e4f4a6b729ec7336da5246b80983eb59bab69fba371fe7ad765756ea0951d6b0afe3dac56b6d4cb53cfb56b3d808ae72e2db6b135dc6b566639303ab571fa95b30739e940998775190491d6b37ed8cc581e82ad6a0fb370ac2b898ab12bd6b420d3fb4fbd2aea5e5b62b9cb8bb0149232d5424d5f6363cedbfecd57299ca5a9db2ea9f30ab51de6f19ae160d6864664e2b5ad752590021f27d28e51f31dadb4e1d70dd3157ede6323a11f7554572d6b7c1a3c1e95b363708ca00eb5068a5a9d3477af1ab04fbdc7f3ae82cae96f08c7de18cd71b6d2fcebf5ae86ce48db7053818e4d06af63ae81447b58b6df98f3f855ab69e2599c850d718c163d39acab390cfb03b06213806a5fb4128c16342548e07d68301752baf263f2a4d9b33938ae4efaf024c4afddad4d6b501e7ec2db588fbb5c7eb179b56439c6050066f88f563043b41c16eff008d15e79e2af117cadf3e769e9f8d147293cd63e53a2aedc58981f23ee9aa8f17cd5f567c1ea31ba536a458f9a788771c50664283730156d23dab9a72af9698a2a0d352097bd4753343b9b75063da33406a0a372e28b58f6cca7fda1fce98d9da6a6b519907e27f4a03526b86db3dc1f715149d9e9bf7e42dfdfc8a6c7feac27bd030652ca5875a9f48d3e4d4ae92303249c62a2589b7009f7ba0af54f861e112d2076fbce735856a9c913ab0f4255e565b1dc7c3bf088b18532986615ed7a1e95e5c51d63787748db12aff00745775a6d9948303ad7cbd6a9cf23ee68528d2a6a25ab1b308a18f415a4912ede3ad456f6ccab93d2ad797b6326b9b53a06c71ed606a74cee155b38e68fb66df968d4d352e96da33501937381512dcee38a63cbf35032ce4af34e8e6dac0d508a6eb4d690ef18eb5659a0f75f3527da7deb3e4bc758ca9e95599f72eea00d9175b4e735616f8b2e1739f6eb582b2fcb53adc145c8eb4146f4772ac30dbf3ee702adc32bff1ff00a9fe0f9f35cfdbdf3b3007a55b8eebe61ce3deac83a4b79955811d6adc775f375c5737f6afde27cf9f6a956f02b027a551074b0cbbb618dfcb48f3ba3fef6462a76b8565c31f96b9e8efd7b75a93ede7b1c1f5a05ca6fade42a9b475a6b5ca30c0eb584da9145259f22a97f6d22963411ca7551c9b980a995b69cd72d0eb91b900d6bda5d34d21dbd2820d4f2bcee29e6c556225c657b8a75bb98d773fddef52ee32723ee504adca335a8debb5302abbe9fe5b6300eeec7a56bacdb4eda83cee5a835321ec3e6fb883e94b1d885705ba56a346648d71d6a486d64e2a444505a164c0fbb56d6c76ae6ae5bdb88d727ef53e4fb86acc65b983796bd6b02f6d7e63ce3debaabac64e7a5606a12451ee63d0569a91a9c66b96e238812f91e95e77ad32a4acc3ad76de26d5a15f31475af2df106a686338eb9a6b733317569fcc9197d6b98beb8f2d9855cd4272fb88eb58573233360f4ad48295e5e32c60af5ed589737f36e39e95b33c6650541c13dea8de5836df9a4e2ba22724ccf8f5174706afdbf891eddd49e959170b2b36d1200a3d6b32695e193ee249ee2ba62aeac79f2a9289ec3a3eb62e52327a574f6178b232a8eb5e0d63aa3d9ba12db467eed7a37863c43f68427fbb58ce9db53b28e2b99a8c8f50b79b6a835bda6de79726ee7a76eb5c869b73e743bab5ec6f36cc8b5c87a1cc77ba6de23a9317999ef4b7123336e3bf1efd2b3b4897c92def572493abe7150c0cbd52623383838af34f176bc369447c81f7857a278d2ead6cf4a4789f3262be7af16ebbbbccfaff005aa840993b2b9ccf8975cd8d337a7f8d15c86b1aa9babce0e08a2bd7852f74f02ad7f7b4661dbc8c5361e86ab5c59966dc3ad2f999f9a869b0335e81e26a43f6665e4f4a3caa71b82c300f350348ccd83d2a83525f2c2f27a51b95791d6a1a280d4249371c544d9da6a46e951b6769a01dc655b8bfe3ce4fc3f9d526fba6afbc5e55843ef5066575ce6a48d773006a318fe2e9576c6d24d4ae238e319c9c50cd52727646f7847417d5afd652331a1e6be8cf04f87d6d56360982075fc2b88f03786d618e2458f94e4d7b77876d3851b31b475af9fc655e67ca7d96030dece0a52dcdcd1ecfcb556aea2ce3da80d53b1b5fdd56bdbaf96b8af225b9ec92274a8a4a99ba55691b6f34806b7dd355036d626a5f3373815148db79ab3516497e5350b4bc544d2fcd55e67dd914165b593e6a8e49b69cd5069b68db51bc9f29ab02db5cee7c52f9d59de652f99bb8a00bed37cb52472f1596f9da79c5496aff00678d86fce7b5051a30cdb4935761b8dd8158fbb7f35346c5791d6824da8ef0a300bd6a5fed04fe3383589b9e4f9691dda35209c0a00dd5d44c6721c15f43449ac7c87ee7e15ce35c6c5ceecd50bed4b673ed401d1dc6b9b14b5605f78930c715cc6a5e202b1ed50493c6075ae8fc23e03d4f5d9d2e2f40b6b7650620dfeb0ffbd48a34745d427bb44fee13cd77da4c8d1db863d055cd1fc0f676103055dcc00cb56bb6861502afdda93396e36d2fff00775335f165c0383eb549ad8c2db475a6c562f293413ca69c770cdc17c8ab51c84f0bd6aadae96fc55bfecd9524623ad0592c56a27917232d9e95b16f6be5337c98acfb16324caadf787f856f44bb23dd5a44e7915da3daa4d5395b6e4d5d9a4dd91597777223c83d2a8c8cad4e708ae4f4af3bf116b0b1bc814e1bd6b73c49ad2c8d22afde1d2bcc75fd49e452a7a55ea2e5b6a60f8835c67c82f91e95e7fab6a7b8e2b43c49a9b46ce17aff00f5eb84d4259a690b1e95513394875c5df9accbeb488372e2a0f29f617f4a9a1dfc67a56a6239a2f96a278caa92064fa558a08ddc535b93b9cfead0161ba28b27bd731aa67ee340771f4eb5dfc96fbf22b0351d3c79873d2bae12386b5238ddc17e566751fdd35b7a3eb46c668c838506b37538628d8eee959fb8272bf76bbd2bab1e3b7c923de3c33af2fcbbdf2ad8cd7a0d8b09395c6d61debe78f0eea415101381eb5ecde0bd73ed16cb1c8f9f415c5563cba1e961ea9e93a1ea4f6d0b09367b62acde5c7970c926dddc74accb6912355c75355b5ad4fcab7907fb35cbca7a2a5a9c078bb5a916ddd646dbcf0bf8d789f89357dd363eb5dc78cb5ac23fe35e35a95d79b333fbd7550a5795ce1c655b2b11de5c06dac4e0668aa124a66f90753457a9a9f3ce5a94125f96869370c531b3b4d32b6390932579a3cca89ba5368027f328f33771506edbcd234bc5004ed9da69950f99bb8a1ba66802cc08249955ba75a7dedc19e5207dc518a8d7f77097ff009e95179a7b75a0055fbc3f2af52f87de1cf26159a4fbedcad71be09d07fb5b525793ee8393f957ba687603ed288bf75062bcfc555b46c7b980c3b93f68f63b2f07e9bb466bd2f47b3f2d55ab9ed16c76c311f6aed74db7d9006f4af9c948fafa71d0d5b18f6a83575739aad6b8e33d2adfcbdbad646a365ff566a8c9d4d59b8fba6aa4b9f2cd069a95a66da09a8964dcd8a1bef542ff007a80d474955266da09a99fee9aaf70bb88140ca934bd6a0f34f6eb4db993cb63507da777156516bcc76e0f4a2ab4726e602a6c95e6a891fbb6f34a936d606a1690639e94c699146682cbe2f0af23ad496f33c8a73d2b27ed4bc63ad5cb7ba3e69c75c5481a28c55810707d6a658da46c97c8aaf6bbe426b52089bc95cf4cd00675c5b6149ae475c98c0242064e302bd06fa30b6ec4f40335e7cf026a3e248e393fd4c63cc3f971fad203a5f879e0e484a6a57f879e419894ff00cb3ff2335ec7a5dc5bc70b04d9b940c63ad79de97a846546e3818c0adfb5d5a25c0593e6ac65b9d5cbee9eafa6b5bc96b112016f43d2ad6a0d12aa9544071d475af36b3f12187043e4fa52df7891e4e4f4ad23cb638dc65cc752f642e9d89381eb56f4fd19bbb6e6fe115c543e2adb1edf715d8f86f5c171c138071cd35b8a51924d9d3d8e8819402986f5ab52695e521a9adefa36e37e78e9537da124f9475ad7962727348e7eeac4e491d6a18ddd1c467a56d4bfeadffcf7ac3bc3872691bc6575616fa4f2d377a5705e27d67c966fa5743ab5ef976e057996b1742f2ed83741407299f797de746cdf5ae13c4173f658d9abb2bccf96c80657d2b88f111c315d98f7a6b7225b33918ec1b516df374c9c573be22582c188f4ae9afa499963894e031db9fad78678abc49a9d9f88af2ccb6e10bec02bb210e6d4f22accddb8d7208e6c6edbef56ed754866c625dc7d2b8b83580cc05ca6377535bd6f65657f1a91b813fddeb5a4a1a99c6ae875f66524208eb5796cf7b66b8f86cf53d2b0f6ceb7900e4c6df7b15da786f56835888283e5ca9c34758ca3a9bc64579ac3ad655e69a25055ba1aef9acd1d940eb55a6d2b70228bd8a7ae8794eada0b10768cae3a5729a8589b740ae985cd7b35f68fb589c67dab96d534312162c981eb5db4aa9e7d5c3f31c0e9739b79011f77ff00ad5dff0083bc49b26451ff002ccff318ae16f3476d3a49557eeb54fe1fba68e778c9c02a39fc6bb64b9a2797ef5291f55689abc7716287f8f19ac0f196b9b91c671815c8784fc560d9404be43467f438accf1b78851adcb0eb5e7387bc7ad095e373cefc71abee9186fcf3d3f1ae0ae66f318d5bd66f7ed179237bd65349b9f15ead18f2c4f031353da4ec4d0b155623ad1516e2bc8eb456e60546e94c6e9524ca53219307d6a1adb9794e40a28a2800a28a55b72e723ad1b8094aa9e6305a56b5902d4b230863f293a37dea39408a67dcea3d29618ccd2aa28c9638a615ddc574fe05d23fb4f54327f70ff4aca4f95366b08f3c947b9e93e03d00697a7a394c338af4ef0e69bb5d0fa9ac0d1ec70a8be82bbfd0ec76c6a6be72b54e6933eef0d4f922a2759a4c1b1947b57496b1edc1ac8d2adf6461bd2b720fbb5e748f5625c8eac0ff005755e3a955b6b66a4ad424fb86a8c837645599a4dc08a86a350d4ae63da334d6ced357666daa0d529a5eb406a54b8255491d6a8de4ceab93d2ae4d71e5e5bd2b9cd4f50f99ab45b8156faebe6355639033863d2a85ddd0f3371e95566d65218cf38f7ad4cf98e99644d86a29af9238d8671ef5c3dd78ba2873be4f97bd61de78d6369308f91e95a7291ed394f439b5b550543e4fa544ba9658357076fadfda181ae834f6fb4ed5c6734b947ed2fa1d359dd79cd5d158db79aa0d6568da7965501306bb2d334e31aa97195ee2b32892c34fe056fc36bc2a55bb1d3cb22304c2fad69c761f2d481cfea16fbe163fdd15e4525e7d9fc4d7cbfec8fe75eefa869e7c96e33c578078f2d65f0df8a16ed93115c0c1ab35a72d4d6b8f107d9e3ddbb6e075af3ff14fc6dbff000c3030c6922a9eb27ddad4d62e966b5debd4ad7847c4695b2d9e99feb5b52a7172b31622bba749b47b77857f6a8d3efa58edf56b76b1763b7cc5ff0057f8d7adc1ae9d42159639d25b76019715f9dfe732ee2a707d6be87fd9bfe2334927fc23574f9daa64b51f8127f406baebe0d463cd13c3c1e693a93e4aa7d2b6fa86d6535da683ac792a8e4e315e7327ef8af38f7addd2ef3eced8f32bcbe5b6a7d15f9cf65b6d5a578e391df271c0ad6b5d61db00f4af28b7d5cc716e0f93e95d6693ab6ef2cc8709dff2ad23239e74eda9dec377e660d53d4ced3bfd2a1b098000abe4354f7681c027a553d8c56e703e21933e6357065775cb357a26bf66a9e681d589af3a6fddccdf53589d051be90c6c5875ae435a8da42ce7a57597b26588ac3d421dd1bb7b5691dd18d4d99e71ad47b6407d0e6bcefc7fa0c57d2c7a8c49bee231f3afaf6af4ed5e1fddb7d6b8c9f61b868e41946c822bd189e3d45ccac7036b0dab5bc92ce361c7ddfa571d378925d3efddedbee16ae8fe2059cfa78d889883a935ced8dbc57ba7346c70c8339af469c1495cf9dab274e5ca8eefc23e3c86f5847336d97a035d95c686f7920d434b5db7f18ddb7fbdebfa66be718f7c3366393ee357b0fc33f880accb6b75261bee8ae7ad4397de89d986c5394ad23d7bc27a845ab5ab73b275e2487fbae3ad6a79615994f4ae575ab6362d1eb7663cb55dab743fbc09007ea457490ea51ea16f1cf1fdc75e3eb5e6ca27b5197311dd5bac91b28eb5ceea9623cb19e95d4799bb8aa578036e04647a55c4a7b1e61ad697f6c8488fefe703f3ae12e2dce9f76518e1a37ce6bd875b8d0460ecc7bd79cf8b2cfed0c648fefaf4af4694b43c7c4448ecf59f2638cefce18f1f81acbd7b5efb56ef618ac9fb5910156fbc0d65de5c6f0cb5d2a1ccee79ce728ab14273fbc1fed13509ff00594e9299cd749e7bf7a5724452cc00eb454d6717ca5fd28a07a8fd62dfcb9775643fdeadabc3e648d593711ed6cd7b38d87ef1ca270d1f848a9186e5c52d15e61b92dadbf9922ad6cc36f84db55f4b877465ab5238be5af770546f07238ea4f5336eff00731b0ac8dbb8b356ddf47b51cd61a8dca0579b8a8f2c99d14e57415ec1f0bb49f274e59ffe7a579569763fda17089ef5f417846cfecda6c11fb57878a9da363dccbe95eadceb749b5fb95dce92be5822b97d1e1f992bb3d2e1f956bc091f694ce834ff00b82b521ea2b1addf63015a91cbf32d7348dcd00db549a3ccddc556493730152d49a6a49cd236769a56eab41cd46a1a952e1b6a93546f2e3cb1baac5e379796ae7efae8ee38eb406a41a85f7defa5719aa5f316017ef66b6af03dc391eb5047a3bc8e32323d2ac1ec72772d3ba923ad723acb5d2b39ce38eb5ec8da08f24ee8f8ae47c41e19691c958fe5ae8a73d4e399e0daec976dc07cd67f83ee5edb580921c6e6c66bd4756f05bb076f2ebcef53d027d36f3ce8976bc6d906bd68548b8b48f22ad0929299f42f84fc1b06a0526ddb9d97207e15e8ba678056355609823bd782fc3df1d5c59c6a51f2dd0d7bc7853e274770156e7b75af3aac647b3457344e9ec7c3ff00650056ddae921f00f4eb573c3dae586b3929f7bb57469a5fcb94e8d5ca6df0e867dbc6be5aa0ea2b62dff853d6a116a613f38caf714d594ed6409b54d040b796e1d581e95e6fe3ef08c5ae4796380011fe15df4d71b322b2b52b80c841e98aa19f375e785ef7478da095b744a72a2bcd7e20784dee62126cc7ff00aebe9fd5ed639a419e9cd707af68f6f233ab0c835bd39d9dc24f9a2d33e4abaf07bab313d2a4f0e473787b5ab3bcb77d92c132b06f6cf3fa66bdb35cf09a4dfeae3cfb579edcf85ee9b544823b7cee703f5af455672563cb783845f3247d5fa4dd4775690ce0ef5740dbbdc8cd5ef3d130c3ad61e856afa6e8767048363c712a6dab6d27cbd715e64ba9ed43ddb2376defa4f3bf7871e86ba7d3b5654e1a4e38af3d5b8fb3ae37e73dab4f4dbedd2a0faff2ac8d99ecda56af0b3280f926ba8859563723ab0af29f0fea182ab5dadb6adb6d4ad68b6382a47533fc4971e5995bd8d7997da374b21f735d6f8ab562a1c8eb8ae26dd9e48d49e8c4d41baf850db88fcc6a6ddd9eeb561ed5ab67646e14c83aad2dedbb2aed3d2b55b984f63cb75cb1db93f5af2fd694c77c9819393c7e15ed9ad59ef9185792f8d6c7ecec1ffba47f3ae98ec79f2899daa68b6de24d15a261b262bb55bdebc4752b06d0647808f2e78c94947f7876af6fd32f963243fddc7ffaab93f1df8746b41a6881370bc9c75eb5db8795b43c7c661eeae798476f0c9664b9c16aad65786c6ed1a27ced6e051796d32dc18bcb7dea71cd5bb1f0fdc4ecace985ea7f2af44f2146cee7bcf82bc489abe8ef6f3aee0d1ecc7b9181fad5ef0aea456de7b52db5e06f28afb039af2ff01defd9a5961ce307afd2bafd1ee7ecfafde47bf3e6207af1aac7567d161e5eea3d16daef6b03515e5f9c36deb8ac786ea9935d0c1cf4ae75b9dcf632b57bd0fc1386cd715e205dd04adbf3d3f9d75ba85c236e15c3f8826558188eb5df4f747955fe167117936d91d6a94926e840a7de36de3fbd507fcbb8af4a2783290c6e94cda5b8a39a7479dc2acccb96ec55768eb4559b41bb028a8d4b23986e931556e22f94d69795cb543245cd7d756a7ce99e2c2462491ed39a66dddc55eb88cab6475aadb1a49029e99af0aa53e5933b6333734d8f6c20d68a8dca4552b61e5c2b57e1937478afacc2c7f7713cdab2f78a77517eedab9d8edcc97455464938c575570bb9587ad4fe1bd0f6cc64f535e2e711f67a9e8e5f1f6b2e52ff0086f4516112314c3357ac68f17fa3c3f857191daf92ab5dae89feaa3af87ab2e63eda8538d36923bad263daca7dababb1fba2b96d23bfd2ba7b56db1835e6ccf7291a6a4ac88475abb1cad8e7a5508fef2bfa54e92fcc2b98e934e19376054f54639370c55a8ea4b255fbc2a499b6a834c8fef0a74d9f2daa350313519376e158f2db99391d6ba46b6f31a9f1e9fba4028d447370e92ed863d2b4adf4cdab9adf5d336ae6a74b3f2d777a5043b9ceb69e0a9cf4aa926829366baf5b3dc73491e921b2c7a55999e757de175f24e064d7976b1e171f6c93745b867a57d237d648a9b475af3dd7349dd765aba2130e4b9e25a87832e2d641776498ee52afe8faa330f91b6bf465af4eb1d1d242c8edb14f1bab93f19f80df4d90ded88cdc28dcc9fde1ff00eaaec8caeac3e5e535b45f134f6aab83823bd7a4f86be2acf0f96923e514f22bc2b43d5135288151b2553b596b7a1f378da70dd8d65289bc249e8cfacb47f18d86bd6f85c6e2067357af6de358494d983e9d6be5bd1fc4575a7bae24e86bd5bc2bf150b451c13be57a115cb2884e82de275f75180493d2b9fd4ae92256c75aeb2e658ef2d55d3a48335c2ebbfbba939f94e7754d4396ae5efe61231cf4ad5d4a5f99ab95d425fde1ab208e6111930c32bdeb574cb5b6565754c11deb93d42e3cb9037a53ecfc49e490b9c7bd69a86da9e8ad3955007dda454ded9ae524f19d9e9b6fe64f23018c9dbd6b8fd5ff0068bd274b9cc2b633dc37f78b01fa9ad214e53154ad0a6af267ac490fcd53dacdf67753e95e45a67ed1be1dbb1b2e21bcb52dd5b62328fa915dce89e32d27c511ab69d7f0dce7f8633823ea289d39c77428622954d133bdb1d78c2ce475ad9b5f13b32807a579df98629038ea2b42c2e9fef7e1f9d731d274de22d58ccb144064bf6fd6ace9b66f711a029807bd63e5db51553d11335da68b9f2463ad544ca44b6ba7f951557d42cf740e3fcf5adc843b601e954b5287744e3fcf5abd4c8f3bd52cb6cc4e335e7fe34d04de5bb054c330201af5abeb3dcc45739a969a2457561907b5691329c4f9d2d51b98dffd6dbb146a9e68fce8d1376dcf7ae87c6de1f3a66a1f6a893113fde35871e22fbdd0d6ca763964b9958e675dd1bec72acc89be31cb35655deb56eb16d64c30e2bb0d4ae0a46c7f831cd79e6b9a7ab23ca3a935d909736a7935a9f299fa7de6dd6a5319c03debb1d0e777d61897c8d95e79a7ed86ebe7fba09aee3c2f8fde5c37de3f769d6d89c39dcc371e5e1aa1d42e19be64fbd59df6aaaf7179b549ae5e53bdcb420bcba3e58ddf7ab8dd7aebe593fcf7ad9d527df2035c5ebb71e7cd8f4af428c4f2b132d0c876df3934add2957ad34ffacaee3c596e22e7352c437480536ae69f0ff1d052dcb96f1955caf5a29be7ed902d151a9a96ae2db6bb1a87caad5be8bf7d558c5c57e9156872b68f968cb4466c90eee2a316d839abed17cf49247b6326b86542cee6ca4450b6dc2d6942db63cd6742c56406b46193710376df7aedc36e44c59177216adef06afda2373e86b2663b547cbbbfdaad6f0291fdad3c47a3afff005ebcbcf68f3611cbb1e9e513e5c42474b796fe5c3bbe9fceba2f0fff00ab4aa5ab5aa0b42475c533c3371ba303d1abf315b1f7eb747a768ff756ba187eed737a5c9b900f6ae9231ba102b8e67ad48b767f7aaeab15606b2230629030ea2b495d9b6b1e95cc746a5f597e5ab56f26e602b2e39373815a96e372e2a465b8f3bc63ad4e6d9a5ebd28b08ab56de2f98566ee59560b01b39e957adec51581ab90c7b706ac2dbf98c0d4014cdb2a8c8eb5018f6b835ad72be5c78acf7fbd5a6a042f9db56221ba322aacadb72738f7a4b5937646fcfb5002de463cb6cf4ae2bc436a9bcbfa5779b7782bed5c9f88ac8c96ec075ebf91ade2072d0c4be60c36d3eb5d1af8685f6965a5197db956ae6a191ade6dcc70ac715d6687ac471ee064e3a57540ae53c23e20782ee3c3f7cdabd847e546c07da3dc67149a0eb11ea702b0ea785faf7af75f126829a942cc5f31baf35f38789b41b9f036b8d2affc7bc8d93f8d74bd88e5b6a762abb9b1524770d6aeaca70c0f159d63aa47756e1e3f419a9246322123ad6069191e99e12f1edc59b7953fef54f017d6babd6265bfb61328d858676d78a69b78d6d346cdd14e6bdabc31749e20d24003255718ae7944753de8dcf3ed5a27dd27f9ef5cfcd6ecf26d3d2bd4356d07a7c98f7ac0b9d0fcb62de952711c24fa7ee04561dfe9a50923ad7a44da66dc9ac1d5ac3e6ad4c267937882191b318ea6bce75af0acf34ad2d7af6bf08866391919e9f8d361b04d4635fddd7546a721cdece35b491e1e3c3f32900f4ae8fc23657163acdb490ffac59171fd7f4af568fc0c970bbb662b5fc37e038edee564fee9ab9625b562e182847547a2d9c26e6c639dfef301bab62c6de3450c7b735462912d6de341d54522dcfda331c7f7091bbf3af31ae695cf4d7bb1b1b5a4c6d35d4970bf77a5771a5eff002467a5739a45b6dc1f6aeab4f8f6e0d6b13296e6a5b80c307a557bb851b2075ab81b6c719c67ad4521f35b6ecc67bd5907317d6fb589ac5bdb6f35597d6baabfb7da49ac8ba8fe46a8133cfbc45a4adf5a989c6548c62bc7b59d29f4f91edf66003915effa959965722bcebc55a3c72c67fbfdaace59c4f1bd4159b713d16b93d5e4dc1d3d6bd0754d2fc9cfd6b8ad6ad7e66ff3debb299e656399b7b7126d53d09aebace35b2b30a3a915cf5a8f2ef08ad392f36e16b739e268fdabdeaa5e5d7cc39c7079aaad79b549ac6d4b50e1aaa11154a965719aa6a3b576efcd72f24de64c68d42fb321150c69b573eb5dd189e254a9cf22566dab9a6a2ee60d49cd0735a98936377157e35d8aa6a95aaee914559ba6db85a0b1cd265f19c7bd150dbc7e6ccabebfe145401d9ea1175aa3e556b5c4655b68eb54e689b9cf4afd82ac3de3e294b42898be7a82e23daa4d5ef2ea0b88be535c7529e8745396a8a0bf785695a638cf4acff2f6c80d6b5aff00abacf0f1f78da43e4dbb7e5fbddaad787666b3f115b67a3311f9834fc6eb76159cdfb9b98a4feeba9fd453cc687b4c3497932b0b5392b47d4f65beb7dda7c83d39ae63c3b27972489fed57676abf6ab157ff009e9186ae094fd935c917fbcd5f8ac746e3d8fd524ee948f59f0fcbfbb5aea6d24dd815c4f86ae37a85f6aedb4fed5c754f4e9ec8d08fa0ab2adb57350ff1ad0ca59f0bd6b90ead4b5e6fccb5a566dbf0b58f1b0570a7ef56b58fde5a87b0ce86c62f9456c5bc5f28acfb0ff562b6e1c6d5cf4ac0a2c410ee5c55c8edf6f3496a159401d6af243b9714c8d4a73467cb38eb595346cb264f4ae9a4b5e959d7769bb22b4d4672975179527d6a039ad3bcd3ff00786b3e687cbc8a0b1d1cc146d3d2b3750915b701d69b7171b1b154e6bac822b44072bad47e4cc4fad47653ed653e95a1a947e6ab56046c2dee324e0035d5091bc4f47d3b565b9b611336d5c609ae3bc77e128356b564d85f033b875a6db5dc8b31937e507515bb6f789750189ce158735d0371d0f995e59fc1baa4b14a8e202ddebb3b5ba17568932fdd2335d3fc42f06c1a85abbc71fce470fe95e236bac5df8275110c8bbad8be18568627a4f987b75aee7e1ef8c5745bbd939c45ceefc8d7050de59eb36eb736adb4e3e65a6c327944e0e2b19c47195f467d3905ed96b16e27b77cfa8aa17da6ac8a48ebff00d7af18f0f78bae34b2acadb957b57a0e95f1046a4f1472a633c67f0ae4e52271fe52cdf59056914f4c573da869e86df03ad76fa86264475fbac2b99d417cb40d8cfb50b73cf99e6baf787fed0b201deb8fb3d3355d06e18c69e6404f2beb5ecad62b76ff0032614f7a1b43855491c9f4adf98ce3b9c6e9b73753c6824b5c66b5acee258e570b16d3eb5d32e9491c08db318ef54a6b7459323ad074f319dfe932483774adfd16dd6490ab7de359eb67b9835749a22f9698a8d4b3a4d2e18e26c1e98ae86d6258b19fba798ffafe958763d0738f7ada811644daef95ef408d8b76fb426dc678e94df24b14455c127ad3ecdd5a48c03851c7e956bca58641b5f2c7b5592666a36e1a22c7ef2d63347f357497d03b7cc7a5605d47b64cd46a35b9caea367e5c8e3fbd5c6eb567bb78c678e95e95ab43ba146ae2f56b5f383afad35b9133c7fc4163b5b3b315e75e20b5da5cd7b26bf6be5b3d795f89a3db239aeba67955a279cc92795754efb66de69ba936c95dbdeb2a6bbdb935df13c99cf949ef2ffad73da85eeedc3d692f2fb73e2a8b0f3debae313caa952eec3615dc4b55b5fbb4c8d762e29dcd6a61a8734f8d4b48053305b8a9a38f68cd032556dadb696452e857d69957ec97cc60b59bb9658d1ac7c819f5a2b734db51f2e7a515981a779216da03b95cf7e9559ba55d9a292e17749b3e7c631d78aa537df7ff0066bf6ee65512a91ea7c3da507ca3082c3154278be6ad35fbb55af21dcc1ab2a91d0b5b994d1ed6cd5fb5ed55678f6f356edfaa738f7ae0a71f7ce897c25e5cede3ad55be0cdd7a0e7f2e6b532a2cdb7be5781fad51ba8c36235fbabcd7a5529f342c73c25cb2b9eade0ebcfb56876cff00ec62b96f1841f65d52397deaff00c33bef3b4f783fe79b9ab7e38b1f32cf7fa7f8d7e0f8b87b1c5ce3e67eb986a9ed30f07e469784efb74607b57a369373ba302bc3fc23a97968a9e8d5eb7a2dd79ca3e95e7d4dcf5284b43ac8e4dd81534df74553b46db8356594b0dc3ad71c8ed123fbc2ba1d35fcb50d5cc333abe4f4adfd264ddb4543d8d4ed34b3e62ad6c471ed19ac3d37ee8adbb7acb52cd1b7059703ad6be9b1b2ae5ba565dbfdd15a5633100a8eb46a2351add5e22475aa725a6e38a963bf68586efbbdeb4e0f2ca6ff005a35235395bdd3cb2b01d6b9ad534d951588ebff00d7af4ebab659318eb58d7da6975651d6819e41a8295dc1bef562c971e5ca05775e28d21d5735e5faaef866753d2acb2d5c36f626b12f60dcc589c0f5a2daf7cb908a6cd73fbcdd5a477409db51966ee8d8693f77deb5ad64dcc06fca60f1f8564dd5b2ac7e645d7a9a6437a18807ef0aea3a54b991d4ccbbadd049dd462bcabe23f803fb52433dbfa64d7a2dade6d8b3bb6f6cd68dbdac3756b2204deaa3e66ade064f547cbba26a12f84750304ffeab760ff9fad7a2473c7748244e8e3357bc7df0f3ed8af3a2631d3f3ae07c3fa949e1fbc36177fc2df2d6a657e53b38e3c3035621ba68645d870c3bd44251302ebd18542cdb5c1f7ae7944398f5ff0006ea86f2c7633e4e3a52ea8c16624f4ae3bc13a885bd553d39fe46baed6ee11991ab9647354dc486456c01d6a5621464f4aa36774bb4e3ad3e4d439d950416e795368acc959249368eb504f73b9f145ab6fcad05adcbf6f8dc10f435bfa7a24385fef561431ed20d6e59e360cf4a0db53774d5466c671cf5ad68363348824e4d63e97b71f2e33fed56842d22c921da8dc7414c1ec6c430f114bbf3b33fcb15a16f26e602b1acc9568e477f2d46723f0abeb212770195fefd69a981a538dcc07b1ae77528f6e0fbd6935c491a96924edc564ea126cb7ddbf39a35029de00d0907a62b97d4a24f28d6bdc6a4b1c403fddae7f52bc0e1cafddc51a81c3788e3558988eb5e37e306da653fe7ad7aef892ebf72dfe7bd78af8b6ebf7d2574d13cdc41e79ab4bc8fad7337d36d626b635ebae3f1ae6246df2035ed5289f2d8a96a231f35f34e58f69cd0bd69ebf785741e682fde14fe69c8a5980a7b3606da0d46479dc2acc8db7069b0d23aee6c505935942676c0eb5d069b0324c81beed52d3d1a08c2af56ad8d36d5e76fde9da87a9acdec06ac0aa92921779feed156adedfeceb941e581dbfbd45625172fb4b5b3da668ce00e7158cffeafee3819e09e95f5c7ed1dfb365e7847477d66c508863f9db1d7d3fad7ca570c8c0b3c8f2caee09cf6e2bf57ca710aa53f672e87cae2e0f9b9a2548f1fc5d2a290166940fbb5686dedd7150b02db00eb5ee4b6679eb7322e17cb6dd576d63f9a35033bbdc0fe74cba8d94927a55cb680b431b062a7d4570c63ef1d32f84b623491b2250b22b2e14ba1ee3d2b3e7873236e743364ee03eb5b5b9d6d0a9477191f31fa8aa575f7a1f931f275ff00815774be1315b9adf0d67db7d791d773ad45f6bb2fa0af34f05bfd9f5cc7aa37f3af52560f6f96e98afc4f3e8fb3c74bccfd472597b4c22479869f27d875274f56af54f0fdf65547b5798f896dcdbea5e60fbb9aea3c25a87cbb3e95e1cbde8dcf5e8fbb3b1ec16326e546ad7126eda2b94d36e37e07a8ae96cbeed79d2dcf5a3b09377abba4cfb485f7aa970db509a7e9b2fcc2a447a069f36d890d6d5bdd7ca2b9ad1e5f956b7239693d8d4deb5b9dd815a31cc5791d6b9b866db835a56f77b573596a59aeb78cac09e95a7677db88ae6bfb436f35620d5391408ec616f3306a39c165217ad63db6a8368cf4abb1de2bae475ab235286a5a7a4f1387ea4579578d3c2293a334432fd457b0bb6f6dd587ad5a89b208c82280d4f98ee8b59c8622986538cd34879e223d6bd1bc67e0f170a6444c30e457994864b39de29fa83c568b702f58ced6f956fbbde9d73a76e5696dfea6aaadc248bb7d6a4b795ad739ff00567ad6da8d4b525b4baf90a4a338addd3e587e5c47cd73378a518483eed59d3b5050a558023d0f4ad2274a96876ebe54f1c91bc7f2b0c1af29f891f0cd6ed5ae214c1ea0d7616fac491cca245454ec456ade4c9342a9bf3bf1c7e35d5139a67cebe1fd6a6d2ef1b4dd43efc6488ebab9261e5875e86aafc52f0c234ad756dfeb11b7562e8baefdbac555ff00d62fcb547239f2bb1de785eebfd2139c7cdd6bd03566f31633bf3c57947872e87da173d335e8faa5e2a69f1b0eb815c7523a97cc345d79754ee2fb7362b166d4f7498a9219bcdc564c946c4371bf02afdb7fac5acbb71b940ad4b78f6a83599a9a31e7b75ad34dfb573d2b22362a323ad685bcafb467a5069a9b1a73f9733356d5bcbf32be33cd73225fde2568473158890707d680773a456dea4eddbf37deab11965c1593e6ac0b6ba6da32f91573ed9b632683234dae268e6662f90074acdd427793613d29b35c06018f4ac9d42f1563623ad324a9a95e98f701d6b93d46fdfcc39e957b52bec8615cc5fde6ddc6b4d44f639ff14dff00ee4d78b78b350db2486bd23c5da86d818d784f8c358dccc9ea6bd1c3c0f0b1b5b963639bd52ebce99feb5497ef0a453f31ff006a9d5eda8f2a48f9272e663e85eb4f8feed3d33b855123d3eed397ad35ba54910ddc541aadc3a55db5b2dfb64f7abfa66826578e69d3cc507216b5bcb792eb90102310aa7a74acdec6a3ac74f48e418ff58c38ad6857cbc08ff1a6c168f1a626d9e7375c75ad2b5b1f2307d6b01c46c36ece416191e94569245f2d15251fb51f123c2f63e20f0bea3672c40c72dbba367e95f889ada9b1f146b1a7c5124691dc4912b0fee2bf15fb77f14b5a7d17c1fabde44a5e486d257451d73b4e3f5afc6ad5fe1b6a736a97b35c5bb93e6bb3e7a6e2777f5afabc2621e1e4a5d0f22ad3551348e2cc43cc197cb7a533c9dd2015a7a8696d67247130d8cbfc3558c71cbdf0e3a57e8d4abc31105389f392a72a72b1973c7e63e7fba6b464558ed959beef4fcf8aacf6abe72ef7cae72456678ab5a30ab244c54800061f5ac2ad4861e2ea48d231755a89d4d945009da2c6efde038dd8fe1f5acfb8564880cf9a70bbfe5d98e0e38fe2af368752bb594b0b89013e95d6687abff68daac0e55648ff0085bef3572e1f35a588f752b1d12c24a9be6b9afa2e4ea916d4c1c9e7f035e8f6176255443f7abceb41511eaf0b374c9fe46bba7b536f3acc3eee2bf36e25ff007b47dde43feeeca7e24b3fb4238ac7f0ede7d9ee36ff0074d74f7589a3f9ba115c66a16e6c3505947ddcd7cbc763e89ee7b2f876efcc816bb3b19bf735e4de15d532aa3e95e95a6cfbc03ed5c5563a9df4e5a1b6c9e6424d53824f2e6fc6aec126e4c553b8ff005d581a9d6e8d75f2ad7451dcee6415c169371b180aea2dee376c15406d196adc32feeeb2a293760549b8a73507444d4f369565f98738acb5b8c9c669eb3735251d0c171e5a6ef32ae477db8637e6b95f3b6f357adef0aae475a00ebe3b92caa075a1e17994e7a1ae7adb5075604f4ad7b7d43cc50b41064ebd61f237d2bc87c65e176914cc9f7979af74be87ed69bbd0572faa69a2484a91907b5590ee7cf76ec52462df7a3e3fa56847fbeae8fc47e196b792591530bd7f5ae7628d8139e8b56663f6adbf0e32a7a8aa77d07964322601ad98d77c78a46b5dca46335a1a731cdb5cbc6b8a6ff6c4b1f03ad69dee9eaca42a625ed5cedf5a4d1b1cf4ade322b9866b975fda09fbcf4af21d62f078675804ff00ab9db9af47bcdfb592bce3c65a4bdf32b1ce07a75ae886ba1e6e25d95d1dd784f5413488ebf75abb0f106b9f688e2b58fee28f9abe69d1b50bed1f52458ee1fcb0d8d86bd72c7568e485097cbb0e452ab4ecee7252aded3491d3dacdfbc5ae82c537a835cde8e166c30eb5d85841ba2c571cb73be05db58f6e0d68c6fe5fcd54517cb5c54f1d433a0d2864dd86ab91cdc565c7d055a8db6f3599a6a6a47d37d59126e422b32296a4f3680d4d48db6f38cfb5598e6dab9d98f7ac8497e5a1ae360dd403d8d76baf94f358fa85e6ddc698f7ff0029accd46f37c6a2839d999a8dc6e90b572da95e056627a62b5afe603713d2b83f156b51d8dbb484e3683cd6d0d7439273b2b9c4f8f35e4843fd0d7895d5d1bab8677eb93b6b5bc59e203ad5f3e1f2aadd2b097ad7d0e1e9fb38dcf8fc657f693b44753a35dd2014dddb79a9a2fdcfe35d879c3d9b6a95a7c748bd77d4b1c6669063ad41a8e8d433005770f4adbd17471248b24bc80788fd6a7d2f4269155cf4adb8ed4c50941d4f159bd8b12e24998a410f12f46ff00a643ff00afd3f1abba7d8881492b973d5aa7b1d2dad5467a3735a51dbed19ac0b21862e957618ba53e28f6f352af5a9284f2f6f3453e8a8d40fd8cf89d11d534c3661771978c7d083fd2bcb343f813657d2493cf6db8b76fad7ac6adfe997c47bd74fa3e9bf67b746f5afa18cf9558f3a50e6773e1cfda13f64cb4b885aff4f88acd1a92147bf1fd6be5a9be0fcd369ade75a3c33444c6d9e871cff4afd71f1669eb7e8d6eebb95c608af38ff854ba7c6d30107cb2fdeaeca55a74d5e12b184e9a7a33f26359f0c5d694ee91a6032e33f8d798f8b2c668664793b1afd57f8a3fb37e9f751493430e242322be27f8e9f0667d0b4eb99234c794377e4453af8bad595aa4b41469c23b23e60ab7612186e23603241aaf8db85ee46e356ad1774883de961fe24692f859e81a491fdab6e51301ba9fc2bd26d63325bb20eac715e6da136dd4ad57ebfc8d7a65a74fc2b8389bfde61e87d0f0ff00f025ea653c2d693184f41cd666ad6be729aea6fed4cb19c75c561f96264d87ef0af8dd8fa628785f50fb25c795ef5eada2de79ab19ff003d2bc7af2ddadee04a9f794e6bbcf08eac93246fdcf07f2a753de5734a3eebb1ea36726e502adcd0e543562e9f708630d5bb19491571d6b88ed2a4319ddc75cd6f69b7cf149b0f4ac5923db28356236f2f0d401d8dbcde62d4b591a6dcee502b5e296835d446e948adb4e68924dc715133155cd415cc4fe66ee2ac5bb6c60d59e921dc31d6a5123e79e95233556e773015a96326e6515cfc72f156f4f94f9c36f5a06f63b0b71918aaf7967bf26a28ae84aab9fbc2a659371c55996a735ab69fba371fe7ad79c6b9a49b7b82c3a9af58be50ec41e95cbeab6abf363ad06679bfd9dd240c7a5595fbb5a97506c666aa2ff7a810b1db09179e954ef2c139e33ed565ae3cb5c530b6f04d590ce7af74d8ed9598c7d4579cf8b2c4c9d130beb5ead7ca1e3607a5727aa69a8ecc6ba2333964afa1e1979a318ae0e3a935d8786f496922456e9572f34956bcc0eb9ae9f45d33f76ab5aba97d0ca9d3b3b9aba1696b0a2e3ad74d6ebb17159d669f6740b5684bcd627744b9534755639370c55a8eb377352d47f769e99dc2abaf5a923fbe2b302d2b6d6cd4892fcc2aac9f74d45e76df96811a4f36d526a07b9dca4554f3691a5e2993cc4cd36d526b3aeae864e7a53a6980c93d2b9bf116b7069f0c92cafe5c68325ab549bd11cd39a5ab2978935986cedda490e114124d7cd7e3ef1b49e22bc68e37cc08706adfc42f8892f892ea4b7b5931a7a9c15fef60ff008d706edbdb35ede170dc8b9a47cae3318ea5e9c3618cbb9b752afde14b8ddc52ac7b4e6bd23c51d4b1fde148a371c55bb7b73232a8ea4d2603a38fcec26339ed5d5e85a2cdb59ca00dfc24f4ab1e19f0efd9e4f3ee3af6fcaba95d90affb15cb291d118956dec44101794a285ebb7afd29f670ac9379c62f2625ff00569e9db34ad1c9aa4813fe58c4726b5638d55b68ea05646a44b6e64605faff000d5b8d762e29163dad9a917ef0a00106e602a5f2f6f342fde1527351a8115152f3451a81fb1d6762b25cb483a96aed2ca1f2e33f4ac2d16cf748ad5d432ec8715ef1c273b7d1896e829e8692fada3b78d642db40effa55b0375d62afc70ee18aa24e3357d1d7504f9937923e56af05f8c1f096dbc49a6dd44d16e6910a63eb5f4c5c5a659c5731e22d13ed16ac3b90714c4f63f077c79e1793c21e33d6347c6dfb24ec029fad67e9b672cd22cab1c92c4ac373ff000af35f557ede5f0adbc33e3eb7f12db438b3bd8c24effed839c7e278fc6bc1dacd341d1a0d208ff4fb9922bbbe5ff9f7c232a43f8ee0df857ad87a7cf389c927657343c36bbb5856d98da3fa1af44b4ff575c3783ed8c9a84ce3eea8aefed62e057cd71254e7c635d923ecf22a7cb86f526550cb86e86b075ab07b393ce4e9fe45742aa2360c7a525e431ceb8f515f26b73e9794e25d964525bef554d36edf47bb04ff00ab63cd5cd46dce9970c3f818f355e7852e1723ae2ba63b1cb25caee7aaf877515923523ab0aec74fb8dfb57d6bc33c25ae3e95702ce5e99e2bd7349bd5650c3ab0ae6944eda52e63a79fee8aaf53c67cc84535a3dab9ac4e8771f6b75e43afb57436375e728ae636eee2a5b1baf25b6d06675d82dc0eb50bc4fbb9e9552cefb7102b496e7726319f6a00afe595e475a55dd9e7a54ad2fcbf731ef514b27eecd41a8f171b4e2ad5bde156057ad6579d4be6d49674b6f782e0827ef0abf14db79ae56cef762915a70df6e8f1408d993f7aa6b0b537f2d5c55d5bc89572df7ab2afe4f389fee77ab219837d1f9d0d60dd2f96c4574d73b76941d4d635d45d683231ff00e5a0a7b74a95a3dad9aaf3506457b860aa49e95cfea522956c75ad4bce86b2e6b5f3bf1ab20e75b4ff003a42def5bd6b66521503ad5fb1d342b293d2b6a1b1458f347317ca624366cd807a55d8e0d8315a3f655edd68fb3f97f35059043185c13d2ae2ecdbc75a8aa54fbb57a80e55dcc05217d8f8a0b6de6ab492d6604af28ddcf4a634ab8e3ad43e66ee29acdb149a0cf9891a4f94d40f3621049031cf3d2ab5cdd7ca7e6da3d6bcff00c7ff00152c3c310bc51b19ef71f220ee7ffadd7f0ade14e5339aa578534ee747e2cf19d97872c5aeae2448931cc63ab76af9a3c7de3ebaf185e1c3f9762a7f771ff7ab2fc47e26d43c5379f69bfb869e404e14f441593b99791d6bdca18654d5e47cae2b1aeabe58ec31610c771e94ff002d5791d6a558de45c9e9566decd99805eb5da79ba9479a500b1c56ab68b2eddedf7694e9a1222c7a0a0394ce82dcc92aaaf535ddf87fc328b124927d6a0f0e69790b7120ce7a575caaf1aa844c0ae7948d23112399605745fbaa2982d5ef2419ff00567ad4fb45b48cc7ef9153da26d39f5ac8d47c28a91ed1d56a45ce69d8ddc54ab1ed5cd00317ef0a928a993a500201b948a163dad9a917ad3b1bb8a8d40663771453fcb2bc8eb451a81fb63a4dbf97f356d4a37478a8ec62f94559923da84d7b671192d17ef855a8e1cae2a051ba7c55d58be4ab033af6cde75468f1bd7a66b366b5721925d9d0938f6e6ba068fe5aa1a84266f997aad007ca7fb617c3c5d7bc1315dc5179d159dfdb5d4a9fec2cd1973f82827f0afcc8f1d591d2fe22788d22f9f75ec8cadea8c4328fc857ed6f8df424d7f46bdb29067ed113427fe0431fd6bf1fbe3a78667b7f8d7e21d28c7f3c73c2a7feb9a428057b980ad1837296c8e4ad49d46a0ba953c136661b1323261a573cd76b690eec0aada458adbdbc5146988c2e07d715b50d9eec0afce71f5de2b113a9dcfd270343d8d18c56f62b9b7da3355e48f6b66b58c1e58c554b88be535e59e89ce6a567f695753deb8f757d2ae181ff00579e6bd0ee23f94d73bac5879c4e7d2b684cc65030a58d6eb6b8ebd45755e12f133b39b5b838707087e95c3067d367607fd593cd5e602655953ef0e457435ce73c5f248f7bd2f540c402f918adb69964518eb5e39e13f1519152dee8e2553843fe7dabd1ecb50593a3e4e3a5724a3ca7a119731b27a540c70d9a23b8deb8a24fb86a4b65ab1bd11f07a56ddbde248bb47535ca6ef2fe6ab10de796437a569a999d9aca7c8381935048ceea414c0f5acfb1d4f728157566f3585201be5ede694e3bf4a9586e18a8de3daa4d6669cc4d0cab9083a9a9b25791d6b3c6ecf0714c86f2692e197cbf2a01f77dea41dcd2691f1cf4a8de4dca4554925a89a6daa4d064493305c93d2b36e24566c0eb51dd5c6e622ab3c9b948a0920b8fbc6abc9f70d4adf7852fd9f7734019af6fbdb3447a6f98e0d69adbed39a7ac7b5b3400db6b411af3d2a448d14311d696a097bd0012f7a89ba50dd29a5b68cd35b80374a6eedbcd4124b5119b68cd6da99f31334bf354124bcd579aebad529af3cbcb1dd81fddeb46a66e5a171a405b9381eb597aa7882db4b82496e26d9120cb35707e35f8b961e1ff00312ddd2eee40e117a03ef5e19e25f19ea5e2cba0d7770cd112711afdd15db470d2a9ab3c8c463a14748ee7a0f8ebe364b74d25ae8c4ac7d1a71dabc9a7ba96f26334b23c8ee724b74a3caa3cbc735ecd3a31a68f9cad889d677635402d86e9576cecc952c3eed5649096545ea4d759a658a416f24927f7735a98990da7f9511e71bb1cfe35ab6ecb6f00667f9475aafe609ae46d5dc02f4ad4b5d3fa4d7adb76f2ab50595ae9659e3dd2bf9717fcb28ffbd49a4e9bfda972865ff50a79fe9fae29de549ae5f3227fa85eb5d6e9d61f648d123fb9fc559b968593d9c49bc63fe598c2d5e5fbc29ab17cb53c71ed5cd625103af98db6ac2aecda2957ad3aa3501d1fde15360b714d8feed3d739a3501163e69eb1ed6cd2af5a72f5a35005eb4ea28a3501cbf78514980dc1e9451a81fb9d6b1edc1a2ebee354d6ff0074524dd0d7b5a9c465affae1f5abcc374605565ff587eb575bee8a3502b18f6f355efbfd59fa55f6e954af33e4bed1938a3503976b5f3a3604edddf2e7ebc57c17fb717c36b6d0fe26d8789ecedbcb4d6adf6cafeae9c57df96bb7cc7dc986dc39fc6bc5ff00698f8677bf143e1bdca69c9e6ea3a7c897b12fa80087ff00c77756756fece5e87561e7c95a2cfcf5b28f6a85ad9b4877605362b52b95923f2e453823dc1c1ad086df6c79af8e97bada3f43a6b6910c96bf21aa335af5add8d36ae6abdd5bef8d8d606fa9cb5d5bedc9ac8ba873915d4dc5afca6b1af2df682685b83d8e4352d2fce0d9ae69a47d2ee361ff00564f35dfdc4219483d2b02faca390b29e86bb21238e7132da459555d5b6b020835d6f87bc6924122dbdd8f657ae164864b0988ff009624f353065913206e3e95bb5ccac73aa9c8cf7ad3f54176bbd5f231d2b5e3b90d1e0d783e89e2cb9d148494f991faff0076bd1f42f15c37d00314be613d4ff76b9654f959d71a9cc762515c6475aad2c7b79a86df50f357efe6a6f3f7f19a9d4a1d1de7d9d73e95ad63ac06500f4ac09b3ce3ad519c4ad90bd7b5581e810ea4ad803ad4ff006cdff2d79ddb6b97362c037415a50f8b15b01bef504739d979db79a89ee37b6dae7935f491734bfdb494b945ce6f336d19aab34bd6b28eb4b8e3ad579355f37e5f5a8e52398d09a5eb54da5f9aab35d71d699f6aa8e51f31a91c9bb8a917ad674375d2a66b9dc31505f3971db6a935134d819aade6d4464dce055f295cc597b8dca466a2326e18a631dab9a6799bb8a08e610a7972799e9514973b8e2a576daa49e954e49901c838f7ad09d46b4bf35579260a724023deaa6a7ae5969d0c935c4fe5aa0e5bd2bc77c6df1c20b757b7d1ff0078dd3ccf4e6b6a74e537a1c35abc28eb267a57893c5fa7f87ede496ee64565190a3eb8af0af1afc5ed43c40cf6b647c8b53c13eb8e7fa5713aa6b97bac5d34f773f9c58f1ed55157cb207f7abd7a3848d3f799f3b88c7caafbb0d87331931231dee4f2d426770a957ee9a4aee3ccd4291977ae295ba530fbd005fd0ecd66ba667fbabd6b5efb54f3a3f26dff00d5818355f44d21ae63cb7faaef56a65b78e4f2c8c85ed59b34897346d3c5adbabb7de6e6964537f70b144db533f31fd69b6fe6de288e15da99c66baed2742874d8cc8b17ef0e32fe959b2c8b4fd345bc2a40f2d07dd1fdead3b78be614846e988ab3147b79ac8a17cbdbcd230dcb8a928c6ee28008a32bc8eb527cddfa53e28f6f352500431fdf153af5a4a913eed46a022f5a917ef0a17ef0a91739a35005ce69d452a8dc7140094539a3da3345581fba49f76a1b8fbad56a3fbb505c7dd35ebea711461fbc6ad0ff0057502ffae1577fe599a350205eb54aec6722b479aaf38dca456606247a7acf2e1c6573cd58d42dc2316440046b9f9ba7157a14d8ac6aaeae4f931c23ac9c500b467c05fb487c25d4fc37e2cd43c5315a23681a94e18490fdd8a4231cfd7a7e35e47e4ab0561d6bf51352d12d6e74f96c2e605bab595764b0bf46078af92fe327ecab7be1f925d57c1e92ea5a5f2cda6c2bba483d4a8fe7ed9af131b8597f1227d765d9945a54aae8fa1f38795504d1edc9ad1f2994b06c86dc55a365dac847622a168f6b66be7a5b9f551e592b98f35befc9acbbab5eb5d2c90ee3bab3aea1dd914c47257d6bf2b573fa95a9f29f69c1f5fc6bb4beb5f95ab0eead7ad6f139e6724d6a029dcf96f4ac8bcd2da162f074ef5d6dcdbed626a84f082a41e95d5191c3389cbf9c64f95ce08a4b6b9b9d3e4df04986ea2b4350d35244621b69f5fc6b2de392152b22e7d1ab68ec61a9da687f1102948ae06641c6faee6c7c4505e2236fcfb578635bef52d9c7bd3ec753bfd25ff72f95a4e0a4ae8bf6ce3b9f43c57714b1fcbd7b51e66ee2bc7f4bf884d0b2a5cb6df535d45978be2b950566dcbe958f2c8de35a333b29177fcb559adf6b66b3edb5c4600d5d8f52475cd05114909edd6a2691e3156dafa3618aad232bf23ad066352f1d5b34b1df3b641e955db1bf9e94bb9179a093461bae957edee7730158d1cabdbad4ab27cc2828dd13735662937715891de84183d2acadf26deb8f7a8e5035e85eb58cdad430825e550a3a96381f9d60ea5f13344d31889351891c7f0c6f93f853509dc87520b56767210a727a544f711c6a58e31efd2bc775dfda0b4fb55912c91ae3fda6e95e79ae7c6fd5f518ca40eb6d13775ea2baa1849cba1c73c75182dcfa1f58f18699a2b16bbb95040e14579578bbe3b40a1e3d31492380c2bc3f50d6aeb51999ee26794b1efd2a9f99bb8aeea78382d6478d5b339b4d5346d788fc5da97899f7dd4ee62cff00ab3d0d61af5a752a2798c16bbe318c57ba7912a92a9ac98b18dd20157557cb4dd4c8d7cb5c54ccbb8a8a08447b049c9e952a6ddbb075c51349e5a814db55dd96a0d352b46db4bad3c6e240519278a6c9f78fd6ac59a969900eb406a6dc2d3c767e5c498451f355fd2f41f386f93bf34b6b209cc51a74fe2fcababd3edf6db13ed5cf23488fd3ed228e64913ef6cc0ad1605971504517eed2aca4526dfde7e1591a8d8e3db2035617ad3a28f6e0d4bcd46a046bf7854ab9cd0b9cd3d7ad1a8094abd69d42f5a35005eb522fde142fde14fe68d4055ce69d4c39a917eed1a8094abd685eb4f5eb46a02514fa28d40fdcf68f68cd137f0d3973b78fb94927dc35ed6a711557fd68ab6bf74d451e778a9a877018dd2ab49576a1906ee2b334654e70703271d2aac90b4d7b14a530157fa568347f29fcea384e58bff7a8332a4915549adcdbfcd11c2f526b4ee3ee9aa8d8da73d280f53c53e377ecef61f12ad26d574944d3bc46a99138ff0057747fbadf8671ef8af8abc45a0dff0086b56bad3354b67b1beb77024b76e9bb1d457e9c790acfb9577ffb3ea3bfe95e6df19be0ae97f15f4b53218ac758807fa35fa8c9033f71ebcdc5e06355734773e872ecc9d17c957e13f3d641bb22a1922f90d751e38f05eb5e03d6a6d2f59b196d274638919311ccbd9d3eb5cdb7dd35f3538384b9647da4271ab1e783ba32aea1dd1915917b6bf30ae864ea6b36f06ec8a4632397bcb5eb58b796fb726ba8ba8f6e4d63de7dd35d113966737345d6a94d086c86e95af75d0d66dc7dd35d31d8e2918b7963242a4c7dea8b36d1b5fad6c5c5c08d483d2b36e592442475ade27248afb55b81d6990a329251b6b76355e6ba10e73d0540daec71a9cf4adb91f432e78a376df59bfb360565f3147f0d6bc1e389e14cc898f7af3eb8f11c3b4ed193e959d71e2298a9d8bb47ad74430d525d0c258b8c7ed1eba9f112dd1732b6d1dcd397e2569ccd837000f535e2135d5c5de77be54f5150f955db1cb54be239259aca2fdd3de3fe163e9439378a07b544df153488db1f6e3f875af0b31ed04d529bef544b2fa7012cd6a4ba1ee93fc64d2617f9649243eb59f3fc76b647c4568f21ec4f4af18a2b3585a7714b31ad73d52ebe3c6a3cfd9ecc47e8c7a560ea1f17bc4979b82dd8b753fc519c115c4d15b7b182d5239e78bad2fb469de788b53d4a4dd757934e0f50cf906a8c8ceed93d2a35eb4f5fbc2ace7e69497bcc4a31bb8a939a39a0cc67954795520058e29de5ede6802258773015721fdce0524552ee2bcd400eff006e9cadb5bccf4a8d54336e6e951c92997a7dd14cd19148dbd98d5ab7fbbf85562377156a38f6c64d519a2ab0dd211ef5aba7c1f67b776f5159b1db97932adb4e7ad75561a69585142ee91ba3543355b97bc3b63e7430aff789fe59aed963f26248bd4553d3f4f36b0c7bba915a51c5f2d71c8e98ec436d1ed93356aa1f2bf782acc71ed5cd67a886afde152ae7342e734f5eb46a305eb4ea17ad3a8d4b6357ad48bf7850bf78539b3b4d1a998bcd2ae734274a751a8052a8dc7142f5a7af5a350058f69cd3a8a55fbc28d4017ef0a29fcd146a07ee8c7f76926cf96d4fe69b26769af6b5388ad1e778ab606e522a05eb5613a50c06347b5734c3d2ac374a8db38eb8f7acc0a9703642c9fdec7f3a5f2f6c60d3d8f98fbf7e76d0d2f141a3b90b6715566b732723ad5d29e60cd5766dadb683328dc6e89864123dbad47e5f99ced653d416e99ed562ead9a58dc248626604071db3c5731a778c2de3d51f42d4cb41ab28f3555ba489d03d17b6a0647c4af873a5fc48d066d33558be750cd04e7fd64127f787b7afb66be10f1b7c26d67c0fe2e4d0b559ad2c5a453f66bb9a610dbdc0ea0973d09e9f522bf462eb56b5b6b8304a44930192a9d715c4fc48f04689f127c372697ac5bc92da9dc6deee13892dc9fe21f4efed9ae1c450a7595dee7b782c654c33b7d967c0779f0cfc516d25ca3e90e8902190ccae8d1c8a06731b8ff59fd05707717086250769ddce1bef035f4afc5cd16f7e0efc33bd82775b9b6510e9fa3deefcb799319bed521ff79015ff008157c817dab4711c29dac84283eaa062bc3a947d9bb1f4f4311eda376695ddea202075ae6eeafc6e7cf4aa1a96bbb830df9ae6af3582d2103ad38527d0caad5372eafd7271d6b0afb52d84b5655d6a6e722b22e6e1d989af6f0f96d6afb23c3c463a9d3dd9a375acf5ac7bad618e42fdea824477e4f4a67955ef52c91af899e155ccded144135d4b367774aaed0ee1baaff9548d17cb5ea52cb69c16c79b2c5ce7bb33fc90dc1e947d995791d6aef955198f6b835d0b0d1898fb52bac5f353c443bf4a999770c553b89bc85353351a7a8a2eed222d42458871d6b25dbcc6cd49713798d5157cfd6a9cd267a118f28abd69d4ca55eb5ca50ea55eb494a319e7a522c7afde152a02cc0511b220ce3356a3bb4519d98a9021f2a8f2aae477e9b850d3a3b6475a834d4a8b1ed39a76edbcd3cb6f7c546f1856c9e94c1dc5694ede3ad3e38de45c9e9512b22b6475a7336f5db54662493f98db7d29dff2ccd3a38f6ae6a361b9b14013429e6617daacaa958540eb4c8536a64d6858d8c97ecdfdc18cd43d8d6259d074569bf7adf773cd77ba5e931db2907bd57d134dfb3c519f4adb863da6435c7291b4620aa525603eed3dbee9fa52d18ddc567a9632d7f7b287feead5ba8eda3db9353d1a9a6a32957ef0a750bd68d4351d4e5fbc285fbc2a45ce68d44c4e695739a752af5a353312957ad3a957ad1a802f5a75148dd28d4072fde14fe6923fbb4e5ce68d462734549451a9a1fba54d93ee1a7799bb8df9f6a2bdad4f34817ad585fbb503f5a963acc0771dfa557999179ab2df74d5475f31b6d002dac091e58753561ba526dd9b452b74a0d3523605862abb45f3559e69b26769a03533e68f1ce71deb95f1c781ed7c6da725bcb2c967750b6fb5ba8fef46c7804576846e18aad2439cd2b5f41a3c4d6c7519ad7c98ee667d52d9d44b3b292d2ec619200f5008fc6b4747b9bdbebe9a3b46db0c2bb7ec73c8e8cae58162d9f6cd76fab6832c521bcb5192dd4562437d04c2e4487c995460bfa1ae26b959d3195d58c6f17f8474bf11dacba57882ce1d474dba5db242edb90e0e473eb9031ef8af893f688fd896ef40d1eefc45f0fa6b9d4a0858b4da1cc85e4893231e501d70483f406bedab8bc3703ecf3cc495fb8c3ad69e99709a82c904703aa451e198f7a9e58ccd215e74b48b3f143c63e11f147841a33af681a968d1cb8d92dddaba2c9919ea7a572335c2db82cf27ca7ad7ee16ade1db2d52d4dbdc5aa5c229c98e440eaddf907ad707a7fc0df0547afb5f47e16d122baf21a191e2b340c73cf35ece123470ef99abb39b1388ad5d59688fc649b56b45d84c25867ef0a9ff00b62c9940f31a3e3a374afd5df885fb1efc36f12d9cbbbc31a7d9dcb027cfb18115c1f5c8af89fe297ec4f3f84e79a7d26ea67b5c96588f4c57b91c7492f7523c5952d7de3e7f8563b8b52c92a38cfdd149f67dbcd3f53f8777da4dd61ddd240dc31e83156ad56e24575ba3bc631babbb0d9842abe5a8ac73ce8c96a8cd78be6a7491edc1ad1b9b72a548fbbb6ab3c5f29af66504e3cd1394ce6fbd50bfdeab9247b4e6a36e95c32896546fba6b26f06e908ad7986ec8aa37117ca6bccc4c3991d70918ef1ed6cd36acdc47b549aad5f33523cb23be2145145645851452af5a402c7f7854e8c5581a8685eb525a2d79db79c67da86b82c301307d69131b79e94f408cc00eb41a6a45e6bd1b19f93d2adac7b5b34b20dca45406a5458f6b669dbb6f3527954ab1f34011799bb8a519edd6a6119edd6ac5969ed70d863b54f5340728b6b1bdd633d338aefb49d2e3b58624fe37191fceaae8fa208e10c576c03eeaff007aba1b1b511b2cac9866e14d73ca46f18966d01e31d56ada8766c1e94f863f2307d69164f3a691bfbb59142f97b79a58fef8a21fbc6a6a8d4055eb4ea6afde152f3dbad1a80c5eb522fde14abbb3cd3b9a35015739a7535739a7af5a35005eb4ea2957ad1a802f5a751451a80514abf78548b9cd1a8c54e94e5eb42f5a75069a8514515607ee8afdda46e9450dd2bd7679a30e6a45fbb4c5ce69f5980d6fba6a383ef1a5baed5243f76801cdd29b4fa2834d46374a67352b74a6b74a0351982dc543247b4e6a6e695739a03533a4ebc8cd676a9a0db6b11b060f1b63ef47f7856f48377155258f6f348ccf3a3f0a6cfed45db51bb5527256ba9b0d161d3e10916442a3e52fd4d6cae3b9c0f5ae57c41e255d1cb80c589e303ad2518dcbe69197a844be749b7ae78ac4b68d94ca5beeefad386e1ae61f3151c3487bd5c5b129098c7ddead5b1060de4a9b7663391d2b89d7fc3f0df42c5e3ca9ea2bd0750b05de36fdeed5877f6322c6f8eb8ade3a19c8f8d3e367c1db5b8f3678e1c3f507f1af96f5bf0a7d86668f66369afd28f187836e35ab778d5cc65c7de1dbbd7c8ff197e01eb16e66bdb6b97675e403f5abb731929f2e87ce371a130462832d8e958579a798e4f9930db7ad6bea1fdaf672496f7127319c1ae7eeb52b9498095f31e7915ede071ce93f6757639f13878d55cd1dca9716fb5b354a68bad744196ea2f307576acebcb7da09afa471535cc9dd1e42724f96463b47c557922e6b49a2e2ab491579f5691d119997343bb22a8cd665b2075ade68772e2a336bc75af2eae1398eb85639a681d1c03d29cb0ee38adb96cf7645410dbe095af0ebe1654ddd1db0a9cc670b6e7a5598ed030c1e94b2c7b650b5d0f86ecd2e2468a41946e0d709d063269eacb81d69dfd975b9e22d0ae3c3378a163cdb4c3295941849c96dadfddac8d625336386db4e580a1c0eb5a70d889304f4ad55b543184c66b3e62b94e69626ddcf4a9161dc715af23a3ca23b65db274cd598f420bfbc964f9cd1cc1ca60fd977718a72e9fb980ae852ce546c3c595ecd56ac6c4cadb163e4d4731a7299163a3999950056279c374e95d1e93a1229123b3394eebf756afdbe9ed1ae123ccbdaaf456af1dbaa4adb777f0d67cc50d552d2201f745584203053d2962529803eed4a177fcb5203a5957845fbd4f8c3b0c1e952436fe5e1aa7a8d406a45f2d3d62f9a917ad3a8d405f2f6f34abf7850bf7853f9a3518734ab9cd260b714a91ed6068d4d351ebd69d452af5a350d417ad3a957ef0a7f346a26317ef0a7f34734ab9cd1a9982e734fa285eb46a00bd69ebd685eb4add28006e945368ab03f74923dab9a5a28af4ce2233feb29cbd69586e5c52edd91934015a4ff00582a74fbb51c2b962d53500148dd29691ba5003776de6a2697e6a7c9c213c8fa551b8b90ca493271e8714012b4bf3d3965f9ab1a6bc2ac7e5cafab31269b6b74cef8ed41a6a6f2c9b9b14e605862abc126e5c54d1fdf1403b95ae233b5b1d715e65a958b5d6ad2b9e8a6bd66e3fd4bfd2b8cb48435ccc7de833333ec7b0c2319a9638fcc6cecc6d63cfe15a925b037080f4ffeb53dec52152477ad44605cc5c9aa1716fe6291eb5d05c5b8da79acf9edc60d51273d7162369cf4ae17c79a2c771a6ca186415af45bc731ab015e77e34669ad244cfde15b437337b1f9d9f1f2c134fd5e74b64c65b9fcebc0ae60669998fdeafbafe207c32b6d72e259247504e7d6bc07c65f0a20b06678e55f97eb57288a323c1de5934d6df5a1a7dc0d523253a0fbd4cf15598b0260e0e4f51591a62947054e0e6bd0c1e3e787767ac4e7ab4154d51b2f6fb959bfbb54a68bad6d5b319b7464e091d4555b880461831dcdd9abeba94e35e3cd13c99c1d3766652c5f35472c55a1b71cd35c6e522a65485cc66345f2d549e2fdf256c3c7f29a861b7125d46b9eac2bccc552fdd33aa9cb5463cf1ffa50aeb7c196066bc5006496c62b3f52b111de16cf46af42f863a3adc6a0096eff00d2be2dc773dbfb276baa78162f10786d6295312dbf2a7eb5e49ac7c35bdb29098137804fcb5f61e9be1e8c697c907e5ae3f55f0fc4d36060726a792fa19aa96773e4eb7d1efec9d958ac4dfed8c8fcaae2e9335cae249b767a88d302be82d67c0965ad5b885c0491ba49e8473fd2bc9f54d2a4d16fe7b3322bf967ef8eadf5ae3ab4dc4eb854e630a1d352de3db16fcf7cf4ab30db3af356941dc326a4ae53a0a3e4b99056b69b6322a97150c76c2691726b6638fca8d545002a6db35cb7534d8d4bee0fd5ba548bc9a7aa0dd51a8c48edfcb60d52e37714d68d5948a72aec4c51a9a6a2a47b581a92913eed2d1a8985397ef0a6b74a7c7f768d4cc7ae734ea6ae734f5eb46a00bd69ebd692957ad1a8c751452afde146a69a82fde14fe68e695739a3513b82e734fa285eb46a660bd69d452af5a35005eb4ea2957ef0a350131bb8a2a5e68a3503ffd9, '2000-01-20', '04125972365', 'Masculino', 'NOMBRE DE MI MADRE', 'Maria', 'NOMBRE DE MI HERMANO MAYOR', 'Jose', 'activo');
INSERT INTO `usuario` (`id_usuario`, `usuario`, `tipo_doc`, `num_doc`, `correo`, `contraseña`, `nombre1`, `nombre2`, `apellido1`, `apellido2`, `foto`, `fecha_nac`, `telefono`, `sexo`, `pregunta_s1`, `respuesta_1`, `pregunta_s2`, `respuesta_2`, `status`) VALUES
(26, 'test1', 'P', '22198821', 'dunsuarez.ma@gmail.com', '202cb962ac59075b964b07152d234b70', 'test1', 'test1', 'test1', 'test1', NULL, '1995-02-02', '04125972365', 'Masculino', 'NOMBRE DE MI PRIMER COLEGIO', 's', 'NOMBRE DE MEJOR AMIGO DE LA INFANCIA', 'd', 'activo'),
(27, 'test2', 'P', '22198821', 'test2@hotmail.com', '202cb962ac59075b964b07152d234b70', 'Maria', 'Juana', 'Perez', '', NULL, '1995-12-02', '02514456248', 'Masculino', 'NOMBRE DE MI MASCOTA', 'Terry', 'PELICULA FAVORITA', 'Titanic', 'activo'),
(28, 'tes3', 'V', '22198821', 'test3@hotmail.com', '202cb962ac59075b964b07152d234b70', 'Maria', '', 'Rodriguez', '', NULL, '1995-01-06', '02517178172', 'Femenino', 'NOMBRE DE MI MASCOTA', 'Negro', 'NOMBRE DE MI HERMANO MAYOR', 'Jose', 'activo');
INSERT INTO `usuario` (`id_usuario`, `usuario`, `tipo_doc`, `num_doc`, `correo`, `contraseña`, `nombre1`, `nombre2`, `apellido1`, `apellido2`, `foto`, `fecha_nac`, `telefono`, `sexo`, `pregunta_s1`, `respuesta_1`, `pregunta_s2`, `respuesta_2`, `status`) VALUES
(34, 'marce12322', 'V', '24325485', 'anais_asdm@hotmail.com', '202cb962ac59075b964b07152d234b70', 'Marcelis', 'Anais', 'Dun', 'Suarez', 0x89504e470d0a1a0a0000000d49484452000000df000000dc0806000000f06d7482000000017352474200aece1ce90000000467414d410000b18f0bfc6105000000097048597300000ec300000ec301c76fa8640000f81949444154785eecfd09b06ed955df09ae3bcfe31bf3bd9c53a94ccd0342836d2c81b125aacde0aa72815de546386c4b44b81a8872b74c745508a2bb022b5cd598764580ca152564080b97cb2d090706814112203420295399a99c87f7f2cdefcee377e7dbffdf7fedfddd73efbb2ff3652a2524c8f5dd7dcf3efbec61edb5d7da6bede1ecd3b12b8897e1657819bee5d059ae2fc3cbf0327c8be165cdf76d069ff9cc677cbd7cf9723cfae8a3f637e1ca952bd784df7efbed71db6db795bb3d201c07bcfded6f8ffefe7efb5f866f0f7859f8bec570e6cc193b84ac0a120e61fb56c0f8f878bcf18d6f6c0b2c4289ffde7bef2d315e866f15bc2c7cdf4440a810b22f7ef18bf67fe10b5f284fbe3d01a14408dff6b6b7c5bbdef52edfbf0cdf3c7859f85e4240b8709ffdec672d74f3f3f3e5c98dc31bdff87a6ba7f1b131f9df5042f7606c9cf0d797bb84471f7d3cae5cbe52eef6e0d1471f8bcbd2ae6b6b6bc2eb4b25f4c6013cd08cef7ce73b7d45205f86970e5e16be6f0010ae4f7ce213f1a94f7d2a7ee7777ee786846ddcc2f386b8f79e57c66db763f6bd55828629b85fa0be595005f2fefb1f88b367cec6fd5f7b20c30e11de83c098f13def794fbcfbddef8e1ff9911f8993274f96272fc38b819785ef0502e62302f7c94f7ef279cdc893274fc4dbdff6d678e7bbfeaa850bffb7f3a4c7673efb87d6a29ffdcc1fc617bef8258d4dcf962787036629c2f8a33ffaa3f6bf0c2f0c5e16be1b0026437ee3377e233efce10f5bf8ae07f7de7b4fbceb9ddf136f933643d0b8ff4e06840f21fca24c5604136d793d60d2e6c77ffcc7e3bdef7d6f7b86f565786e7859f8ae038c93d0701ffde8476d525e0f301b7ff447ff76bce7dd7ffd3b5ed89e0f10c6dff9d4efc5273ff19bbe5e0f181fbeef7defb369cab8f165381c5e16be03c032c0cffffccf5bf00e1bc36136fec80fff60bcfb3d7f5d02f7376c5abe94b0da5a89d5d5e5a059e617e66267675badd4111d7ab6abdfe6d6a6f09ad3fdae5c47747676c4e0e070f4f6f6db4fba4ee27774c691c963b1a3fb3e3d1b1e1ecd025e22989f5f9000fe6e7cea777e2f3ef1c9dff4fd4180563ff6633f163ff5533ff5b2597a08bc2c7c05989dfca55ffa250bdd6180867bdffbfe8104ef873c69f28dc0f2f262b4d656637179defe1509dbecec74791ab1b5b929e1e988aeae4e0bd3e6c666acaf6f445fff400c0cf449ec2488dbdb725bd1ddddadbb0e09e94e0a5e6797d3e2b6f5bca7af2f363637acc9878686e2e8d1e3d1d3d51343836331363a19fd03833132f28d09a6ad844ffe87f8e8affeda75352233a50821daf06548f80b2f7c8ce53ef4a10f693c737f09d983db6fbf2d7e4c26254287ffc5005a6c71713e66e6a76271693ee6e6666253c2d5d3d3630141785aad960587fbddad9d0869bb8e2e09546c4a132e477fdf40f474f749c076a3abb33bb6b7a40d25827d7d3d16d4ae2e095c67a7f2dd56bcded8962022b85bd292bd12beb5f5753f1f1c1c74b91b12e47595d929ed485a04777cf2488c8c4dc4d8c8a484724202f9e23a18664d7ff5a3bf2673fdd73d8b7a10180f7ef0831fb446fc8bbee3e62facf0fdeaaffeaacd4bcccc83c0f8eda77efabff5f585c2d2d2624c4f5f91569b6b0b1a42b5b9bd691312e65f9730744a182ac0fc3804714b5a6463633d7afa7b956623a22b2c4c08d6c6daa66277c5aee49338434383f26f47a704a8bbab5b82d46d81b2c6eb95d68cede8eae852588f85bb0adf96d2ee487352deb6d26f6d6e49389556f9c00cee04e43972e4984dd7231327624c82f94281b5c55ffaa5ff257ee3dffebb12b2072c537ce0031f88f7bffffd7f6185f02f9cf06156feeccffeec35b3961e9f48cb7de003ffdd0b9e38999eb912535357626e7ec6666405ccbdde9e5e0bd69684af53daa8b7b7d7665a253b8cbeb1b16161c4bfbeb6a2b85bb1bcda8ab9e5d5b8323d1d97ae4e6bfc87065d9526dd88d515a54790bbbba4fd64862aaf1e09d2a0ea30323810a363c371f2a6a3328f47627c64d861037ad62de142f8ba11fc5d09adcacb7223d625802101eceeee71183857fcd08ea43b3279228e1d3919c78e9db4797ba3803644087fe5c3ffea9ab12142f80bbff00b9e25fd8b067f61848f311d4277706d8e0993f7bfef1fdab47c219327972f5f882b5317e3ca958b62c49ce860568449101837b5c7ae04294dc4ad9d2d998cd2503ddd12b0f5e892e084cc4888bfb1b926a6ef8ae5952509d8725c9d9e8f679ebd104f9e551933f3b1b4bc211352b221cd1621b753a65f548e4d4edd5a8874df2db9da96a06f6da35d15bb632b4e1e9b887b5e7977dc72cb2d12c8d1181eec8fb1e1210923afb5ec447f8f349e042f3416ec4053227cdb25ef5237ea83e9aa1b0bded12327e2e8e471d1ec660bec8d009dceafca1cfdd087fea76bd610d9d68610fe451a13feb9173e341c427770228549930f7ce09fc44fffd43fbe61b36745c271f6d9a7e3d2e5736d5371474285468361b7242130ecb6040e13ce571859f1104c181a7163cc86c967d34f8cbfac71e1fad67a5c9d9a8aa79eb9125ffecac371796a3636773b626b5766a404afab03c14b7093e94fa22021eef63d82481974045c291b40cb750bbf0e99a0c240021471fce8641c9b1c8d3b6f3b1db7df72328ecb3f323a1a3d7dfd89b332ef54d9ce1b8143ba05d4c5508431ef3be2f4e9dba4116fb2897aa3c0b8f0e77ffe7fbc46089998410859aef8f30e7f6e858f5e9631ddbff817ffc2fe0a08da3f95d0fd9484ee46662d11a88b12b6b3e79e8ea5c5796baf4a32181086ded120ac4e5cc0908cd1b85a284adc5dc5716c998bab3229590290dd17dbba2e2ead4afbedc49f7cfecbf1f063cfc4526b43e3bdddd8d84273e69282749052e3765398a53511822a1055d8106f87a1a9f4c3b4643c88b08203c29972bc1383031ae7c5569c3a792cdefcc6d7c56da76e8ac989118d257b25ec1a2faaaedbbb8a23ad58675e313f29171c5233aa2ce5cd64507fffa004f1d63879fcb4ccdc41e3f35c40bbfcca87ff376bc283dbdb180b22847f9ed709ff5c0a1f8be23ff9933fb96f3205a17bbf4c4bb4dd8d9897add66a3c75e6f1b870f159cf1a024c66c0fe3037cc97a65832227e0b85008242d614ce148c8dcd75b94de78bd9890694bc69acb52d73732b1e7bec6c3cf1c4b3b1ac676b1bcc726a5ca7f2b6a4253b95571765c921d86e323b675f801c6522bac82c97f85d12b62ef02ee93119b15a3b6473ee6adc8746ecec9020f6f5c63109dedd77dd12f7dc7d9b4cd4e3d1afb0deae3e0959b7858e7a90077e346de69742b98d092d7c78c624d34d32476fbbe5ae181b7d7ee1611cc898f05ffcd2bfdc3726fcf33e1efc73257c6c03fb899ff8896b76a4306bf9918ffcab1b12baf9f9d93873eec9b878e9bc99ab026442f4aaa0f568ec0633a24d9a9acf4e71894f18d3fab373733127ed3635331b172f5e8ce5a52533f4f0d878f4f50fc7b3e7aea8bc5969c42dc55f97d6dbf2a40b797145cb552d665c10335aed40d3ede8f90e76a58047e029ac94928e00ec11c22e0ded3027c956da927a75653e3d5dd292ea4c4647fbe3f6db4fc71b5ff7eab8f9f8d198181bf1c40eda8fd27366352d001c79a388093376f2431bee27268ec42da7ee88e3c79e7f1336daef677ff67fb049da044cd08f7ce4231e17fe79823f37c2f72bbff22bf1333ff333fb4c4c84ed977ff95f7a47caf3c195ab97645a3ea9ebe5c244c9bc40eddd6178b420f74c985813e8f9066130ba981333754b42b3aede7f6d6d339e7cf28cc670f7c7b31766626d7d3b05d60c2c21501e9874db92849d1d1c932f9b8ab3e52500b4cb8e8530850f7c707bc267f4da80f0d14580d42e69c0497e5d2c78bb2ac74228010b693b3260bc4ae781f9c818cf69248c0a8d91a1beb8edf4d178db5bde18a76e3a1ec3837d318036eced8b5e69383a197746d2a600758336cce86e487b03d0923cd96573c76d77c7e953b73afcb980258a9ff8fbffe89a7542d6077feee77eaedc7de7c377bcf0b105eceffc9dbf738db6635c8789f97ce3baf985f978fca9afc7dcdcb405ec2098d9158e636adf8221260308ebededf15201a6167ea02501bc70793a3ef785afc657bffa682c2fb394d0abf87e6c61b0f927c6659613530df312c1dd28f9f38ce836ef90954c6aa87856bcc01141ea907061aafa8e340aaff87345306a58d3a50049788a4457012223796372ac3ffed25b5e1fafbafb5669d2ad181a1e8889c949c5edf0520a573a9ecdcd0d5dbbad25a1c7b6c6abe48573192a6b647834eebcfd9e1bd284ff4c634126659a1d2a5af0631ffbd89f8bcddbdfd1c287c06166368f60601bd82ffe7ffeb9afcf052b2bcb12ba47626a9a813e4cbc63a6f7c233da496481699accbd2d0d474f6ec130d9249030967e9bec4c1107cfcd2dc4efffc997e28b5f7e20e6e697253cbdd210b9acb0c7fc685016dcbbad45c8934573b691794c57a48772c0855b4b82cae3cff8c88183b5567d4ec28c624d6cfce54fc64f2d441a50771a05a28189838423ee2c2d40837c2cc19150f54813f6766ec75f7dc777c75bbffb0dc25ba6b0ca6587cdd8e8883b909d6dea95f5ab34a4143a19f0a063a9cf10cc239347e3ae3bee8d89f1232eeb7a8029fa133ff10ff76d5b6312e6177ff117bfe3c782df91c2576732ffd93ffb672524016df7c10ffe3f9f73e9808dc98f3ff9489cbff0ac1914e6855d113e48018324832659605c98160662fd2c193dc381dd1d99571a476dc96cfcf2571e88fff4079f8d3357e7c5c830a0e2894fc5964e8753ceed3c30f3aa40521e0c2a8ff2562c8410e1332e0876a6f27ff92d80056c9e1adf5a5202792359c655c14c18d5c73c6b965d058f30ea0b344dd1beeecee896809ebee968bceb9d6f8d3bef3815db1babd1d5b91303fd7d322b8748e1743939037d727206c80ea074082aaf963f397134ee7de5eb95becff1ae078c037ff227ff6ffbb420c287107ea7ce887ec7091f5aee077ee007f6edc5646cf7f1ffdffff1bcda6e6afa6a3cf0d07ddea40c602a31e9201e906323726abca683410093092d5398977bb41401bb1dddf1bbbfffc7f1993ffa62ccceafca7444a88bc095f19a05a8a48309d100d61012381a00e6b490502ec2e7cec0499c26bd99d64c5ef000fcdcf9b2952c05a7e665844b3eb90658eeb9384d6a27e47247e3404aa2ce0e971076f5b28e285a71af4468c1d1a1def8eeef7a5dbcf52daf8d8911999812c28ece9e181818b48053af363e45c8c8af96c7d566ad8009a9eeee3e09e06b35ae3cedb0eb016340c682cd2331303f7ffbb77ffb3b7232e63b4af810b8bff5b7fed6be2584f7fef8df53eff7cf9f736cb729067ff4f1afc7f9f3cfb61900e09a9b8fd31caba6516510cc23180960619c49861cf349031661dd8c9ef8d4efff61fcf19f7c25e697d6259098584c94ec30c5811460d1d922ac795ba3304951c26afe488505af08222dc3631a285ba90414a875693fb3446667c17d366dc6279e674b1d5f02a66ba6250f47308e6850e388ebc6a500b147942218f7f68b5e5daaf9ab5e796b7ccfdbdf1cc78e8ef9cd8c912166457b637878581d1be6a534b9ca878e68401c5a957bf2ece9cee58b9d1d3aa31eb5e164bce6ded7b505f37ac08c28e3c10a68be8f7ffce3df7167cc7cc7081fe33b2656ea3b769896bffccbff5f0bdf7301daeeeb8f7c4de6ca7a9b590198db3db27915adb4276c550bd5f8384c41b18f044b02b6bbe1d948d6e97ee7d35f8ccf7de16bb1b8d80ac9b1e2698c268ada6c547ae2290797e3056ee5d5d40640ce92e6248bd32a5d969f0288fc1053d8244e04da84245461c4b52f6365bc3d338fbc00ee495fcbae754420e810f444e169163a3ff2ef02f714680b0fe3bbd0d858e666bf2cca9b4f1e8d77bcedcd71f2c4588c8e0ec586ccc293c78f7922665b4285f6a45383aea477c7a28e89b2fbfbfa6df6639e237c74406cfebeeb8e572abf9b5ce6f500edf7b7fef3ffca634220f9e197bfa3c681df11c2c71b082c9a577b1f33f3b7ffe36f3ee7a143d6768f3d14172e9db3294423d3e8301242603fccc51fe696c80093c0146612dde3af0e4dd10d638af13634cedb969af8ddfff4d9f8f41f4bf096946e9b891848a9f8ca878dcf95b4667a85531c8c4fcfeeb205dcd7b2b93685cf5ac8b132ccf9e89a8e3c136a5ef539407aa0e6cfb3e6f3e6b5297c8ad44e430c15133d9ec5a50cc5ed61e980a5126943ddf7895603d284afbce7967887b4e0d1f11199a61286be3e095ea663f693b269075e81227fa076741decdf51186d52c7c14734167ce52b5ee5b4d703b6a62180cde32dfee93ffda75e98ff4e80a4c2b731b02f9319cd2a78bc71f0f93ff9ec730adef4ccd5f8e3cfff7e9cbf78165e1223a51681b32d0674b50acf098664401c8d5e4d2284a18e010158717db315bb9dd290dbbbf1852f3f107ff485fba589a5f15807f76667b44c323eae9d56d7a630c074950109af820770c559581af740cd2391272f62643871d2844b3f0e7f75cd7cb85661040f0b250f441fe844fc3dbf3a9b8d75e1286daffc19a332aedcdc5279bbdda249672cab691e7cf44cdcf7e013b1bac1ce9d8e68adaf3b9f7d75557ef89bf88112ed80494f5b511e023abb30139ffbe2a7e3d2e50b4e7b18f08ee5a7ffe077f7bdfac5245c935fbe9de1db56f3413cb41d5aafc2bbdef5573db172bdf11d4cfcd8130fc7858b6c7c4e06036a6303f4f255a8cc7816be647ed6ebb8a29978e70ee01e06622b169ba89944f8fa13cfc4c7ffc37f8af397e68357eeb6996061c8866033fb2926cb92054a8fc8b3a88d7949990303036ddcb86eaa5c16d7c14d18b9cca603f60b10dbccb27edcd72b71f05707d43455000e423bbd1c0bfee4edf1a0e26fabce845322e94d2fddfb8d0c65ef301190cde10c6135dc8b37bef6cef86bdff3d6e85171cc608e8cb01491ef1a1a441bc6b5b401e92d9c1dbdbed27e148690d206cc9852dec4c464bcfa9ed73ee758f0277ee21feddb19c3f88f71e0b7f34ce8b7a5f031ae636285d7802a30b6638c77bd6584d9d99978e0ebf7c5eaeaaa1bb242ad5e9331eb3de05b09063d6e0dc3dc63628571186314cc50c66e080faffbfcdb7fff5bf1f8d397624dbdfece2626a6185f9a80b150ee9744072210cece8c8a90c3d4cc2c0e685c431cdec14379e522bda45809ba65aa8133f8c088121dc595808a31b16a7164db161ac7ad1a11c8f8fcd5f289d3143ed2d534953e408704a4aecb2154db7422aab3677595a1c3e50843246d822a5b04b54b787777edc4c84047bcf6dedbe28daf7b95c67e4763747838c78a98b6d9d3990e596e96636ae95adbe7605b01e471f79df768c871aa845c0b4cc23019538119506642bf5d17e4bfed848f994c96129a2fbbfedc07ff7bafdf5d0f2e5c3c1f0f7efd7ef8c38240430395e9e86581dab03ce76a5354b023cda7d8f603bc83b74de31347bd2f62b52e15b72161fcc4273e1df7ddf76448d6a4ad2410725e2e50596615a5ab7eaef6935797c275456b0c0d0e19af41e1c1b86997ed698c091517d1cdb11e33b1ca5b38b0d0bda9b231e7d679d36197dc1db3949169a901f7c05ed9960e8755a83871b53015bfb79c296f263f3a3a341e234ce0f118b4d08f45791566c173cfa1b44caa504e8fd41d33c77d7d9df1ea7bef8cb7bdf19eb8e5a663c2733706fb07d5d930f6738e6a13ca9646b4b0677b804b85a600566b05ffe953377b2c783de0ad79b460353bd17c08e0b7e32b4adf56c2c75202825777acdcc88c260be64f3df364692805a836d4088634532888296f7661104ea3b2b3846b5d60c79c046a83b3377387ad5a627876fcef689cb7bab116bff7077f1c9fffdc43b1bc221d27214720e491f06d5ec3c8464557fb410c86950052768ff0628c3336d01703680f0911762bfb26d929b2ce4e174c2ee581b0a2f5742b71eb141edb1a4f6df9fd3fde94a0b351c116825a1ee03205dcda35c20070dd879f62f0532c6b5fac07ca8446081f9d8127ad84670f38a3fd082f57d2f5f6b2b54ce97637a2afa723fef25b5e1b6f78dd3d7174622cfaba7b2d8098a829683919b32321ece9e9551ef22b1c64dbb8cb657be59204cfb03e8e1c391eafb9f7f5fb84b509cc84fec07ff643b2a0f20d09f8882d69df6e2fea1e8efd9f01b094f08e77bca32d788ceb7efbb73f795dc183091ef8fa57e3e9334faa0d6122362d73768918473d3066627737337808216324359ee2b15cc55be5b9b89e02eb4617d4b1a01e860c30f3349a87c985071e7a32bef6d0d3b1b2b663ad8756a8631798a53242657ef2accc0d1b75887131867b74dfafa8e30312befeae18959618d18371f987751deadeb17f72a0dbcf063bb6f57c37c6fa228665d68d8a67793eaa3a8ef6f5c4200cafb2bba4b1eaaf02e35e6baf067e95b1c1afd6bbe26f273f75ca353ae12d1a6d8b5edbc53ac8fbbdb4a5ba825d699b758d95d1e22c1b74c5830f3f158f3c76c69d05d1d6d65a6d1adbac06541e6d41fbd161d25e740256d865d2874e0bc1b60217fa53d397e3be07ff34c78887009b2d9894ab875ea10519c634e70fbe1de0db42f3a1f1bef77bbfb7bd8607d17efb3f7ed2339b87018c71dfd7fe34e6e6677d5f991c6140f860261a86debb32198d5ecd51805e9cf80820c61e820b5472a460b1d77237a6e65bf11bffe76fc553cf5e95492ae653f95bd23ab24d15af69feed394f5ac8e9464c23734c45f7a9acc1fe9e18921b1f1e8811090f02c911803dead1731e43794ae5980555762eb8cbd49486605d518a4f26b0185df569098fb54d098ab4342fdeae4b039392f2c0813a7bf9435ccb7d858a178c4f780a9fc2c4ec989d2c63384c63403d6da7a971fc2a12618c598be6433b4167ae98a003fdbdaacf761c9b1c8cbff2f637c5abefbe238607fa5360f47c787844f9b1ee47f9d931009463fc04494bf2cca5992af05580d1686f79d3db741d70f84140f3a1019b3b629884f976d1807fe6c2c7180fc1abbb565842600def7aefdef132ea97bffac558595df13d8d52abc095de9b6b0de79ec66a36284043fab97a55dde93e1bb4a643f01617e663a7a3277eeb539f8b071f7936165b5bd2828acbb4bbcc503a6f74ab38c87992ae32489d54e0ea719e34d5b0cd4c09a24c59fc43d2cc9d62be5e3def91dfe33f69192662d030e0823cf0ca0ea6300286e9d9dad8b2f9b9a2eb8a34cdaaa4d202a87af22e20dace8e3a213ccaa732acbc16274ccaac6be26b13d22492905958f18243312f0b3e08201d97df3354b8f77e2a0c3a7be6d2f9e4f6b90175329d1d1b717c7220feeadbbe2b5eff9a7b8d13cffafb3943466adc65a8609547bedef9231ca0239d656d4fd3527ea0dee310f637bceebb626cf4f019f0d47aff557b633602cb18f0db6137cc9fa9f0a1e93035ebe40a1a0f73e17a82b7b8b8185fb9ff8b5e06a868d7c6a1016b83714dc6daab5a7dee8616a44066436e6df3ca4f32688e7532deb98b57e30fbff095b8efa127a455a44dd7c5fc62f8cdf58dd8d2b88c9c308de01cf2c135cb868d588ceed7386840c2352c66942519ddd21cdc0ff5f2c64087c6476246de70602c25e64460a91775f164838a60dcc71bb05b1234267ad40fc4f27a0ae0a2041021dc44cb299d30701c74f2a6f293fe93a98ca697092ebcc4eeb984a0e8b924433ddc8d5023d300a00e95e12bdd76113475166cf8a6aec655f12d78aa6b5b40f4eb1fec8b3ed779375efb8adbe27ba4018f1f1ba774e1a1ba6b8cdb8939294debf348d5e1e56c2b5bd052102b1daa198cbf42a53938bff655af8f13270e7f4d0901fc81ffec87e3339ff943df3309f3f9cf7ffecf7c3fe89ebeff1643b5c3abe0798c2753f37a8277f9cae5f8dc173eeb697933b77e851f7c4578dc2b8bd9789e8ea730108cc620bf30901b2c594d2ce46b155c80c7bca5f0f5479f147e4fc95492d0e114a736b8532bbb3d06d80333b9ae085e9f5caf189bb119932b9de027f37040c2363234e863fd06fba511652ef75007e5d5876690eb153ebcb2c4e962837a3e2021c66c1d1ee88d6109eec460771c1dee8d9b46fbe3d623c3716a7c288e0cf5c5484f478c2bee90906061a65355ec12b37b1d8ff70a35f0ad28338191f4cc7a03b54e307ea5a53b2bfd1036e80020702461d302636ae2e000447c1dcddca263d88927ce5e8caf3dfa74cc2eae485b4ae3a9ae98a0e4e9f8d6c0b453b62bb4cbf6e29e19cf26ab56fc945a8e09b3071fb92fce5f3c579eef07b41debc3751843a7cfc45e738ff09f05fc99091ffb34eb3a9e4d01999ad71be33d7bee99b8ef812fca8779989325f8192a6088f11f338886705b32656e27d6f0fdae670689d7d52d06928c7549f3f8398f89e36b6e0266aa9d838cbe7aff23b1b0b8a630a5649fa29e23dc38cc55b41e692b835607a3b001198119ec95a068cc32a0b0edb5d5e812fee3c3fd312ab393f9be2e31d180e2f62abf6ea51de2f51c261814bf5f3812deab7af50a6fc99be2ecf83a2ae11ad7407242aaf4e880ae3d3b31d6bd1de392af13ca1f413c2d7754da674442d42381918ef18f711d7569e20ce9aad6aae0f02280296869ce56e1ac7110bc7a0f384f5d59fbf4060499eef3ab9bf1e83317e2d98bd3369f29908384d16868bab444b221f0bb8d4bfbd141d2d61e22282c7fc4a74c2c0db6e76dc6134f3dec77340f83dab9d74918048fcebfce33fc59c07e6a7f8b80e31e9a47f97dec63fffabaaf033dfdcc93f1f0a35f571b6082b0d3448da9014b274770c9cf8e135a686b530c80bcb9b5d48396ed5e621ffb39469db70db679e9555a8070f2240e0c50dadd0c303d331b9fffe257637a6e59513994b6db4b001beb2cbcab0310a36539902f7b6b3467f6c61afb88b1d078380b16794bf807e53f31311a4747476472324b19d6882960085b0a21932f684184d15731580f4ee61b133738c68708e7b06e86743f31d063419be8eb8a51c51b96904eca7febe4988470242607fa6350f9824b3d8c095785a6ca4e5300a91382d0ac9f62b6d3566b018716c311c615b9007fddc45a390ceaf2d44c3cf2c4d3b1b8ba6613d587059b8e1587bcda04166d693796226833c2fcba94a2643b33bcd0ff4e367b33b9238daefbf3e7cff90d96c300c16bee9062a20f2550d704bfd5f02d173ef6de719c5f85e73a63e5e2a50bf1d8138fec6bfc6498da50ea75598b53cfc9c01b26c89933b85d906de9b8443763293d3d3583fbda926832d263fa30bbf9079ff9a378f6c215f5ccf4c8599e271e3237e300544dcb3d79dbe97997aebdd2145c11924ef5e2837d3d71646cb86836b462b767fffa24703d4a8fa6c3c1b03877f24aeb7b0450ae47e8db8cf53d42a47b953332284d8aebef8d7199a4b246a56925d87298a047658a9e92009e50f92c4fa059c1ad8d7371742895d6d5b99ec221e98e20c8b494a3038430989c394992dbfb2a401a9bcda4553c3a3868fbe4d3cfc69973173416459ba5395bb791551c9ae5026e7ba54d9cb251890b9827f4634db7e20edf3c7df6493f3f084ce87dec63bf666b0b60898b6d8c7f16d0f573dfc21369f82849b3a2bc798e3b0c6666a7e32bf7fda9889c0dd06c88eae78aab8d05d446a961356e0aa04c2ff1c9f60edf4fd03345650d0bb3a5b3433dbc02bff6c8d3f1a5079e8c2b732b123ea553f9367230773737bc2c50d38a259c468a560ce8be58cc26a613330e48287a641a0d74efc69054dc91e19e1895c031ebd92f1cd0887df2f7c89c6c0b9c4497056cd6b5a836e520ecd408b6e4205bc24d1231211a0ccdd82364302959cae8515d6c51db1493a9bdbbe563010947e89881847fc5f3544eb98b7e38773094b7079576d094ce09801684fbe55a9e8347113e040481b430280db4618b1a6360964fd052d8fcf3733371d7edb7c6c4f868b4d6571d37db927c489df911de34473764ff537e8f4c7984cd8bfe2a12bf22e989807c948eb379c079f4900fbebce21577d9fdfb7fff71dfa30199c4fbfeefff7edf7fabe05b267cf57dbcda3bb278fe2fffe52fda7f10169716e34fbff2790b10da8c3538b5696a3631184d41188de241b7b5dd9e46b2802abc0ed8498c9983c6231c4d0764e3b24b9f1e7837e69756e30f3efbf9387f692e985ccbf32e959f18677363dd826744805216ff719d083642a0fc11827ee12aab4fa6a1185e42363eacb19734d09034d38084d0a6a584a1bb389899b4ae0ff90937caaf8ee97fd7d77ee2e795b88c31117e9ec37003fd4ce248abf6f645b7c69bbc25d02da6f7f84a42ef9d26bba2ab34d896eac3c9d8cc5e2a0be751e958817b6b185d2d54d05451da5a48e5138e395e8525d7ff32afda8e908e1768579617e3c4b1c9387674b25d5fb6ad61c110877da20456417719ca1fe7c8023ad2cc57dd4ec18fe7d5cf75767ed6c2373870ed01beaf7ded6b3cebf9a9b204f1c77ffcc7c139a16f79cb5b7cffad806f89f0d1b3fce00ffe602c2f2ffb9e57407eedd7fef7f6947613721deff39e2081c0a6b5c63068034cc4daf038c24c6864cf0d95d7eac759707d2f86250f411dc7645cfd57be7c24e4735fba4fe38567637171c38ce417471597c13c0cac88ce879eb50dca823b340f339368b07e315e9f840e37a831d9284227edc7e23ae6271acfe6a69ef58879d86ee6b44ae7f7e4e4c7510e0c9526a234224e95f597874ab89dca4470104633287593c3f4ed65194342c856399c38569d43574c0c71e60a0bf31aab09f7b413321d75f49dfc95912bb8fe0896f080aebbd2a8d0b31bb3bfd99e64a51f6d5cd3fbbffeb1d56f7e7e266ebdf9741c9918f3e7ca380b94c3a43023b2cc6c3fea246352092b2ee085f5533be022940da8560f303573551a76d22fee1e04e61916e617fce96be0b77eebb7fc11cf6fd512c47eacbf0950df50a8b34a076dee26d0337fe5fe2ff93875db7298455c7774f5048a548907e2f24958304f36d9f2a1309b2abab22450ef7380aec6535ad2104e4f5b99ca3db7ae7cbce4d2d5a9f8fa634fc7fce27a984771ca8b891cd6a1c4d636fdd0206d6da47bc633988b10d2a58a2b102eb41d6b793d32677b3a399a5d8227c772411f932cbd8c0bd9e3d9e5353ec258ef8359d1125cfba4b5fa6462f54a5b60cae27ae4f8fe02c28b06ed6789024146d35ad048a7b2d0800a63961553f7c8f0601c1f1d8961a5eddd5ed37870338e8df4c658bfd288b48ccdc01f8036c041210408235e2ea7e8b92c06cc4d66892bde80c7d58a8360221ca6b71c9327bc0738bbd88ac79e7c265656f8362182c4440d63f12c0b4b04339571226d9aed8f2b947607946555fc28ab76ac75490a1c1e78f8fe606bdb61c011247c9daa02d6d9c12f587db3e09b2e7ccc6cd6f594dc36f69bedd9a626600adef7c0976361a11e177eb0e15368007a3b0487c6aae09e58cf2bc1b3115441316bed19331c2dcac44c6a09ae34fcfd0f7c3d66e6966343cfd9d18f9021586a7d252c0246fc624a55402cb9470379a70a79ab9c8edd6d0941972755469869949078b9004153387b15bda54ce560366276a1f598f5aceb7b08b2724b8da667945f1dda837ac8eb7122f9716e28c28a40e66447ceb8d219a075272480a78e4cc6f8507f746eafa883d88e9b2687e3c850af84913a643db24e7b75ab7407103a1ed609ae4a434cf3f53576fde426017e580b5bd2ac350e54a30d380e7f43163c932f57a7665c77e5acb40c2fd46e2e29e3faed763daf3c00ecf101f81dcec274067c74b47606f73df4d5f690e7207ce423ffabdf150598f9fc56bd8cfb4d153e36b23637b37eecdffcebeb2ea23ff0d0fd313d7dd5fedae0341af4f6b53409e1b824bc98c50d53c353d8f2c5cdcc83381510323e328970b90c99334c083c7dfe6a3cfecca5585de7d52109b5c2bcbf5271d170f4ee64ce04026324cf94c29c0af6d62bfd58afebdedd8aa1aedd1894c663c285a585c9e1fe981cd1784fcc3f84602014c2af5b38f4a8e766019e4ddc2984d27a4a07c3a4069400dae999cab19022e0126087e91e21484787215ca4a5c11941ecb559cbb20726b13a83aeed189565777c64405a703446449349d5e36609dfb17e8d05e5ef41aba0e999c6d7bd8551f54610a0279ac927010808379ee0063dd519725a9b3b0c5d3b44c35d593384836fed14bd562ada4dcd2dc4d94b57635e6340b6d5d169e9a15a45694476a1a106555eaa33ed44d9b46fed7c756b9c7040f5831796157441e0104484e9be07bf6c1c0e0271e1cdaa14f88c1c27287cb3e19b267c68bb83339bd75bcb7bf4f17cfb5c3433e12a88946d62c2edd09830fee3522893e81095066ea607885f275e3c09e3e7992fbdaafee2c1071f89e999f9585f57cf48dba8a16934deeb63f11e13ca0c56980c5c76309160423d632941ca47da2617c2d9bd32dcd7eb258021b93e0902c9c00d0d76ad90a506b99e6b0be0210e614c57f24408e5603cdefc1e603943b870168a1d1d809ed1091c1f1d8b313d1b57fc13a383313e20adac7e8b19d87cff104aed4135e900fe83dbde553ec5f7fe4ce1431841d091594a1fce8bc4293dda13416aad6dc6c38f3d29537fd94b0fa2a8cac47c4c8d979baeb3343a17aee000404b70a96d9f429d829574491ad47808fcc2e2a24dd0c300a580095a81e5b0e6cbdcdf0cf8a6081fbd4c73f1929d2bd77b19f6ccd9a782af01e58c26036911b443e309866b68181a44cdd2094368ec6439220e52e278345015d0640433b9226e6ec9ee574c188934f003df29c8d78fc8bb33969656e3f2d519330263ce5dcc4e3de2b524e2f245599757cae0a760f7f00872977044e05800ef61f789f0617961a0a743e6669d6011538be9f3cdf52250b8e2af38c334f5bee93cd1a2674de7f0036129cc6846dd4bfb52872ab8bc3fc85787fafbfb84535f8c0e0c68acd7e1e58f632383714463bf5b268663421a908ddfca5e95d49f1c6559e874e33199aedc6320d2a1f1e115b41351f4e738847928203a7136278241a7402b6155f0ea51684c373dbb1857e5d636777cee0bf9421726b9767659124a81237d1d425481028c471148807838c2ab3056de20af99d9ab1a6b3eecfb83c00c7cf33c1878b8791afa4b0ddf14e16321bdf905d88ffcefffeba1132c0b8b0bf1d0c30fe5110ca213836bd3547eee6174ec0fef5e81bef2bbf39449a426f7bd7742643b78ad86864862a3e558a61083288ee313a61adbec9143009f7aea4c4c49eb317ca44cf7cef29006bcc04522e06b8eff78260651462c2d3096635693258521a90dbfadc00ca7987950f7acc3310162c1531a3be1671cf58c2baefdace1aa501df6ec70a7f865224a39ea1eadca8bb1cc442290c287c91b34a17062d9035c87257027a5f94ee87a4a26e9b84c6476d458500a6dc93fa94a0388a6f20b33fb7d2299d4a4c76ea21f9bce3d21434fa93f04697d63c356433d44181c699bf58d9db870793656d7d62dc8d97e29f9c8148e7b0b7241069a549a019895403d258d3c8caffc08600a27f1e9a07ae2e2e58b72871fccc4d7acaaf989e031fefb664162ff1202cb0a1ce55ee17ae626a6dcd71efcaa080a5727f0ad826acbdb2494cb9d28495013bf3400e05e8e38ba02f4fcd9e3a570b971d4f89c8fe2387a86865d5d5d7183f109e6c71e7f329656d6bc09183bab3628e5e16c22cad19008a64d260ba1341d82a1de948914661e072578ec5c617283cdcf8cb772fd0d8661bcc6ce7f318e1943c28193bfbaeb09615d72b8265cf19bce5acedaaf38c6962a2f3fe995e62d428839d625a1eba5b390d08db0d7549dc511e13ca1cee418df711723b3c99b5e4fb56e4ff84050ea8f39092d11665c150cf000a055c551779e8c212df8108220705a0047623c7de6bcb41faf6fe5666bdadd9681e84772da8a0e0bad5ecba940fe944338ae765800339e98de3c0757f249feda8dc79f7ad4cf0fc241f393f5e96fd64bb82fb9f0357b8ae732371f7bfc91989b9bb550c0e455802008c4a9cc4f235ac8e468184c43a0a68331f27edbc485c8d9e8ca6307e2d2752aed365a513db2b4991e45b798ecf2f4ac17d45756102831971945e6910488b11e78d0b89425af816b074b088ac31b0a43628811b4881ad96f95cb06e528059b7dc493a9e5c5776961eb23a5a71c2f2e17cdb7c7a4ca9bfc8923477c98d071f5bce96a2fde740818c28d00e230057921d6fb1f3b74151e9e41557e98a1bc78dc2b1c596a18ead1d86f68344e4f8cc589beae38aa0e857da292499507522a93ce4471d1fc1e93e9c79a1f2da718a6576d2bbe8991e54b1054ae17f4d57ebb2a8f9304781979133373a7535a6f27ce3c7b55d72ca74be6666707ab8f8cb5d5226a0bde9267769bba93bf69253f5ad6134caa3f1d2254cc996a8dc15547c6e66eefd201d55972daf19127ae6f7e36b73c32f9f2cd303f5f52e163908ae6ab703d73737e7e2e1e7954e6a635948448d71440098a1b1033012f4c9f8dd914348f0788234aa786cc7c6052f242d371256df6781b66789883491472d952ba4735d85f5e610b96185d0d468390c6efce09d0123430e592b67219fd2a82c7c6669cb76d697ce5b71174cfda1d3dbc99ddc28360a7233f20ebe2027d4ff83ea734f2388aeeae795e05f69a705c2d530e86ab1332b83463533be052334a1bea196357366a9f1c1f8a9be426d4890c22d82adf134c62dcaa41d1848ced984cc14fded0a80a605db363f1dd78511f416f7fafdbad5a02e4455dcf5fbc14f30b0bce8fe7e443bbe298b965bcca4155dc033c275f3a997ab0aeef5537c078a88d09c32f8ffd5570014e42b82413f43060cf719d9947f0be19b39f2f99f01d44f0bae6a688f7a5af7cce93211b1b6b12120e1f4220682c395d7392839e158dc5c09bd788d8319f57f659a6b94a9abcdfdc5a9363c09e7958104be3d1f0f4c48005498d7bf1f2d53877e192cd4d1a9cb23073101634a4cb9580d14bbb13509ec461070bb39b7e2156edcc792c7dea5a7b14a75f65b2bc302086eb9726a4374ead87e01d141484474ee5ed0bd73df8e2af0274983b7c0654cf5407f84f592b1e9d4ae6e367be2a9eaeb53cee2d04a289fa8fe8ebdcf61b12374f0cc7e9f1e11897361f555d0654179620e063d2383d42296686b97d768e9c3b2c9585e3bd3fca04d07aebeb6bd2785b1696daa1324e87ba7c60747179c97edaa75a1eb583862e08da41b06009aa50521eb8118ea35cdf17a10377e29027ee89671ebf21f313d3f3a59efd4ccabc04d03ccefdb9cccd871e7e206665df7bf244f4e0cdec7c1d480d29fa790704131db440c3216bf91cd322b5d4a606eb39e9a24b9954210eaffe60a6a4899a420820801c04cb3ade33cf9e8de959f5b48ad2d199af2a410e725787e9bcb8475b913fafb68007b1d0045e4ae8939089820332d186a52558cb1b16b3f276023b51707b339aa4dc031842ffecccc86d97cfaacbb4d713c664a4fdf77b9a8d09178ea04801df8b8760ec4f87537ca531cea20f753b3e3410b74d8cc6a454e2a03a9811d5ad8b0e4f44367eaa135798dc7471d9ca5fa4c26c4ee1c90370117e3a39b60f020c112c384a8f86e41bf497a7a6647aae391ef173089182ce8c2940fea46b5f0b5d884359ce53c03d34e09ef6af633d80708070f078f43ae6273b5f9abb5f9a3cfe52c04b227cbcadd07c3fef7ae6e6f4f494cccdaf2741d4808516260c40380d414b32e8aeb639019578ee054de84ce3c697bf9a18f55e4d6286d0ad0142bb4cf9996879f6ec79f5ba223eefe7393ea5146da9728948584eb0d0395406ebc8ed6098975217cc66f2163a6f9bf34603af0bf5ca3463cb57ed651140b4863315e04bbf5c2142c59da795492af284930f1d016695276dfc2376a6dbd3ac30623aa7299aafed086fe457f3d63f65a67be34e07c28c2def0776c7844cd149964dd4c98ca85dd19cc6abe0607c0bcaf5aad632ed78061d3cdea257538a14c6140cc21036ce9eb92afe40036e306c503882473e741eb5dd715b459be12c48d441c2ca3df16843fc691da5c0d251900ee059a507fea999a9b87cf5929f1d04b45f353fd97676f09b90df087cc3c2474fc016b20acf656e7eee0b7f146b1beb6996405011969d0b5b120a9f4d6962a179c4f07e8a602601011a4bb4525ef9e2a61bafd128f59e679ea45019f46c3c23dc1f2f915b985f8d9525e5be8d29258696b71badc73885b35988abee5bbca842e59709da21f3587ad502c708a35f697ae506a515381ea24f66596f0f8c2973d3eb6b300feb93ca426a00bcc5822e872bc73ae406e9a22d5c1874d1bd98bfce8aeaa19e6116f64a587a9499b4d98e34b5c27694b99dfcdb72bb62703ee965271a0b1995ad82a1053477188caaf2abe089de38f5258a8ec0a495c08e9d1eb5006b814706fa7d2cc5e440af4deb7ede3a10fec8522e6720244a03ce545480607bb283f6d1bdcb56da7559247512842b1d9d0c73b55d973ae779858956ca17e1a3ee3ea84974ef502355d31997bc208112be798a81c2556f059a8f70f5752ff3931cf855fe303f280f1cf0c8e30fdb043e0807cdcf0f7de8432fd9e48b28f28dc1affccaafb49161d3f4f5cccd07be7e7fcc2fce8970fb7ba0d256c89c89ead3a2edf688839993bd5812aad0cb04ac828843d0d27ecf89009ebb81f48c7cf828e686eccc85f9c5585de504eaec25dd20ca876f26d0135b23908bcaf5c48eca66c68f71114cc9ba9e9716649a0d4b3b70f2188e9d2cec26c9c90d09975c7602e4562b6afed8bb6ddce0dda347ed9db363711cf05258ba14ce7d4ef1fc73d44c979a2e1936e95dc2758f06ac904ca83ac2c0f85d5f6976d5c13b77743fa4fa8da8be43d4519ce33725443f2674100cf240b0a93f3427778ffb104e3d23dcf414e0af8020aeafb1054cdaefeaac04adcb7c401a5c0ad75e47dc14beaa416b3b5a53967ab5af8516357ef379bb0ce17bbdd94f4ccf3afb89b2692ea57d23f00d091f88d01354f8e007fffb43cd4dbe91c758afd45984423098b9ca1e88464fe1425bc004089e885f2639d25ce407717134a0e2d345aae5d88982f3b92aba722a3279435cf2af66080cba26e17bf6fc6575044b3675b6548ef390534c51447ea44c0d623349e9415b4d167c1699310fcc98871a617eeadad363d3d3c7ffe9596e21832153ab5526f77f1adcfefadb0fc6b3b8bc4f8db1a39e1f0d2a0484dfe10edc773b451fb859c9325c7955410417e3b32788157caf675c11c05c24a7a3916697d9398459ad76600336134d1cfecb3b8cf9ca15136169abb086984b0c1210e5cb733a352feecbdc5449e61b848fb898b89cf88d8a5adbd88e4b5333deedc2518955c8aaa0012e4bcf080308aff7c94b19d604ee29afc6a9692bf09cb02b572fc7a52b87cf7ec2db155038cd59fd170bdf90f061ff36b5de61c741c0f87ff2c5cfb982695ae5352738b2d23c4b4213461c06db303f8427969e2107c89ce2e0bfd6a911ac2dd364e14ade3870a0d1c8933d9c57a666634d5a30cd5bc5030f76cd286fcab239281cd9b5011feb4ebf143e5e9065569037c3595ce7b4e87c8d8705ed143cb4159075965f0ecd00737bbc55ea5b9fe3af82da4e53c0f7e48949692704dc7b8353fdd990f50f3f3b7bea13a5f60f38c874c0c1b252eb0b5f266b14d62d01ec57bdfc82b028352a8141100953f5d5ffa99d445b248d0de3a4a17e5e92707d647eaa5cb6b55147d63d690f8481f2d4423211691b8dfd3676fca6c352ab65c1acc294eda87c951f50b517cf9bf8575eaad70aa4232e5651f50307d392ef53679e50bc6bcd4ff8fba77fea1f97bb7849b4df8b163e84aea9f59a7671131e7be2d15858e45d3e2aaa6675859b954e5727509a404873913d5d360472eae738fd235f8449eca39e34899b1a2f1b9f6734f8c2e24a2cafacea9e664f66c311d7e30cf2d633cee6a4c7cec9178d17943fcc8690f9643118505a812b931339a52f27d9a0810f3a0b8bf200cf66a31b845fad4392a6c4235d71cac44288f059888bf333d214e7acc9ab3ccb38e4057e259d3b88c35de64746e4230aa9c763443748bd09da6879dc57279b303bb7a5b176447370868959d0deab6b6647e70770fa34906d433129bce0c78e97d985e5989a9da3026e6fd2910fb4cde1072d9e809f7c8c37999530d21186bfe24418c255af356e851ac6b8ef7ab39f1ff8c03f695b764c307ea3daef450b1f8257a75dd178ef7a67be0fd5047a9a871ec9af8652e96665f1d7fb26e1ea1567c2e9110e664881a3a794101287b8079c4a29f1d084455b76680ca2c09604697671315634de632655cd1bdd4a44efed7520e5c9963184cd66afa8c3266fd0638cc33b767d628a3e3d1fd0bdfa70e634d470a9d9d2a5df8bec8a5f351d2f7f7674f6d8814fd3316102e3edec327e518608009a873476e4b3c760f208373197e3e1944ecfdb8e67c4294e892d5408af276008232b1cf77e2ee780a4bb972b58db131e6852ea33d0a7f1adf2411b72fc616f8f3a249901d46f9b892dd1af973872de584d99e050da131e705d9427136c740294b7a3b6a1df631d4fc66c5cb834134bcb2b6d41615d90fa6f5980e958c96f6fbc5e850f3f901d690e359a3c55e3555cb8725fd3a6bf33ae4c4fc5e2d292d33581c997f7bfef1f94bb5c7af84680dabf6040eb61f75668dac34db8ffa1affa85c60a54b6e96ac52bb108db8314272f70133f03db57434621967e25debe3cc87b4f5b32e172f9f254b4d6d8d5a2b2492ba2bb47a58757e3d0086e64f1a1cb762e8c6f600b99267ade2fa694488821c588d27c3088271de4d0aeb9d52b9d0f05927367d074aab78543fe2cc128a945c4204ca6284f9b9856a54a6f016b38371d57f24f01ac8ef494992e190a41a894f155e14c84c0907b2edbc318e91fe9bc4d0d4192df3b65545f6f2cd773f6b526ed92f68cd3484c5a2f13280c47de9499b461a245770a67d70a2dc75f4b1d39f44333f2b9e7e5227c953f728f6ff20c90bc93824619c46d6ab69a163fd77a5fd336af3cabcfc1139c9e3afb849f1d845ff885ff577be9819707d8fbf962e14509df41ad873d7c1010bac79fe000531a80c68148397bc8b586e7ec1744a5dac483c879adee609ceaa403e59af1c91b22d2a0f9bcbd234671f8be036b7c5b9b62081893686a38eff92ce9d9bac69576e199194d52c168862585dc3e2673b33fdf91ab0c952e0531f7554af0647e5920c4b83909a23a974922d781ab1c610e07a12248165a0b92eee5b716f17d716dc14a2d753d97e9b2c737b3f94a312970e05b852fb552114261e3bc798ec01056ea27c2c8dc1493239c8a497cd351d6045bc02880a3e0a9258e0df3bcf9c0380e3a5918f500cd9a6361e5a13429a82900cc5cd35972ad9d33c0445ab677f211e9499769b39ef81126ae00614d21ac8286036a5aae4ceed1125766a6627eb19eaab007989d989f153efce10f17df0b87172c7c9cc572235aefc187ef17e1728a3f818a521c95ce6bfa693c88464f0971201c048188c958c4219bbd499aeacc07826cccfa9cf4364b758f9f2d4d68c0d9d985989d59b4294afc6c50ca43b0613a3116217e6624c45c12368573e810a3150e44628633351d8c94cc9bfed410986ab2bb2c3c98816a6afbf540a50927e553ba93749eec2934810e38f290dbf1bd9e29bd275cc847e551665bc08423ce132d354cfebdb08c0f03e65e4e75140855094bc64c2180d6d40521f156319c18bcab97978c92aeb2fb35cee33522a1a274fc0033aee94ead543f98bca4217f989e8918fcecb74da6a75bc374cf307621adac2ec7c202f3042a40b0c5b84f3fe7eb7c689f6c5fa00a673e4f41c3513fc2aa030823bf1ab75e71e04791d937eec6a34f1e7efa35a667d57edfc8d82fa9f602803d6e37a2f51e799cc36ecdbf666edc1ec064fa4bdab581fb83ee20649ea581d51040f666fb89acd4d976c4d7855e797a6a46bd2982988d97e96aa3d1a87b789ac90a0e3011132ecc6efa9c4d989448fa474f5dc778c9b008c89e2055814913d36d6a26f673c0c5553f4c900293daaa38840926d55585a55ff95ad01a0297f70ab7cbfb4aa326649112cdc2a0071d6021723c958f76017f882167c6e60aaec2b90a990869e77b3d6769c1f9e83e2d0b3d2f5505afaacd5c67e1babdc97d47b0e97d6a5ae3be9515a7211e78d199182939df831359eaca3df1aa600155282d54827a252e71b8aff5e51e2d5bd3029cfd7965ea4ab9db03b45f73dbd92ffdd22f15df0b836b5be639e0e0badefbdeff0f8b6f3f3cf0c8fd6230f556eabc599ba2cad5d159d1202c0b34c763543aafd7bada629530109bb0e6f3caa819379f5546dfd9de881d1176696e3536796dc5f189970297f93823873b8c86228382396b5e6239315c0a409db8482650b9ba328eebe866d73eefb73937fd987dddf636b6755dd7c41c2cee6f286f0e5edbdc261f8ed79596c3ed48634ac762e8aa54d14b44d4f3ce4ebededaab7169bf84a6df7ea9a3d855793bd2b275b70bbb5c3430f375b784b3fb654bd86fef4a1831a0099746db713d9800c244ee537ce555f2210f34af1bd1e5934e1440c3cbf47667235ae446733968a0f6c41c85261c5bc8f28228ab76e63b877c2f515a67734db4c98df34ce9d379796d107a291f8e80df929b5e588ed67a0a03df43c404a56c5b122a738b3692df5f4b7229d0324dc6cc4a3ca02bcfb9d29935db187f76bed929e02c947a5ee3717df2cce163bfe6cc27db2b5fccae9717247c0777b3345fb9afb0da5a8d479ec8fd9beddeae0064c81e754fd53bbc5d595f047b02d4847acf35f34f77185888caf80fcdc4d202eb48d61e05aac0d6c6a8bd2457961b2888d83ede4f63187f0e99f8683e3514fb2c7b7afaec98c524f6c6e68e986027d6a4619955e57c92b9a5d5985b6cc5ccfc9a7af3ed585add8ec5a5cd5858598f1595b5ac710cb6c486189a15a60d15bd2512eca875d03aca5ca172f45c72de27aaf2711ebb15a1c86508390483056dc7216ed21a3a1037673dc5c83826857a062cc81ceb606194e031b26ac904e45b80ebea2c30fcd06f38554f82d4139cbe06bbb6c7da2a2ff7e38a12c287e5976a11a029b132d8adc2bb9034fd963aa2bebe7e6b52252fc74da429bab0bca2ce09010513fabb9c2165e78bef95a73bf1223cce50409ec471b882a837bb9d6853f06b02cf08076cb5401bdf653ec0caea6a2c2d1f3ef3f9de1fff6fec3fa8946e143a84f8e1dc7b08bce94d6f6adbb71ffff8ff71e8a2fa97eeff7c7ceda1fb5cd1646a424b95e067b3a81a4dcf6a459376f56ebf3f07f3e927b8daf984a5d649c6a21ad599d08ac6e09cf236773644c0f5f88fbff5c7f1e45317d518d938998edecf393a2d8d6fc2d3834b7047faba634c8c3c39d027d7e5371746067a6378506ea03f468786dd73c3e8de142ce7057c18478cc86e7d66575b12ca0da93a0417dc19330e0d0d88f97a741df20e10b6a68d8d8c29effe18ec43cbb29ba6474ccc76ae9c19747da19c70ebf0240db448dc2b2da07d7620aa03cfec2f7451d932c62444624e25e73437c69c7c07be252665ef2d67a9acaeafc5f26acbc73cc842170dd9b2b76dedb2a2fab5e45f9150ceafaa4359d358cd42aef690408e8c8f79326a7dad154b4b9ccfb2117dd212fda217efe671964bc5777272d27303ab2b2a4be576f776c6f0505f8c8d0ec45f79db9be2d4d1f1181f1d8dd1d131099f045302829020d4081fa6e2c0c08097b568533a446f69133ed53c4618594e220d619443d99576163addc34fccd8921e5a630ac31f278f1c8f37bdeecd8edf84fbef7f20def4e6b7d9cf69d7cf3cf34c5b1bde08dcb0f0f12e135f900590fa679e7ef49a8260f68f7de2d7d513b48aa4a42031fe7029f00ce12284cdba52b289660264cf94dac85e4136523616cf61b47c5809c8b5c6a942452fbbb3a31e4ff1d7d5f8d3b3cbf1bbbff7c578f6cc15331cc2513573e64d9a34437c2a999eb3a3852d6413ea9d27f908c960678cf1c92d399fd7c2e964fd4362cefcdc554b0cbbb0b86401c4645a96e0a9286f9b5a557e6b1246f2a62c18c29d901ab8b7077312133362726c246e3a3611a78e8fc5a8047d7c78586edc47c0d33128a999447fa6a7a1d4014dcf331e5037d751e5f3b6b7f7ae523e7145154cbe558dcdd7851bb86c4a009756d7637e09736fdd34031fb406633095aabcd1966250dd2fab43e198c575f917d5f3b7d4968e250dd23f38100383832a7fd39610af0921949ca436363eda16163a39fc8cbf9914238c0e6568449d8fe87df7ed37c7ebeebd2b4e1e9f8ce1911175587dd15287303a32ea4e6ca3d48be3e0c98b996a962a68433a1aaf0f2a1ecfd8c4cd56b62a7c5ca159d22b798830366a237c6861041d3e25ddf7fe95ef0b8edf3f087cf5f6139ffc0ff67fe4231f89f7bef7bdf6df08dcf071f16ca7a95aef9ffc773f13dffffddf677f13f894d7d90b670a4f2079fadb952061bc59d014c0d5cefdb719ca8c88b9046709b8a6977f728df02a78c0fef8e987f000b73019638b5531da726b331e7df44c2c4b038ae68d78a44b6d540511fc30407cdc821cbb3bd8543cd4d72581eb0b1f7acb6ca71aaed55af782f0d2f26aac142d372701c45c5b5edb94c9b9a6f11d45d0e3636231a64333d1bbaa1431b414884d55348c05607121969796628523f524c47c89080185913c8be9fa26eef9aa5202a8bb2eca8871264cb6b2dc123e2b327997e3ecc5cbf1eca52bf1d4f94bfe561eee897397e3b173ba3f7b312ecd2ec6b4709f5d5a9140a91e36fdd092ecbb449078d74e82ab30705d9360820826fda60a476b40570483976b2124b397ee18d03c2c35887630394c5f99dfcfc9532ecf1bed8e41092f66fee95327626c6c38b5a2ad80141acc50341902cbd542249cb8ae2c2fc335163e6884d6f7e14d10ad01c4a5334a4b29351f2464fc4a19085d8d47d22393477ddf04b4f9bffdb7ffce7e0e7c7e21c277439a0f9b766262a23dcb89d6ab1f196cc2bff93fffb5988fa3de93319c3142d6ae741695ff9381281e9715245e8627c8839f04c5ebbcf9ed45da079590f4fc9bdbeabd3b7734ce6ac5854b73f1bb9ffa93989962062d852f05106d4203646f697c14ce2272aff21956634f48031d1996d9398ca9c9c1486c361673292e59605ed2eb323ef0ab514a87e663e746a77a4bbe1fb721e1273e9a036d4c0f8b498436a06ccc3d367aefcabcc4541c93a09f1c1d8a9363a37174722c4ede74d20c69c615735810e5a01b00deae0f75533d5624441c5a342701c6343c3f3d1317aecec6a284917795bd84213a425af0679980c41e132a5ff4231b0f3ad57971160a34273e4c4fa7811665f288ba70caf73a9d2869184fca0d0e0f7a5c88e6c33484c9a9eb00d6c2f08004ab5b1dd79a35154cce3a202f40b3311e011c51fa9b4f1d8fd7beeaee38717c42e994461d950f4472fd59f4ef8e55d11cbac00e167c3d5b275f3ddbe329c68caa6fe10de2f999dc1675503879f999f0e41938d7b4fc47e8bff77bfe5a5b202b201377dc796f5cbe9cb3a2989eb7df7ebbfdcf07d972cf03cce654c16392e530c13b7fe16cee66a1272e2e372a17a1b906685efeebb92aab9a967bcca7ea8a1958cdc3121f773d80607e635de994c466935834e66717bc5f13a1ac3940db36d3969c794e79664605b15d8c4575de27233f3e118da936b7b02453762e96a4a53a7764fa88616e9380dc72fc58dc79d3d178c32b6e8db7bdee95f19657dd15dff5cadbe2afbefed5f1975e73affc77c4ebefb8395e79ea58dc3a311ac7a549ef383119afbce564bc42cc76cb91d138a2f124073379eb1b8c2d665a5f951612236f4903f07e21931c62b7767db89a5714be2541a633c0fce7388cb9c5b9585c599270282eeb766220895bce46f32d09f5238c6147e4fa780f715b6699c6c9acec75f19d0c26aa488ae9296af2e3a326088ef856f453b9827c86e610defae5a23a1a30d3c0134cc8e4f86cdb0c0e513d11a444bce902cdf9a809fe45d17641160056c596840473de26b23aa93abec67ec044b6d655494a9e1a16e12b1a11e1a243a29dcd4734a4c0ed2eb4889fe33cc6c0f92a1ac26ade2b6919525dbc74dee99ac0d08b03972abc9093ce6e48f331d6abe757f015d9e61a47853ff8c34fc599b3cfc887d6c92c6bcf61e2172f4fec680b7e8a0b813c555d9eb5014295109e935f0ab4c449f7a4dd2b238130880d31715b6222b4d0030f3c115ffad243320d5a226a968bcb0649ee31b18be35b0b03327346d508c73406191fec8901311b6b7cbb5b1b92c2759f487d746430c68606ddfbd2104c26c89831d69866683f72efd8067f3182ca8451fc1228131832e76022a6c63d0ba934f4b2abac7189e1c634be191a6052a63f8635fec394aae7a57886938eabd4c375611943634f4caf85b97969e3562c8bd967303f654e62feaa76c60fbabbae2a8f4e06a1f681bbbaa71c6b37d10e81f14ca3f0647ccbc1de6bc27d5d99b454deaaeab04e87a55cd17e08387b3cc78f4cbad35e9200d1269868dd1c59d8cb0ea17e0b14e3c8c98931b7c1ecccac997e6c6c4c186ec5c8c840bcfadebb63727c388e1e9d8cfe5e4edf661c975a8fb8e4413bb677cfc0172a2b792a35191ce28926c5250e262ce5bb95a07ba18369d1e027f2e68ef5cc0da53976f458fca5b7fe957cd880471f7d2c5ef5ea37da8fd643fbdd083caff071ecfb1d77dc613f87895eba78e6d089965ffd37ff4ac853d13d330866a347036a9d28ccae5d473c848808f236d1b1b0298f7c9e505ffb69273f00a481889e5e565e1cd4b42273e6cb7ffaf5f8dafd8f6bcca75e57e195d03931930248d9383fd3fd804cac719939081f5ff3e1bb0abb08cae69a3fef7ce76d37c7d161be2e8b10d0e924fe5b1c0a255c30317d4c856e9850205fc0bd2c95dd84e14527844eb7685cd6c2d8339a336d6488e6ed92c0c1b07dd60a36bdc46c9d1a1b31de018c37bd349a451a1ee16badb0aeb9215a6cc59a8ac6dcec612d4f7e30011fb4179a8785b60e361148a859ab43c378030299d32e7911fd24d86b5b5e879b5b598f6909f49cccda15a559a7d353a40ee1c53b7d1393936e074c4318196119191b523db7348c19f38409e7ed8c8f8f58509618abe93acce7cb76373debf9a637bd3e8ee8f9e8e8701c999874dd1164af0d8abe5cf9f41ce92a5f22687cb702f2510730673d3227743a2cc0d00bfe48464af33db7ae7107dfe512855f8142c0553fe2bcf32f7f6f0c0df279b5fdf08ebff4cef8c217f253639ffef4a7e35def7a97fdcf052929cf014d358ac63b2878c0934f3fa1ca604f2b3b219d3572adca351d9325ed1fdca6ebbed6f573044b8ee776190eb788371d57770608d474004465ccc63def03129beb4a798d480f48d970994f860b8c4f01f9ad79c9538563cef126fb29f5c277dd722a8e8d4913c104a4a5e3d13384562d25a15b8bb5d6b27ad91535ea861a9ab09c9ddb9299b4218dc059250e53e3da34525168974dbe4d280156bb4bd830dfd294331e0884e272a52c3ab7b64368a5c17030cdc0405f32ed91f138a971d3a9e39371747cc81feae490dc71cc5be5ddc7928608cc0bb22adcc7227288129bc83b856f975c07131ec273acaf3b8e29fd6dc7c66d5ebff2d6537193c6a4fe0cb63a2b8fadc8c775496626cceda1fce8a0abd0e0e8b4d0ac8c7bd9f646db911e6d84d9383535e53cea178fc88b711779b527e9141fc1c231b9027d01488620f29cce847c9914a95a92e76cf6c8f6a3ddf2de6da17b4fe83054519e940bded73be9fac71ba6e7473ffad1e27b6e785ee1fbd4a73e557c113ffa63d79a9bc0934f3f2a22a436c21d040b0444b0df75b4cb7f79adc20398e1755f7fe40ca17d3a16e1c55d17f48c785b627acca5967ae6568b4dba55cba971f53cf1d2158da632921ca98d242dca8359323905efc824ebd678e8e8c4609c3e36e9f53e0c38521a6309577d3bdfdba4f8967be92cea788c064728faa4c106d489716c3b333bebe0a9fc7d282d8bdee0a3340899ba5d9b9f1df825981d76eb1a83e5782989e76c6c127b615bda13c11b1c1c506729cdc673e222e830263490802543335e1283591722dc121031201d49d227674ed1aa1bb220b69d9e836a77247011bdd298c765051c1919f2bb8e50b00b6655853da623d7465e98d97c5371596630eb9e081e33c61e268886ee9cd80d2366079697972c54080cf4604f29389a714523eef9f8278756b101dedb00198b82b3e2d92c17d0de2ccca38d59ab44ab1927f2d233eae757c04a7c9ed54ec37e8593dff5cef96c0ec56ef44d872ce93ac06e96facd054ccec3ded95b5a5e8cf317cfb5995a7f8740253e954a07cf10e674dc6434bbd47a1954c39a8e347be511b807f5de79aa3159cfaaf15db0fef604b7c6559efa877372956f9359f1fcda8c0483b719c635be9b1c19f6e965081dc71fa0a9e891e92db97ab653d2c0d62dde215c9686bb3a3b1357ae5c8ee9a92b7253317df5aa3f87c6648d7b56093a1dc31a4c28a6614a9dfd99f83734e6dadca8bb361002984f4cad7bdd402c31982e45fbb1fb0dfeb1dfadab0a29ff6de54167a050d5112d24590467e8a8b83b9250c5b0c368c6b1c3665dc2c93a1de324b434028566de649b98ee99fba413e2084574091333648e99064d680fe85d9938b588c65d6bd42369ed49b1c2f498ab082056018280b0ae68fc4b8b59482498740c08191d09e5f8e3a1ecb8b136a3cdf684c838e88ae00909619a73020c3d003aa03a164410bddeaa67f04b5d0f34bf289c3cd7349ee6b4b38360f928dff8436e6ee48ccfc4f03ad094e01ff9e11f2abefd70e6ecd346ca089aa7cdbd873a1650a9be5a47348713148ed333bf56c3f923723be56a01aa72d280da98d55568defb2a67c11331bd8bbe9d9ff246b3d000306f4695031781f18299530079c17640bd6b1d6fb13d8ae77cd68a7cb7a489b8b2a84c3e1b128eab6aa02b33d35ec856d37bb9815946b566746bccd1af71436f4f9fc668bbd6ccbc5dbfa2c65e567c26399888200d8deed95784baf4e6986e391e4bdc1525054dce384b98a823339d30715d97f3163be5b126e161ed73b1b51a57e7e6e2dcc52bf1ecf98b71e6dcf978faccb371f6dc39b9f33e5478766e21d6a479182f6e2a133e68b2c6acabd24b0d6a2cc5ae5476e2f0963f1b06ca181427fa263e7b6ce656ad8cdfe8b4a817e1683c3a35ee110c6b61c5c504657f28f5cd839473dcc778d9932a2aa32ebd4017caf1d8de98147cc8481920dc98e80896b7a9a92cf8053c922720aa78071ed18f49238fa70b8ed73b66f0dd8ded964d8bf17af09cc2f7c94f7eb2f8227ef847aedd4a069c39f774f1b97ae96d03b5250ca1d81f834af1f3039ee1353a2562039a02d60408511bb21987b0daa0404ebb43c0bcdf074ad7cc231d866e5e394496a3f27aa552bcda250666a3afb721a96919b47bc15c0d8509353d3d1de7c4b80850b7844b2c12adad8e5890b536b7ae31c76647cceabaa2f0759852e6ab3856f1f28552989bc56c181e35967b46533b609a5227d74bc2c7110f6877efad548781d0d183c35400c2bae5091f3196f006273601b0f3066d3c25c16b49b378cd8fed6b1d7d2ab25f71a59984e7e2f27a5c9e5d8ab317a6e2d94bd331bdb0a2f8aaa7542233a19e96179d3b24143e2ebf1bb317becdb6f0784a756c6b0f419bc10b10ce3d428846cccd07d9863cc304e5246b5e6fb2495ad233595385ade6c336b50cebcab2854cb6271d4fce805ac3d5fc15571ee3074db9aea903241ed832318375e099513da76c8003c10e83e676cbe639b6d783eb0a1fcc5a351f851fb6899acf3e71e293f0b713090e380002508c1ceface117337460d3c875b20346d76a6a7a36133fcfc9c379a7901d7415f0431cae49ec743001e7b060de78111da63554fcc83faf29f838400ca1ffa4f7384d8dc2e1407ea3a19445637a29438d0323ac4a7b4d4fcf6840bf24cd38281b6c20163776e3bc18f6d1cbd3f1d0b92bf1f573d3f1e099abf1e8c5b978666625a6d87c2d06d8d518b05b8e9951be51beb4ba1acbca6f5dccc4ac28bd33f5b1192a868709736673434e26a8aac04c25269b195df540e8d894cc4ce7ba98665d662d82b6acfca725782c75f4a85d3bd44148cfc6e2da564c2dadc79585b5b834bfa26b2b665adbb1a4ecd73a7a63767533ce5c9a897353f331bd241c5b3207d758c691565419b2ca7dd21957a16adaa07968936687402785a021b87a644d07b5b70a63138809493c16e869375a07f313739cc933b62b32aedbe1943385632e6272e2b887366c0ca81f51f132157c445eba923f380bc11c4baa4c9ba7ba26fdc0231df30cc4013fb741c19dcfdb1d044e6aaf6be01cb05b3f877e3da8dc760d30d6ab0bebef7ae7f71c3acb79eedc1937320cbcb38da33ea9eee1693bd72201d30cc298ea0ac74080f0760ac25511c061db67dc6ba1be3282a3bc14842d31432bc75d1053cfd80ee5de1f34fd0fa4e8d95482fc997dbd961cad4d52c3c04874ae326eec7806e35286c763ca9f5784f8ccd88a846947e6694b89cecf2ec4d79fbd100f3f7b359ebebc1897c5d4d3d22457c5b85796d6e2c98b53f1e5471e8f3ffdfa6371e6ea74aca9b3e9eb1f5659dd3941c4a66631b6fa630916da4ff41333e58449a1a1984715f78e18265bba7b25a852a48cdcd0483b6802610df342773619e4d62bd54463caa50d69eac5569cbb3ce76d6667d5793cad31e9d3c2e729b967e4cececec79434e5b2f0c34d29fea599e55892b0d6734fc18d31584f179d9f6ee85084136d081ede59a27be2f8c56104424c4d9c1ed18b03735972c00417793596243f76a460b0b3fb459dc0c2a2db84daf1cd07da9276474b595329efeab64afbd767b423803f851e01665b5c769ee06ffa8227e1ba9207f9d371e067211ea0f323ddd4ccf36b3f36a73c17409f4361bfc979f878effca5f3d990f024bca02a5447652c14689c521906ce9e0e56386dd49650432501ac4298fcfc292eae023e3781c2c81f47163e6b538d8e29810996274e4bbc15d9afa5942cc8aa3a0b9ddb45573ff3ff4c4b43f244ffa8916aa1e78c35681431148daf7a3121d19240b0c17843ac32b7b6194f9e97763b7b3ee6a42d6ebdfdee78f5abde10478e1c8f5e8d19bbcb0c6717d79efe68a9d3ba30b310cff06df2964c1ef5e81c13b8c19b02129e1df74ab9389f0bdd2a9b0e0fc1abc2276114ab8ab9a03b6343d1584ce20f51963ac1b04c8ec14cbdbd03b12646bf32bf246d765557099304912d623dfd03d1a7f1285a71f4e8d1e81f1b8f5909dfc5b9d95890c9da12b1e75a1b7e1dca1bb5cdd830b318359b40344b4d0391ebe7ba30d5d13cd9a9415f0481838ed178f05076de32525d2fe2a666db8a397500cc7aae087fcaaaa66305f3931a0a5ca04f1546779ef2139f7be2f18c3884234408937948f9f0cc79eb1e0d5897372a8f615333f6e4fecaf4b52fd902ef7ecfdf28be88cf7ef6b3c577385c57f89a5f963dcce4049e7986f5bd242844815b2d7aa236ce54672245614c668c8c0cab7214a9705520c508b342c4ab61ce2bc31caf8085a138fddbe788e513cdf4ab6b5de092130f2a1d266df7b6ca5d4487c0296c09c43c083449333c851d9393925224a38bff30ee8e99f9a967af5893f40f4fc6f77dffbbe3affdb5ef8b53278ffa83999c68cd44c5eb5ff7da181e1a9440c83c92b67bc53daf8993b7de1ecbeae117a5413bfcf22a669a3010479aa62a1b53378fc4289a993190043fddbaf35e6fb5a2b5bc12ab2bcb72abeeec985185c97bfb06a4f4a5f134ae5915bec76e3e150363c312b4dce1d2af318e6735c574c78f1f8f3befbc2bdef9ae77c5dbdef176bf26b4b4bea20e421da8ca5ed990598cf90b09455b9fe7d270b90349633ce10cad60761817a6067f20db53f115469938981d539936a3ce84e58c357b430724f04c22b12c93824203d12e9e0d8677da7ca1a691194efde9b42c3ce6956c43f0219d355a498379cf73fc1e0fea9a79e2959a4170550ef9b2ed0db3f82034adc4a60c1d06870a1fe6667d838129d4c3f6724ecf4c9b4820547b1aff444cf0b71398b87e0e91f77aa17ca668aa1cda51bc6062e74c5ebabd38d910cf097a9eb926547c484638652701f319f9190ffd650f496ca734eeee5474470339a080f190cbd9478da5442b5eb6e4d8030ee45d95f9343c3c1277df759784ee788cb02d6ca84f26598704b02f468687e8db6d26f2fe1e66ebe0d048bcfe8d6f8ed7bfe9cdd13734ecf7dffc622c784a8bf15e1cdb9bea6ca7973760485dbbd5b9898de4179329ce9acc5516f0d90fca3de9e8c1d942a6a2625a1dc44e674fbcfecddf156ffeeeb7c691a347bc09bab7af27fee60ffecd3875ea94db935d298b0bf3c2b3338e4e4cc6e99b6f8e81a1a1d8145d5694df8a4c60760ef1c22b0c8cb0315a82a1f83e032626744b533fe9062dcd1f3c919f72d0c86e06fd43f0588a4044682fc65af9764487c6aacb1ed3d20131838bc0ba6da01179ab1c8fdff473d102f2231f6686bd4b85f26100e5573bb0846c63d668bda6a832c91ffc884b86e445febc87496cf8657a769ac4fb00c1bbf7de57dacf7947cf75be4b52e200ec1fef5dbbb607b0c994bae32a82d439593e7fee6ee4f235a0bcfa535e6e807a9fcf12f24a43ecc57190ae29803807361ca6559da869bb769ebc8dbc628d91bd69e6a5ff76195371b955b968cb36d10bf028e326d0d06812c664eb322db7a4c1d8d645323e0d3d24fb6b79ea729c7ffa098d55e6e2c4f1a35ef0e6cb450312c0071ffc5acc4c4f79afe890b4cde4f8a8cc2c06f4bb324f8fd83c65d66d7747382b9c85643aa80a685e2fe64bf8bc597c9b05774996980cadc37b67c3321df94620e65eeea4d98ed9850569a28889a3c7c44874089cb4cdab52bc143c189ff9f4a7636666c69320bce07beac4c918573e1d4ad4a1f2f9180cb4e26d065e27f2763211c7a6a3680bd53852028219df24b1e9e60eb8b417f4abda0f5a13cc3de3303dcd640adc5239d6f4ba923f34c68ce5fcd07599e88c25fdae229d8bd230c3c973ae383eca4266ec9ce1ea78ba520e855217eaca8bcc94636d0d8f94f4944bbec25cf84be8f48cbcaa097d98f0014d9979aef53ee8750d3413bcb32c1c1e840b57247cba426b7a011311e2a952d52144c6be0104e5154fa6c3e53d5005f25a48a149e2b9a18bbf888f094c94ea3037589773230828c2bd20e69218c0268512d53c484419eea1154e0fae142e87fc85a6af8907ccc5f4342622df6ce88e9313a371ebb1f1b8696224bab7d6e3c9071f88cf7ffaf7e399c71f0d4e775e93c9d69296142b44bf7ae46ddd8f49e32c4f5d8dc7efbf2f1ebdefab71feccd312a896186f431da0340b33969eb19500084f5893ef0ba201586cf70bc3aa8fb79be9294b83bd0362a84131e9c8400cc9b1f6b6bc3417eb2b1a336dadc5a5b3cfc4435ff9d378eaa187a2b5b0e8f706b7d73763757e4103e4ade89366dc6ec9b493d09d79ecd178e2a1afc5dca58bd12d661f92b00e8811e9e098ed66ef6c6d176685d98c90339e122e68691aa670e11028981c8686996172c2cc2f16c46c03c999e2a3bde8e8b66345e638477420e2ddeab4c89b996c688296e28d1ae894c29c6336960a004cd70a151faeb52c003e41dba3dd801a8ffc00e354f0c4f19c03960e83a6cc7ced6b5f2bbe6b21733e00cd81e2f534df854b17bc7200478b869e10a815a98294f7f8f7ee0f86edf9af2f74403b6d75151a6139c41493da2f33423d549a2749489b9630869c725312c55322e27a9828bcc99967fe2f6d4215952c9f2b0c4dc49e4a840966cb46ee8d6347c7e3f8e4701c1bee8de31a47dd7ed3c9383d391e1d12b0cb4f3f19cb3353d1a7fc2706071567446e344e1d998821d9a073e7cec6faec540c4b78c635363c3a3e1c2765b2f20e250bf14c3ab8b7852140cde482c1d4ab97b535be13911f8c5187d0bf1b3d4332db06d5290cf4f8ed805b6e3a16f7dc796bbce2969be2b6e313716cb0375a5357a2571c3e2cc61b50264764228ff31d7669dc1e69d50b4f3c1e579e7e3c3ad6966362a0374ea85ec764a24e0e0cc68818bb0f8d024298be2e1f0d27bcc04375f1d183d0d474ceb6ad5ac78228a1f0962e85d578fa539dd8b1c2b71d30f3580ae015a64159035b31bfb8e8319f5f03521ef5fd3ac66bb405403e08471544aec4a58c7aadc20534050d21aef7c4335ef2930e579f21d07e57510279106e54f389efa8ee1e606ed61767b15f5bab73e5c91e4c8b917ee313ff4688611727510f42459c1e0e065688ff6771e61edfb72ba8701cfe1a5eaf35bcba83e0c907f5fce9cf7c18e82f2e2d6bacb0165f7be0f178ecb1b3b2c1657eca4ed2e37d040e4ef51233b36b82bc608a4e3d1fede98c5b2686e2f4e8404c4a2846fb38950bb3ae479a8e110eda9386cdbc28d7f55223aa0bb089d72955c4873f5637c49466a8ec917d6e8b187e536337ca924de5711c4cc4be4f662e5942601b578bf18ef01a100efdbdd268128481be6e9bb803c3fdd12f81e891306179d0093201b3bdb113abcb1bb1d192d6585df7592c688e8d4dea298d82c6515c961c38e0971ec66f190887d4365b313e36a2ea88ae7ab6b2baa69e7e296634665c5d4b0dc03376b5604af7485038186ebab5115735ee5c60e940f972a4048be7ab32fd61584ede664f2be61e79f4974914b40aa703f85b18cad37b5445c7b1b141997feb71cbe953f1c637bf5af723eef48678b158d2dedb3798932da2611e495105849772730289c919c22c9ca06d1ea2add24f1a2683bcf62700174fee085ff6e2e6c6ef6dcbc4b0c6ec950fc9e1bb5ef75d71d3f1934ed7045e31e25523e0d2a54b3ee3e520a45c348085c13ade3bec239780b7d75001332ca640fda94ad4cb8e7fc9909871c998f0651522df1aeab3244a0261d5d570fc10b1c63f780f6454a513b118f4d3408322a48955e2a7e9b9d78b9126f348e73ce5eaf88f47e9cf457718a76e4f621c57996670a05faed71f4f1990908ef44b90ba77e3e8d0409c9a188be3a34371843360f4ac97cdd1322f3b36446b99821dbb32f77aa5adc41f62070b1e02c9a66aa6f07d50afca4760f9508b3712eb5a81fda149057a7ad157c2db272dd62b37c8840f937ad28a1d9d8c6336a3577e701b51f898acb871957debb1b1b8ebd4d178e52dc7e24df7de1ab79e1895093dace7ddd6d0435232c33d1d7e236254f51c135d195732ce82485c1917f2c63998d11439295229abeeca63d5fc96226de036a1f3d2159a730fcd791f9036b360e89e71ebdcdcbc051541215bccc46a6af21e2571685bda88727986f6054411e7977168db9c38a1c3015caee889f3a48e3a21aeb43174a65c04d1ad237c8db3806f4e1e066f7fdb9eec5c6fd2e51ae16365bec21bdf70ed81b8c095e9cb621655c63b538ab35f0ccad54e1497936caab2384c0dec66111b425373b8fe3a00a1aa83304d9702b45fe8b22a084a5e99dda3917851953cf0535e26a9ac515d02b8f2dc82464348709dd68287b0e549cecc86616aa2c16a4fed335d3061cdfc398ef54ba9d2080398517ad62ba1eac32cdbd990c0e5de48be70c404091332038343ea71fb3d09c23b7d6c226622c66329ca410065dea11530f1da009d144679684e70e454b40169c34199c14343bd31aef1e8f864be1737323264cd31d8a7b2945fb7347e1f66ecb6c650740a5badd85e5b8ccdd585d894d9bc29f36a47ccd8215c0684c398709c501e2343836de1ab4b0c7dbae7f5a29c5c116ad01b552b076ddc7e12a8441b6d2b2d2d266f2f76eb399a47942f8c9feb6e1ef38aa6bc31c20e17667e995566e386cd7f95cd240899f87b804a47cb72053f77980a31aece479d10f2e3bccb104579f0860493586c11e42d0e5156ed213af63376e63cd5e418e3a6f8d71bf7bda171987453a69af09cc277db214b0c0053a8160a932b09d6f6975fd588609a632d555d0dedb181d2ba068e2797311d5e1d50af07c1e5ed737b71db61222879d2d02928225c3b3f18217f56d5455d93cea122aa27912400662a09b4fe5b08110a985f7fbea2f96c86cac174298cf9ea106653f63eb9f1986ffa71e484948cb5e310679ac80d4b3362baf549c3a0d964b02a89cc2551a65fe6252626475920e4c93cc2051cf513a2495b3918c2cf61343a0f69d81e09619fb4ed80b4dfc888c66aa3fd725c077d960ae1bcbdae9ec02630870bb32b255f1f020f185a635ce5c752c9b84cdc518d0d39548aa333d870cefe57ea6a2aea1fd3f1cc204a1c9496f6c03cc7af086a17da04c663ac570531e3495ba97cbf3daf72bd8b08cda43ab2e7d5d68ae2a0852868ad951fd964f697b6253d9d1ec095976c1164c26b670d6d1ca61f3cca7d6a425948ea90b655d6438f3fe9c3a6ae4c4d5b102b6e0057ca4273333e64f1ff3060ab5985c71e4bf3f3205c237ccdd99966064d985b58301d8176c5f88164b9124625e9d1dcb3c941246f48564fabe6b0d0f94ae3f85af290ab70f01eb846d0e42af1715e27c4af2b3d2b6b4926b0080b43d06d203c302f21661abb142ac67f60e6af103986e24840bd854a36a067f474cd2fd1ca4f2fa84e05266e9ba116445dd970acb1221fd0e4383c048db5be6169ba41996f43fd8adfb52b068e624e528e4c3839362af7c9cce3535c3cd723339b6758c5dc5e0b541a5307c499e850bcece8d4f30b8f0ee1d0a5b27b07187ff548134a100784d780f092ebd538b29713d9841b8742f1ba54b732414fd8d1c1500ff51e1c67312a2d3a3ad815c3ca6348f90e4b4b0f4adba17dd8e5026d11541c1d1734af93719ed8025909963b47c26837dd23e458466c24974858281008eac2c6f095566e38a7feb63e546e9d48431068df0a7ea6fb3c58a931b92212518e3b2fe5ebfcf51c3e250df7730b2b7175692596a5593989003396f46c40a87c57f3243e3ccdb8f22034adc697ccec6486675d3da441b8b477b2c002be125efc3c878d852093197b4ef725acc62339a685c38ba3719ae0862a0d599f1186ab6338a7cb273cf4ac186622454048f049c82bf7352f88891767615323f99be4681da9ab3cd62e9d4fddc29919d4f35b28f2bae724588a8bd6e5fc92fe410e8e15a34b1bb1a86d412d020b63a275d032083de1a9451557ce67c314668121adf9241819e6da1a103e7708ee2058a84e3399e3f8c08593b78d0bc2865fe1feb26ec1093728611c9686432bf7ab6c846b507107c580037aee34e02d61a793a063f057798504da9a2b9d917152bdb862350095713d9603f1427ba0b62f9d992767e467b283f800e6e4ca0ac729c27f8c6965222a1e430b4e7f73dea21f1d3e44813edc2320948290e1f3c84445b3171864474647627864d869d6365aaa7fbfcdf46ed5734bf5e3c80ef67d624db832729ec915ed19432e2c5dbbc99ab36dd9a002bc60b39384f54b2c4de0750aaf3165351492c48350290039884e264957f74a52b936f3538fd2204d61753c01795401745e72b51100c2abab8d59e323c4109ade5501f63336703a397a3f05677e144bfe0af74445290bc66039016dc3ee144c3f18b69edae5afafea791d0fe26a6fcd9802e6b3f9a58683496c86eadee756e2604eea0c0ea219facb9a5674e12d71cacd19bfc2d494a1fcadd5748f43b3e8621ca84ffed33312380ee3261c6108044c83c6467b23f4123a041321a52ce38cd0267e29bc743a683e04980ea14b1a52a6b0c2fb8be36d0668543b12ea93d3199057ed035e469a46a7deba2a8c890b62413770ad0249f95c9975c67241c098044458789995e3293d06345f292f019d91fa4be75f274df0270d2897ba679bc123365545cb4433b59fa2aa83e98e634738d89776cb9d3b6836ca24afdc79855063c2a6e63bec439a40b51c19a61df62d87c4bc008257673aaf6b7232dea3969e50510057ee0f713e8e4171ba98ceee64002c66a1dbd1b33a51e3b8ca83574598ea85d00015c51d0610af09dc1f8c6f417403c16c2a5f0dec78606106267ea6b5531aaea4b3f0c0ec8a8010c0ac9e3984018b16a2e74bb7a7e960223bdf73c02b5be90a89958fd17341083f820f8e6212958bbc5850143d676975c52f07c3244e60efac128a47c90beeaa07b39eb40bf4f552101d014254f095df4ef922e8988768583a07c26b87d265c14ba1635205cdc718157379986d721af78d720627b3bb4528f96a2d8ebca96ba52f68dae407ff128e46aadbbb9a9d27908bf7b9460bbd7a7bfb4d5f3e98c91bf09cf7c9d1139b9bc51c549c6c2b950dbda1a74ac59c35c5f49c099a6ade32812204ec1873aeb140afb11dcf86fbfbe3e8e8688ccb649d1c1d137dc001bad25ec245edef71aad29227e5f149b3c3e0f94c4f61ba074de9bcf79ec3856f895d120208650687b8aaf841e627dc57ff30f393d8dcedc5da039236f33998573bbf76be09f50a181784468ed43ca3c1595742700857292eac9d7fbdf89ee78569f5803bb401e3ae7e4e0f538f8fe682115293b108bc5ff0ec37031646572664cdd2810f3c526fc435fdea3df51c41f37931ba17ba0acbdedba6254cdbc0b7a26dc46b472746f0cc9d990906cb8564d3017a1837e1097e7216023ba5b100d08bab9352fd304fdb63570b9f343ea626c227a143f8982d1d1d1d8ab1f191181b1df4de55c684cc9cf6295f041adcdd81c9d10e6e7b844b37e046bd08370f09ef1a9fea8116fcc2d18854185cf99026c76c3001c3771f9874210e428c7551f9c2a6a1bc08731d0be277d93c571984252f242ef889bbb828de16fd6e39792a6e3a7adc8285a98ba35ddb65287e75c0d2cae19aaf3961f9bc9aaff9f2df612627c026620a85d1dc807bdc50889af7b5524cf957e5c8b172fe5e38e17a0e112a705f7b6553cf6a352b4ba59b8e279e50210f9eebaabec87e65e47b3f83c8bac26c7507083fb5b57180ebf30d0c4a82198803912b59d8c912fe22eda09891c9139b57d20a9892bd6246b6255501ac4298a69bb2c7cc537caaa48b9cf050835647e3c26e7a9457e165ada704e4c558435c67bca8756a0a68a0abea0fe22ce97468e8d2b1a51a70d68398679771120ca7389e94e1088b2e8d7bd516cad0a5b9e5e58482caa56380027a2aba5421c562680ba1ccb15cbee88ba131099fc64413c7c662ecc8480c3183ca4969a2c9b0eace4ca89708c09b2694a3bd10021cf7b483db5ce5f1ab933c6a34d30a707a85b331822335f8500a9bf96d02aa1a8c653145a903f461bc8ac9aa6c0d0825662be5404fcac6bf651333f923f92e2d049ec3abb4458f0ac819f30e6b61d2434fe234058f8e8d437c0f83a60c1df6626de650a0299d27ae237c2b2d0e5e950724858005306fdbceff94b3c71e8569927100b37ff00a90194aee7a60330ac6108170006d59af767ace352753f2de5ad66122ae708491ea3589a6a7958133557109c650cf6cca287e8ef3d8e92ea65223f0b1ffaae908f7b92eba56e1335d94b63652dbb91ea51095e1d3cac42ca4735af22dfe9a17f9d0392456f9b39f7ae3246c30040c957b5673dc6dbfea886346b44342919d92da452e3b257002b7c4b9ba5a377080c17b543f9fb826536c6078280686741d198ec191111f8ccb8960ac1b7ab656f5e19bf5fd8c895d59e16b3a03c9e8e60f05d5b7346c9acbd146a991d14e5957f806e667ac97e33d0d8b949e210a7b5f01e220744c7e2098d69ac205dad23675cce985780963a1a0e3901fe5f19cf8001336b63c70d043740088473ac693f8bd762cf087810e81e6ae962b57ae7dff6f9ff035235c4ff3b5d67887a9a2cf4f0d2c9ba7e9dc85d767e54a586ee112b398419239000e4bf273c5ac79d328556061c0bc575e727e77af9d4f89a738b4b5854644a3119d3f813cd37d325b1580bd729a409c7cc43f92669a34dd9231dd583089f32a0de4e77b8eb07d02485a0980f3d0d5f78a576725bbd1aad2308491ae0275abce4c2b3a517f4f2880a8eb9cf4302d5c1f8543ab421f769498d1c5540e2763e346bd0a7e0d070eee4c2478764c34c9dcece39366bae2ef65e67678505a70344627c763786c38674b550726a7344cb616aeedc62d573a09ae0e30fde10b3fd45fc6e5477b21742c51812fd64a6e7bcb6fb5a716c33010ada1a7aecc9efbdc53b91420d1b2d4cf6fbf2b0fbe154fe754698cd03219574d54cae63969195610421975c92cd3655a5352edc1b3f60a40034e9ed893a1e7353b9b11ae277c8b0b4b561a74a13e7f05130d5ddd704c9e7024007e4fce786245bd196def30a52bbb63c8073fcf31313c1680daaa20442b3472a5ab93f5489d6d1e58abf1234d09cf37b831a1b2f786a80cb22168b201f9c2e499163043d42b5e958317c2bb818d8b7a47848d54965922ca290b3f53fe075d65687fa6b94c3c7116898f07147e1ded306650537b92174ccae4978f92103d556bd5479a88789d390b47c136bfa92f3fd75782d2c304056b5d62d8353122afdfe8bab3be29f3548cc503d757695456bb63dae7c01dc6166ed6c8f2531fc6b9687a69c21e0961bf34e1d8d18918991c939062268ba1354e94c88b322a03fc4ca3d29015289e0b9d8684943289413dd8484e58d25af586b6c21101aa6624f5a633e1d522f39c0493952b68d82b1a78bc26daad2eaf9a563ef345f15797571447f58156bab219005c28032b82f2084ffe610249e6269d88d2921f79b16bc69d9ce84e7c5e6baa13854d68cad00b12bedb6fbb76770b7be9604e98d9d0a0270401e8290cbab5862a8260c2ea2a1ada4f83d43426a6f2a437cb8999928762c256dcf13c7ba66cb79a96b8a4031ca63f9b19e59e34662e314ecd97f0b6ab08719133a3982a59365aae9aab69a2292fa72d0c8f5fbfcab41638350e4c6033550ee132e3d6387269d289898b4323f24c486a80bfe91d26759709e571d689bfe22a664120c8cfe61a9da0852e0517d3154dc53110c465b7caa6da6db3d59293e9b6b812db1beac14bc75835f71e3de4172e98a93e9089b2e438f69045fb4e0491b11593581ae7f5c8f5ca0c1d3d361e43137c9988a507999eaa13b482e4edf684ce05eaf63322a8d8e2544fe59f34a5cdf399db1e61142dd7d7d89b89c6d2184efc853682f14961fe501ac0b414a0d92888f8e041783dbe1e57e3c133ec27ade1c4255ff8813838f3a79cc799428c38c425efc316da5f90f03ddf84cb4a6b350bd5af0a430510d985626acc1d111d278c8d34d5471b79c64f577a0d3708f105f6034acbce0c76be4b6472378c9c55bef32f0c525c13da61fa332e254fcaa2d74a46d86be8fdf81357f7ea3af3eb3f12681c75d11d82461bb94a2aa0f6c8fc6cfbd3c0e4afe75cfd44da892fcafaabb26dad265784123f5a046686d19544e5f366834c2af5b0f4aa6c15eb674db1a74fda6420ba7afb15b757719546f970edece6e32c83121285330ba1f08ebe81e8ec577c092b2fcdd206e0c695b7dc3757a509d55177ee48986471d0a924fdc09b3caa13520aab135829800a43388537b8770ff447eff0400c4e0ec6f0b8cc528d63475526af28410ed34379bac3322d75a56d102c09945fd49510415bda87268182fcf759a8b4bf189c74743e1cbd71f1c2658df96c465928f17b8ce8e62c7c50007f9aa8694d34c7e6581694895f1ee3873ff924f3a87e1cebbbcd67c4adcf7861fb30a872f4bc132e4d38ecb432dbcd6654d813018261d146e50701516f25063f5fc1d5cf3294b3182f5fb9ec03959c0f2cae67d4a969f79b1aa5a26d38705b62dad567f44c39e9a29ff283a93c2902f3c04ce46f2212bb9d5af749480baaeefdbd3cc2c5b4d6908dc2b337cc30f26a42ad27d14997f9c2e0e483369100caf95ef1219967d62aa3296f1a1626c1e4e39ae52b6ec1d102a1e6c35052d7e2436dd98ebcbd2b46efd698ac7f449a6934ba0687a3534e04d07827b748f1c14d262cf6e30d7e68673126a6b09d98923ae897da5ecef54e67ad8e9009b75ef1cb88c67fbd1aefb12b28d70d5557d5116ab8b32be571212ff2203f3418579ed3d132ce63ad2f359b784365d019d60577458e96c658ec3a013f2662f84c18e5510e69c80fa01cee193fd226ec78228c891966ac6b1a9e533e9a1e2c731c6d443d9153871fd4b5cdf36e5ff0de3974cc071c264715ae2b7c8781df98b6a0809402945ab88998890c44ceee477784e1c73c3392d5a569e1d387295dcfa8bc2ba3dbea4f46852148ac1c8947ce140d61092b692c04fa83c8766a14cffaa957247e3e4f81ca5d11f45a3093021c0a24be7eaef81ca1ce1be3b2cedcdbbbe7271fc14161ab90b826a38262d3a52927a163bd5182c01280b32b42c79803cb80b434326b937c101253c8c247de05f0fb388e6e3deb93d69356dc9186dd91e0f17e21e77fea4ff86afc3328211c198d9e2109a1b4e1f8b123aa539a54d0a97644295c68413119634ab4abfcd969b8d052af34992d58729eedc504651d7064c8bb80d894e0736b7a24bc0298987c1056706fd6c5edcf73d10741a64511844db51f54769b2b3e82b8c17119ca9213b7e778eb5e04c424c622a3d3e21eeea14debd6310403939e6bbe802bbea32da897aef979b65cb64080156c3ce8049237763d2cc047fb37f9d23fc2740f7e8741dd6206b0d3a5092a6a0faa6abcde640b5f5ecd4914152ee781ee366871af1ae0f0936d79ce040b6f22131f03d4268e7cb7dd727b0cf60fe5c40c95a0d600b7852139b30393d18bb08a630695b36013478d26294b3f0e334641cacde51884924d3ca5f39a92340f4c956fcd739fda30fd2ac50c073ed96332a600250598c81987b44295f2f3a9fdbe77580a47d222cb63fd30c76b726242619a51e572c71069c5047a3e20f30ac7c01e07ee3ccbfc294d3ca831e0e0e8780c8c8cc9d2e45b735d62003d160d305b19dff1214da8dedf3f1cc363133130311643c726a37f5c9a10c68476ca137a51bfda7e4256d772eff2921ec481cea4cbb45c116092c9baf072847a7ad9b4ec7ab1a56186750902d1c857f994883cb2ade5a79de92ce5fc993309c2860485b71c580ea02d10c20d0999cfb75143235008d3d1c923a2a18456f5f6b18a850e7e9d48ce85aa0c6b61f9b9c20bf00a2d4405b004384c97579630f78d8bd2789c4ffda193ee8574e2c873f361adc3f5846fbcf89e47f82a5c4f5542c0ca98f45656cb85b8d48f7f8e23e74a39d44ff6c071105aecfc34af1c858a95a8ce8ffc55a1c39c050d62b80c9c92bba7cab438f265ef20e301e262afa7e049304578c270fb21f3aa9d18e9fde224a8e9911b1b82f3a3fc8c6e205fa7e75a2ffae75e520e81c3d5af10b9ae72255501f0262ec28a10241d5c5fd55b378a933813c6209f973e31bbdcd33bae3a2cc64a7ac6244b6b6939d657a419c45c1eabf1f6fbe888f360efa4e9499ece36dbd194158ee90e620810438c49dbeb073d01b41f6f47708be9a946c96d5d6dbedccba7d21e1e8289eb9a1f79d5651884d78be6faa18dc107a16c4f6e08373438e9b62494a6b970226fee813a49427e59973d201c5396994f4c50d211060e74d8b5fe38a3ab6b9d3833fe492cfb2b0d5e08bca0145916ff05aa079d3bbd91949bcd34338e1ed7c35a219bd007672308f31a14074160906ccde91e778f30c4a5c2b5429568946d6629cf9328f2970e00e039405afc1c87e0c90eb95a26043e08b52cf273396206b6cdf045593e8d8cfd43aa3a99944a8132619e7435840fc2445dbb043795eb4e4a0cc9c2fa2e4732cb29a74c4f3a1a5a662393284c6cb0bb85eb4ea9e3aeeae1090aea4b213b9bb1d15a8895c56909d9a29e33e5aefc70ea70b6f912ed854b317deed9589dba1a1b9c5c26a6b58947c9858e08b59dda66a7635be65eae91b1ecd309cd34f69381a976552ac5f72853f1f90c983f5d26011391556ece2832f9d429b373b0af275fd4751e0a8332f00635761db2cdd04038c22a4e5cc1514f2594e048672d41db40486bfbed46abb5627aa27dd904e0b5cf347d0ccdf358805a2e1d559d78210c20cfe427f25333b8a34cd3bb4429cf854fc907806f7068e0170a2f48f838f198baa978ff12ea352b0701d254db0b274dfb5a90872808a3e3a91e6d4daa4a65b51cd9cf70d435c3f780187ea69fc70b256fb4067965efa5261443e43312ed11ae5c0a94f204043b3f797c441ecc559e014eb62fed1eb89ce2af40af4bef0ab1394d9a23ff2ca066149c1e3891e8074383a31c07e0cecfcdc5d4d5ab71eedc396f6acf53a2338d35861a1dc6f15aa082c52ed19a5b8cfb3ff78578ec4fef8b4b8f3e15e71e7e3c66ce5d8ced95567448303794efb56692d2e36813f264efa4ae58286eaba62b61684e2f502b2ee9a9275fcf35d3aab341e59127cc09eda17b756d1e9003aa49cf3df5c1a159b9272e8be7b696d439c1b6abab2d6bbd166fd9573a88ef6a5bd381587b5621a36e347869f4c4196d9de7bc509ead0747c938e44b19dc930f3c81e6ab7893273f8f114b3d0e4273c9eee08c675bf8eadb0ccf05b6b3d5a3b73fefe5a2f1a763aa5c1d663a9e97d57076bd906647f7a467c09fa82b07fdc319682f72d495aaa0551d28e7309edb657a8863b3c56925809828228493081844d7c98a2d31350d93cf6844aec6c0f7fed28ff232de72a461cc21f613ce190b70ec5ae673812258104b44d5604ff0d450680f042c73e2bfc2841e7ed6f738fc1654c74647fd2d700eb385f9961617cdf46d33d465641e6c2be9eaef89d5adb5387ae268bce295af50e3df1ac72727fda5d9d6f2722cceccc49acc50174baa467abf6141c7b923261433d6372e3c79a5f292de72ba87594997c2a1686d8b028b45784800a1930f1f22bdd2b9962e4bb1445f1c6139aba9fc44e78c9571c8bb5a24d6306823091f3b5d9444cf99016583b5f8ce82d161131cc162761b5e61ac085f9023b3a80818bb762c58f223385825ac8fd20178b655bcc02c33f18d8ff2016fcf98ea6a0154b8c7a1b412f528f57a219035133cd79468052606bc3624671349d4f2844ac3a91a1ad0d2ffca04e15430c5c9335d441cbb6ac2909f3205e9eae8d1e5ea339bac942b479a62c9c96538697c4f9c123fd7e078aede4a820781201cb63df13d7dee6ad31b433432e29e318152fa3906734eb8ac684cc5f7edda6b6124709aebc31e43fbce4cc4b7fb38611aad82c9a98a663c7a99ec69f40f0d99132c76c28157842897576738552e8f4ce7d52b750c12463380f281397bfafa6353718f9e3e1da7efbe3bc64f9f8aaeb1d1e81c1e8aeec121c75f5bddb029c8f8ac3236401e683d10ea10f3edf0296be16b812af541c03c54a8f7727408d690a4833e6264f6c25a3869cf9ab7ae55e0807a75eb4152e5c36409575ad03b4ad4c9a0bd00ea89402378ece95c5a5e91d6db88c181a168adac89b6ec621a30bdf898281604132e42d8a777c31f75226547da7f6569c561dcd3daf05d9b7f688bc67d9df823bd69a13c79967192f7702f14f6a87f03303830685a412d5fb8ca831fe7d9c43651852454d5edb557a0c693afa4a19180da487b0d5440f7ee015d0ed5dfffbc999ede770b6da7abed7151c783ee52e3649e64dc8caffc1ae59113fd38a7327bc90146228d9f0af0f8660fd7eaf42ffd8e9782c7e794f9922b8c9d022ca746c4b5b59832f40bb4c2d367b1b89e94201ce567aa1ce1f3d182d44565f8d52539046ab3258d29add662078724ba87335b4e4cc6e8e9e3317464dc5bc17afb7b9d07130ce461145534b8520e3860051867753cee30a837b432aee0ee64a5be191f2d497a4e8d63970bb41751214532a8e90133abf355782dd1a03cc9bbdc8924d92e94433a9b84ea6c289b4e876e6979a9152b1ad76286830e6d8b698aa5c37938351f10a83c433e759c871999136a68b93ab992133d2e5bc0cc73f57305970a354fca80376c551d02fbb76cee3f3ef005091fd3b622932b246c6c55aa9ff63575858cabc2d095803890cc8642d35019b9a2c67ca092b0204be2019451d3fabe5c9b95aff9d5bc01e2512ef75c1140d614ebd8c45fc67517056e6a44f909f364030de53c6ade4cd0f4476bb3239656e985b3f7b3a080bf514abc9a4088b5743b6f986553615cd122682be58709a34e816fabd793a765a4897e2a038686262c56b3950be628bd313446d0bc16b72b0b4396c4ce8634fbb2ccad1509b7f0ddddca789d3d627499a1bb7d6a37366d8bf1d078c1de4bb95dd62f8909ad9537b3f468186b3b3a2ce18496e6387a8f05f5b3d9a8b842d89d89ebe06e8ab8a2a3eac5427b4b57bedc64ab8ebaa88300a7ecfd6054684c98da8f9fb2c4e5ab45f0095189936d8c16e4c32fbcd327eb5d1a9cf168c4c2d2a2bf1fb1265c301da16d6ac91c9b655b267f34afc3232345d008a96352aec9af40e561f808c00f6d785ec79e394123616687d121c0b2488583d665967283603c7dcd9f68648440b2daf4f539ffa9a49f5109fde4739a4203fbedfc347f792f28cfb2a20d34eb73814b69dc434c1895f8e045f9d8fe4c637bbd47a060fedb5fa1e2431a3f735a788c7181c64aecb5f4d8a5d4952b8c561aa7e9480b17556f029d524ddb48e7b2784e9a8c47c10844027efe8b41a103e31a5df163525337efdc29e31598bf6a08c6657e11747dc3028180410f16a5395089fd99b8ce5e0982feb285320e2ef15096986905df0ca06e7bf570bb539e98d21b99a5753923a64475bd6b1b226480f32a7ed3b2e6555c0a9d1f1bc0c7934bea98788025c2823842465cc6677e73431d01e5d84a5138cfab32a83c81e673b81c79e1078887df9bc8ad45332f6882b9cefc81db4b906d97146bd3eb45c03ee1ab6af1f2e5c3bf3dc6f992363f281806f35504704796f7eebea40a73f0ac7bfc4cb6403888eee7c4cf34385743f7e9f44f8e6ada89883888c9731a93017a569d1819cff61971f8918f82d02e109bb2b2119cb589d784bca711d2b91e02f261bcb7c8c72af9565c6114d3a064760ddd9d7ff10b88476f69934dfe2693c12394e1fa423ffb8b535dcc8430ad5c0a1ea6264c4c1cca4fbcc9375f1f42630977e54de61eab303953d63ac90fda77f4c884e5b3607d6ab86ee15727d104ceabe16a27e3f54e5d113487973ac8ababeef51c618711d9c5c367ad49eb090d418daf0c2845f112f7bc669ea4cd3c15264747d2de5226302d64dead33c9a2e7cc42e773be17415e9423f357455a43a96c0bbfd29867ec74af70b683612a620df8b5251559b5669db8a33d30cd2d8cd055c03361e878e45527614cdb43a03991f99c9aaf3ebcdecc27e3843a81520fc7650a5277fed59d2f7e6e3f0508798c53492893099e8cd1336fe86542a6c4ad132ab646d598ed49195532d70d93d7324feb82b69f6ae31735da57a8c99869cb3d18a61ab67e366cb3b78271eac44bee7aa9a690f2e4b9c25a7c385236595bf311d9e24d5a5d9ae0e0642633916ff798b886db2f5771ceba536f5d1b8e67a06a7c0b52a4e7983d9c62d979478d7065cced092978c582a8a772a68bc09d19eb8dbc73279394ab06989ed1ad389698145470650c988e384d0184a608144702a2f96042187a5d66208c49fd6a7c6b673a0fd31e9a27ee39decab11d901a27f1a96d8510e4ee16099bcc60fc730bf39e78212f15e1735d68c35cd691b1bfb6eeb1339d106f8770fe0a25739f9331a4ccd646737365970bcfbd1b4699b2d19d2ebd4eb41187676e33f0c2812f081c024d45f6928cf952eba9306a6280401036fd151c26202e9504da0c48fa02ed3b55c4d174a50cfcb561da8da08ad6c906fd23d53e7078298b1e0b60770b3d9f9721047b0c06208c8d720a5efc07eb3aabc8f7d193f9842b84ce6899a6e95cf6de7d05d7598eb2ab43f82a3d14b9646964f6dc3ea8711c4b8000d2f3521ff0520721a6ac6353e78b2b909d068c2c1aaa07ef96d9c99630c69574506e07c5499755ac7852e7acbb705679ae83eedb75118d569756ccf8e0cd1203652170996f6aa6043c384a20df34f9d0ae082c573f529caa71738d8ff534d6f36833363cb34365cb87e3a20153c815aff01d9d00132b7bbb570aaef2e71294e2a8de4cd4507f9e990e7aceda1fcfe10b3a68dabed20600e7c431dcc1b31df085c23ee16b4ae69933678b6f0f388434a1120fc957cfa21ed83b55bcdca02b3dafb3debb82b3f1d6333b85ed01f1f2be326d7336b359690b897ed211593665aa074dad859901c3e8a9b42c7ea684d8d2e5b52b99be4970f2d0ad88edbc4afe760a3723f0cc04662282715fd92dc19f32b6c694ff1a5075d3944abccd3872d08506a4a170084865841aa782355771aa6548bc6243f1d4fc269d6362eecbc7ec297b29591a002184c05463270dbb3f844f7e5a1a9a083d34936928a75ebe5b4ce3cf556bec58c73889af4ab110504fa587a909a3ee54dc79722f9ae2363b62757ed9677d6e6fcbdf120d550a82022d595f93d894b55a3057f6ca7b53cf28860de1ea11e457bd7595dde21d2dd52a213d57ac279613741bab2b5bd15ae51b0aea5c55ffad1d693a697195e03a5858a135780b17267858aa801f68285e544658d9c296076c61f5d1ce9c9c467c5e0661ae4034a070416d2766a489a3103b84fc30a8727450eb0160da866684c3c67da323a354413f1a327d2083a94145f7f5f6ba141ecc76323339381dcfe0243f23568673df845a6903d1452c1ad32d41901253a4cb97abfb370108949a814f0a8bc99898d03333573bdfbdfcc99b70a72f7950d672ab154b2b2d6ff2756cc569273f00499d03022d67ad511ce038fa597b54a7b2bce0acc614cbb4af5eeba373939c758ab1bbe0e04202cb057434719039d51f5a2b4e9a9bf9cca22afa787b9cea66d243f86ec513e3314ef33847995abb155cdaf83a1cfc6136c2aa4bc8a318d6a549793b80b712a81d6583832f82fd6988e17c1bf7d9011450f2d43854567f8a0bdf5910953fb39f00d6893b4cc5c50c74c9f0a7f222bc5907c2799e1da1844f3f8f4b159ef303357d2e4db09734d3256d00e74198e2d63905de353c08f3bc7951e08509df2107be0083230399aa34e07ebf2aac8ad4c12abdaeaf72746cb92fb2deeb1fbdb3af0aaccf4a1aeeb956c77d9653049d344e57d242303da36192f0244a53192d43ef38323aead941d20310308908519b4c05abea4a79f26d6cedc6da66ce7a5501cd5fe6d104ee946c3f94727030358e98be577e6d4798982ab5aaee294fb85bf0369586e315380e42ae6353d59730768bb00823ae5b6368463b3b7c9eaba5082da55d573ae1cfb85a3680489e1d902d3339b4624eb88077220ec38223131e3020954ac1938728a5c33375a4fd58e7e3ec4b4e87eb19e8899535deaf533a1592c2c44f6539bdd2c8326d4fd8c951f77aa5cb216fd386bacb4f87cab937c6499a8c67ad3285cf823bdf4bf06493c2fdc6837e163afdbcdd0c5cd511533e79f9336a8aef37f4851fc3182fe8ab7376fb2a5ff888ce07d315e73a80178e82851857f8105399632a0ec273adf101c985054eec3bf0e570e11b1e18512226256cb8949e5648a88dfdca0518716f274c15869fb87502c17e5c3121f79e6778fdd9df88ef7cb95284f3153145841a27c73aba911fd3d24c4c743984b17e526a4f0008271e3ee5005750027891af7e0c5d64fdc40a5f6e5543e7584640312a3f2ffcafb0e76f86d3a83032e512ee67fa03771c74c26444d876d1b0cce8c92cda5815232fb7ecd616566ddab5165662757621566716626b414cdf5287b3ba156bf32bb132bd106bb34bb17a653e162f4ec7d285e958bd3c1fada945c5d53846e660972cd42e69500497efeab16e487da117f5db1233812bb5b3892ddc798e20a5eb361373fe8c7212cd93b6986f9cfdb9b8ba12eb7418a29feb2ba7e4a5bde91ee4907e7a61b97ad0afcd49be3e8b9f72755fe9e5b7232099fe79efa87207cfa5a5250b07dbccfca6b9d2d1e89e747119ca4369791d6d637dcd3cc2e900847b370bedac2475270b6dce644c9d740163f0f7a687720f2ed6b0e0a636238cd3db0e4253813daff0dd7efbedc51771e53ac237c437ba4d4855503d46bb41d0423c1071204ce14a7cb4811bd2a08b191b978fdaf7cea71d4eaf4a188d8ccacf30678344b925082376020d53f3e4313d1d79b0f6874dce73f2af380334061929b834b45a9e9b9213c2c95a1fccb42ecd430fe95e562d062afb41f18d5bbd258fbc52870a94e3735ad44b73523257660ad7113499b7eb4b123209586b514c2ca143003756d6f55cf13810698d735964e62d294c71369610cc65ddafcab5ecb6157f7745e3a045e527215dbd3a1bcb576762e9ca742c4fcdc6caeca2f3df5859f3214b9b6bca0f5c36d6fd360038b92dd469414be8e0a9f9d2e60ad015eae72c252620c2c73ad9c2325f6c8508f93c35f97e6a591095bfdb4c644a521107615727a57690cf0206c00720e2ce40f4a31345e0981859985bf0a40a2747fbe39e6ca8501a269f48efbce46abb9b0f843bf8d6579970401dbb71258cf8f5599dc0832e0079f2ec30c1039a0aecb643ce44da277c4de93c6cc205181a1c1683e5ce000aa62200d724a4c82d572b6a07e315da730f1097f4353e0d95e8e0a8244297e5a426aa61e4bd5f80009b4782767e8ab3d5a1deb25b657441449968620c08c8f38a6be6215c30573179d4e04c622083b6951567550dbdbc2e066b650fbcc30407e6969c194582d8de345e4c38cab7e94bf672964939967156d45bcfcfcdc6b4846166662e1624688b1286b599c5589f6b49b34928a5c9f8aaecfa1a824afd6062ea8c7983c649dc98d0c0d4a283e0de9d5599b0d8d9ed96e9c44723450b76c148605725a4cbd32affc242cc5e588c8b67aec69567afc6e5339762eafcc5585b5c4e0d4cded08892a84b9718564577f54808d5d152972d3986095e8f9355c027ac3b767b634a7561ccd7d5a5046e430800d3ab1dd59ed6ee724c68b94315cd45593b4c28cc58f83ccfd4a19d687f99cd0ae4f876da9a35d72d21b122adbf26d37a591d097973b0316d493a002112f66e67deb86088b1b9b52e5a66de5b124ef880457480e6424bf2b937459226ce4f57130f7ec5517ee28499daa17c9f5ff85ed898ef90d39680b111decccd46a152406578dc3ec8fab7af5c6a1080eef04f4468ba1a0bbff374610af3331ee485fb9aa696bd97470a2444a397f47de9e50e4249d94e9b9d82fcfaa13d99405894865894e9d9da526f2ce6f4b435a91a55ae931b4ed9c623c3c8bf76105c59903e7b793aee7bec6c9c97e978796d37aeec74c754f4c47c675fccedf4c472e740b4ba06634d8dbb3e30101bfd03b1261371bdbb37b6bbfb624bccbd2906d82a6eb3b3273625009bbdfdb1d6db17ab68839eae581be8551e03b1a0b433db5d318b80e83ab3d519f73dfc74fcc11f7c211e7ce0915896f6f2c968d208d033359f989e1d310a239c3332eb183d09c74666665a77a377a03f5636b6635aa631eb703cab901c43b43dfa43679b6efc0addcddc8cc7542e38100ebd20259d59ed7009f3649afc2b6c3bc372101e3870365e121ce279b15df99a0f0a9fb03ce13db4aaafe709244ce4e5e32314277920cba770e28117793346245fd348798f8deebdadde84b30d05f6bcc277efbdf7165fc4fd5f7ba0f8f6c3c4f84435d573122549d7eed9ddc935fc3492afba6f3bc2782eafa171ef30fc72c9dc3c932b7e9727c1b0398453386166865236c4233c1b0dada79e4c8c58b51eae42151213b979efd211b09c0e5f94c69a91f9b7a201e0d636056563d995323d59a45f2da33af2934f28e67b617c871c0be2c4b19b62a07f24a6e656e2ecc252ac1f3d163d77dd1503afba273aefb82dd68e1f8bf513c7a2efce3b62f0eebb74bd2db66f3a1eab6323b171ec686c9f3c111b278ec7d2f878cc0e0fc5e2c45874bd42715f7b6ff4dd7b77f4bcf2aed83c7d2afaef795574df75776c9eb825764edd115db7dc11b312e08b3253cf5f9ab60abbf5f46d71540c820041279b58e02fe6f29634590d4c5a58f098862f53f198089c8886b7ab5742cd787453a6bac8e75772ac61e4d06aa266d21e81423030095303f9a747d0db6bb230794300ad6d115cb53d932f5c3127d7647a2eaec87ca6ad25409dea90c097d6f3040a3fa5873fc8177cc89bc373f9ac1861548478ee4e850318227cd5cc346728902b38c14f3939a410a51d1d1e21c63550bfc90e3465ab826ab107ec70a9915099cda9d20a136a68cc12952e6cc45460040ec5e5f4b64c14fc45a2cc780c80f5cb7330325d4d5b1d95c6e1574c23e73d898a9f036998389f735fc711352f344f1d44c314002fd4328900d13c2d2ca8bd5a05374e03d076d9d0f2ebdfaeccb81535f2d4d24acc6adcc5ece7b6ca523b261d8aa3eeae4b812a7c95893c73a606655f266f5e1f1d1d8edb8e4dc6844c9e9dd66acccfca0c5d58886531d29ab44dc7e458741c9b88e99dad58523dd6d5c89d12904da5e9bcf574ecde7c2ab6248c4b7cb0e435f7c69004ae43e171eaa65897202ef6f4c68a847c6d6434ba8f9f8ce193a762576d3cafb21e7bece178e4ab5f8e23033df1ea7b6f8fd377dce4836fbdec8086036731996795e5979ad0550421ccf5a1352510b204188742678e7c3c73712a1665328bc54d1648eb719a68e6b560da55f1d404f6b7c7c8909b3012790226b560d55e581ab4a3cd3d95bb8d05a27bde6a68c92259d65879993133d68dd2c3039e44a96dad7ceb992ef0caf0d0b0f987388c75f7785a425b848e74940f2d189b533211e0672674cce7f2330f72185405d694ab26ec133ea019a929b915d07cae8c00240e027484e0beeab14d173f70083532b3e32a53f2dc4eff7c8fe700381f87e733889a0591ef1e90a7816088ab7b6fb8555acc06826bb9e050cb6a0a6009f18f2b0cd892e939ab069ed19869a5c5d17b3269618ac224ae937b1327511e7b75706316a6a56c3a017f3473a0338e4c0cc4f1c19eb84d66e1f0dc42ec5cba1c9b57ae4487c685bb2b4bd1a5deb9475ab65b03ae4e999a4b6b1bb1a47267998451f3750f8ec4e0d81169cfc558145eab1a9bee6a9c37d433124786266372783cfa60c2e5a5e8df94e63e77262edeff9598585b8d37df7422de7ccfed71e7eb6e8b89db8f46ff2827a1a58603576615fd4605c288b0413739cb0b4e3fde9de3d4689891b70b1e7bfad95858c1bc4b068612ee781162f9a1559b5ea213d68c4955f223dc6d2bf0660895bb251336db5065ab4deb92019b2c303757d42ef30b8bfe84d86a2b3743108f74b443ce9466db10463d3c83a976c0718f80d7dd39b42940786ecccf34e619cad773e7a12cf11f267c28ae3ae63b4cf0806b84af39e3f9e875be253d3931d9665a18abfa9388c52fb0062a409c1a0fc46b65000883bf56261b2689d504a729fe767efa23bc424dcf833e99205d62c4ae0eb45fbe1ee326d673e201b5ec2cbf969b65c36039dba706515ed362fc671757e3f262cb633f14df96e2d3cb17a30a82d81caea639428783a97983a083cdcc3daa874c22a94031fc704c1c1d8fe3631242054dac49e02e9e8bed279f88ee33cfc6c4d47c1c9359d73575353aae5e8d09f5c437099731c63b4bcbb12d811be91f8a3169b9232aee14d3e857a72266a7a25f790d2dcfc5dc43f7c7fcd7ef8f273ef37bb1f0e8837162672dde76d7e9b8fbae9371ea8e93317942823734187d2372c3fdd12d6dd8d92b1c7b853b73263d727c48be0825d4864e5bd266abab8cb336a367a83faeceafc6f41c8739a5d68176eef0446b5e15629f2e7e18bd4e78e85f6a3cb4a29ee5be5e79597260f8e5286a034f20b1684e5b8190c65d4a278c9476c7eff6b1d58c8d106c41dbd85c171e9b3651796d8d320184099ea5fd1144664b09032a1f11173f71cc63f2573eafe96a5c3a81e1a16b85afa9b89a32d5843dae2d704fe3bb7c8f3dfa78f1ed87f131999e221aaecdec1051173b984ec0333f2fcc0c9d9ad776da725fd3393ae10282ec2bc251bc0aaf9105dc97e776fcd40bd3ab71f5b4be06db987a0cb26b3e15b807973d80c88dba5194f25f13534d2db4e2e2ec62cc2d2e2bdf3cd2cef63f795407c6c63181d2d09e75c116bc30ed987dc50df2d2ebf8a8dc708c0ff6c5a49e9d14aea36282cd2b9763eda9a763f7e933d1f1ccd9d878f889e87cf26c7449c3ec3cf954f45fb8185d0adf7efcc9587ff491587ae0fed87df6e9d878faf1683df948f45cbd18b788bb4f4bb05f757232de7aef9df1fa7bef8aa3371d8bc953c762f4f8111ff9ce444a371f00e508f87e31281d45b7a88c324885e09af8e746e636f74032f3db3bd417e72e4df9dd474eeb46f0785ee98ab091be76744d97a03c21540184544fc9c2711867653bed75d4f59e0dd56b2d76d860d9b0b5ad959b2944f35a3ec2424740fb28037722c4e1c5621f45215a5ba878a6f8d684e2150ba1fca4233d617519023cf856e161d09c33b961cdf7c637beb1f80e373b8123478e9ac152ac541908539cbabc3425b887fe85b6f6e3c1fc8078f51969daf7faa77bef4554a5096312c3d4c0aff03a06611287fcd26cc9f42633e572550208e5f7db4438183edf752bbd59019e59c08abf5ef787931b78f7c4bc98ebc2dc724c2faf464b020d53d1104d0702e0c2362e6fe5921ff38949833ac36601e46557be4ed4df6393af475a87175107b997300ce9f990ae8362fea1eedd18eeda8d89bece9890504ca8849ba54d8f6dadc5918dd5b85982734425f5aeae44ff7a2bc685eea8dca0e831a27c47264762e4c4780c9e1ad3f86f287a8e0d47efc470740ff7c56e8f188ed78c945f9f84bf5f82c41bef740cb9ac03b3aa0ea8247734544e26a74dbe65bff4bbad7a3dfdec15d1847a6b8cb451e982862b3393a46563b43492e9642a9119906d52e99e42924f31f51010cc608482711871d85696e6a5c6c8ec74d1989ceb161a4d263638c3a5d8287418d0dc1da5ca866fe125fbf4cc589877b27c84ae6a37e3e41f4a5642aa3c48cbecefe8c8dea1b84d78ac213b6f78c31b8a6f3f64ee0d684ae9f5663c6f3e795a09d5289812fc924e6dcd472898f2acc6a1b1fc9c96d31faec64320dca2c4211fb9da036192d4fc317832cf7484d9ec503acc1cf2b170953caba9812defa965985ebd56352100088bbf795fc39ac43733283b8dede3b2ccab8bf32b31b7cc99991b6e6c3768490b78a288ab2a08a6359cdeb8be23e66fb3db0495400e88d907e5c4f81df277e22488ccdcf135dc5e997d7c7ad9d6df2e9300e4274690e06d6f72d892c621dd3217e5fc4d879e3e99b5bd3273c97740f90e462707da4aa36e6bbcd9a9b09ee121c563770bf4101eea38bb79d5c86fcfa39dd1d6a283843f8743a2034e75621cb5ac71168beb43a3e371797a456ed96ba25b3bea94f8b9ca987cd0051ae0a0673a9a3de992aed208bfb58d9c699a4da3f8d99eb40b3487866cac67bd0d93736a6a461d2cedbee3735df85a1159faf87bfd1054c66ff0863949cf704cc4104e3bf1ab5a8f320ce2857509b579195e51a6a4674c3a393691710ec08bd27c9cb05bb51f0bed872db6f3dd314e5f76cd0a508926985e7a0ea2fb00e4b9ec738e6dc8eaa76ddd0ca77d6afcd2566da8820331303159c8ce9d28291030fc8124ed343ccf5e782fec30b010a9f7660331931dcf4e2fc4158dfd56d4d5d3f0ed575f4a99095cb3163567eedcab0a279f73ca64064e661edfbdeb19949048389839ccb18ed2d023c3f4ecb697bf9bf4c1162b31159c29a6628b174cd68d204177c517af5858f2ac2b8433a4ddbaa4d9fa3dc6e3db0dccfe919f4f0397f0f5e839df0aec9436f4823ae631f8298e2ba1bcd1606bd2b0cb8b8ba6b922c7c38f5d88b925095da704a48b75b334dd2a7df71cf7cdd66852a74286d95aa0ae74ac8d76e24a5b1156c319ffada967a4dda1316b778c4511380b4c719ea5d495fa70ad1d742ec667de80b2cd67ba7ae78e84313b77c551616e63fd4d68087610e0bf2f7ce14bf637e5e9205c237cc0bbdef5aee28bf8cc67ffb0f8f600f5cfa221bbe4b755812d9cfc988095a4224bf1a9102aabab055115a292343657c2ddf0dc1f70e4c015f03d842e0effc1670044b456e9e21511690f767b6026280eaf933020679cc63d767f330f085ff301aa3fe3c889f1c5a9c1d6ddb3734bf1d895a5b8b0b8a6de5e1a48261047d6f18d011adebdb4d32b4fa96f3a27a6d5ab69cd0ca26713c15579a20dfd7e9dcc3ebfe42a1393b35fba825df598b7f4d85b2a27cbe0805b769d60f279324782c2ab459ddb8a2f6db82bb36b1bd38b1779dc83532e5a91c393867cd2174c0db87ad2a4362bb94abd628aeec8d4f5ce1d3dc7d1d6b0ea369b0d6476afac2ea9b3e88bcb0babf1c8f9b998df9070294f55df34af26a60f09c6f4f39a1ecb05b41d0e46a72d92c638530c0180561e5b6427e457c4522e9257102a09413784d5dfd6269badb7fce2b3088ac4a8ade92cd3d5fc6b1be31054f80541ace1bc3ced2f40a91eec1462971cda95ef1eaa643986336c5564beacdb4b1607e10b5ffc92051068cad24148ea1f8077bef39dc517f1d9cffc51f1ed8753ac19e98a6b02b4201046e307b2604ac5dce3c3f0841662b8472509b529b9f13cf3d03ffe48af9f7374788993d10ad0db654feb729437e522080cac117fbeed966f7f13bde690e03228afe1c7d128e918749786536eab62c0abf3cb3123edb7bcca840e02a8781af4d363d6c6acf8564cd3afb26bf93ce75768d189000e0f46ffd890c663321f258892504725cfba38cdec2d8e575efc959eb59627803c092461035f58d99323683209281fb4e4bb7a98b2a09038a50054fc0034ad2760942617d7d5469093f2798155da7e4975e7f3679d12e2071f7e5226e75cac89c93744835c8bab5a0521dba33542996eafbc4a6ba0a2650d091dc943f75834eca4215ee5219b90ba561edad2fd858b17d51e2b7eeba125ba249db373e6791b14ccc60b6b67fd78c664585df4cfb722f680ce11a87c0b8c8d1d3ede6bcaccf5c67bc0a1c2f7f6b7bfbdf8b05dbf567cfbe1e8c4515f2be1ec84943bab863395146e8215c471c4076a4588e3f4bacd9e36f32b9d8dffd53c9984b15338843399e4c744727ac5ded862dc91da2707e6f9fa09c46e970934fcfbc20b547cbdbe4580f221af4d09f1a5e9d978fae24c5c9a5d8ea5163d6c0a1f0ce3dd14c6ade2ac5eb7e06fa7a228aee66fc18389a0134caff159cfa804103734105d031a0b2208aaa3a7fb1bcea69ff2f28babe028c1b16695a075f1ed84215d076556b17c80096accc464fb07d409c64782c75893f163153ee84ffeea7456d8c5a2f1ae06a671e6e25c3c76e672ac5277a593e8e546f4321965e62efc41c96d5e69b883006dc08b1f57656b1c110e68e5319bea2c4c9dbf6731f929afe515b5c5f292378693779aadc9574eef8ec50358fe72178ee2d50f632264d96eaaabdab03d29a31f7ef2a96e74f870e1bbfffe3d9979c19a0f93b2ae4ddc7fff0387ee74b9f9d4699b2d4d220a1f13c76666710e2be100d7aa15cc6c258cb18cd8ca71f5d03c019109a9035d939bf610cff8f523da4d0c81231dbb1420361a93f114a60ea768d3384b4bcb6a10d6fa14b7e052015c806678ad5353f3598b285b16777735be6a49fa9f9d5b8eb3b34b7155a6d78a342bb3722c3cfb5d38efb6503ae1e79d3f85d7936db23cd70b9c299b3f668be5766868189f899761099eb460e7a04c1f69c6dd6e45140359a0950ffd3f42b72d9eda9180f95840848e25045d65d75be031f5543339e8af4e08e65218e65f5e13176887e9ee857185411ed34275e18d87c5c56555a22f96363be2f30f3c161716d6624d71d0b5e0c3f71428905a563a36a1797fd8738020e856cb679c05d031d434e08ae0249df3ed02aef02bcfb10cc8d9cb418a636b4880e90e76b42b663f7e9bf3ea30f0fb9522e563b31cde2ab8909ae79447c6c7265959bd169a43b5a6223b0870e8a1f07ce3be3e9972cd0fbe4368906bb76f75104f17c05711a5329d89e8270da8e90e00825885360bd9839a174286790240387a456c6f06d9feb6b9188294ce47eeb9c0e55c0f7824e1df9600cead6dc6d9e9f9b838b7100b2b62429b5ed99034a82762e4b2a699e7beac4534ee29afd2ce74d43faf95d141f54a6ba1f9a40d3b87245043fdb1dbdb256113d32070acc7711092846e47e13b3233b7e5b6e476e8e42512f50d028e8def2cfec4e7a0a3ec14420b5f6570d5818f6a2e2d2c454b75de102d1f78fce978eaf26cac86c646ca910d07b094db555ed21c4667ea076469fbc15914201f0b5d0de35e6d0cb8cdf583c6c4c3bae1fb0d7ed5486dcd788e7b4e298396ae8f9c77b1283f78806b726d1e0e965b1173a28efcb3bc5c2fe696f86e277907149ff5ee83d054564cb41c3cb1ac09d715bee6b8ef939ff80fc5b71feeb8e54e61afbea04c555b17d33760db38eb2a146240dd99985c219c1cafac78f2447e06bad4904a5707b100d2ed8303b7163a0deeebb715d00494a3f6b05be0fdb8964c4ef090b346ade56416190e2e8db2f6f98b931e93d0f13f056a5d81e71796e36969bf8b8babb1c4da97c6652de1b2ae7120a6a8fa00d58f32e9787034bc12669545423d931a47b3c252d4da7227e16286d27e9cb45a1747fe0dc80d7645cf50b7c6873dd133dc6bd72b0dc90488972d24842c13d8ec2247d79bb1a0a8b35b2641aab4ab54ff1054379d04c8e657695721c9b9a5f38b6bb1b8a23c7afae29c3a9bc7ce5d8d15de96b71dadb8b204d030d951eaaa3a1b5457a16f685eab03680bc069888f6616ae3eac7787194cf679e6db13e0c35a1b9fa5d67f998e988f3b1a876bfcab2833d34bd24ee4461be1a10d72374be5ab7cd325274f72294406021360ddb903c6565b890bf11927b37d6e5b68327e3e7af418055c039ffce49eacbce73def29bec381763e147ee4477ea4f8227ee753bf5b7cfbe115324d11200b95d472757b4c8c5071d913426efdcccf9ba07b552ca3133f430f039a4925e4af944327c01a1ec2cc24cb2a1f8754af8963acd7df3f901332980fcadf33a2222c7e5c85a6bf093067f1d8d15750341d33e39da72f4d7bf9617a5563228dfbac01f9308a186687193f958d80e312c03b2b69c6e7a73c6bf1d59f3d3626a0981bc798cf633a392652e4d88de26b5f9784aeacd1f590467922b545c8f66896c2910252712865e39037cc5ecc55312ef8afadc8dc5407b3bebe13332b1b71dfa34fc745dd6f849857c4a89328a9e968671c6565fe005937a1defb5af11012d565c85efa7cb361affd3c5bad30c66dfec009ed2d49a4edc9ce6fe58bfe1bde8994e3cf3a06ad50352941e499fe3dbc2983092dca8196cc2b40a8e393870b5f5356defdee7717dfe1705de1637da29a9e6c103dccf41c1b19f53ecfaac17292819f1017a285fca6eede7385e83e2753d211a73c51ae354d8967bf3c767a2c97132dd5a9314a1e302a26020091189f40bcc5c54513b09a14109646d81384c3a1d9080920b01ffc4265474f2c6dec5a133c717921e696b7a2b5cee13b39d5ce074760909c1848b66c6755eae489009849f5ccea162654b8d703e5a81393054c82d49948d60439161e7f570fdbc2703d9e5cc8098646139b6059276aee9a65611aa2c9e1d7d569f02b0642c599978bd274abab6bd1daea88af3cfc4c3c73655e1a5ea66fa74c3565e4ba59ab267dab063b08b55e15aa8f9884571a5430fd4b3e5cea33dab90a134296f1321fda9deffd634ae65203633ff10934149d7c151de149beeb4edbd069c19fd5f94b464eb5ebc391ea4c6be2d815c78ee484631330379beb7bcf35d9025c57f880a6e9f9a9dff9bde2db0f77de7a9b4d316f091388b4eefdaa45e32644fd09716fb62d6154c2fe763cf56a456b92474e57037b0d6168a4a9e6a3b70c898810d97b0d15ce99228c396804e230f663fce072e52a34fd40324ec1e340dc7d609cc14571c567db32bde6d7b6e34969c03357976256e6d932eb615b98c38c4d1044316871e4ef6c4a67d02cb332a0b51ee5e347538be1d06afef4193b57e4782f8d63ff98d98461cc5c622c9c543b689a0e5bc2c326be7fced26554c71879cf150d20bc77367735ce5b8dd9b965095b673cf8ccf978fcfcd55894bdbdad781e2e90afdbaed24f654a203ce6e3a601dc6707c84d8601e040180e3f909d2ff827cda005e9eb5aaef136ad1cdb1d159a8cbac20b74b6c45be1239a859f56c50ff00182091ecc8ac24fb6887425168ec93bdacc61a2231d52157616d629f7207ce293bf597cfb2dc7ebc1730a5f33834f346cd926bce2d63b9368205cc2002a4665d5b4beee07a8da8c9df1201099b8c1e4dca0caa79d7179e69e8c06d473d29849744f38c441d08847efdbd2a07b7878d8f9d7a3bd8176033b5e3a80f0ea0e3e4bc08f9064584e5ec8a9917734409b5d5e8b339766e3f29cccb47599bf62c23599a19bbc7f86007a4ca43ccdace81ff0203f72db2b1348bf42ad8d140133528c80505561ac57fb31450ba3a4f6523c5de9e5fddcf5ca3a9a195d68325da98ec18be1a227b45cd63876666a3e9634b67bf2e2d5f8fa99731ad74a9099b8207f254c11279d2f89bfcb4957eb64a7e7194e9c92c0f5e65aef13dcf1e4030b0cf800352f264fbc81da4227bed850e7ab411f2789a18596256868c8e3c78ebb33268fad0df1007989175449955c4c49956d9e55995c013ecb86bf76f200f7a78eed4d3436a1a9a09ecfe4049e53f898ada94b0e6cb23e6cabd9e913276274685415eaf054330a9e1e3167bfd46b298ea7a0a99418a16e3486e0388896837ab607adc5ea5acb0e415916c156d533318b961f2cd988f9a5a5b83c35256658d99b5c5123b2931dad07d0ab3165bfb1a341b5ae6c33c23481e09847b5f120a8195178e16a7875408d63a4e98a993e2cce87f51af7acd396c8d952f8e585e5383fb318d3323f97a521d07e2d999feb626a3ebc88799687dd2675c83cf1c174aebd79966bfccad59a40cfedd06a1236961c189be572428e839cde42a870fe74c519d710ee080ee94b5e54275fcea73e0c0f9890d9882d8d95e767e66361b115576717e392c6b4d46743a6a77782286f70f770c29339a4a37ec5bc677c40e69e9069b8423f26698c0fbac6b8a56b4fd8a90c6b56c2841b05560dd4c7be55da48fc935f202e7929cfaeee7ebf5c4b87b78ac5a3780829e9f84a137302f00390e6311e95526857e9cfd51a16222a0f0419813f7de294d336810ebf8ef798e1fc86351fd09cb1f98d7ffbef8a6f3fbcf695f70a77662f452cb7b602edf0d3a0a2916ea9a36ae46bdef3a6704ecdaba9a2bb9f1df5833299d274ea1be88fbefe01138fbc44e7e81f1c88a3c78fc6002746290c427a6a5f0e4241201a9ec372303b10c4baebdd8cad3455b05e305011d7a9b852d12a248451ff75953fbdb01057a431e6a5393c0b271cf8de03c71d78fc27bc61861c2b55eaecc7cb79d6fc11a05a8efc2e1ac00bb3d895787eae7aea31c204bf43f77c3b21e3797c470ce2e12df18d0fb809dff9f9c5b8726546c2b7aa8e901d23580e98b4bce4970cda76e4ad2b75a15e55abd3c6c96638f99b34f4b31a279deba72be32ab695c128291fe21b2148dbd189622e6ea953a5acda39e5645f7881bfe53557bae60e77e6f9da1738ed8d17f9d22d828b90194c8e824b292bf1f4ad9f9d3a71d2dbca0ec2673efb47ed2506c67acfb5c450e17985ef477ff4478b2fe2a31ffdf5e2db0fafbbe71e37a64d89c2d820eac6f65da9480108c29d48e5714b9a4ff982243d1d3b3538b488a3fab6207419ecd27bf1c1c2fa3e15cf202242c73599183e93065a5d9399b79d9304ad75694509b83b3b95adbc9af8dc38908632f63b182d994dcfa181cac72c5b96c0cfcc2f7b8abed5a23eec2d95169749d0fee211cee9418e3c129209c036fd3916133dd5623c22acba664f8d06c96b8d27e79cb812bf6460ea27389c1b59177ce195b3331785f7658d5f5b3237a3934f2cf3bd0be8ac68fc73f414b4ec402414f2d326b51d0ed2e97af4b3abf493ab78b3034754b2a35ba3a3a5dd101e2ca3acbf92f89a824f47bde6632d7a7db01202cc1aaf67bac95df1f91cb413ea8f31339d9952a655422c97adabc2eda70839e09693a78b6f3f7cf4577fadf8f6cbcc73c1f30a1f52dc343d0f9ff51c89db6e1652aa90d7d2602685bb27b26f0f201e4f21056b26d602e54a9bd1c375f7f647774f9f9828cd28880d405c341cb35975cda60a271a0e872002737373fe820dbddfaa4c10765d206fa43908d9887b0ee6ad6e3f90f6a03b086a48e5e16f10a82e4badcd9859589500ae8b199810828952f87471fceac00f57c1f81406300be80f9a72852ed43505ad0a1e699c54496a7d145eea92daa964a74c6a07c41501625a7e4b745d538775f9c2542ccc2dc5e0d0b027746058cc77444419390f8fc9048c5f59ecae40b9c557ae4d206ccf19059c71cd7ab0de06fec2ba1d8f8f6bd638a681c07b76d56123f4352dfcc6fdb08642f3738bce7f7d0d4d9ebb59729e80b894a09f9ee78e95bca71e89b5e2d091c9794946217c22eff8916b9718580da8732268bc1ffbb11fb3fff9e079850ff8f11ffff1e243c20fd77eafbeeb15ee5d6cd2085306b7ee892c51f466a97198b54a8a73d1bd5cf69e30a3ee75ade1f54397ccf091be12185381cf3d11cfaf8228dce33c5d1958cfcdcddbf4e8eb1bd07d4b66d3b2ca60d09c8d99a5ef01f998d8ca9b2b3837e3f0b8de5713c957e304d3c3dcccbe15d348e1521eea49f5bcab5763a48885e5562cf22963996f6b6cc21619a8abcb52a22c239bdd50ea8aa35e00bd765b984ad9358ee3355c332dbf04ae8dfaebd6b40607da49f8b09e77f1dc257fb3fcd8d16332fdd1788cbf972480bc4748b999dc6d0b182fffcb7bc1c132abcbba3c9fd37fc583f1b94f1c45a3c21b7414c4e28ad55085afd655292578f3b1a43a2cc874a6c27e1f4f4f2c80ba377fca91165a7a5245795ae0a09bfcf0aac3744f26b79fbe45d76b81e1587d8b01c1bb119313b821e17bef7bdf5b7cfb0b6ac2ddd28eac47b1f3004dc6409e41bd3017d3d023b14d897121444be1625702558659ad0921acae79af78f22306d68acace8e70d2c1d80cb275c514d58d4c550e10da8c0531108cbf2abb9f8fe66372b29e832941b99822e0e0318549908ddcbed2e87ac673f0f6278d094bdb4c57b060e7047eaa984c0e63986934c862b2817ab3ffd233a16ae896cc9f65e1b3cc41471b4c22752a075e5b2993534a4fce42adb8c485ab27aa6002ccf34e753c1d38b6bfa8d3e9ee57197d194e598ab723daec421f5cc070d90eec08b1bf10d49f9096e3fb0f1c433f7379c6af0b4d8c8ec6e8d0805fde5dd4f8952180371d8bf6cc166687519c9075072afa5b8815964e451f04c8dc74f089eae61b5d8d96c25c5f682907d9f9fe1faf9e01b43faf5579b749f7deb10e2924d04de6bd2ca2c191614fd0d99814199854e2880c26e8e0d30d752668749ee73d75cc091dea55814f22f09ee461132dc0473fba67723615d5f34162fb3c80d959170c11bcc3265efa65027cd7eb5eef5e57cde1cae42c981ad60eb6a2b1200e31109ecab47eb4afb13c932520a61b8746213f85d71d1f1660852158100c7385856d1a0d4667a7835fb094c9513515d7cc1a3cf31e06cfe2cb3d6471999087fb4c6b6f899900e351c73da7004583c179b3a22eaeab51bb932ebcf9be2ae1e325dcd5759972528142cfa28c43e82cf45c5d820a15332278bc5f96e6174227bfeacba4019dd02e02a62b4c4bc795424c7d4a3d25709c786d41d6436b129668543e7b215b1a1fcd5c9db28638323111a3a3c34a83c99edf41cfb7c5d1d8748909d40726cd7ae7b5c9b409598b748089d886bc734ec25f3edac8573f482879d70e0ea0fd71eeeca04db9028aeddd45e3e313b67c38bb87b35239d99b578d8c8df2674dd4b3bde51ee7c93b096e2dc775923b79f4780c1f724a197b397140534e6e046e48f8807da6e775265edefada37aa71934895204d1308523b0c6657e59a3d0c57cfcc951f3da01b40f101e2667ed9389e2e462392d679f2b1c40d99752b662028cc9a0fa730239036c7cc844e217c28137fde27a43fd7f070d465efbee25a8132eb64497575db165857b3c6b8eb671359f930530753d339308e627c985a38ebe6c1beafe9f093bed22e4da3ae1c1bd9ba508424afb156b40624eeb058c58f4f48ab4790f04998547e8bf34867664cbfd1d13131eaa069cbd7865634beeed5bd383d3bb92609e4872666506e69c3ea6a847daed0dbf54b87a0182f7519f86b1bf819132e72d9e96acc26fa559e81165e48aff4d57dfb59210496d8e2c2bce31150dba28e95fd068a9ed5f4007c42f2e4adac07ee9653879b9c2f56eb0134d90d41d396fdcc67feb02ded4d181e1c8c7befbccb15b1b9a0301a3b6df3241850af15b873486d38135050346625aaa3c8619e6dca616642fcda5bad2c2f7b2cc84ef645991b8b8b4b12404c2112ca9cd0d53dbed2724d3c1297ec2ccaba8e3488b56b71c433d32b8ee3e997f16b3a84907cc12ff3ace10ce059f2c001bc37c60412f15b626ed6a3d6d6e84868e8d498ae2965ea42af6bfc0197a1a7463969435896e840e3d404d7b5ba363d6566b1c4a34e6a7569d9935374080312327f3c049a4a1bf29ca51e268830e119c78a3b5d08c29075066f902e6dd606d7e2001c40ce00add49148b37a8c577a1b515affcb4fe1ae47e103ea8073bb28b6e950003f25d329cecdce3bed0266b3f0777b34b41a71b8779a1266bc5d1674cfba8d8e8c1cba9d8c89965ff9f0ff56ee22defffef717df8dc10d0b1f82d7ccfce77ffeff5d7cfbe11daf7f8b2b547b14572affda95442009a80ceade4664244e21b79ec3d0ba880000e9c8d74ef9fa5511ecf3d243b18dcc4cb3b191635225f3c1b632ab52f894b7f274dec565ce0aa1d16b1871ccc1a57c3beec9c26c26d4d207bbd9f93975a92ef3a07ede81220d45dde9201000765478065771d739fa40daa52546672381c7a2764d86289068081231e2781b979df256fd3d91405a39ae6df35257e8d3de6ca0f6595567b5b4b868d373a06fa03d79552aadfb5ee1df63cb81a51f65619cb30dafc5af8a9fc31d97fbfd8e0e26fde453c2dbd994d6219df148e750c5a9dbd5780efdb27e29844d7c181372c610c77a1c3b76ccc2d75a6bb9fee4eb7565c571fb141e64f6dccf9505e5b1966761579977dd7aa7f33d08cdf90f16d50ffb1ec373c10d0b1ff0810f7ca0adfd985aad27f236e1847a88db4fdd9c84d17dba143804c51b57cd649840f861083103cf0ae310e6e7f4ae642ae2782ca92b7e45524fa9f10bf1e5d645004e2c5e9229b72066e208b9d6aa6cfb1d692d8d851455f9a80c8d619c63c9c74267bff2564c1ce5a8391546e7c0633048477f9c0cc1359d055a79d088983979d810b1a59dc5b0160cf01463a490a8e17585937d0e89d272de648bc3675b8ca918fc2bae4ac43186cbc90765eaf2e995e9505413e2a2596126e5c91addaea7594928dc330392984efe3a10e56b1cbc32bf14cbf38bc27f378606fa6c31a07d603cdac0da5f8eef192cc83c5e562701da5edba35d944e94301ed4850e2e3b39d144787a1c9a8dd776d004cae0a7de3803fef4d9f8043c0399191888ebb36e681f955905a7c6e1da767a9e0769ad6b5c272154dd3d8e2bf9306431bf957c5c3e79e9394aa3a9d511c293c78fbb8c2620741ffad0ff54ee223ef8c10f16df8d032d7ac3806437673e9b8537e14daf7aadaf162c04c9c2a40a290cc681d254cc1525bc5494d633938a30bcbbe5719d1c3357f462a9f198b068655add7365698181f41aa69118998f3db2be47f5106c33aacb813b2a23c0332a575788df16401abdc4aae1c92834523654b25d7606c86205aae09416581858b16cb6328396426346b5a064af0aaba299f83edeeaf28a3438934432f9f43c4dd12c4fe83b7fd34a373b745808128c845f57f2afdfc7b730fa3eb51d662f3bf337a40138756c7d556339d189b7b65d6140f8927f0a45ee3e5a50a7b628d3980f843223cb58c8e35cc5a8c95253e34b3aa1d1dab428e05bfdab6d8da3ed01ca8396089c0fd6e25ac66500fca3205d53cbf18c76071257e89cebc17e2e9ad3d9b0b98209298627940435e123e2781ca9f2cd97c285f4944341ae8fc28877f79daf741b1e845ffde8afb7950f6fab5fef84b2e78217247cc0fbdef7bee20bdbbb8769bfbb6fbf334e495011167ae55a412a4723b8d2f84b23b8f7d413d84c9c28c6d1384dcf21303d565e155ed259a0e567f66a6965391696163d19402e9848846346acb4986c515e6a1f915a8455590ce071ea63d3f9490ad11eaf08d06a8c3cf4532f9ee66479049eca434d6847eee9a81d2e81c606671ceb635c61689b827298a4d41f738fb54b4c4e7a5476e5700233c75e6c6e64e7e589124fea645968f1ed1d4cfb86dbd9ebd11112a6d14d3b091dbb3c56975765662ef913ceaa54ba5aefe2a0434e3aa44616d9958fec063933a781c87bed086e30f35efdab6bd246ae5811d0912252b66aa7a870e1939b0aa00d5705cb4f9f072d15d10201cd1040caa67edc43371c61081cda8ed9e15c22e9b1609316be207ead03f1b9a72e5c710c67a80f8bf8b7df7aabe31d840f7ff85f155f5a842f065eb0f021e175d32895bdde7ecfbffe8e7766c350b142242a08105e2bcd1501a3f7de9289b3bdc92b1e6a64d660d653c36de9195f1c5de5542af5dcfe7aaaae4c14cc4c4f4bd3b1e1b5c77b1117d553738a1853ebe45d7b34ca36d31b1f3d977f4fe2b261ab7431f0cfde3bd7c82013828800925f2e34e73d9c517b7b03f9d0b6822e357e968b9086850c2662b19ac62d29dab428a57b16ae25530f2de8b1a00436276d926e36dba197c2b26e683ef90b1d53138aaeca8799dfb5d5d5682d2d4bdbadc68ef212c66e78ca8321aba313241de5780c249cd6646e7222599ac3aa8b9c05415019d6e94d1307675ed0a101b5aeedb24c6efcd04f571eb6d3e8b99c82fdccaff4386ee6523522f7e000ce75adcff798df32b7a925e7cd60026379908e34c4771d945d4defbcc94f38983f747dc5edafb0163d080cb9ea842307e2dec826eac3e0050b1fd0b46f313d0fd37e2735d0bdfbb6db2550799e060264d3a7f82d048558f84d1008a1e73eff4471e76767fd0557c67479749c18ac30d48a98092683c4108bd9b92d6989ce0e6910d947cc6e315b57685c844d4d2a21e187e039acdd29aba978e6f8a4c8c6e0ea456993aab0acee7d954b614c13094672e3957aa111601c843ecd355e83d1d8d0cc93e63550992221cf8884711002b4205fdfe14b3c0824e3181cc24127b4b9c901c15c45670ba8e82c1af2cd3ce886e0ad291d2fc466fd1373773cf237e903d356535515f1fade8ac6a26bb2394562d7234d751216b03769019daabf1da67a54fa51a7360dedf6df7b3383ee73d65341f62b8c4e90f62ac5d2f9a0f972d22a0510070dd32465df27749782a0eea223137119a7d33c48587dc712c733b4a308a13c3a63787038ee38e453ce4073b2b16909be50a0e62f18d07ef56d0704ef7a63bf77bdedaf6054a8e74c61b2796286a3a1198b2170d9d81c55e093c618bb14f389cf68218cfec6b635859a5d5708d4d3d325ad2006d3f3151198574796358e995b58f27555661b470ad0506e58f7b0988ff853686828e86dd736c1f8c755a4919fd475936d9a450a77dc74757c933d756a400e6af2614d683eb0b609a51e5711d5213b6fe7e38438ea440e64ad7cf4033f9faca5b88ce130415764367a7d508ed9dd962c015e0e65896555e6f7aaccef15dcb24c4b091de33b7750cade5570fe798596155c07eaaa48687544458de0baaf427fd0733cae8aab4ac0ac4ecbafd403925470fc729fc22aa7fb669c6c0baea44d9729c5350a67a2498d645a7916584f38738544dcf93d4534932283359d159ba937b7e88836626e7e3e9e3d7fc1d6c3dc9cc6b9d2e22cf5d0595a835306b82b3f9beae2c3dc09d511afb9f735cfabf5980379a1cb0b4da01d5e14fcc22ffc42f15d7fec77d3f1e3f1e6d7be5e95809920342a1fb3889e27351ccef784237832393d6e9130f6f4e477ec9251105809a8c2b95f96e643a8d93ac6186f7e7121d6740f63b3ed4aed207e48c6a547579fe8066a9b9e2236577256a26cf3bcc98b83eaaf86895c12603b5894b2145159f2d0cf196fb0db84cf677180123b587845cacc0d3b430335bcc7c124d37fe381003a37e7249738e187097cacbb1c75806bcca7c4527eb836900f1d9cf26726d3c2c663e2cba17f9ca99328803f972f0fef04ea67ad209aad48ebaeb2319d994eb6a19111e595b6dc2bbbd60101cab0ec444a3942b614ef67145581e4ce03e183bc9c904d5e0549aede56271a300ca04ddd892a0cc7320ece9331aa9db5a6f2e0ed754fb4881cbc137a656a3ae6d531d3d17898a307b63c548ceb2c3ff5a2ecc1c141bf3a74101866fde44ffeb7e56effecff8b0161fae2e0e0d8ef7aeb7edfff97f3280a98dde33e1a0882eada54f9e9f61ab13a1fa72e8799c57a182605e617a8fbb803111b26e1bb05ec64e758f1dede7e6b0e08cab7da20aa9ad4b5f5e78cad89947fe969e905b799cc284c4283a4231e9e0433821f20746a7c3102e5e0fc5cf8faa9feb977559d7286364f4e036a6e9e31a48ee5fe7a90cc7d0828f89a27ceecf97214280ab1e8f92b0642c5b3ae3e755b0f36247c741c9bf23327eb7603175d6b7b817f854aaaac1726b61c34b77369c5494898ac72fc1a06205408129dad1e1e0078c0b822a44eab3650f95b1224e85fe9546726e1354ccdc5c51515c9986f272e5ebc1857af5e759ad498e138f016e97194f18657bdce791c84a69281ff7ffaa77fdafe170b2f5af800c67e55f241ecb05d2f2343c3f137bfefdd26941b0c47ad0507192b4dce22a4bac2b4362d451c1c444340d12e9e14e0fc48395e195950af76e1fcc598ba3a13572e4f799a3917b52558a841811b55453346042a2e95f0159f36aeba3abc2d5c0816e3bbec7911fc1a87f187c7211af85706a8f52d251b88ef1f99093cce1090074c54c39bf8904fc5a7429ad13557e264be59d25e1e783db62de0715bc1cbe1ce438ef468374c4a0921cb1debba6713f826b6b28482e233cfc49f7cc89fb0ec80b2534d34c1847bfc24493ab92c01e3aaf41387e501963ca8331a2dd7187358207c28c7c0733652e7f17eb8fa360be5d7a50623a5b82c3da1b11140f865746cd4c236333313535353c6897484a104e0af57de71779c38e4b52114cc37baae7710be21e143fa6f64d7cb5bdff496b8edf42dae2cae2e1f54cd97c29504a803630801c1885f0903d1212a6624d3e0ac415dbd3a15d3d3d3ba4ec7b2c6444cb430516053538d29bda44662eb123d1d8c934c917eb417573516ed2547d3197c0f3367188d9a7149ed5c95275aaf98406ef4048f9bcc0c3c1373a93ef4bc55088c81d202140d90be32035019ae32563ad2edb94431699a08d7ff359d70aa15284f9ab7f51886b6204ae83c7925daa2f938fe7049b46c6de474be81f2f4ab3890997c2a2b279df24abda5a978eed2f6042deb8df9d87c960e01f4db20aa7aad7fad7bd2980e3af769561ea97110bc8c5769032d31472316e697cd5f7cbe998f61a23038b2644aa628e7bcc07308174753bcf5756f729e07e1e77ffe7fdca7f55eec0c6713b2a5bf0138b8ebe57a4b0fffc50ffc301683679810b6aadd6854ae4c0cd0f0f4cccce671f011f1b8f7e6630922849a9e9e898b972ec5a5cb97256cac59ad7a4cd9afb1a1cff550a39bc7d5c86c31e2b053bf0960a7d693cb3184b48c6e3d6e6b3b4c2c1a8e38c24b3f8c27c21d2672118fcf12e7d757c99b2d59eab5f50ca1444019ab76f7b2c491b36a30191d80c78a083c04c17c8251c049212ec1261b265932d09e530c2702a85cba1a76305efa93c9c129410f841bf5485cf387d059b07465320ceb83b5d1d666474ccd33a1a511ac92184da5a77efc9ca3caa90c4ffe6d3c7c571c0835aef228be70023f68ae2014ab45cde1ed947eee7ad865189acf6bbe98c8ba3291573f014d674387473b4167003e9b9f5f8a0569bfabd27868c3b1f1899898985499d28acbcb31b7b8e87381def1c6efb6363d08bc44fe2f7ee97f297711bff88bbf587cdf182486df0030e3d3b47d7fe667feef874ebe4c8c8fc7dffcfef7781adc5bc32470f57cc51446d6f22498228e7768a835d05e8cef104a1a013b9d854f66ac262727e2ce3bef88b7bef5bbe2ed72b7de72731c3d3a61c6f7943542a8729595b76be1f70141a5e1abc0216c16b8c2005ce1348f0b0b752c7c8e0f4328dfe21c462f6ee14b4d680651fa3e75069c230373dad45366ac45f26e98358c2a4827910a054f62926201aff1bf0955d8f684ae6a3ddc1e93c3c3079b95425c902e0547bc2020c7124bfad1d032e3c5d4f32b9b717986b6d98c1ed1a25b9d913fe5c64ff5a4bcbdf29db3a0083248189dc409207ee25868cf33aee0ea7681e608b2fce4491afc942981a04e0e531a342442085d298be51c26df56d7563dcef7cbd6e2110e4beae5db16faad89b7682b8ef7387fe172ccce2cc4f8f891387aec84378f7ff71bde14b79eba1954af819ff8fbffc89a1140e3bd90d7869e0b6479ec91eec50288bdea55af8a3367cef8fec77ef46fc7c73ef6afed3f08bffcd17f15e72e5e30f3d50671efa92b6100f7c940a58140b1342a13177e3f4f8f88c3da1626e5ecf47c5cb838155775bd7c99b54134abc8aef8b58acd6b7594915a222119842b020253c36cd99bc27a683a0a77da0e0df675adb38ac82b5a78a07737867bbbfc39e7dedd4d7fde7972a83fc6248ce303fd6266b101cf98cdd518b147f5e8e5c469a5edea6633331d4831b74c1fea2a3c71fc284cf8659792b01737e959c3729d41b426adebc655f892073914fa70e5f5a255591d68bcfb1ebb188f5d988b19f6c876f6faecd10d29f1755928d23b4a9974244f3011f6ba477edd85d94fb88ab3dff84367c676d054b8d536f090b28cdf2a0ff0aea2692ca8f1e8b70607fbdda90d888eeb321d97579644fb9c45a7bd586cf712953a90a4873053deddddbb3179642c5ef79ad7c4c4d8488c8d0c2b8f3e6fd618191e88f7ffddf77a36f920fc338df37ef667ff07fbb1f01e79e491f6b12adf28ec71dd370020f5918f7ca4dce56eefeb999f7fefbffcbb313c346442930e87bd8eb356936b320f3cc2a2344465932bcf3934168242dcdc9a25e69e1c8f3befba2d86870763488ee3d2d5629947c92f99af5cdbfebc6fc683012cb848b8a7b731dfd0a6c5bc6403b27ad0343deb5807d332f300a70a3dc217a84c4ea95e32a05c1ec06014c3953f6940af3d1500b78ab7c1de0ca32ce85069910c9e71eb957cc9cf4cad2ba24241b9e69a38791ba0848a7db31c3eb4b4b296eb7b12323408f52115636ff245888c6fc9df63eb423bf23650bc71a838c9e95a0512471ae7e7a8d9a1d56b2ebd64feb52c92668798af06c13b03436a6b69374eeeee9530f5f1755fd11c9a802f75242e87565dbdba109ffdc3cfc7673efb27f1a75f7d50c39769f1574ffcc8f7ff5f0e153ccc4dc67a15986479a9040fe8fa3941f17f43005267cf9e8dfbefbfdff79ffbdc9fc47ff35fff1d1f58db048487dd038f3cf9589ba810b3ce5411664629e162675a40664fb7cd1e5a8d0670ebc9618ad2886891febec1e81f188aa5a5558f13315b490b905749d21ee738cccf0ae3503e579ef90773a4b3d0592349a8ad09894f3c1bad660cae5e9b940a1ce85727a1ec3bc5e4fd8c0115775075ef95805a4362caa9d3a0d1fd3113e2aa7c9757ea047ee9402d31e297f108241c44126afceaaf0ffd9f8ec43eb04ce6ae8c5d69cea7cdd6d6b7e3e2547ef27a512667770f9313124499fee25f8fa32147a51f2ecd503a29f2a2b05296cb4f9c2b1d53a3d39999ccd916265e0a30f9396ff9339f848c9359f6713ab76877eaf4a9387ef2448c4f8c7b18d28b304af88e4c4efafdbb9191110b21e00fd6881dc093fdbf1cf377f6ccb978e36b5e1deff9debd93d99bf0833ff45fb4cfaa6592e5d77ffdf097c85f2c14ae7b698085f7fa4e13e33ec67f87c19b5ef78678c51df9d2ad1bafc16869dfc3e029646e4c5a9bc68029f59c2301e8f5ac25454c3b3105c7c01d397a2446c747acfd7af9361d79cb314ec03472954b595c9d37575a3639a73c4f6f92087c7a72ac271cf2439772309cb4205ff3c154b4502a0f4492ace88107856b9f3407a71f9ba170cabc53e98853b50f865bba76c16da86801c6bbc4a9319b34ccd02c1f7e6ddf73ebf254167d925cfa2578e24a7f53702b627989039e3886814f63616243013a39bac1bca2e99c4e997896111ab6cb825e153305caeb892cc5c19996b622a099f2446b2bcf4c9e69f1679d13f7f4a5b64d7339ddececbcb78f9d3871226ebfe38eb8f5d69be335afbd276ebbed669b98a74fdfa4b05b753d1d379fbe394e1c3fe9cf38f7f50ea863ee88d191f1f8c77ffff0b7cf3137eb771780a665f752c14ba6f900b4dcd1a347e3939ffca4ef1ffafac371efbdf7c46b5ffb1adf37e1aedbee8c071e79d026519da6f60408546f30180c490311e6062bd3f7c96c985df946000dbc6986e8f0007a4d26143d1c1339b9c385fc3a832d5e40bb27ded7e0081d265c8a00cf18a44707e756aa0c950f8ec9245c99de8699324fb4590fef9c81abee0784eb80eefb14de87692d9c198f603e9b899d15e6aaeaa51be352ea860310a8b6d3b3bd7b1ea6db17c70f32cc0fb362beea69fbeaa022782c83c8ca8c8df5dd98995d89f9d6765c9a5d545fd267dab1f4c00c23663734f2381a54d1f0bc842bf39b892d65a7ec8d50e2a03b05e53d74c23139a57ae6e415bb7d404818d1b6d4597e37913535408ed034e9518720c4a1c3606696f15e4f6f771c3b3e2e21bb29c6468763481ad0c52a3ea6339ddf883ae4a3478ec4f8d89877b1fcf30ffe3fe29653d7ee6461bdfaeffd5fffbecd558009c5e6ab742f15bca4c207a09e3ffbd9cfb6275f9ecbfc1c1d1e89c79f7e5a4482f8497834411dc3e0aa66c04fb8bfcca3b8de716101a0519951545c38c0f78ad7dd2bc618d4a05ce3182fd0b395287b4f33044c22c74f09cabdfe3b4e09db655b583d2dac086b118084bd4ec0e32d855493103313b3b34fc2d72f611bd0b8a447c2281615033156a5e7577ac5510ea9599ccf7e57e94091762e3ffdb943077fe251fdf59a0eda39a81d0605605e349fcd4d75506c275b5c5c8dc59575999ccb31b7ba6e8d4ee747d7c52b451cd0c48497f745da9c46b3f335588d07953f7951163446687090b24d3b3bda163a8150c62200bcdcbe727b63cb14c4ead73f3fe77d4d2c1966c9e717e682e322af5eb9ecf55d5e99e230286fc2579b5347369eafafb754181fd059565d37e287dff37df1437fe3fb287d1f3079f8833ff49fc7f9f3177ccf70eae31fffb835fc4b0dd9622f317cec631ff3279280e7323f5ff7aad7c4abeebe470465809c3b44ea6485092e86a2d226b81817c68680b49ac74a3ce3543077b96256e583e0744bf826d4bb8d4f8cc5adb7dd16237cb85eccce64338d8fc9a7669443d052d852eb41e0e48add22781d9dbd92e75c3fe4084048261e739c144626234827bc892f6d610da1729846a7674fada07ca9873a1db1aec24aa7424e85b9b2ce84a83a7a964cecbb72cd67beea0f6185364d21f5535d498b30a480655edcc3d890d002a341dc96341e7ed6bf384fa625416c896939b898f0ca74581f60e1bc54a1c1befe1857e789315fd726c1a37696c658e8e0cf2a11929da8d98ef87275f33869697b3a65ea44d5f7ea5ffc0ee32e69ef0e777337166617627176399e78f4e978f881c7e3c1fb1f8d73672f476b95b7673aa257e356862ae43f2c9c5f7dcfddf10ffeeedf76be07e1431ffa9ff7edd48297ffffed9d09905dd579e7bfeeb7f6f25eef9bbab580045ad82419241b63160f0684c396b03b09631bc7c6558ecb13e2d813268cab921a88379c89b7a94a05621cdba924e3d40c36b1433918db808d8d21c1410c88550ada9756efafdf9bffef3bf7743f3d750b41d006fdb58eeebde7de77ee59befff996b35c4c9c434187047cd87d07ebfdbcf4828b6c5e6f5f52a9f067009b3766c25c6e7ba8c27984e7683f1a4b2ce78c00134daa21984a849ac433fcae5868911adc61dd3ddd6e8cfb5ea2fa1d2c1f01e7ef05185e15c9d1c7c2f81e017b61063589c0f31178e1f97a9346e66003a03ccba7c21c5230879ec7c8077c6132b554601d71adb3ef24d23b9449c05070c65484ab83e14509f1be702f88128ec4cf4ea4c55ff82dff53d60042d4cc92542adf444912c2b7d3677f539db3570bca169d061d01f5ccb348f6e04d456bc938f8b2d44d15b809de2e0a787e5d2320e89a73ffb1ff23f3fc9fe48db8703a45eef54d803c4da1cd3cff0ad16449e375464a4fd6dbe0ee11dbb675d01e7f6cbd3df0c387eca19f3c62bff8c5e3f6f453cfda73cfbe68a5b109fbf8876ef4219e5a0274d87a91f06eb24afd50111c744888c1c8eaa967b30dbe23c1ae7ef7a5d65e6c932a412522edd8e12b7c233b8271ea3358bae619071080d0d1a58b389c06e6591a9b1e9bf1203c61754acb32b201d403a24ab9ea83247315083b2461549782f4f041d5c4bbe9360a761f8dab86f7de56cf94f50cdf2f70499796eae5520fc06217c168ac2be38b3e656768f7beeab72c8d818994533d2726d735f977773f336260382a86fcf07f15533aa09210efcf44530ceb8f8473073a2071a9a78ec0554d569260d3956d6874c23b9271deaf67d85f861943acc744ebc066c2db4cda4c20c849936082b452d45f2817450b1d8afe748e5de71ac0541dc36ebae7eab2425204cf216512b8a32de84f9056122055bfa7cf66cba10361bd644a1dabecb9628bb5b577ca9e6bb3867c933b5598aac6d0c9d0de11dbb57350e59eb4dbfef066ebeb9979eee67bdff7013f420ca4bfce16d97e74c8c007310d8795be10c0ab5e8e514db88eafb9f43219c44535341e4c3130e2410ccafc3c027a7e8645a66ac892981b46191e2db9670e46a741e3625dd419666d60478d2a6e785c8d962a0a800575db0d3621a0c84417d60258fc1d4c1c567c19e74a4a601260cbba5f96624500900eb674837029fb35dd64932985fa462ba5f256a706afcb3609fca828f4aa928230a5ca50d2f998b2894368725271122d6c402b3cfae465ff78a618caf7efd41f258f52c607c819280f2cea94f0a2d314d0aa0870bacac93d40819450278056801dc41e32756244a15ef96027ed491b525e46c9abea36ab4e2727c9c5c03f335e705ed0cd61e765a5e667182e490b20f5cab7de35a9e791f8d88661b327bd56a14447a6bac56ef4ced2ff682fe58bb2f19f4b46da4fbf272d241ee8e711af80a48c493969e7b85a85409d6518372e16acb958b426a9951d1d2d366f5eb7428f7576b45a5f6fb7f54afbf95f9ffd13a99c8b3d9d5a623c2faa9b984c87c2bb594b87147ce8ca18ab516766eee76c00646fc42b2ebc480063de245ec1acebe8d3361f2009b60d445b704e6332519b5e1c9afa8d7a6b1a73f7e098cfcc2fc10d02467dae2090344b0a0a600259a92e2f30e614f262a246aba4052c81ab3ecb7305ab649a04c4060f957441bf972deb2096bd932f2849810e892a095896e42b4b624e8ae1d405e8fdac2b84590017539ca4e24992c030ec31c2ea76d427df20ca251f8ce7c5d89f28b6332d123e1cab1f9d920e3ac640254589e76054a09e3c285f4c4e47ed445df767751f9b30d47fce07ddd13cf83dcfa10ac6c911756aa792cac767a1ebea73d2b865ab290e8d22483bb555d25e84eab6db97aa4b01e9f9aaa86ae005c026445a0a4840242a12afa7afd7e6cf9f6ff3fafa7ddcaf28307677775b5757b7ddfe4737db9ad5a7263fde97eebceb6bfba89b5ffef2975fd7c1f4d9e875f776d612430f847beeb9c7af1ff9f92fbcf1ce3aeb4cbfaea6a6c646ebd6b3eb376cf0c6224435323622cde06a871837a89a483806e8931e1466a3b1d4364895a79fdb6a1b370faa7707a64823a94b7cd720d5a0734935493b892d012b4ab466814a525212b22ca6aa28f06cbda45a1dd24ed780ac22662b8bd97cc57ac268bc1f9e88fc2421819f2704490aee85712ae55bf73c9f309b6e601b61636550b1093a77e9e721d445f4a446a9484a912189af3ec67af090000f7210027c77d3b37a8167eafdc80e00aad2441a4ffae0ba5ee69d02750eb0f8f80caa9e346a49cb8a0d4fd4b916427bb8a415853c24f948aeab0314db373ec75c5a809ecdaac3924a4c27e0f1f1370aae92522f3abad7559d026602e5405a75b6b75b4b73b3d4ce9c4283b5c9e40080efbfee723bff1d6b3dbd5abaf71fbf6f575d757d721536befdc4273e915c1d5a3ae4e0834e3ffd743f320401dd77df0fd4b32cb4952b4ff3eb6a6ae5031d521d36bcf842d2388162a351e96ee379c52b428123bd9fdb8509f3eaae18a322206fb1edbbc75d0a315ee760434a5574ad63bd83ae510cd5208434e9bc496aa7a420aa2f9e4e3e42a267ea14570174a4ad2034e9c83ba526ebbd0e10e5910168d6f4a585bcbaf284e5a49af1b1914a45b2500c9616f300304011ba12723acd6419dd673c304c558b40535a2a5f38c288f1e8059faa1b28003a1cfd3c099c47e987249bf07d3859dec5dabd92b48351d97b7cc2ba24e9ac30ca5083785d80f0552502433edfe8750cc8c6959fbd2581b62c0d4365f6f7f1dea43ce4cb0f5eae509624223984dff839f788f667eb7cf23df9a443f2fbc42760f56960fe5c12af76e4a3ac74e8ec98ce6c226c3bff76bdb49f75e7bdcd2e39ff1d9e4e2da166beeb82774f694df829bef6b5e9eddf0f354d73f72126305e3d5079d34dbfebbdce4cb4e28425b676e54a5a1296f323ad13bc933845c2390c0923f2083d278e013c711e6447c22875b2e57c260a1f0991eae933db25f10cd048ba9954c68a00565698749b0f7b109555361ee0cc0a980a969104c4e61400090c6bf83083a42ed2347c3148c096ade8e92abd09c561928e8bd91df8ca3beae7047bd52827e27b5d8731b418d8a68fce45bc97506034fe03aec9457204d53a121417d7c21154008f8f751502924fefc123acdf87f7b168392cd90a4b742471748f619582eca83492486fa64361b0da49754e79d5ad241d54f0f47a33797e094967a1bae748bc4efc09886762e70a087d961265507e4828aa9e21ad10c87f9078acf3d4b57e81130b9ed8b973b7ef5486e3ca3b3f8174d5c927da6fac3b2f2454434c1b3bef9d174c3958f06a32ac70382994fe3011ba74dc7889425f77dd6fed33a6524d6f5db5ca4e59b6cca5180d489bc0a8ee69f4ef798bd951215504d4153c70cc72f05d8d253572eaf9dadb5a2cd3c8b89b9e5303a59486b3813301d23180061b0d15d2a59a1802c64b0b3c290189592d4c25f36fa003308152301717e83d159c304a5bcc075027243dc7a5ba8ec9769c904d58dfdc65139916a55db4d149d981ca3bdb32d0cf8e0b217e2ec69c547e001c0c05f850e9c2c73545a8d2741e30a6823b3592f3d011511fea58c247d5256d4359f52331721274df3b1f3e49560274217dffcc16efa09312c3e2bca24380c159dec35796f82e3e53f7009e346765472051e73256c29e15e02ac12945c7e3d3c7f887c4e6dcf3ad3ca97ee9ac98888e6a5e0d3a977efa8777550dac97abe35163a32a7b0fc4333cabc02e66acb4a79ceeb82ad3f9e1494dd9dea1712f1760e4eff805f3ecfdd75ee2efa9259c7fe7bdf3c2a9cf38e314fcee77bf3be59b385c146ae1301185c301c32c1888c2afbbf8d2a9c9abb574f69a336cc140bfab70beed80ea3daa4d1c7dc0588d13aa3bb0665a1210fb8adfe404c6862c937091526a24353a6dccef837d1602de4e7a7302c0f3e10c40cfd1999f94453095f2e1ebce3c60a708c6c48b41eb251deb641399d4b34aae68e56c9b4da40b368234556730a1df4c483a8f0002cb2904e001263a0366e8c08bce778aa3c349f8cf99cf1f73f2abe4a872bbfa19ce394eb32b67921415ec3160465c12ab84dd46a3fe00bf381786474aa1b2d1e9919f54396d0549febccac70a82134e3ac532850e9b70a9172614f8e404d5239d20eaa12214543f0a008dcba06252be90875aaa8df7f6d16ffd57eaa87c568dffa94ef42ccfbbcd47504783e4dcba75bb0d0eeeb5eeae36fbc87baf141f285f3544a75fcd738c4903bc3829e470d261051f0400296cf426d10badbbf8b2a95ea89a608075e79c63f3fbfa68373562e03ed6f041f11a6062476555d97e54601caa2197f6397c3ea30580a931692498c5c7e2bcf802245c0df89080ba76b7b7e2029cd5d8bc27821729a86b77b2e83d293c7d52297d784469a3e2960436cb156cb2b1c52aaded96edebb5a69e6e0a2f0928d54e29fbc71895ec84d22a295d3fea5d2e1585baa07e2208b06f1dfa4e9439963b4c1d83f9c498ce9c09d050cbfc892a8261755fa979c9e8b862075692cdc3b60a3edd4de553caeac4540ed95e0c0365d561e00c5bf99635966a6ab3edc35255eb1a24fc1bf43e8655d044f43b2471a206069533e43110eae27439aac93bd0a44c91bc3cf4944e214f148a6e360edc7b84aef5a87e9f323effbd74f142bbf977aeb5c6864445ae228077c515574f695bb5bc78b8e9b0830fa2b7f9c10f7e30d5dbb06e8ade28eadfd504002f39ff3fd9494b4ff0738611984f48634d35a6da009ef1c5a83ad22ea93a49c1fa72b27c0727010daa0bc047b1b98651683c1adec115d4249f0ac673c4e9381dd4f42ee5908a418ab2720175b7a939679ded8dd6d39eb5ce82a485349886067504cd45a9a1456bec3ede7a169f6499d62e2b6573362ee93c525f9154acd8b8d29a54d926f53e5437800df0824304a60538d304b306e94f1d28afde8c942986c090413250ce2041d97a9eddc9b0f9c2100460345f948ae4a363726785ea98dfb2a35b364f2753b6f9c72d54818ab661d32edb339eb6b14a5eaab3243a80d3fb54f35eaf7ef4f757e54bb11c032039df9f2853ec08bc7cc425a5e627fccaaffde7496df879489ffc9eb17285fdf1cdefb38eb62237f6a36a3f43ad167624e87559c9fe5ae9a1871eb2f3ce3b6f0a74975f76892ae46ffc7c26fad9e3ff6af73df8b32011900e13ec4c1cf66fc90b00b8a9bd91682c317539dd68fff787cfd8cf9fd8ee5f012a95c67403552401a082ab94a890927aa1d7e6b7e1da5528dd733b10e051534a1b4cfafa3c75fabd6d199bd7d562fdbd6dd6d29cb55cba62f9868c7b0e77ec19b1f54fbd28a93e6695f1316b69acb381ee9c9d38bfdd8aea98376f7ac1275ff7b4b5d9f3eb9fb2f1c1412be87d0d92da399c471906ba1369ae6b3a9f30dc4021c94c683acf9bc7110da80026d2301cc3de2c3184b1be21d972c2a10d8d8cd96eb6a5575d62830e4f08002afb8ebd4392c26595256f7d030b6de10927db8e8926bbef91a7eda56d7bf52ad9788cfda94ed39571d9bfaadbf2b0025f8792fc767114241af90879249341fd8df191fdb80e2aaa5460e5d36dbee437ee0da52d04749c29b42f6d58f22fedd229d6db6ffdc605f6f95b6fb2bc24f54cc420fa7fafdae08b41f443b152e1d5d061196a988d0606067c18e2eb5fffba5f3f29067cfeb917ecf2cb673694fba5ba75b6b5da332fbc98a8626cc7008366c4a030298d075ed8ef53a04965ecb92d7b6cd3d6115f7e225e52fbb1fc450def920c00ea3815022001664e368ea3cdd3a43f0fcfd70b0c1276025dd6ce3c65bead5dde6527cc6bb28ea63a6bc955641f99b564ebad355f67edcd192b48fde19be7a3237afd8424d9e8b0f576b7596f5fab2d1c986ffdfdf36de1e2c5d6db3fcf37769d1c1bd69ba4fc021a499e3ac607e9185c7546328bc4b071cc8fe012ddbb1d752400ae2a0400720cd28f6bf6ca117ffb20fb10dbebe90690e083a3a97ccef648128eebf96c63f890e7d2934fb3d6fe05f6abe7b7dbb31b876c78d42bd2251c154e1e84c2505f3ad2f1a17140482bbf2f0a2a32d79cc7b8003aa8d611c33dbfaf72f13420c48b19b513d2a63e7eefa66bec33b77c4879a50df727b6b5fcfddfff647215e66cfe47f7dc7c3de888820f5ab26489aba17110fe978f3d6eeb9f7cca7eedd7d679c3d752677b9b0df4f6d8bf3df3acbb959106cc6a89ebe8684000e90e9a74d6fe7dc7986ddcc2464dea9969426c334f8946d53330811a152917d4229a5a0c2055ab4e40730fa87a57e69d6605c842b66cab9676dadb57f6dbfc9e9c3548d24967d36fc40893137a2fbf265fcca6673f979475b7156c5e5fbb0df4156ccdea65b24bfa250519080edf0a6711706767977fa8727850b6af18cf7398e487bc32558eb2f21e42782630a93b24002b20529dc47382933f0e08c33d3e1a0af01866c081c406533e0482ad2880ef9534c4bb8b8772c1c2e3d5392cb39172de1e7ef459dbb69b695d0272c8a2575f5d9d3a89ca8402162b47de1bf2074d038d90fc5014e3a1784efb5106c881e7ed128e61c132f7299b3a07d5db17ffe4f7ec77df77a53f3f133173a57a550d83e89ff9cccc9f3738dc74c4c10721fd589bf5a31ffdc8af5984fbe31f3f2835f452d7cd6ba9b5d06ccb8e5f64cfbcb8d1f8f0bd2f5255af47cf173ca392126a4b18e929f5d62f6c928a25a903dc8244501beacfed3880a7a3ab98809178d41cb5739974708fabc1f39240cdb992ad5ede6ba72c284a3d94aa559ad07ba5260a443edf112c3be391a62ef42206cd9ba58676b6e56d7e5f9bb515b39695647677bc641cd2cc594d8f0fcc9f6f9b37b31466d8c112184f79543a6cd214c6c012958c6bbd8be722e038afa500ba6930967c6a190e19e55160a6a23807884c18008823746ab24b730d4db6e294d3acbd67c05eda326a4f3cbddd768f283d958ddf785df99982d4cd00401c3a0c905307d320a43d0288f474924fca07c56b8e316e3ff2dfaafd942492bc506cb6affdd9ad76c5ba99b780c094f9c0073e6c9ffdec1d498cf930d7e11ecb3b10cd52d2c34f6c4151fdfd07befbfeb633cf99751802f5f3bdbf7e89f57576aa5d42ef188856e61ffbbe203142144575470a673424bfd1336c6318086689012782ec2bd935e9ba8caf466fca4eda5ba4622e5f58b0a64cc9b24a2a8d2a2a031456c43e637645034c9b0cf232d79190960d9795244df98c4f01456f43f58589dd7ed5f53003dd7af7aa33cfb42649c112eab1dec0b815790bf33e25d908e2c030d81c241d44be61de18fc5e7c4ebf892a280c9c531e51d5f16842a4419d30c4a084fc5ea1b9604b972db3c64293aba35bb6ed1130a50560f0620f4ba577ef3065f054423e432796d4b3ee13bc0351c943bd86bcce0632f208c5b6982245033a125830d063dfbdfb0ebbe09c99a78c8521accb7cce6624ec3b1c2c47131d35e083985357bd78112fe8aad56bf7d94ba39a9a1b1becb72f7fb79db8687e12334d81095831911300601a35248d9904b1220f21549c318973d53309f5a89a0a69c567d2653bf1b82eeb29488dac1b95cd27d04addac4fb1ce8dc1097a7a81d15560d99e523733b2fb005dbd4039561ef7f720eb7c605c679330a2f2c7bb830a2889235baca9b5cd969d769ae58a451f03a489c232243d2b00b27e11c93725cd0056f57512dc4daf400a303dcc8e46e04e1ba9c45e461dc302d68cd71393da792623702e5eb2d8ba7a3a7d6c0fc7cb3631f4287b0726f9267d0788fe784b08fe320a5a05fc007a8fd481dfc40e22528c83a6e3890bc718f87fe5294bed3b77ff999dba620937f7a3387385ce3b129d3a0e9699b4a823494715f8a06bafbd769f414f7a316623b022622682e12f79e7d976cad2c50e00b78d9048028ef4460108094703ab2525c10875c911a18230641f182004939504a649a98524c1be9c75025e4747c696f467acad414cc3c73b65daa4d59bb3f426af747083f8e330a30283bbecc599d1795a2fc8d7659597c058dc870959d6c39763010ff9abc8906218607078ccfa8e5b6c2df3faac2c9ba6a28e83af1c2161b0a87c4e2b6971aeff64a6f97221ff163bc08cc1c1a7e7f6f1e01282aacb781fefce48254ee79164740ccaafded9b7a0df8a5d6dc6767c79e64b3634db883a08d6faf96e71899a4e95d2a1a4988ac7f22b496bc639993ce079a564ee98a12d940f443e19e7a04c7927a1e354bd24f1e15aef492467688c7abbf882b3ecdb777e4e926fff7d5720c6efd096aac7f100dde19a28fd6ae9a8031fc442c6071f7c706af0330e8e566fd95d4bef38e374bbe89c77b8fde5daa598039d3393576f2e29e45e43778624cc08db38332ace9d0062159dbaad425b4b7ab1dc2f9b9eb013fbbbacb3895dc85262189c29c1c3cad006408b8c13c147eaf13a481c25a828d4bbc868c48789c3f137e6f618dfe1c31bb9fa2da75b6b67878dc8ae648501139b997f393d07b364fe055a824b987d251fe4f5a010d3afa67486f149d5958ace04816c8eb9ad664d2d2d36b070813b3778869a71694927a0fa135c429afa134ca6deeb75ea8009e074808657f9f3d517e42786992844f3e6406c88f4a53ffdaf76f717ff879fcf4474ce002f2ed8a6f3a6133fd2c30907a2a3127c10f3ed1e7df4d17d0641f15acdb61e101ae8ebb52b2e7c979db06881b73503c6f07d4ad22c18ff623a8185004301a2e02155106381d738cb2325f0e5f2f556cc4d5a7733ea66d9a7abc11813a531311debdb50c3c079a8c6d86bd70608660dc00080e44771fa5935ff3950c5bc7cab22dbd068f3972cb12c5fd6511a4811543be42492c52789d7bc47ff5e916078ca1e7709608132c043ba8eeb7e4fff7cbdbbc96d4c767f1bf4f140ca19ec4e960e451136f53e2f04e5230e5025f5e1b74201c313e1d1da7cfb7ddd9806633c56ec7cd9753ffba7bfb6ebaf5c97c4ed4f0c25d039c7f1623a6d3aefd76b5bf74345472df8207a2f2ab1fa8b3054f4ba7533cf8681904867ae5e65e79ff9562b48ed284a123666658be95e5a4ce1d3a7d4c86182af820008af38e8141cac9292a88d28507ded79493dbc9d2e4805c8aca40ddbd54d3823c1262ec592e09234a1c85890dfd30f6050d621ba704a44537c4eac18ae05ace1b1715bbc6cb9b5747749f564da9b7ecbefd564be65833f4b518075f2cee9572777f7259e0df9a4ec927669ec3ca6c7a9a4ca4b4b67a735b7b5baf463a2754373933fcf743e5475ec66cfb6271ed3a25c0aca976a4f3755495e2e584b47fec58a4a28d60544d9a3b4aeaeaf9662c1bef4e9ff667ffb979fb59eaef624767faaed90599d40a71d7750389ae9a8061f14a701550f8a3245a85ac59889e6f574dbe5e79f6367af5e661dc5062b3666ad41368c7b214198b7bd1a3b393a1323f1a45e316c212bc6bfb570e2a23eeb6c6527e4e098c8e7948618314a4c5431979c9c13473a09a355f15b485fc155c22a26e3d9788f3fec35ce913243928027af3edd8a9d5dbe2cc93da4faad4ffe1680fcc74e21bd70e509fa592db12201a9cffa43977c0aa89780b9b1b920e0b5f9dc53861df0e1b2d505d3e776eddae51fb471b0a907a293e08de4d3e759baa40b607300110fc078692445f31ba47e2d793a092009ef3af74c49bb6fd87b0e20edf005d49a2274d2d5d3168f763aeac11789fd60aa3fcd8451bd7cc569b3ee8a063135ebdd6f5f695ffaf8d576da89ad566c2e4972b1344f4c883494384b4bbd2418f34065d3a5536ceb5eb6426ec2561ddf61c775e62c9bc239312ec9396979812c2f8615c7ba83c33d1e8aafd7ef080c38072f4850cfc48e3229019c3284a7d3d5458108a7089984e19ca9831383efb7b32f0a8b7f474aca5ba1c306969d6aa9a616d97eba27a04cb00b9ad2f7b999ba762ceb3f8e7a1b89ea2404961789b51525b00ab0e5e41d1595c9ea0568decf77eb7a7a2c23a64d49dd6540a4bdabd73ababa2d2ff0b1348bcda802bb30f327a36ce3e3259fe8073a7a9a0abaf67259494f53f60055cfa24258041d9ea826e28a8526fbe29fde2269f7b9034a3bbcdf74bed54e383ae7ea2d4b8e053a2a06d90f965029b001d911bb542ab96df4777ff7bf7d4adab9e79e3d6bc577b515ed8af34eb7b696ac6dd9becbeac4bc69265e275f0b721b4801d5b2b529ed5ecd3356f40ab0ddd65960105d2a6b5640605ea870849483f9515319d88f3db6fe39e92c48098222e339cff87d1d91b071ba558c8b47ce5c42ea9c635f6f8f6dd9b2d98687062d2520a342a302077616832375b9f42370278f8924997ab722b9467229df8c79b29670f7e884350b642901b05ef5c75e2cf9c6069f79c33e2e940f703df5fc4edbbc63dcbd9a9e3f66f570a2fcf3469fdd520ee398f59cfb803bf7923f3debf94cca1ccbcb39e1c2779e65ff70f7ffb4b79db1ffee06d5c41c4d7693e63b8d9158277acb2db72457c70e1dd189d5af95f818cb75d75d674f3ef964128391bdd0bef1d77f2580ae496266a6e7366db5bfbfef517b71f3a0edd8336443ec575962a53603e469eb928a39bfa7d51a332507635e5252b524f6aaf7a180495f15c07e976244555d18230b1bbd4e014835ca790440045f2452cb66f88d2ed409ecf3ac02e9e219e59a4e01af6a7974d81efcfef76c72e7762b8a99b38c2fea45303629f3cea8fa421c09deb88a0a7b9622991c2a5612f8760978d620a9d7d1650d927a637a2f98cf49fa65f2802fabb24ed8b865ed6fbfff84fdfc49a99fa34a47d2ab3cc117840534ea86edd82665834f0e5aba3266a9f2a88ac5246b49d7294ad8ac8e550ba1cc94932ddc6fffa3ff62bf79f5ccf3792331e6cb77f2aac77c999688b4a3533e16e998927c91a8f41b6fbcd1bfadfdc8238f781c36c05ffcc59dce8c0070a679a150ab549b35272fb2deb6bc9866c406ba9b6cc9bc365bd453b0fe8ebc75175356c84c583e13a68d311b043b1150a0c6f951ffc459ce7c611e69001ecc44f047122044e0711ec901a3fb484e9872fa5e927e42c4fb3da5d95c68b63d2ae3de5d3b2d4c2d56bcdf276dae387ad4d46f2165d901c70de14a21742423ea70c653192bceebb76c4b9b6504b8a6a626690f523b057cb660e7e3a5e42fadb8279fdb6e2f6f1b73d597b73177357995ae5506546b493e9f5e861718c9e76f84043cfed159d04b88d807f423bf73bdddfd95db6dcdea533c6e3662a6ca55575f6f4f3fbd2189991e0f666ef0b14ac7a4e4aba67befbdd7a5204e81487c9ce5f39fffb45d74e1bb92989989bd4b7ef9c47afbd593cfbb33032695966532fd2c854d98c121a10b67ac492b617395d86f136fe7a44da8f787f5e276850e32ff0b6a5f35e83887e2358065160c5220386c78360008b0a16ef22cf18ce535e62529a5ce3df44fdfb3d1cd9bad59bfc154750fae8ebc1510d427432afc163e9789e9761e09fbb9dec7529c215d14fafb2d2f95939dda90c4218f15db33342cf08d7a59db3ada2cdbdc6677fefdc3f62f1b466cbc1c3e3c59c603aa3a612f4fce6d72cc2aa5214b4902d65746640687e5454e91c3c89b6ce2f75c79b1ddfaf10fcbaeeb486ecc4cd8f5377df823fb483b9c29d8fe47f3f8ddc1d2b42e748c129365f95a68dc1b06f2c5b9eb2e15287ffb801e51f67d59bbea64bbf68af36dc5b2850291408127134f2060809915fc2326927e61e236f621e371f4fe41e2453739016fa0efaccdef01401220e2627cf80d718c1dc6f98f7a63222ca69ed539cba5588990911dd6bd6081a5320dea2c00ae9a4f20f2192bfa795968f3e18824e04cc1ae6356298e927249cf5572b6575869e99fefc04b3537a9a36128a32ca9c6bea263ca8bd462a9db25817deff888d2606c52aa6eaec1d20d39ab3464115d3efba63e2dd0a7557601aba27c966533b2944b99549cb40fbcb2f45f52932fbef02c7be09ebff2218403010f2d862184daa985a8970c3dbd1180071df3e083e23e1c18ded56e663ca178440f34330642bd3c73f54976e5ba73eda41317c9860bdebc6ab0e0daf7416921947990bea9af40e64b9744ee20899400312a15d5008462ba802d128f268f4ffd2e527896993e6376c2d2e5962fe2f914d07887df51faa4a577b80732065dfbaa789db361125ed42149ada6f6769f43ead3d6944649361b362c811dbf793f6a61574fb7eddab3c7f7c5cc35e62d95530724f0d54b1557c12dcd1761a57ebac4556714cb38556e44b2eebde7aa8bedc7f7dc69dff8ea6d76ea8a13fcde6c848a59db6638d2989f09f08e85f1bb83a5635eedac25d4cf8f7dec6376e79d7726318156ae3cd56ebdf5165f2dff4ac4cc8ee737be6ccfbeb4d146c7c6ab984ada1563603a41ed74861563faaec97ac667cf08a02e2913c044e0555f73ee47a4064c1b9ff3e3747310178e026059f69292c029b4e1f1276cd3fa7fb3d4c8b0350afc486252477a7922129fa4128224a0a416a32228c91581aa7d60c0d285169b107058b707f8787b1802919c44255627c3d79d9a6423b38de277ee7fc27ef1d40e1b9a4cdbd0886cc2917197c6beb1aeeaa27e7cc84aa352356547a7cbc3d6da5067efbfee42fbd00d5758f701860d22fdf3fd3ff46f9fd74ea247a3617e261dec1b8dde70e08bc4161537dd74937b46ab8921895b6ffd433bf79cb3939803d3c6cdec78bdd5366fdba92b4911311a84b3856d2cb01bb18da84698d61937515b6b01587d4ee0366aeabef1c005c2390120b827c9a223f6614e92272b8cfdf8deefd8e8b62dd6a4f7b1e544702f85e95fc8c32089f57b05df1b5457382a5be6f558beadc3ea64e7e101455d9d947aa9dc08b3f59278796b907a8bb429b614acb151524ea0dcb86dc49ed8b0c5366dd92df0956c70b46c1b36aa5e76087425253c22f5746cd84e3ebed3deffeb6fb7eb2f3fc7bdc0af44d8759ffce42dfbede1ca14b1eaad26df88f486055fa4db6ebbcd6ebffdf67d1c321020fcfce73eed12f160881d9c376ede6e2fbdbcc5f6ec65b12b430e9353e0736607802efd640b494c0580051012a8ea0832977e80cf55b370f47b824ba0780c800c10055e025053b3fdebcf1eb497ffdf7a4b8f97ac51d290151438407ca2b3a457906602967ec9464ce3ba9f6d2d5a634fa7a51a9b65afe594ae1e90ad363e392ec0355a4b739b1f51afc90fb35bd8c385c5cadb76eeb17f79f219dbb2751782ce1a9af9e661a3ed1d29db466909ab971d67d7ae3bc3962cec219baf482cfd41d2d54e9200f40c98b3d5c3b13460fe5ae80d0f3e08e001c03beeb863bf39a1a8a17ff00737bfe2f86035eddc3d682f491a6e52600322be7ecb367b10b6a22fbb514075a37a23f8aac99d358cd5293a82d201294000c17d0869482b25d10c47944647ec91071eb0c9dd7bac98cab8e4631b0b267db3529d45b7b841c30c1405750a85de6ecb14f8d80bbb6ee3840969f119b57c362f4925bb4ec0232fe4cff3ad6bc0fbe2c68db66dfb4edba5b2f3b149a4fbd2258b6c956cb8e3e61f1ce0209c617c80b27aa16b24b67800746f441573267a53802fd2cb2fbf3c05c25a027c80f0606cc26a02889bb66cb3675fdce48ce920aa0bde4e6c409766c425e0e33c0052714c490320929af119c0c0f9348146c0a766d2296a2fcf65157efe939fd8ae8d9bac5100cbe9ba3c312655981517cc03057c927a0aa3faa93b59dadb2cddd828e487bcb1a7698bec3ad44c267ca794ce3ef9d40bf93a115bb10f8fe105353b4ef6e2928503025c9f3f77b0844df7853bfe7cc675998cd9e1503952fb671e297a53812f12df8bffd4a73eb59f530662a60c20fccf37fce6ab567b868647ec854d9b6df3d69db66dc71e38d89939022b828a23a7f532e4f008c6191ffe4c723f5238a78982f7946b07afa2fffdf9176cc313bf4227966cab481a8efa7d3e3de60f288c28ed7473c1dabb7bacb158b43c13a89b9b04b8b033597c17aa2a8ea330499abcd5fbeecfccebece9e8b4793d5dd6d9feea272c23e1bef0853f77dbae9698088da43b927b671e497a53822f1220441202c25a75b4b7b7c7a5e0073ff88183b60b6b69d79e21dbba7d97ed1213efd83528fb10b7470054907c9c4f830aaa957ce13c800faa06e0a4d4dd9f4aa20c49ad4eeb31860998cb0982fda391522f5bbb3b6d4012a5a5ad5d365c5eef64fc0d874cf8d4b3a723693a9ea8cefd52f9f89e7d4f67a7750878af85502defbaeb6e07de4ce3ac8cd37df4a31f7dd3822ed29b1a7c915047bff295afd857bffa553faf2566cc7cf08337dab5d75ce5a07cadb47768c43f900910398e8e8fe97cd7ab029f934ef50bfd55ecd19ffed45e7ee1459f65c26a071c3ead5231171d779c752baff5b23bfdbb13783399f5c56a0a49dcd6b666ffe26c432e6705a99f6c075f6c9e7995f8c11003e3384fee12e06a870b20c65f23e8de6ceae56c3407be2a42fa7df39bdf749514a93813210d2fbbfc121d2f1543bd36c9504b7852fd7b785211770f0eb9e4627c717474dccf21c614877cae25c00bd0835e90eaf9f8e38fd9c8d0b0ad58b1dc962f5f6e8542b3a41a13b233bec9140d5c6c6ab64c46b66136eb71af07515fd870fff0edffe3c799163803340007f08e957576878be6c0370b314e78d75d7739186b872922315c7199c0c81c52a4e39b811822604cee1feffdde8cce13085b1927ca35d75cf3861ea7fb8fd21cf85e81bc77fff6b7ed5bdffa961f6723c007082fbce8027bebda35af9b543cd244f91f7af8a702dbf705baefcde83889c49e2937dc70833b52e6a4dc2bd31cf85e05610f024016f3b29ae240041801e1dab7aef1e36b75da1c6ec25902d81e96ddc6f140608398ec8c84037073b6dcaba339f0bd46421505801188b3a9a6d5c458e2a2850b1d988072d1c205474c5d457d7ceef9e7edfe7f7e60eabc7aa3d9d908951255f2b2cb2ef3e39b6540fc50d01cf85e270280d889f7df7fbf1f67723ecc468012a6eeede9990223e00cfba6045ab674e92b7a5af138fef2b1c792ab40800b8a00830e0664d5843a89845bbb76ad03ee8d3eedeb70d11cf80e110140c2c30f3fecc7d9bca7471b21c922d0381eed7b5f1ecb3407bec344eeb81008d97766fdfaf5beda827030eaeaa120a417e0627ddc52495506bc09738e92c34773e03bc204f8e2b22780895387cfa501d46a3a18a0464055138062fe26a08a334a00dc9cad76e4690e7c7334474788c22cda399aa3393aec3407be399aa3234266ff1fb38447c8cf21b35a0000000049454e44ae426082, '1995-07-05', '04120515005', 'Masculino', 'NOMBRE DE MI MADRE', 'Nilda', 'NOMBRE DE MEJOR AMIGO DE LA INFANCIA', 'Roger', 'activo');
INSERT INTO `usuario` (`id_usuario`, `usuario`, `tipo_doc`, `num_doc`, `correo`, `contraseña`, `nombre1`, `nombre2`, `apellido1`, `apellido2`, `foto`, `fecha_nac`, `telefono`, `sexo`, `pregunta_s1`, `respuesta_1`, `pregunta_s2`, `respuesta_2`, `status`) VALUES
(39, 'Test4', 'V', '19198563', 'test4@gmail.com', '202cb962ac59075b964b07152d234b70', 'Test4', 'Test4', 'Test4', 'Test4', NULL, '1990-01-01', '04125972365', 'Masculino', 'NOMBRE DE MI MASCOTA', 'Test4', 'PELICULA FAVORITA', 'Test4', 'activo');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrativo`
--
ALTER TABLE `administrativo`
  ADD PRIMARY KEY (`id_administrativo`);

--
-- Indices de la tabla `agenda`
--
ALTER TABLE `agenda`
  ADD PRIMARY KEY (`id_agenda`);

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`id_cita`);

--
-- Indices de la tabla `direccion`
--
ALTER TABLE `direccion`
  ADD PRIMARY KEY (`id_direccion`);

--
-- Indices de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  ADD PRIMARY KEY (`id_especialidad`);

--
-- Indices de la tabla `especialidad_psicologo`
--
ALTER TABLE `especialidad_psicologo`
  ADD PRIMARY KEY (`id_espe_psicologo`),
  ADD KEY `id_especialidad` (`id_especialidad`),
  ADD KEY `id_psicologo` (`id_psicologo`);

--
-- Indices de la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`id_paciente`);

--
-- Indices de la tabla `paciente_relacion`
--
ALTER TABLE `paciente_relacion`
  ADD PRIMARY KEY (`id_paciente_relacion`);

--
-- Indices de la tabla `pago_cita`
--
ALTER TABLE `pago_cita`
  ADD PRIMARY KEY (`id_pago_cita`);

--
-- Indices de la tabla `psicologo`
--
ALTER TABLE `psicologo`
  ADD PRIMARY KEY (`id_psicologo`),
  ADD KEY `id_administrativo` (`id_administrativo`);

--
-- Indices de la tabla `tipo_cita`
--
ALTER TABLE `tipo_cita`
  ADD PRIMARY KEY (`id_tipo_cita`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administrativo`
--
ALTER TABLE `administrativo`
  MODIFY `id_administrativo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `agenda`
--
ALTER TABLE `agenda`
  MODIFY `id_agenda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT de la tabla `direccion`
--
ALTER TABLE `direccion`
  MODIFY `id_direccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  MODIFY `id_especialidad` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `especialidad_psicologo`
--
ALTER TABLE `especialidad_psicologo`
  MODIFY `id_espe_psicologo` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `paciente`
--
ALTER TABLE `paciente`
  MODIFY `id_paciente` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `paciente_relacion`
--
ALTER TABLE `paciente_relacion`
  MODIFY `id_paciente_relacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `pago_cita`
--
ALTER TABLE `pago_cita`
  MODIFY `id_pago_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT de la tabla `psicologo`
--
ALTER TABLE `psicologo`
  MODIFY `id_psicologo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tipo_cita`
--
ALTER TABLE `tipo_cita`
  MODIFY `id_tipo_cita` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=162;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `psicologo`
--
ALTER TABLE `psicologo`
  ADD CONSTRAINT `fk__administrativo` FOREIGN KEY (`id_administrativo`) REFERENCES `administrativo` (`id_administrativo`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
