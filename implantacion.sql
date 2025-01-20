-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-01-2025 a las 23:30:26
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
(80, '2025-01-21', '01:00:00', '01:45:00', 1, 2, 'Pendiente', NULL),
(81, '2025-01-22', '22:00:00', '22:45:00', 1, 4, 'Pendiente', 'https://meet.google.com/mdv-skrh-pix');

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
(87, 80, 7, 2, 142, '2025-01-21 00:00:00', 'consultatestpareja'),
(88, 81, 7, 4, 146, '2025-01-22 00:00:00', 'Test3');

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
(2, 'Infantil', 'Psicología enfocada en el desarrollo infantil');

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
(1, 2, NULL);

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
(1, 2, 'Pareja', 'Juan', 'Jose', 'Perez', 'Perez', '2000-01-01', 'V', '20145963'),
(2, 4, 'Pareja', 'Test3', 'Test3', 'Test3', 'Test3', '1990-01-20', 'V', '10789654');

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
(67, 86, 'TRANSFERENCIA BANCARIA', 30, '2025-01-20', 454545),
(68, 87, 'TRANSFERENCIA BANCARIA', 30, '2025-01-20', 454545),
(69, 88, 'TRANSFERENCIA BANCARIA', 30, '2025-01-20', 2147483647);

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
  `id_espe_psicologo` int(10) NOT NULL,
  `id_administrativo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `psicologo`
--

INSERT INTO `psicologo` (`id_psicologo`, `id_espe_psicologo`, `id_administrativo`) VALUES
(7, 1, 2);

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
(142, 'pareja', 'presencial'),
(145, 'pareja', 'online'),
(146, 'pareja', 'online');

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
(1, 'neyli12322', 'V', '20198566', 'anais.asdm@gmail.com', '202cb962ac59075b964b07152d234b70', 'Neylimar', '', 'Perez', '', 0xffd8ffe000104a46494600010101006000600000ffdb0043000302020302020303030304030304050805050404050a070706080c0a0c0c0b0a0b0b0d0e12100d0e110e0b0b1016101113141515150c0f171816141812141514ffdb00430103040405040509050509140d0b0d1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414ffc0001108028e020803012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00fce66e94d6e945158ea7691b6769a8eac374a8db3b4d1a9046dd29b4ea28d48d46d14ea28d4636807069d4374a5a9659b7bef2d80ad48cfcc9fed573e79abd677de5911d6606c52af5a8a26dfcd494143e85eb4d5eb4e5eb400ea72fde14da28025e68e6a2a72fde1400fe68e68e68e6800e68e68e695739a001739a75145002af5a56e948bd69d40c55fba69291ba522f5a0a1d45145040514abd69d400d5eb4add2968a00652af5a75140c28a28a0a0a28a55fbc280128a93715e6919772eea00652afde142fde14fe682439a39a39a39a0a0e68e68e68e6800e68e68e695739a0805ce69cdd2968a0631739a7374a31bb8a431ed19a0a1a73522fdda62e734fa00285eb42f5a75040514514c055eb4edc5791d69abd69d5a6a02ec67e4f4a29ac370c5146a070edd29b52b74a6d1a92328a7d146a031ba5339a95ba5368d406734734f6e94ce68d4046ced351d4bcd1cd1a81152af5a939a55ce69301f6337ef027bd6d0ff59f8573ec486caf5ad1b5d443c7b4fde15981a545471b6fe6a4a0a05eb4ea6d0bd6801d4e5fbc29b4e5fbc2801fcd1cd1cd1cd001cd1cd2ab1539a7799bb8a0061cd48bf76928a061452af5a7afdea0a18bd69ebd69adf785397ad040add29b4e6e94da0028a2957ad00252af5a56e94dddb79a007d14cf3377146edbcd003e8a6ab6f6c548b17340c6d3e4ed4863db1a9a45fbdd3341425152795245f7d319e948d9da68206afde14fe6a3a55fbc2801fcd1cd1cd2ae7340c4e68e69edd299cd050ab9cd3e98b9cd39ba50486dddc5236251cf414c6ced34e5fbb4143e3897f798ebc7f3a4dde673fdda6162bcd48abe5ae3fbd4002f5a69ff00594ea280153ef0a1bef0a4a17ad003b76de68f3377145140052af5a4a299039ba514c61b971456807227ef0a18165c54b48dd2b2020f2f6f348dd2a46ced34ca0919453e91ba50031ba5369f450031ba5339a95ba5368019cd1cd3e86e94c08db3b4d47f5a979a39ab60496d75242cbfdcef5b71fef155eb9f7c95356ec6fbca654acc0d75eb4ea8d26f3569cbd682875145397ef0a060bf78548b9cd2734734143e86e94ce695739a001739a751450405145140052af5a17ad3a800a2919b68cd355771dd400fa7460b3003ad3695543360f4a00578d95b27a5369cccb22e4755a6d002374a749d5685eb4ee3bf4a006af5a70a19955723ad3564dc7140c99ee36ac6b4fb58946666e8bcfe3daa0dc5791d68f319b83d282895e466b932c83323751ed51c926ee3663de9add2a48feed04047f7686ced3436769a671dfa5002afde14fe699f2f6eb42fde1400fe69c88f23055fbc69b92bcd2ab6f6c50324726153bbef546adbdb3514d1ede6a456dbb4d05060b4800eb560c2fb972322abc331c9c75a51bb6b39e940160b6d5dbb314c6e9491af96318ceeed44d9dcb84c1a6035b1b79e94abb7671d693e6efd296addc028a17ad399b68cd6603685eb42cdcd3bccddc504052afdea4fc71ef4336d19df9f6a062302cd81d68a6f9a7b75a2828e617eed14c0c579a9964dc98a08194d93ee1a931bb8a478f6a9341256a2a55059b14d31ed70680236e94da99b3b4d46dd2801b48dd29cbd695ba500454637714fa46e9400df2f6f34374a28a60339a32c391d69f4374ab604b6b78eb22a9e95b11b6f8c9ae7f696e2af69b70236f2cf435981a74e8fef0a685563b875a750592f34734c5fbc29fcd4941cd1cd192bcd0b26e6c5040ab9cd3a8a46e9400b450dd568aa00a55eb4eff966698dd2801cdd29cbf74d42b9cd3a801f4ab8ddcf4a62f5a566da334012e11b8a89a30b3314fbd4b2767a6afdedf400ee3bfdfa462546475a8de5f9ba67da96694e170983eb400bb9df83d2a58d762e6a35568f783d1a85eb400ad29ddf2f5a9e3fdd2ffb66aae37480648f7152795fedb9f63400af233360f4a6b0dcb8a19368ce71ef44709de1c3e4fa5003d22f969eb1ed6cd364dfe62e4647a51bb6f3b3140c939a39a67983bf4a1644cf1d68287ee2bcd1e5f9dcd2a4bf30a98295e17ab53208245d9228a6c8a5908fa7f3ab50c43cc7cfdea7c910dbcf4ad35029c71ed627e9562652ee40eb561a48a2501ba5431dd75d9d28d4046b778d949e94e54123053d2a192e9f3cf4aaaf73b9b146a32d3ba34c00ea29dbb6f354b696f981c1f5a9519d573bf346a513bcdb549c67daa20c03052980c714c9a693cb6236e7afcdd28b3d48dba19e5ddb4f11edfbb46a05dba8d6ddbca1d40cd434e4bc5ba89e41d699e616e075a4ee005b68cd11c81a3607a51e7b2fcadd3bd48aaac9b875acc08b0adc0eb4549bb6f345007136b3798055a462ac0d60c771e5b86ad3b79bcc5ad1dcc8bfbb7f1479551c6e23f98f4a9a365760475acca1be5ede686e953499da6a1a006374a8d8165c54edd29b4015fcbdbcd153b74a67341247453db3b4d32800a6b7dd34ea46e941445453e8a0918dd299863d3ad4add29b8ddc5005db3be68c88dba1ad256575c8eb580136f3572c6f3682b4166b2fde14fe6ab236f5cd397ad4944fcd1cd2afdda4e68200e6a45fbb4c5ce69d40052af5a4a1ba5003890a32dd2a0694eee06571d29dcd2ae7354016f26e8c0d98e7ad4b5148372114823db1934012b36d19a6348586075a4846e56153b45f32d00575dd919e953c9d569a91850c4f4a5dc89f30193e94006dddc54127fc7c227f9e953fda19b844c37ad33cc569d80ebde8192c71ed5cd36e8336021c37ad2336c5dd5135ce6641fe7a50513baac68195f2c3a8a62c9b8e2a165dce1a95a4dc367ad004fbb6e4fb52c2bba1ddef50b43f32d5c5cfca83a9a6411d1b8af2bd6a7f2dbf8b18f7a46b3963181b36b7a75a006dab097729fbc453638fccda41c6d34f585e13bfd29cb0c932af38f7a0095bc9b565dedbc9ed490afda18848c119fe2a7dad9052497cb7a55e550ebe59c60fad680410db349704b32055fe114f99636cb119db44d3c76f1954d9b3f8b1d6b2e5d42459331d68049cfcd84c2d4727fa915467ba9e56fde7dcef55ae750961c11f7455125f6e9d71ef4c68782fe6562cdac79ff34671b7ad553ad3f9cc9bf3c5401d1ae7770f934ddce92063d2b9e8f5675dc738a5875a70c7e7cd02e73a4fb4eee2a22de63853deb2e3d477ae64fb9de9e9a86d6063a0be62dcc1ad7ef7fab3d69e667555913a0a6457698dafd585452662b838fba528037ade61222e7efd2bc9e5b6ef4ac5b698ae48eb5a1f68130564e8bd6a3502caa339f317ad14c595b61dbd7b51401e6abd6a584ed901a651bb6f346a646c4373e7478f4ab31d60c736d706b52d6e3780293b966a46372e2a378f6b66a28d8ac80d4fe66ee2b3288e86e94fc6ee291e3daa4d0491d14514142374a6735251401136769a654edd2a37ceda00652374a73f6a4a091948dd29edd29b400d57f2ceea7ae2661bba5252336d19a00bf6f70518463eed5e59372e2b0566dac0d695a5c6fc2d0517d7ef0a7f3502f5a917ef0a0091739a56fba69158a9cd47249b8e2a409d71b393b47ad324b858d0803cb3e9fdea8dd436d04647a50366ed9b319aa0258db7ae6a36fbd4e58d54823ad4972c55411d680056da84d470a6f24d3e1469304f4a6ef092480f4a007dba796c4d5869372e2a25548d303ab54b180cb83d29811b7dd350a77ab9b4476ee5065b8c0fc6ab3058c7cc9866ef5a6a0273dbad579b7fa81ee7a513ea9146ce8df76a949aa5be7e5196f4a35035216658f2ce857d0541e5a4bbb1d6b3c6ac8bcf97511d4165d855769f5a350367e586362dd31552dae9761ff9e99f9aa8b5ec370a5649391572186ddadcb2cdb5bb1c66802c2b7990b1dbbba71f8d2dbdd794cf87d9fecd2d859dd2c0e3ed67e6e984c77ab771a5c9e4ef759663edd6ac0586ea0fbd23e7daa44d560da89c6c3d73d2a8c9a3c12edf30dc45f97f5a7369967032edb8981f7d9fd2802e5dea115c8112940a9dc75a8212c2419fde37455f5a921d1ec860c6af316eb9f5a9bc98b4fedb243f796802c5ba9dc1261b19790b45d5d08636d832d5526bb8e18c9f5ac5bad4bcc936ff0005320b93df08df97f39cfe959975ae451e418fe6aa37770ed911807ebd2aa3d88914c934a8a3ba8aa2352cc9ae2dc36445923b5451dc0b8dc206dac7aad55ff4687a1de7b28f5ab0dacbe9c8373c71cbe917f5a0351f0e9b713e647448557a990e14d57b8f274f63bf75d1ff0065f318fad53bad60de13e72ee63d1aa36916688b0eab406a3975391988c227a28eb4efb706e0fdfacf7fbd49406a6bb5d7ee529cb77b57359ebfeae3a5dc579a066c5bdffcc2b556ebed901f615cc452d6858cdc1a82cdcb36f32107fba6b56ddb68cd6069ff0075deb76d64dd1e2828b6ebe59518ceeed4528ced38eb450079a52af5a4a2a3531d47edddc53e398c2e36f5a897ad3a8d466b5bdd895769fbc6af2b6d5cd73b1b6c706b5acee37e052772cd2126e422917ef0a897ef0a957ef0acc06bfdea6b74ab1cd42ff7a8288e8a751400da46e94f6e94da0089b3b4d32ac52374a008291ba548d9da6994123291ba54948cc54657ad00454b9c73536d11c641fbcd4c5fbd40176cae77109eb576b0d890d91d6aedadd36d087a5051a0adb4e69eb889867a1aaa2424e14e0d4eb1881325f2c6800790b361faf6a7a90a996e94c5fbc1f19c55a54574cba617b9a60567ba6954edfba296099f6a55a9210d80bf76a36b7f2c6ead350176b9f9a92dade47932081f5e953fcb85de76afad46d22b308d4794a4fe74017e1b748fe691d0e3d2a48596e98aa8ca8ed55239e2b7662adba4c702a1f31db7e5768c1627e9cff4ab00d43548a1dc90aed65ea6b9dbbd525bb90ec7cb0e82a2bb2f78d180c5a1762ca075cd5efb2c5636e3cc91e5926c06cf6e6824cc8637909f31b6fbd5b16290c64e339fe3abb702d6c235f2ff00d730e2b3669259e3c2f520d0037cc8638dfca8439eec69d1dc6e18f2621f5a58e2b98ed5d08c869071f8542f23c6a7cb8feb4145f8f5030ffab4842f72a326b406af716b6e8cfd4f4f9315cf4734f2c817ca2dec3ad48cb35c4c41df1e3b1a09359b5c9e66f23a62b46292484223a18147271deb26cecef66c0964c463d2b4ec74d8e0902958d189c91fc4c3bd3289619278cb0883c7b98f07a353d61134cbe6fdfce6b42688dbab328596e25c2c68dd234a67daa1d36333b7ef597e43fdd5aa018a5228d9c7566c563ea57c1b723671edd6b335af17fda895b30d23ef23ed1275fa0ac9b7f32e1f2ef954e5a820d8f3bfb43fbfb17d683b211c556b362cc587dd5a592f8c72100a838232dd3a1a08d486e6f61b691c2863291c05ea4d645e4ad83f68da256eb0c7d17eb57edade799a416b80cabfbdba6fb91e4e3f5e9f8d52d52da0d2ff00760b5c5c75dd274fc280d4ce92e9f6948d319ef55955955831219bd3ad5a493e6df215d9dd14e0fe742df4d6aade42c6a0f7c65bf3a0cc6476772cbb9609245f5a6fcd0c833be37f4353497d34db7cc7cfb55769373628025fb4c6dc49097ff68535c40ca5919d5bb29a89b1b4ee191fecf5a985acd1c71cacaea1fa13400aff00ea63fad393eed37cd7fb9e6628f39fee15dc0ff15003d7ad5fb76daa0d6706da7356ade4dcc0541aadcdcb193746457451ff00ab4fa573362a19941e9ffd6ad8b77548980eb41a9ab6ac17712703ff00ad4554dcd247185fbd4500710bd69d4ca2a3531d47d14ca28d4351f4e8db638351af5a751a8cd7b5b8dc00ab51c9b9c0ac08e4f29c37a56adbcde628a4ee59a4bf78549f5e95593eed4f1fddacca17e5edd686ced34bb8af351349b9b14008dd29b4e6e94dc6ee28006e94c6e94ff2f6f3450044b9cd2c9f70d48dd2a03f785003553cc6db4fff0053df1460b71522c7b573401132890659f23d289a23b463eed3e4059481d691a3656527a50057e3eeb74a9a284f6fbb4c6c6ff98e07ad1e732fcaaf95f4a60598dc2300718f738ab6b2132207d99ed87cd54f32265009c37ad4d66f1dbb60c9c3569a81a515befe738f7a9562131e5f2076a8a230c9d1d89f45eb53c30a348a3e5ff817dea350268e30abb51b6b7634d9310c21d93cc607834f65549980eb50ccb230222c6fed9fd680332f2f2479955df667a2d5cb71147b4166666ecbd4fb54124ff67e6358e79fa6efeef6a66dbd5c833a5b09072c3b5684934cdb250648fc939c2c3fc409e01a99f4eb89ed5e161b1f76e99a4fba17ad49696f67a5ed9123f32e593ef7a93c669d15c26d92167593bcb237423d2a80cd8ed6367716d08f25b03cc6eb2107b5364d90cac83f7d276f6ad54bb37313f931b792bc2bafddaaa9a5ca5cb33f96add5a80335b4e371229793cb466008fa9a5be84cd7ed676b0ec85404ddeb8e4d6d9b54ff0044b7b64daaad976f5ef534d6b0e98d71387f2e6b8f977ff747f11fc0668039fd62d99f71833e446c10e3ae76d67d9e9ad23658391ef5bfa5c6354016441140e4b053dd17f87fe05d6ac5f2ac50bdb060bb7e79993a839f953f2a00c9591615f954ab2f190b93f955ab3b49265320b37889380f31c373c640fc6990a968de43b628947c9bbef1ed5afa6ca96709777cc9b3e51400b2d8456eab6f13e12319924fef39ed4db18521dce07dd39dfe9447a96f81cd51b8d4956cdd9ce1473525136b9e2a82cd33bb73b0c015c16a5ac5d6a4e24b993f7633b52a2d4b5079e4dfbf21ce00aa888d23027a55184b71f1abde6c8d3a21cd6a5ba855f2cfde354e393cb18a9add5dbe64fbd9e2a0a2d35d344bb13ef76a961851b1f68fb8df7a9ccf1464b4c017c743d2964dd2e36c69e577c505916a1aa96115bda2f970c79d8bfdce39ac39f336ec2ee3ddab61d7cc6f2e34c21fbd4e874ddf205a0be43122b58bf8bef53dad372e3f83bd74f65a089db61e8793f873566eb47326dd9fea9385acf98bf62716d60db7e5fbb4efb0c823241c57a059f8415b74f723cb8147c91ff7bb5237864cdb9047f21e947307b091c1c322da90f042ad329c8661919fa54fa84336edd7570d24d8c1491b04679e0575f2f84eeace36f2d319ef5cfdd787e6b566692853899ca8496b630d624cd4b1c0ace00383eb565ac76b66a2fb3859013d335a19f295dd36cc177e7daa48e3dae0d5c9214327e14834e91be61f768117ac7ee8ad4865f3b03f0aceb3819300f4c1fe55ada7a88e3563d334166ada41f678fed120cbb7c8a3e9454b6ea91ae0100b77345051e6abd69d45151a98ea1451451a86a14514abd68d435129d192ac0af5a1ba522f5a3519b7657227400fde156d5b6b035ce231460cbd4569dade0b8c29fbc2932cd959372e295739aab1b6d19ab51c9b9715980add29bcd3e91ba549431b3b4d44cbb862a6dc1396e94924c6491547dd354040cd81b69abd6acf9751b47b5b34011b7dda7c736d5db4302c30a707d69eb1a85cb3e5a80216937360d4124b24adfec0eb53b4d1eed84e3351ee68d19962c8fefd30209182a127a5529255ddc024fa0eb56a4b8666c31c0a6314dbfeb71ef5a6a036398a8c84707d4d5cb72f2b0a8636551959816f43576d9a4760a244cfb75a3519a76724919005598ef563dcccc158773551219997065c0a6c71c8b9513027d0d0513cb788fc85463fde1d6a3fb605e586454922489b59d90a8ea075acfb8ba8e663bba2d5904d25f9cf0bb57d6aa4d7e7071273546e2f36b154e95456ea5dc76f5a0936bedc5a32225da4f064f4ad0b386796148dd8a5b0e8a3ab66b1ecf4b598af9d26c0dc91ff003d7ffd5d7f0add8ee60b455c9658d06495eb401bb7491587eecb3cd2aed2b19e91f150bdc2dbc2d71331566e5547b564c7aac92ee4c2c51b7ce3cbe87eb59d79a86f727ccfba73401a51cf3fef255dff00689b9e7d0f07f435575ebe9bf7b0c5fc2022ff00df3cd558eee59a68d1643b5be7e3af4a8566964be62cee557d6803a5d26375b5311ec14b7e5552f2ebcfbc30c7f73386a6497de5db91ed542d428866b87fbabd7f1e2802fdf4f1b3f911ff00075aaf25d7958fa5430cc2487e5fbb9a8a6556b84ddf7739a00bd14b98d50ff1573fad5c49777021fe08fad5dd46f0c2b238fbec30b5cdf30c2dbbab9cd0219b77163fdda1739a6b49b9714d41b980a09d49aa7858ab02bd692384b0c0eb56e1b675209e9416a3a92d9b2c12b97192474ab6b06f541b311b753518b7f32445addb6b40cab19e86b9e523aa312a456e5e3c8fbab5afa6e99e6ede33ed52dadaac12291d735d1e9b69e7c930e7eef6fa563ce7546043a7e8e761da9835bb0f86d63dacc0127b1ad5b0b7025311b793042fcfe9c56fe9ba679b332c0b2203d5bd2b094cefa70d0c4b5f0ba5d323ec8c6dff000ab71785215b85312a39ee075aeb74bd0dd647313b4bcf2edd16baed3fc1fbf264646dd8e075ae79ccec8523cca4f04a8c1783e56eb585ac78015e190ac185afa3a3f091f2ca6cc211cd675ef84d36b2573fb492d4e8f6309687c81af780658d95963f94573573e179e12711f22bebfd53c06b323e17771d2bcdfc45e0796d728d07ccdf76bb69628f2ebe052d627cf31e9ea6421130cbd4d4335bbac9b6bd62ff00c1d2aae5e1c2f3935cbdd78727857f771f7af4a35398f1ea51e4671715bbadc21f7adcb38cac84cfd71c54f269d2a70c986aa6b6322b920e0d59cd2dcd38d8ab020e17e99a2a2fb3ccbb498430fef1e945581c0af5a750dd29abd6a3531d475145146a1a851454a3fd5d1a86a46bd69d4abf7853db3b4d1a86a47402472bd68a296a335ac6e86d087ef55d59be615ceab6d606b4ed6fb7613d6b32cd9590b2103ad26d2dc37dda8619b18353adc65b14143599154a8eb4ce3bf4a26fdce7dea1f3a802e47b36d4725c2a70bd6abf99bb8a5e3bf4a6027da9fcc19e948d70b23ed6195f4a82e2e1235200cd40be64adf7309dcd69a81764ba8a243b576b7ad675d4fbd49df9a86e18ab6d1d6a161230c038a35017cca7249b980233ed5108d41cb49cd598a6503687c9f4a092c5bb4aac0ac7f2d68dbcd73b8792bb4773595f6dd9c6edbef522df6e4c6cdffed55946ac893c8d979b61fef559568d76acb2799ef5cfb5d7cbf7314f8ef0aae475a00d6cc6bb8a74a82eae84b1a64640ed59724cd275e94cdc5790bb8fa5004f2488c71b31ef53d92c4ea4374aa732ba28170ec88dced4ea7daa1378f22958c1118fe05e8bf5a083566d6bc9cac63763802b367d4995f2ede64adf78ff0076b3ccce37549696ad9f9ba35049a904fb533eb504d71be4da29b7130823da9f7aa082d46d2ffc64f14166946d1ac2c7f8f69c7e5496336d507daa1489b736efbb8a8da4589be5eb4016eeaeb3201ebc52b4dbe1483d39acc9257ddbea7b56791d49e9401b56f27950d2a9125c12df740c9fc056734c42ed1d6ab5e4fe62f951ff00175a00afa85eadd5d1913fd5670b55994b2e475ab3069aeea49e95721d376f39c7bd27b17c854b4b169719e957174d08d93d2afc567e547bb7e71da890b053b464d63cc6f1a453d88bf281935a16762656181b0ff7aad59e933b206f2c1ddd8f4ad98f4a9e64501d108fe11d6b3948ea8d132e3b10ac155770fe26adab3d36778f6c6fe5e47defc2afe93e183260b36e6eb8aee743d04c7b5946c2c08ddf8573ca475c30e725a6f87dd001245cb281fef735d6683a0c7e7659f64a3e465fa73563fb35a6baf220fbcbd64f4adcb2d12285550aee75232d59391d91a16d4b7a1e8c92dec9825caff08aecb4cd0dae976cccea0745355b48d2e48dd52200ee1c67e95d86916b3c6a7cf8d33db15c9291d51891e97a2c31dd3a0193b0715d7697a72a4780983eb59d6f195d59884c1f24735d358b32a827a54965cb3d355e3dac32a7b5171a2c041fddd5db59376056846030c1e9401cadd787e2b8e5631903bf4ae5f56f071923ff005487d96bd39a1566c0eb55e6b4dd915051f3f6b5e038a3dfba05dc7a798703f3af3dd63c2d3c6c115b6b672cb1a16181cf515f51eb5a29b8c81d4d79f6bde159599c28cb63a574c2a729c7568c667cc3e24d056d7722ac8ccdf391b9c77f435c94c86de4c06753fdd35ef1e23f0caac722b45997b0af24f1169bf66931e4e3debd4a556eac78788a3ca602b34a7696da0f7ce28a8e4711aa831f145746a79fca79d374a6d49e5ede69ac370c51a98ea368a3cbdbcd146a1a853a3fbe29b4abd68d4351cdf7aa68f18e7a544aa19803d2a69245b8db18eb46a3236dbbc63ad387bf4a4dbe5f1436769a352c7fcbdbad2f3fc3d6a05fbc29ed9da68d40d4b3987087ef55c460ac09ae763628e08eb5a96f7219707ef527702f334970e0ff0000a6b36d9996a1f38ae4a9c1c75a80315870b21f358f18a802792e7cb35526bcf332b50c96b3cd9f2e191fd5a99e44a9c181c37a9ad35024593e6149717c23204270ddcd559229bbc7c547e5baf3e59fc28d4a1649cbf2cf96a8fccddc5482d649bfe59b9faf4ab3168776e3222f2d3fbde941253a6b3f96bb88ce2b523f0fee70247abd169b15bf0902c8dd8b74ab030a15b8b820431f26adb58b065f3a7f3dbfe79d6a30b98a15d9e4463d075a8bcb964e5a5556f55eb401044aa9c08067dea4da1b867541fdd5eb4ffb2aff0018794fbf4a46574188e20bee68288a57d88465dd3ba9ef55cde48c33143b36f7ab4c9e62ed7280fa8eb49188e36197c8a0933da39247defd6868f8abd34d0ae48eb54a5b857f9475a006ac614e4f4a771fc1f7a945b19138eb522da342bb98e00a80208200cc58fdeabbbca4640a58ede39173bf350dc5c6f531dbf6eb5600acf23384ff0057b06efceab33799b8ff0076a692336f0244df7bfd67e7551fef500382ee38ab11ca615e3ad568db6b03576c2c64d4a45862fbee78fe749bb2b82bb7a12d9dab5db7ccc554f522b56db465dc30aec7fbc6bb4d1bc131c11a1232e4722ba9b1f07aba8023e6b867883d6a18476e691e64ba31dbc0c9f4ab11e8efff003cb35ecb67e090a8094e2afc7e078d86e68f8ae6f6e7a51c2d8f1287c3cef203e56df7ad3b2f0cb48a55beed7b22781c6df9633b7daad5af844c7e58891f6721b2323a547b736f6113c9e0d06354e99dbdab4ad746e0799113dc63ad7a83784e245da530c9ce7662a6b6f0c20653bb6fbd67ed0bf6670fa7dab47875824dadc75c7eb5d0e9ba3dc5e2fef653696e7eec702e4b7d4d6fae8ab1b4802ee3fdead3b7b22b0ed5ebc7f3a8e634e530e1d345b910428542f567ea6b774ff0eadc148c0caa905856ac3a5067dc7ef62b674fd2c6f5dc703ffad51cc5f2905869ed1dc88d530a18f3f81ad758191b0738f6a7adb87215a3c463ac9e9e95246ccae2368b83f75fd2a0a24d3e3c5cca70e7e51c1e9d6b7adee0233029815936ba7a47973febcfdeabf1ff00737ecff6a80362d6e55a4503ad6bc736d8f35cd47195190779fef568daefe33d280379bf7ca29bfec55349f6aeda9d1772eece28247c96ff006953ed5cfea5a2fce5b19adeff0081e7da90aeee2803c8bc4de145baf30c4801ef9af0ef1b782d23925693671e9d6beb5d534d32480ae33efd2bccbc69e18593cd918464827f8f6feb5b539f2bb18d4a719a67c73ad692230ccbd14ff5a2bd0fc71e198618fcc8910190f386dc7afad15ebc6ae8783530f6958f99d7ef0a939ed51afde152735d1a9e3ea0a1d9b1c7e34f10bb71ba25f73d299cd1cd1a86a5a5b38d97067877ff00b3d6a092ce443bb6ee4eed55dbef52ab18db72b6d3eb46a1a8d66dadb69cbf78548b70aedb5d771fef532488c4dc7dd346a1a8fe68e6a35fbc29ed9da68d460d9da6957eed2a00c30dd29de595e47dda352c664af34090e78eb4fc3370bd6a45b299d725b68f5a350163b99586c5ea6abc9bfcc1fdfed5347672dc6e5847ca3abd5eb7d2638e1469246de3fbbd68d4a32d6dd9db2c70deb57acac2e6ed4ec62c0761d6b4a1bab1b3ff005702c8e3a97eb4e6d61da2509b231e83ad1a8125af86c950d713bc6a3a83d2a7d96363c13bf1fc55913eae23058be5ab2ae356691be5fbd46a074771ab4292288ce2aac9acf3f7c9f615cdc934d2373d29b82dc374a3503a09759fdd9e631eff00c555ff00b6bfdb3f8566a46aab91d69f1b1560475a3524bcda9175c88df3fdf3daa48efd7f88027d0d52f2da5fbdd28db1af07a51a94692df465b05500f514c90c5237cbf7aa87daa18fb6697edcedc22607ad1a816da3daa4e715564ceee1f355e5b895fe56fbb51ee2bc8eb46a496d7ca27e642edfddce3f5a735f431aec02343fdd8573f99aad216930a7a1a62db1cf1d68d40b2d7d1b70c580f7ab36f79f6a98ac71061fde3d2a0b5d2da665cf4abd1dbbc8e22b7e9d0d05adc82f2f0ef11428818f0714efb0cf05bb4d3fee8f64fef569c56b6fa6fef24ff5fdab2351d48dc484bf51f76a398d5c742b4926ee2ab30dcc052487cc3927156f4bb19f507091a2a8ff009e8fd00ef56621a7e9b36ad7914302ef958e157f0af60f08f8322d1506f1bef1c7cedfddae7343ba8bc3e8b15840b34cdf7e793ab7d2ba3d37c4b7925d1536ea5bd17ad72d5949e88f4b0f18c3591dfe9ba565907bd77163e1fcc88d8cf1fd2b86f0ff008aa3740bf6593cc1d6bd0fc3fae473e64458e40bd4c5fc3f5af365191edc6513774ef0c890a929819ad41e1e0b76020cb761f856a68b730cd1ab3a617ae6baab2b58ae144abf75b8accdb98e457425652ed1f2c31503682984fddf7af409b4f4650075a87fb2c77e95259c2cfa0aed184c1f5aa4da4f96f8af473a4ac8368eb55a6d0ca6581c102a0b3816d17e5df5a31e9bb6106b7adec5a48c9963f2994fcbef5692c3e5a0d0e7a2b4317cc0038ec6a68e3789c6c44119fbc456db69e58601c1ed53ff0067796158be66fe2a04ccf5873b5aa54b5f983e338abab60fbb79e8298f6bf374cd419927d8f7056d98f7c66a6452cbb8755ff63155e1b6612295939ec95695a6438ab015376e1b8e07ad4e8d2a3060db97d2a16b9130c11b9876a48da3560636f33d4ff76802f4774dbc65303d6af46dbd7359adf795fd2ac473714017531b867a54be72fdd1d6ab46bb97753d7ad048eba5fb4608fe115cdeb5a5453a00df78f4ae92a2beb513467774c500781fc40f081bd8cb463330fbdf9d15e8be27d19a6b628a5829fee920f5f6a2ad4a5621c62ddcfcc0e68e6953a53abe8b53e1b519cd1cd3e8a350d46735111b9f15628a350d483cbdbcd0bf7854b27dc351c60b300bd68d462b6edbc75a922cff0017dda5da13e63f78527999e28d4b24dc8bc8eb42cdb4e719f6a92087710d4acbb1f346a508ac1d8131f15694c4172c98155cc831cf4aab35e2ae42f5a3503526d51b037745e959b71a9ee6c5566371743787d88bd5a9ab1c4a72877b776a009d672ed91d6a39266cf3d28f38fdc1d68daedc558159d7736ea002c71567c96efd28f2f6f341242b17cd4f58be6a538efd28b892389437614087ac6a0e5feed2b5df90328700566c976656da3ee9a4a08d4d06ba79072f91e94cf303707a552a541b980a065b76555257ef546b2be6a4588ede3ad5886dd9f0a7a546a595848c786195f4a9ad2d6399b98eafc76031cf4ab22c504648ddff0001eb417ca55933161026169f676fe636738f7ad19ecd42c73ca56188a8d88df79bd6a29b54e02449e4c23eefbd2d4be506558c619f2be94cfed58e1f953ef76aa97133c8a72f91e950cebbc2ae76e7bd662d7a0cbcbf9267355b62c9cb0dcde95d1699e0dbdd4155d2dbca88f57f5ae9b4ff0008c1a4e1f67da5c756f4a39e313a6142a54d59c65878726bb01e65f262feeff7aba05b59aced5225388bbd6e95f2dc0202479e54f4ad2b5b08379fb9f37a75ae59553b6385b1c7c3a5ca645db1905bfe5a0ea2b72db4594b26d9a58e5ecc3ad7636ba0c7347f21018f427a55fb7f0cb21cb1475fee8a9f6a6bf57399b45bdd3fe6fb5dd49b41f951883d3d4735bda4f89a6b8746fb75d46f18044d1c61c47cf56cf38a7de69a2de15648fcb6560437e22b32fe07b5ba678d8dbcdbbcd520e3342945e81ece513d6fc37f13afec66f21cd9ead09c3b7d9d76bffbea3d7d7db35edbe13f1859eb56f986750d8f9a16fbc2be34b5bc9e5bc926c6e94e1dd6293f789e847e35dff847e215d699771ee2b332101e676dd7183c608fc6a2712e9cf95d99f5cc33209117fbdfe1571614438fef579f7857c5561ac6e7867532c6a0b46cd8639f6aee2def15ed723af1fceb9394ef52d4b7e4a521851811502dd1f31b1d7145bb33ed2dd39a836226b3560e075c547f67dd83fdd5abade66eff0063bd4bf2edf9beed4145258728450b06c6cd5d3242cec83a9c53258d57791d78a00acff74d549613cb860a7d4d5c2bb8639fc2a3998075521c83d8d46a33396e1e356055187f7852ccdbd41ce29f710a24ce02005bb9aa8fbb76c4085bb01416ee4f18668d42be5bd298c258db730ca8ed55e484b290cbb4fad3a2889f904bb4fad5999712f36ae7662acdbdc05601ba3567ac926e033bf6ff00154dc45236ce87ef5006c08ccc9c7dda961fdde2b36da6daea6b4a3fde8a00bb149bb8a6cb1f9b95f5a8ed1b692b52bfdea0931f50d3cb46e075c515aaf6de629a2803f20b9a39a39a55ce6be9753e101739a7af5a4ddb79a04818e0f4a352c7d3a38c4b2056e869eb0a32eeab112a47f37a51a815db4f669982fdda996d62850e7ef55b9b6fd9d1c75155b687e4f4a3502a47b7cc38eb52eef2fe63d2a568d76f1d698d6ab18f9fee9e4d1a94356e25760abf769a5433807ef546f7059b111c638cd31f7c2a7e7cb9e828d4059fee94c6735523568e6564450ddb774abf6b0c93c643bec53d5aa7f211380779fef51a81419048b9964697fddfba2a6788451855fbad565576366abbcbc351a81108f6906924ff0058b5196323855eb4924822439fbd40093315048eb506f66e1beed479f36414b236d8cad59039ae1635217ef55490bc8dcf4a7af5a72aef3b68235228e2f9854be496e075ab50d986c03d2aec7671af27a50351d4ce8ed5f1572df4b92661eb579248625e84fd2a746775ca2ba8fef1e959ea6ca3a90c56296fcc8718ef52ab2a9cab6e5f4a77c9fc6f934ab711c6711825fb01506dca0ab231dc176a773491c91daee1bb7bb7007d6a4b3d3eff0058980862918f602badd2fe136ada80479956d0e78dcb927f0aca552313a234672f851cdeb0ccdf6099176b4b6c0e7e8f20aa9a6e8f77ab484436e645ee457b7e9bf09aca186ce3bb125dcb0218f7eec28c9c9e2ba73a2dbe936eb14117d9e2c7c8beb5cd2c52e875c304e5ac8f12d3fe14ea179b5ae9e3b38ffbbfc46ba9b1f0469ba3f96520fb44cbfc55d5dd48636503ad52999ae324f415cb2ad39bd4ed861e10d8cd10863205e40ede95567b3dc08ad476daa56a161b971527419d6f6ab82ac32a7ad6ad9e931315658f9a8a34dac0d6e69b0962acbd6a9ec32ce9b6a222f9400019c9e9c5741a4c963ac5b65366fce0e2ab5bd9c7709e5ca33b8735ada4e8f0595a9302e0679358f315ca54bed1434122a9c2918ae366d25e187ecf2c3bc44d90d5e90d1fca6b36eacd5b2cdd29c661c87966b1606c640ef1988ca0e1876e2b31ae808d1d8310abf7dba0aefb55b18665da17713dab86f1369274bd9796a793c14faf1fd6bae9d4bbb1c55a91d2f847e225c68b710b5c4cd3db21e76ae655f42a3d01c67db35f48782fe222eaf60844b1ddc2ade519a038238dd861f857c576f7612668f60176a432657393d718f7ae9fc39e329747d485c5bcd25bb484059506645f542bdc6eada7479b53969d674da4cfb87fb54c90878f7fe3d2a4875267c2afddfe2af27f01fc42b7d5b4e5432a194b7cdb576967ef91f4cd77475a0aad222798c07ddaf3e51e53d684a323b0fed04b7b64924fb83ad5ab3d422960775195c5717fdb9136c30bee1b46f5f4ab314c7cf8dd7a9cff002ac8e836e6863fb5adc6364ca9f237e18fe5565755e045fea9ca8c7bf358eb71e6301ff2d2ae2eddcdbbef546a69a9a724abe617693e6c54135d47b63cc5b87f7aaac7b370a94c88c3cbf5a035219a7fb464eddae3eeb55269530a8e779feed599a448f2376ded9aa923166f2dc72bcabfa5586a2b332ae55b6aff0076a368d245cc671ea6868770c6fcfb5342b2901065bb501a9346c47caaf93e956566f3173fc6bd2a99becbb074c11567623ed9075a04c9ede4918115a56f28957e4e83ad6741d455c83abd06668c6db79ab51b6ff96b3e1ea2aca36c60d4105bf2a8a856e771c633ec7a514127e40ae734f5fbc2a46b1995727a53d2d5f6d7d2ea7c50d5019b0c703d69cd6242950f956e714efb2bf7e957adedf6ae68d4ae52a423a7fb34f8bf8aaeb47b466abbaee6c51a8728da1a118dc7a52ee2bf28eb5135acf2b7ef3f0a3500370b18217ad57937cc6ae43a7b798bbba568476b6d08deea188ec68d40c6b5d3249647c1c55d934f116df9f2fdaad5d5d79b8cb88c0e813ad55866dac4e15867ef37dea350092d58e377dda864b85b78c81d69d717535e4ce88bb87a55392d7fe7a394ff006475a35019e64732b64e1ea292d659645512614d4aab6f1b60c6d8fefb74a8e5be923e238d624ff67a9a350245b331ae22033ddcf4a824d2e495be79620bdf3522c777749970cde81ba539b4ff00997cc641fec8eb46a041fd9e91f1e7c3ff0001eb4e4d221918179895ee075ab2f0c316dc0c9a4f93fe79d1a8f948ff00b3eca3fe291bdaa655b445c244e5bb67a531a6451b4260fad33cc27a75a0a2e2f97b398401ea7a5206841cf9519f6c03fce96df4c96e97e53827bd6ee9be1169d94193e63594aa46274c68ce7f0a32a2bd923e228953d195101fd2a68f43d53549018e177ddfc46bd0349f0a5adbed2220c47563d3a574b68d6f6380a880fb5724f10fa1e8d3c13b7bccf3dd37e155f5e2ab5c3f969dc5777a2fc2dd3ed577328651f798d690d693ee0eb56a0d50e46064fa5714eb4e7b9e8d3c34206d693a15a59c6b15a4496ebdd877ae82d6d63857e45dc3bb57356da9c85400bb4fad5f82696465dcf919e9581d1cb636e2f2b9c8c8f4a8ae2c96e95942ed43dea3b36daac7fdaab0d37cb480e17c45a1ba798d6799187f08efcd71171accd66ecb287475fe135ebfaa3968c81d715e6de29d3de760319ad60652308f89e13f7c807d4d5db5d66d66c7ef139f4ae3354b17b794931f02b216e21462241e59fef7a574721cd2adcacf62b592dae3015f24f6ad7b5b590e3ca04fa01d6bc7348b8819808ee30fdabb1d16f758b0c35bdc2c91e7eeb1c03f8d653a76d4d635232d4f45b7b87b56512238f735d05bea28e8a3d6b92d3fc756e196df59b0f24b71e66dcafe75d7c3a2dbea50a5c69376b3646762f515ce6dcc5e170926d154ee829240eb4d4b799434526fde3d694ef8baf4a0b30752b32c19875ae4f5ab1f3ade45fe3c647e0735dcde2ee0cd5cc6a0bbe46154b7135ccac7916bd64eb324ff0051546d669a4e50b065391b7af15dc78934bf3b6571b2db7937817d8ff235ead291e0d6a7cb2b1d1e8fe24b9d2665bfb6758e52409638fa37d6bdd7c1ff00100ea968b239c330c31af99ec6e3f72d1ffcf335d5683a90d2f524c920328e475a8ab0e6d4787a92a72b1f57585e07b52caf96619c56bda6a4cd6e8cc32abdabcb7c2fad192dd5dddc9c0c66badb7d4b7ee35e6ca27d0465cc91dd0bc578c10983572dee8ede0e0fad7236b7ede57ef9432f606b6ad6f835980cc8adfc2a3ad65a9a9b4ad24873bf344370aac557eeff00156625d7cbd71565a3f315640f9f6a0b343e5fbe3a8aade6062c1ba510cf12c8558e1bd692e662b2290f95ab2351376d453cecef8a9a3911948f9fa77aaacdb46dc03bbb1e948b3c8ac164441e8475a0352c2491b46233dcd4cac51703eed529f679dbe3edd6a7662aa241d40a04cbab2fdeabd6b26e005665bc8c61563d2ad5aa86cb1e94199a3cf6eb532ccf2c899e82a9472b4b1b6e3865fbb4f80b492ab97c85ff000a0835e3c77e94532da5fddb514127e55f965796fbd460b71c7e3557ed2cdc2c7f352ac9331c6cc57d2ea7c796a3841600ecc7b54a6c5547980804773d2a935c428b80707bd33ed88bc87e68d40b1259176cac899f6eb5247a78dbcc9f3d555bf6cfc8f96ec298da81ddf3920fb75a3502d341146f8698237f78f6a72c4dfc32248bea2aac3e219121f2f7b943d8f4a57d70b290064d1a90588e431ee112ee3dc5115a4b365a63f3764aa5fdaf349f2c6843f6229d36a17181bc3b1f4346a32f359045258ac2bdddba0a8dde04522de2695ffe7a2fddace926b9954f9cde60ec7fbb48a032907a51a944970f33ab0de13fd9350dad9a3659e44cfb75a72ac68771a5690b2903eed1a81235bc28370704fa1a6ee55e41407daa066da335566b809927a51a816a49477938a899d5948127359935faf3b7ad44b78cedb4f4a352398bb24c15b697c8f4a699571c75acf99b7fcb56218f6a668015a62af91d6b5f47d34dd3891feef7aa76165f6ab82beb5e85e1fd0c2c684f4ac2bcf9558eac3d195495c9747d1be55fee57476b64b6e015fbc2a68e358610abf7ab42cf4d6ba2a4f4af26750fa4a74f9628a71c6f74e3daaf47a1492630335d2e9ba01640075ae8acfc3ae23048c8ae6e73b231393d3fc383e5ca61ab5a3f0eed19aeb2d747e89b31ef5b70f87635db2632e3a0a8e635e5384b7f0f191828eb5a36fa03c6c057736fa37cc3e4c7bd5f8f43f306dc67da8e60e53828f4d74602a5fb2bfdc3d2bb68b432970c163e6997da385e4a61a98729e71aa58ede6b92d52d7ef57acdde9639dc323d2b91d6b4a36bbd847f29ab8ec61289e55a969ab22b17195ee2b99d73c270ddc2be526243d0d7a3ea561e4c85f66066aa49636f2a3e503b71f29e879ae884ce4a94633478549a4dc58ccf1a920e7a8ad4b0d72f7460a37b9f63d2bb7f137871ade63790dba471263730f738feb5c878d258ed6c63c8cb91d2bd08be73c7ab174753b8f0df8eacefa4862ba0a5882087e98c1ce6bb6d2ad5ace413f876f0c576c72d6abfea644f41ef5f30279d0c4b322ed19eb5d9f82fc7f71a2dc08ddb7293823fad454a1a1747189e923e9cd23c5d6de202d677b0b58ea90f0d149d7ea2aecb1a43f2bf1bba49e95e7ccd6de28b48253330bd8c6e8ae93aeef4fe9f8d6b786bc5126a0d269ba9a98b538386dfd5d7b579928f2bb1eac25196a68ea1bfe6d8bb87f7ab99d42105031fbd5d0df4c7ce741f74d605efde352741cf5edbfda158ff0074571bafd8fcd07d6bbbb960a496e98ae7b50b576f24274627f95755191c75e1ccae71b1c261bb918759315674f98062b825fcced56752b416aad9fbc6b28b6d8d0fa1cfeb5dbcd7d0f29c6cee7aa783f567b7701257f2f77cc87e95eaba66a1d0ff00785782e8373e65c39ff9e91815e8de15d4a468cf99fc3f20fc2b8aac4f570f23d3ecaf81520f4adab195372b8ea2b89d16ff00ad7476d3191411d7ad729ea44eba1bafddd4725e98cee5c647ad61c7a808c6e4e8dc1ab71dd79b5059d1d8dcfdb1437c9bc7a548b72d14d26e191e95cfdbdf797328dbbb9e95a325d6242fbb6ffb35604ef31f382bc632dd33d2a4440ec014403daa286612633d29ecc1666299dd8e31419ea58b78d241311d57fc6a610fc954a35dc11b0e5fd0f4ab9180c308981de83327871c21e95630f13b347d05451c6546475ab4bf79bccfb9de9904693b5bb023ee9fbd5a11fef591f6eef6fc2a8dd2bae233f75ba5269f71b64f2bd723f4aa24e82cb1b4e5b68feed154fe75802a0cb27228a00fcb65ceee3ad39c332907a552fed6997e549081ea28fb716f99a5766f435f45a9f1a4ad0e6251517f66193a75a725f1660075ab715e347f337dda3528a5fd93247f3633534760ff00f3cea69355456c8eb52c5ac16e075a35020fecf91b8d83f1a3fb319792b1a8f5a99b5372d8a8dae247841071ef46a027d97ec7fc6873d854124c7b75a45c6d662f96f4aad24be52aa7f7a8d409fe6fbc7a0a85a62ad91d6a16906d39e954ae2f1554a8eb46a05c92eca9cbfddef5526be66e17eed412b17c11d698a199b07a50439134d23a000f46aa5349bb22acb46d22979ba2f4aa92673c7ddab31d48e945006ee2ac4717140d6e3ade1f983d685b43f68d91fad578e0de315d3787748f3190e33cf4aca53b2b9d14a9f3c8d6f0ce82b95771951dabbbb5b7c2ac51a6334dd274d65501130d8eb5dcf877c2e768761963dabc2af5799dcfaac3d0e58997a1f86e59983374ef5db699e18daaa6ba1d1f40f2a10db31ef5d559e8de56cf7ae1954be87a31a76d4e6b4ff0d86da1864574ba7f87cb60f97f22f5ae874fd243002b62d747916453fc1dea4d4e76db4458d8304c11deb4a2d0f7f35d247a66de6a68ec4ab023ad501ce43a16d901ab96da3edc9ade8b4f669031e953b5998d4b0ed401cd0d2ff7b2557bad2fe46aea2dedc5c4b7847dc571b7f2aad7163b589a00f3ed434edbb9bd2b9bd434f13ee8d86430c115e937f6bf28ae5b51b3dd2114d6e271d0f15f1568afa2c83098b57e95ccdb4be5dc04fe06af76d4b4b8b52b5961993cc8d860aff5fc3afe15e1be2cf0f5cf85afbfe7a5bc8d98e5f5f6adce6e52f18639a1786e465141207f2af10f881a348d7d1ca71140c48dc7a0f4af5e82f3ed16f9c02ea3806b0b5cb18b51b3786689087e38fd3f5aeea356cd23cdc551e689e47a3cc2df36b294703a30eb591ac471dbdf3080e02f26b52f349fecbbeb9b4b83b1f3ba29bfbd839c7e9546de45b8be692e0ef970416fc2bd789f3528d9b89d5fc3bf1a4b67702de76dc8c718f6af4dd6a57d4238af6ddbfd32d4ef8a4fef26391f966be7c91cd85d896238f9abd7bc31adb5c69a9b9f2db718fc2b83110b3b9eae0a7cda1dc69fe211e20d2e2b8f33f78bf2b54734db7277e6b8cd26e9f4cd725847fa99d72bfceb7649fcc6cd797289ee4762d39f31aa29a0f32265a48e4dc31563fe599a453d74397d434ffbd580f6a77b22f56e2bbabbb612c6f9e9589259c71b2b1f7fcf1c577539687054a5a90e8d621668c9fbcbf27e4335d9f87ee0f9b3cc0e0b624fc8edfeb5ccdb426dbcb8e43b5a4e1cff00b3dff4adeb3c32838f2e03f320fef28e07eb4a722a9c795a3b8d05d96de52d26033f995d0dacd37cb320d81b8c7f7ab92d27cdbb68ae251e4c4bc450fe1d6ba9865925dbce107535c12dcf4e07476b7470dbbef62b46cee37a95f5ac1b36da41df9f6ad0b79cc732b2f5a9d4d4db0db509ab30c85a1503ad660be0d1e0fdea963276951d585006c42ceb827a54b0c9b988c13ec3ad67db48fbd5b38dab8cfe9577cb7c4797c86ab3377352c523915976387c719e95269d10df221e95169cc150ab74a9fece76951f75883f91cd3332411aab151d7356f3e6053fdda64cbb9849ed8a5d9f698c9feef35440ebc98793b0f4e3f9d323d9b5f1d7151de5bb490f9eadb5b8c1fc69dbb82eebb8b0c6ea09342397cd863e718ef45555953eca28a08d4fca4f9e9d1da3dc48055e860769144ade48ed57bcbfdd948f3239e8457d29f1e54da96bb40ff59daab7ef26dd86dbef571edf6b65d1c1f7a59b6da018ea6a350208edc47c95dcc3f8aa4ddb79aaed76656da3a9a4ded1f27a51a8161a6da33443334d2045ea7f977aaaf37d9d49c641ea2927ba16f6aaca77dccdfc3ff3cd3b501cc3af2f97ce748ffd58e9f5acf92e4b1c0eb507396ddf79a95739ab239892e259365323c45d7ef1a1f3b4e3ad46a594e4f4a08d4b2b2166c2f5a7854b5f9e4aaa26dbcd5595b7c80d302ccd742ee4c2f414df2a9d6a0348a0f4ad88ecd5e22475a996e69187318a23dbcd58552cb81d6b41ac76a9356b4cd37cc70719a8e73654b524d274b927d8319cf6af4bf0e682218510a619bbd55f0de8242c6ee9893f84d7abf85fc34c92ab11907fc2bcac4553ddc261796d22cf863c3224c13d2bd3345f0fc71c6a0d2e87a588601ba3c8aea6c6cbcc555dd88fbad78929731f4118f291dbd91919147dd15b567a685c12322ac5a5998e4207ddad6b5b5fde2d66682d9d8aac6084c1f5ad5b6b5f94524167b9947bd6a2daf9d27d2b45b92320b4dc40c67dab4e1b01e5f316e1e94b05b109b475ad1b75911702b53096e67496691c6582ed23f86ab9b30c3714c0f5adc92349176c99ce474ebd6aa6ab66cd0845477799f6853fddfe2fd335a6a339bb1b656b7120eadba5ff00be8fff005a92684b02075c56ecf649d106c0c32abfec8e2b2ee2df6b11499a2dce5ae6dd9465beee6b0352b358d582f56aecee9b6e56b0af977b15accd4e36e2d996205ba573fad69b6da8da4d6d3c6258a41b594fd6bb0beb7da49ac4bab32d961d6999ca27cffe28f095df84646b8b7ccda713b431fbd1ff00bd5cf6d8f54e6419f6af7ad5236cb232ee53c15f5af31f13782d1ae1aeb4a6f2241cb45fde35d1091c9381c46bbe11b7d734f30e364d18ca357913e837d6b74f6c13ccf9b0a6bda7edd25acc61bc8fca941c3fbd45a968515fc26683fd68e56bd1a75b9558f1abe1e32773cf34af02cb7004972db586485fc2ad686cba66a125b0ea4d5f9b57b8b191a09ba8e056035c336a818f466ad2529495c8a718d3691d2ea136dbeb693d185744b379b27e3fd2b99be8fcc8613fed8ae82c57749bbfba2bce91eb40d287b569430ee8f755186b52d14c9851d6b2674104f096858019358f7169216e1769f5aea1ad5b1cf4a8e4d34ba134e3233940e622b310c8b24accd3487e50bd4d6f5a5b2accb24ea9311d235e91fd6a7b5d3624c93f7ab4adeda35606b572d09f676d4bba6dc6e2ac8ad205eebf756ba1b2b8776505302b26de32aa08195ad88feeafc98f7ac4e8817e16db203577cdfddd642a966001c1ad1b791f6862f90b51a9a97e39034441381eb572de68e40b993ee91fcea85bb6d671fdea9f715e475a35035e30f333b46f9dad5ada6cfb54ac9d6b9982e248d8329c115716f8cd31667c9181fd2833773a8b199be6cfdecfcb57a36db319304b8f4ac1b098b5bb460e0abeecd6c59cc3cc288f9046f35a1997a18a4da7f78fc9cec352c76a0cc664e8dc1a65b01365c9c05a99a464fdec6c58b71201d7daa881b3c4773edeb50184377c3f5abb74af1aab18dc83ebd2a8b1f21b3bb6e7f868248cca63f359e4f91b00fe74550bab9dd2636eef6a2803f359ae971c260fad31af368cd6535f6e18a635e6d19afa53e3398bf25f13c0eb5133961b9feef7aa5e7f99cd234995a08e62dfda9bee2fdda5f31ea1b6846e0edd2a3bbbc6932abf7450048f2b6ee7a542d26e6c5411c8ccc01e952edddc5046a0dd299cd3f76df96991f7a03511b3b4d3376de6a49db6c4c6a38a4dd814c351cadbdb151c917352b6769a655190fb17d9262ba2b39b6c7f8572ccdb58135a1a7f9d3c8889d18d6533ae8cf9743a18616d40c70c3f754f35def86bc30159643f78541e0bf0b920337535ebde1ff0be307e95e2e22b6bca7d261f0dccd4c67877c35b9636af4fd0347f257f0a8b45d1bc95fc2ba5b38444467a5797391ef528f2a2fd858ed00d6ddac262c32f5aa9a6ecda71d6b423731b065eb5cfa9d05a854472420fde6cff002ad087fd62d542c245527ef55c82e3cb4c52036f4d5dca45695bbecc8ac3b6baf9455e8ee80e4f4ad2273c8db8e62bc8193e956a2b891b03663deb017545dc1075ab71ea000e6b62394dc7ba16a573b83b7036f51ef59f6376d7d7934d110208d8a5bf95dc63e763f53c5675e5f4de4ada42cab3cfc316e98eff00a559b3db6768b179ccdb7e5024eb9f6ad352794b0d0a4724cdbdc93d73d3ad55be81197754f1dd61873492e24ce7a52d4d16e61ccab700a8ea2b16f2c4ef38eb5d4b42adb40eb55e6b356043fddc73599a9c1dc583ed7cf4ac3bed3ff735de5e580e36f4ac8b8d3f2d8a9347b1e737d6664568fd6b98d4b438a40ca4e1abd5753d172775735a868df7aba23239251d4f1bd7bc3e970a04f0ef51d1ab90bad0e4b79775bb2ae3f85ba57b7df68c371cf4ae7afb45dcc427dead4c2503c9f55f0fc3afc4229ade4f37a7991f41ef5e71e25f08ea1e19d42359333da31cc732f43ec6bdfaf34b9617fdc1c3679a47b737d1fd96fedfcd005691ab65639654a2ddcf36d07447d4f4d0766300735ad0692f6a4257a5f857c3715ac32f951f9687b5589b45b7691830cb7a565291ac627056ba7b30c1e95b5a5e975bd1e8416752a981eb5b565e1f31b285ead591bc63639e1a4ee8f152c5a496fddaf535dc5b68236f3f7aa0b8d018b7c9f7bb5056a7153e94b1a9ddd6a9885629463ad7617b65f67215fad645c449baac82bc0de5aeeab42e372629b1c681723ad4724dfc1eb41a1721b8f2f0d56527ded9f63fcab1836cf9aacc775918a0b35ade61e58cf4cd5f565936a8eb586b1f98b9ab10dc06c29e82a3523537a1ba618d9f787156a165f3001d53935830cc90c81738dddeadadd0ddf2c9cd00747a7c9ba5036eee7a56f58aee6886ec7cbf77fe042b86d36495ae18abe4e40fcce2ba8b57469b85dc412a47d066b41729d7d991247313d149a9adb77983242b6de09f4eff00a573fa0ea0e6f1d0bec8e4e0afd39fe95b3e6fef24f2e41bfb66a8c2459b86921955576448df731dfd6b2350b831ee6593e503e6a92e1cb290f22673dbaf5ac2b8d415564c3e4ab6282482e6e246b666918b73c01f5a2b1354d43c9473c73ebf5a2a0be53f38b715e69557736ea8b715e475a3ce6efd2beacf83d49db1b79e94f8595391d6aaf99bb8a280d4b125c6ee2ab349b9b14c6fbc29cabb980a80d4b11aeee29d2b6232b42b6d5db50bf5a035117ef0a9173b8546bf7855a87fe3e0fd280d4553891be98aad343e4becf4e6ac85dcc4512666538ea280d4afff002ccd576fbc2a78dde3dc0f4a8a452cdb875cd30f5045f3182e339af4ff0087be13f3423ecc64f5ae6fc19e1b6d62f159bee835f49f82fc2a96d020c678e95e6e32b722b1ee65d84e67cef62cf877c37e5ec15e89a3e91b78f6a5d3f4b48624c260fad741676fb10357ceca5ccee7d5c63ca3ad6d3cbc5695bc3b980a8a3abcbfc3526a4d1831602f5cd5b59035c007efe2ab0ff574ddde5fcd51a9a6a69a36d604f41537da3ece7cd8fee49f7ab312e372e29f1cdf30a0353623bcde3356a3b9dc302b9e694efe1f61fef51e74bfc2fcff007cd581d146d1dd48e76abbae3e56e9d6a79756746315be4f182dfc2b5c9b06f399ccd2161dbf86b42d6f1d46d2f91562e53a0d3ee05b2be644f9fef62b5a39d1e2243e4d72905e1568c85dc79e3f0a9e1bf3b8f94fb0f75ab2794ea925f969e8e19803d2b02df502ac0abe57f8ab421ba136371c0f5ad351729a4ec970bb7d299711aaa851d6abe5d64628f91e94d9ae86f543f7a932049221b0e7a5664f0a33e2b41e6f969b32ee018f4accb32ae2d578dbd7159d71a6472423232fe95b98467c0eb50cd185c93d280e639393c3b048ae7661fb1ac1b8f072cacd8eb5e866dd2419aa9716eaaac40c9f4a083caef7c1203127a566cbe188adce5864035ea175a789a1194c0acb9749173f2a7de1d2a798392271ada7f97e588d31ef51ff0063cd24832322bb7fec3548c86fbd56a0d2d76ec1d68e623d9db538987417e32981eb5d058e823c919191e95d1c3a3722b6acf48091e4f4a6b729ec7336da5246b80983eb59bab69fba371fe7ad765756ea0951d6b0afe3dac56b6d4cb53cfb56b3d808ae72e2db6b135dc6b566639303ab571fa95b30739e940998775190491d6b37ed8cc581e82ad6a0fb370ac2b898ab12bd6b420d3fb4fbd2aea5e5b62b9cb8bb0149232d5424d5f6363cedbfecd57299ca5a9db2ea9f30ab51de6f19ae160d6864664e2b5ad752590021f27d28e51f31dadb4e1d70dd3157ede6323a11f7554572d6b7c1a3c1e95b363708ca00eb5068a5a9d3477af1ab04fbdc7f3ae82cae96f08c7de18cd71b6d2fcebf5ae86ce48db7053818e4d06af63ae81447b58b6df98f3f855ab69e2599c850d718c163d39acab390cfb03b06213806a5fb4128c16342548e07d68301752baf263f2a4d9b33938ae4efaf024c4afddad4d6b501e7ec2db588fbb5c7eb179b56439c6050066f88f563043b41c16eff008d15e79e2af117cadf3e769e9f8d147293cd63e53a2aedc58981f23ee9aa8f17cd5f567c1ea31ba536a458f9a788771c50664283730156d23dab9a72af9698a2a0d352097bd4753343b9b75063da33406a0a372e28b58f6cca7fda1fce98d9da6a6b519907e27f4a03526b86db3dc1f715149d9e9bf7e42dfdfc8a6c7feac27bd030652ca5875a9f48d3e4d4ae92303249c62a2589b7009f7ba0af54f861e112d2076fbce735856a9c913ab0f4255e565b1dc7c3bf088b18532986615ed7a1e95e5c51d63787748db12aff00745775a6d9948303ad7cbd6a9cf23ee68528d2a6a25ab1b308a18f415a4912ede3ad456f6ccab93d2ad797b6326b9b53a06c71ed606a74cee155b38e68fb66df968d4d352e96da33501937381512dcee38a63cbf35032ce4af34e8e6dac0d508a6eb4d690ef18eb5659a0f75f3527da7deb3e4bc758ca9e95599f72eea00d9175b4e735616f8b2e1739f6eb582b2fcb53adc145c8eb4146f4772ac30dbf3ee702adc32bff1ff00a9fe0f9f35cfdbdf3b3007a55b8eebe61ce3deac83a4b79955811d6adc775f375c5737f6afde27cf9f6a956f02b027a551074b0cbbb618dfcb48f3ba3fef6462a76b8565c31f96b9e8efd7b75a93ede7b1c1f5a05ca6fade42a9b475a6b5ca30c0eb584da9145259f22a97f6d22963411ca7551c9b980a995b69cd72d0eb91b900d6bda5d34d21dbd2820d4f2bcee29e6c556225c657b8a75bb98d773fddef52ee32723ee504adca335a8debb5302abbe9fe5b6300eeec7a56bacdb4eda83cee5a835321ec3e6fb883e94b1d885705ba56a346648d71d6a486d64e2a444505a164c0fbb56d6c76ae6ae5bdb88d727ef53e4fb86acc65b983796bd6b02f6d7e63ce3debaabac64e7a5606a12451ee63d0569a91a9c66b96e238812f91e95e77ad32a4acc3ad76de26d5a15f31475af2df106a686338eb9a6b733317569fcc9197d6b98beb8f2d9855cd4272fb88eb58573233360f4ad48295e5e32c60af5ed589737f36e39e95b33c6650541c13dea8de5836df9a4e2ba22724ccf8f5174706afdbf891eddd49e959170b2b36d1200a3d6b32695e193ee249ee2ba62aeac79f2a9289ec3a3eb62e52327a574f6178b232a8eb5e0d63aa3d9ba12db467eed7a37863c43f68427fbb58ce9db53b28e2b99a8c8f50b79b6a835bda6de79726ee7a76eb5c869b73e743bab5ec6f36cc8b5c87a1cc77ba6de23a9317999ef4b7123336e3bf1efd2b3b4897c92def572493abe7150c0cbd52623383838af34f176bc369447c81f7857a278d2ead6cf4a4789f3262be7af16ebbbbccfaff005aa840993b2b9ccf8975cd8d337a7f8d15c86b1aa9babce0e08a2bd7852f74f02ad7f7b4661dbc8c5361e86ab5c59966dc3ad2f999f9a869b0335e81e26a43f6665e4f4a3caa71b82c300f350348ccd83d2a83525f2c2f27a51b95791d6a1a280d4249371c544d9da6a46e951b6769a01dc655b8bfe3ce4fc3f9d526fba6afbc5e55843ef5066575ce6a48d773006a318fe2e9576c6d24d4ae238e319c9c50cd52727646f7847417d5afd652331a1e6be8cf04f87d6d56360982075fc2b88f03786d618e2458f94e4d7b77876d3851b31b475af9fc655e67ca7d96030dece0a52dcdcd1ecfcb556aea2ce3da80d53b1b5fdd56bdbaf96b8af225b9ec92274a8a4a99ba55691b6f34806b7dd355036d626a5f3373815148db79ab3516497e5350b4bc544d2fcd55e67dd914165b593e6a8e49b69cd5069b68db51bc9f29ab02db5cee7c52f9d59de652f99bb8a00bed37cb52472f1596f9da79c5496aff00678d86fce7b5051a30cdb4935761b8dd8158fbb7f35346c5791d6824da8ef0a300bd6a5fed04fe3383589b9e4f9691dda35209c0a00dd5d44c6721c15f43449ac7c87ee7e15ce35c6c5ceecd50bed4b673ed401d1dc6b9b14b5605f78930c715cc6a5e202b1ed50493c6075ae8fc23e03d4f5d9d2e2f40b6b7650620dfeb0ffbd48a34745d427bb44fee13cd77da4c8d1db863d055cd1fc0f676103055dcc00cb56bb6861502afdda93396e36d2fff00775335f165c0383eb549ad8c2db475a6c562f293413ca69c770cdc17c8ab51c84f0bd6aadae96fc55bfecd9524623ad0592c56a27917232d9e95b16f6be5337c98acfb16324caadf787f856f44bb23dd5a44e7915da3daa4d5395b6e4d5d9a4dd91597777223c83d2a8c8cad4e708ae4f4af3bf116b0b1bc814e1bd6b73c49ad2c8d22afde1d2bcc75fd49e452a7a55ea2e5b6a60f8835c67c82f91e95e7fab6a7b8e2b43c49a9b46ce17aff00f5eb84d4259a690b1e95513394875c5df9accbeb488372e2a0f29f617f4a9a1dfc67a56a6239a2f96a278caa92064fa558a08ddc535b93b9cfead0161ba28b27bd731aa67ee340771f4eb5dfc96fbf22b0351d3c79873d2bae12386b5238ddc17e566751fdd35b7a3eb46c668c838506b37538628d8eee959fb8272bf76bbd2bab1e3b7c923de3c33af2fcbbdf2ad8cd7a0d8b09395c6d61debe78f0eea415101381eb5ecde0bd73ed16cb1c8f9f415c5563cba1e961ea9e93a1ea4f6d0b09367b62acde5c7970c926dddc74accb6912355c75355b5ad4fcab7907fb35cbca7a2a5a9c078bb5a916ddd646dbcf0bf8d789f89357dd363eb5dc78cb5ac23fe35e35a95d79b333fbd7550a5795ce1c655b2b11de5c06dac4e0668aa124a66f90753457a9a9f3ce5a94125f96869370c531b3b4d32b6390932579a3cca89ba5368027f328f33771506edbcd234bc5004ed9da69950f99bb8a1ba66802cc08249955ba75a7dedc19e5207dc518a8d7f77097ff009e95179a7b75a0055fbc3f2af52f87de1cf26159a4fbedcad71be09d07fb5b525793ee8393f957ba687603ed288bf75062bcfc555b46c7b980c3b93f68f63b2f07e9bb466bd2f47b3f2d55ab9ed16c76c311f6aed74db7d9006f4af9c948fafa71d0d5b18f6a83575739aad6b8e33d2adfcbdbad646a365ff566a8c9d4d59b8fba6aa4b9f2cd069a95a66da09a8964dcd8a1bef542ff007a80d474955266da09a99fee9aaf70bb88140ca934bd6a0f34f6eb4db993cb63507da777156516bcc76e0f4a2ab4726e602a6c95e6a891fbb6f34a936d606a1690639e94c699146682cbe2f0af23ad496f33c8a73d2b27ed4bc63ad5cb7ba3e69c75c5481a28c55810707d6a658da46c97c8aaf6bbe426b52089bc95cf4cd00675c5b6149ae475c98c0242064e302bd06fa30b6ec4f40335e7cf026a3e248e393fd4c63cc3f971fad203a5f879e0e484a6a57f879e419894ff00cb3ff2335ec7a5dc5bc70b04d9b940c63ad79de97a846546e3818c0adfb5d5a25c0593e6ac65b9d5cbee9eafa6b5bc96b112016f43d2ad6a0d12aa9544071d475af36b3f12187043e4fa52df7891e4e4f4ad23cb638dc65cc752f642e9d89381eb56f4fd19bbb6e6fe115c543e2adb1edf715d8f86f5c171c138071cd35b8a51924d9d3d8e8819402986f5ab52695e521a9adefa36e37e78e9537da124f9475ad7962727348e7eeac4e491d6a18ddd1c467a56d4bfeadffcf7ac3bc3872691bc6575616fa4f2d377a5705e27d67c966fa5743ab5ef976e057996b1742f2ed83741407299f797de746cdf5ae13c4173f658d9abb2bccf96c80657d2b88f111c315d98f7a6b7225b33918ec1b516df374c9c573be22582c188f4ae9afa499963894e031db9fad78678abc49a9d9f88af2ccb6e10bec02bb210e6d4f22accddb8d7208e6c6edbef56ed754866c625dc7d2b8b83580cc05ca6377535bd6f65657f1a91b813fddeb5a4a1a99c6ae875f66524208eb5796cf7b66b8f86cf53d2b0f6ceb7900e4c6df7b15da786f56835888283e5ca9c34758ca3a9bc64579ac3ad655e69a25055ba1aef9acd1d940eb55a6d2b70228bd8a7ae8794eada0b10768cae3a5729a8589b740ae985cd7b35f68fb589c67dab96d534312162c981eb5db4aa9e7d5c3f31c0e9739b79011f77ff00ad5dff0083bc49b26451ff002ccff318ae16f3476d3a49557eeb54fe1fba68e778c9c02a39fc6bb64b9a2797ef5291f55689abc7716287f8f19ac0f196b9b91c671815c8784fc560d9404be43467f438accf1b78851adcb0eb5e7387bc7ad095e373cefc71abee9186fcf3d3f1ae0ae66f318d5bd66f7ed179237bd65349b9f15ead18f2c4f031353da4ec4d0b155623ad1516e2bc8eb456e60546e94c6e9524ca53219307d6a1adb9794e40a28a2800a28a55b72e723ad1b8094aa9e6305a56b5902d4b230863f293a37dea39408a67dcea3d29618ccd2aa28c9638a615ddc574fe05d23fb4f54327f70ff4aca4f95366b08f3c947b9e93e03d00697a7a394c338af4ef0e69bb5d0fa9ac0d1ec70a8be82bbfd0ec76c6a6be72b54e6933eef0d4f922a2759a4c1b1947b57496b1edc1ac8d2adf6461bd2b720fbb5e748f5625c8eac0ff005755e3a955b6b66a4ad424fb86a8c837645599a4dc08a86a350d4ae63da334d6ced357666daa0d529a5eb406a54b8255491d6a8de4ceab93d2ae4d71e5e5bd2b9cd4f50f99ab45b8156faebe6355639033863d2a85ddd0f3371e95566d65218cf38f7ad4cf98e99644d86a29af9238d8671ef5c3dd78ba2873be4f97bd61de78d6369308f91e95a7291ed394f439b5b550543e4fa544ba9658357076fadfda181ae834f6fb4ed5c6734b947ed2fa1d359dd79cd5d158db79aa0d6568da7965501306bb2d334e31aa97195ee2b32892c34fe056fc36bc2a55bb1d3cb22304c2fad69c761f2d481cfea16fbe163fdd15e4525e7d9fc4d7cbfec8fe75eefa869e7c96e33c578078f2d65f0df8a16ed93115c0c1ab35a72d4d6b8f107d9e3ddbb6e075af3ff14fc6dbff000c3030c6922a9eb27ddad4d62e966b5debd4ad7847c4695b2d9e99feb5b52a7172b31622bba749b47b77857f6a8d3efa58edf56b76b1763b7cc5ff0057f8d7adc1ae9d42159639d25b76019715f9dfe732ee2a707d6be87fd9bfe2334927fc23574f9daa64b51f8127f406baebe0d463cd13c3c1e693a93e4aa7d2b6fa86d6535da683ac792a8e4e315e7327ef8af38f7addd2ef3eced8f32bcbe5b6a7d15f9cf65b6d5a578e391df271c0ad6b5d61db00f4af28b7d5cc716e0f93e95d6693ab6ef2cc8709dff2ad23239e74eda9dec377e660d53d4ced3bfd2a1b098000abe4354f7681c027a553d8c56e703e21933e6357065775cb357a26bf66a9e681d589af3a6fddccdf53589d051be90c6c5875ae435a8da42ce7a57597b26588ac3d421dd1bb7b5691dd18d4d99e71ad47b6407d0e6bcefc7fa0c57d2c7a8c49bee231f3afaf6af4ed5e1fddb7d6b8c9f61b868e41946c822bd189e3d45ccac7036b0dab5bc92ce361c7ddfa571d378925d3efddedbee16ae8fe2059cfa78d889883a935ced8dbc57ba7346c70c8339af469c1495cf9dab274e5ca8eefc23e3c86f5847336d97a035d95c686f7920d434b5db7f18ddb7fbdebfa66be718f7c3366393ee357b0fc33f880accb6b75261bee8ae7ad4397de89d986c5394ad23d7bc27a845ab5ab73b275e2487fbae3ad6a79615994f4ae575ab6362d1eb7663cb55dab743fbc09007ea457490ea51ea16f1cf1fdc75e3eb5e6ca27b5197311dd5bac91b28eb5ceea9623cb19e95d4799bb8aa578036e04647a55c4a7b1e61ad697f6c8488fefe703f3ae12e2dce9f76518e1a37ce6bd875b8d0460ecc7bd79cf8b2cfed0c648fefaf4af4694b43c7c4448ecf59f2638cefce18f1f81acbd7b5efb56ef618ac9fb5910156fbc0d65de5c6f0cb5d2a1ccee79ce728ab14273fbc1fed13509ff00594e9299cd749e7bf7a5724452cc00eb454d6717ca5fd28a07a8fd62dfcb9775643fdeadabc3e648d593711ed6cd7b38d87ef1ca270d1f848a9186e5c52d15e61b92dadbf9922ad6cc36f84db55f4b877465ab5238be5af770546f07238ea4f5336eff00731b0ac8dbb8b356ddf47b51cd61a8dca0579b8a8f2c99d14e57415ec1f0bb49f274e59ffe7a579569763fda17089ef5f417846cfecda6c11fb57878a9da363dccbe95eadceb749b5fb95dce92be5822b97d1e1f992bb3d2e1f956bc091f694ce834ff00b82b521ea2b1addf63015a91cbf32d7348dcd00db549a3ccddc556493730152d49a6a49cd236769a56eab41cd46a1a952e1b6a93546f2e3cb1baac5e379796ae7efae8ee38eb406a41a85f7defa5719aa5f316017ef66b6af03dc391eb5047a3bc8e32323d2ac1ec72772d3ba923ad723acb5d2b39ce38eb5ec8da08f24ee8f8ae47c41e19691c958fe5ae8a73d4e399e0daec976dc07cd67f83ee5edb580921c6e6c66bd4756f05bb076f2ebcef53d027d36f3ce8976bc6d906bd68548b8b48f22ad0929299f42f84fc1b06a0526ddb9d97207e15e8ba678056355609823bd782fc3df1d5c59c6a51f2dd0d7bc7853e274770156e7b75af3aac647b3457344e9ec7c3ff00650056ddae921f00f4eb573c3dae586b3929f7bb57469a5fcb94e8d5ca6df0e867dbc6be5aa0ea2b62dff853d6a116a613f38caf714d594ed6409b54d040b796e1d581e95e6fe3ef08c5ae4796380011fe15df4d71b322b2b52b80c841e98aa19f375e785ef7478da095b744a72a2bcd7e20784dee62126cc7ff00aebe9fd5ed639a419e9cd707af68f6f233ab0c835bd39d9dc24f9a2d33e4abaf07bab313d2a4f0e473787b5ab3bcb77d92c132b06f6cf3fa66bdb35cf09a4dfeae3cfb579edcf85ee9b544823b7cee703f5af455672563cb783845f3247d5fa4dd4775690ce0ef5740dbbdc8cd5ef3d130c3ad61e856afa6e8767048363c712a6dab6d27cbd715e64ba9ed43ddb2376defa4f3bf7871e86ba7d3b5654e1a4e38af3d5b8fb3ae37e73dab4f4dbedd2a0faff2ac8d99ecda56af0b3280f926ba8859563723ab0af29f0fea182ab5dadb6adb6d4ad68b6382a47533fc4971e5995bd8d7997da374b21f735d6f8ab562a1c8eb8ae26dd9e48d49e8c4d41baf850db88fcc6a6ddd9eeb561ed5ab67646e14c83aad2dedbb2aed3d2b55b984f63cb75cb1db93f5af2fd694c77c9819393c7e15ed9ad59ef9185792f8d6c7ecec1ffba47f3ae98ec79f2899daa68b6de24d15a261b262bb55bdebc4752b06d0647808f2e78c94947f7876af6fd32f963243fddc7ffaab93f1df8746b41a6881370bc9c75eb5db8795b43c7c661eeae798476f0c9664b9c16aad65786c6ed1a27ced6e051796d32dc18bcb7dea71cd5bb1f0fdc4ecace985ea7f2af44f2146cee7bcf82bc489abe8ef6f3aee0d1ecc7b9181fad5ef0aea456de7b52db5e06f28afb039af2ff01defd9a5961ce307afd2bafd1ee7ecfafde47bf3e6207af1aac7567d161e5eea3d16daef6b03515e5f9c36deb8ac786ea9935d0c1cf4ae75b9dcf632b57bd0fc1386cd715e205dd04adbf3d3f9d75ba85c236e15c3f8826558188eb5df4f747955fe167117936d91d6a94926e840a7de36de3fbd507fcbb8af4a2783290c6e94cda5b8a39a7479dc2acccb96ec55768eb4559b41bb028a8d4b23986e931556e22f94d69795cb543245cd7d756a7ce99e2c2462491ed39a66dddc55eb88cab6475aadb1a49029e99af0aa53e5933b6333734d8f6c20d68a8dca4552b61e5c2b57e1937478afacc2c7f7713cdab2f78a77517eedab9d8edcc97455464938c575570bb9587ad4fe1bd0f6cc64f535e2e711f67a9e8e5f1f6b2e52ff0086f4516112314c3357ac68f17fa3c3f857191daf92ab5dae89feaa3af87ab2e63eda8538d36923bad263daca7dababb1fba2b96d23bfd2ba7b56db1835e6ccf7291a6a4ac88475abb1cad8e7a5508fef2bfa54e92fcc2b98e934e19376054f54639370c55a8ea4b255fbc2a499b6a834c8fef0a74d9f2daa350313519376e158f2db99391d6ba46b6f31a9f1e9fba4028d447370e92ed863d2b4adf4cdab9adf5d336ae6a74b3f2d777a5043b9ceb69e0a9cf4aa926829366baf5b3dc73491e921b2c7a55999e757de175f24e064d7976b1e171f6c93745b867a57d237d648a9b475af3dd7349dd765aba2130e4b9e25a87832e2d641776498ee52afe8faa330f91b6bf465af4eb1d1d242c8edb14f1bab93f19f80df4d90ded88cdc28dcc9fde1ff00eaaec8caeac3e5e535b45f134f6aab83823bd7a4f86be2acf0f96923e514f22bc2b43d5135288151b2553b596b7a1f378da70dd8d65289bc249e8cfacb47f18d86bd6f85c6e2067357af6de358494d983e9d6be5bd1fc4575a7bae24e86bd5bc2bf150b451c13be57a115cb2884e82de275f75180493d2b9fd4ae92256c75aeb2e658ef2d55d3a48335c2ebbfbba939f94e7754d4396ae5efe61231cf4ad5d4a5f99ab95d425fde1ab208e6111930c32bdeb574cb5b6565754c11deb93d42e3cb9037a53ecfc49e490b9c7bd69a86da9e8ad3955007dda454ded9ae524f19d9e9b6fe64f23018c9dbd6b8fd5ff0068bd274b9cc2b633dc37f78b01fa9ad214e53154ad0a6af267ac490fcd53dacdf67753e95e45a67ed1be1dbb1b2e21bcb52dd5b62328fa915dce89e32d27c511ab69d7f0dce7f8633823ea289d39c77428622954d133bdb1d78c2ce475ad9b5f13b32807a579df98629038ea2b42c2e9fef7e1f9d731d274de22d58ccb144064bf6fd6ace9b66f711a029807bd63e5db51553d11335da68b9f2463ad544ca44b6ba7f951557d42cf740e3fcf5adc843b601e954b5287744e3fcf5abd4c8f3bd52cb6cc4e335e7fe34d04de5bb054c330201af5abeb3dcc45739a969a2457561907b5691329c4f9d2d51b98dffd6dbb146a9e68fce8d1376dcf7ae87c6de1f3a66a1f6a893113fde35871e22fbdd0d6ca763964b9958e675dd1bec72acc89be31cb35655deb56eb16d64c30e2bb0d4ae0a46c7f831cd79e6b9a7ab23ca3a935d909736a7935a9f299fa7de6dd6a5319c03debb1d0e777d61897c8d95e79a7ed86ebe7fba09aee3c2f8fde5c37de3f769d6d89c39dcc371e5e1aa1d42e19be64fbd59df6aaaf7179b549ae5e53bdcb420bcba3e58ddf7ab8dd7aebe593fcf7ad9d527df2035c5ebb71e7cd8f4af428c4f2b132d0c876df3934add2957ad34ffacaee3c596e22e7352c437480536ae69f0ff1d052dcb96f1955caf5a29be7ed902d151a9a96ae2db6bb1a87caad5be8bf7d558c5c57e9156872b68f968cb4466c90eee2a316d839abed17cf49247b6326b86542cee6ca4450b6dc2d6942db63cd6742c56406b46193710376df7aedc36e44c59177216adef06afda2373e86b2663b547cbbbfdaad6f0291fdad3c47a3afff005ebcbcf68f3611cbb1e9e513e5c42474b796fe5c3bbe9fceba2f0fff00ab4aa5ab5aa0b42475c533c3371ba303d1abf315b1f7eb747a768ff756ba187eed737a5c9b900f6ae9231ba102b8e67ad48b767f7aaeab15606b2230629030ea2b495d9b6b1e95cc746a5f597e5ab56f26e602b2e39373815a96e372e2a465b8f3bc63ad4e6d9a5ebd28b08ab56de2f98566ee59560b01b39e957adec51581ab90c7b706ac2dbf98c0d4014cdb2a8c8eb5018f6b835ad72be5c78acf7fbd5a6a042f9db56221ba322aacadb72738f7a4b5937646fcfb5002de463cb6cf4ae2bc436a9bcbfa5779b7782bed5c9f88ac8c96ec075ebf91ade2072d0c4be60c36d3eb5d1af8685f6965a5197db956ae6a191ade6dcc70ac715d6687ac471ee064e3a57540ae53c23e20782ee3c3f7cdabd847e546c07da3dc67149a0eb11ea702b0ea785faf7af75f126829a942cc5f31baf35f38789b41b9f036b8d2affc7bc8d93f8d74bd88e5b6a762abb9b1524770d6aeaca70c0f159d63aa47756e1e3f419a9246322123ad6069191e99e12f1edc59b7953fef54f017d6babd6265bfb61328d858676d78a69b78d6d346cdd14e6bdabc31749e20d24003255718ae7944753de8dcf3ed5a27dd27f9ef5cfcd6ecf26d3d2bd4356d07a7c98f7ac0b9d0fcb62de952711c24fa7ee04561dfe9a50923ad7a44da66dc9ac1d5ac3e6ad4c267937882191b318ea6bce75af0acf34ad2d7af6bf08866391919e9f8d361b04d4635fddd7546a721cdece35b491e1e3c3f32900f4ae8fc23657163acdb490ffac59171fd7f4af568fc0c970bbb662b5fc37e038edee564fee9ab9625b562e182847547a2d9c26e6c639dfef301bab62c6de3450c7b735462912d6de341d54522dcfda331c7f7091bbf3af31ae695cf4d7bb1b1b5a4c6d35d4970bf77a5771a5eff002467a5739a45b6dc1f6aeab4f8f6e0d6b13296e6a5b80c307a557bb851b2075ab81b6c719c67ad4521f35b6ecc67bd5907317d6fb589ac5bdb6f35597d6baabfb7da49ac8ba8fe46a8133cfbc45a4adf5a989c6548c62bc7b59d29f4f91edf66003915effa959965722bcebc55a3c72c67fbfdaace59c4f1bd4159b713d16b93d5e4dc1d3d6bd0754d2fc9cfd6b8ad6ad7e66ff3debb299e656399b7b7126d53d09aebace35b2b30a3a915cf5a8f2ef08ad392f36e16b739e268fdabdeaa5e5d7cc39c7079aaad79b549ac6d4b50e1aaa11154a965719aa6a3b576efcd72f24de64c68d42fb321150c69b573eb5dd189e254a9cf22566dab9a6a2ee60d49cd0735a98936377157e35d8aa6a95aaee914559ba6db85a0b1cd265f19c7bd150dbc7e6ccabebfe145401d9ea1175aa3e556b5c4655b68eb54e689b9cf4afd82ac3de3e294b42898be7a82e23daa4d5ef2ea0b88be535c7529e8745396a8a0bf785695a638cf4acff2f6c80d6b5aff00abacf0f1f78da43e4dbb7e5fbddaad787666b3f115b67a3311f9834fc6eb76159cdfb9b98a4feeba9fd453cc687b4c3497932b0b5392b47d4f65beb7dda7c83d39ae63c3b27972489fed57676abf6ab157ff009e9186ae094fd935c917fbcd5f8ac746e3d8fd524ee948f59f0fcbfbb5aea6d24dd815c4f86ae37a85f6aedb4fed5c754f4e9ec8d08fa0ab2adb57350ff1ad0ca59f0bd6b90ead4b5e6fccb5a566dbf0b58f1b0570a7ef56b58fde5a87b0ce86c62f9456c5bc5f28acfb0ff562b6e1c6d5cf4ac0a2c410ee5c55c8edf6f3496a159401d6af243b9714c8d4a73467cb38eb595346cb264f4ae9a4b5e959d7769bb22b4d4672975179527d6a039ad3bcd3ff00786b3e687cbc8a0b1d1cc146d3d2b3750915b701d69b7171b1b154e6bac822b44072bad47e4cc4fad47653ed653e95a1a947e6ab56046c2dee324e0035d5091bc4f47d3b565b9b611336d5c609ae3bc77e128356b564d85f033b875a6db5dc8b31937e507515bb6f789750189ce158735d0371d0f995e59fc1baa4b14a8e202ddebb3b5ba17568932fdd2335d3fc42f06c1a85abbc71fce470fe95e236bac5df8275110c8bbad8be18568627a4f987b75aee7e1ef8c5745bbd939c45ceefc8d7050de59eb36eb736adb4e3e65a6c327944e0e2b19c47195f467d3905ed96b16e27b77cfa8aa17da6ac8a48ebff00d7af18f0f78bae34b2acadb957b57a0e95f1046a4f1472a633c67f0ae4e52271fe52cdf59056914f4c573da869e86df03ad76fa86264475fbac2b99d417cb40d8cfb50b73cf99e6baf787fed0b201deb8fb3d3355d06e18c69e6404f2beb5ecad62b76ff0032614f7a1b43855491c9f4adf98ce3b9c6e9b73753c6824b5c66b5acee258e570b16d3eb5d32e9491c08db318ef54a6b7459323ad074f319dfe932483774adfd16dd6490ab7de359eb67b9835749a22f9698a8d4b3a4d2e18e26c1e98ae86d6258b19fba798ffafe958763d0738f7ada811644daef95ef408d8b76fb426dc678e94df24b14455c127ad3ecdd5a48c03851c7e956bca58641b5f2c7b5592666a36e1a22c7ef2d63347f357497d03b7cc7a5605d47b64cd46a35b9caea367e5c8e3fbd5c6eb567bb78c678e95e95ab43ba146ae2f56b5f383afad35b9133c7fc4163b5b3b315e75e20b5da5cd7b26bf6be5b3d795f89a3db239aeba67955a279cc92795754efb66de69ba936c95dbdeb2a6bbdb935df13c99cf949ef2ffad73da85eeedc3d692f2fb73e2a8b0f3debae313caa952eec3615dc4b55b5fbb4c8d762e29dcd6a61a8734f8d4b48053305b8a9a38f68cd032556dadb696452e857d69957ec97cc60b59bb9658d1ac7c819f5a2b734db51f2e7a515981a779216da03b95cf7e9559ba55d9a292e17749b3e7c631d78aa537df7ff0066bf6ee65512a91ea7c3da507ca3082c3154278be6ad35fbb55af21dcc1ab2a91d0b5b994d1ed6cd5fb5ed55678f6f356edfaa738f7ae0a71f7ce897c25e5cede3ad55be0cdd7a0e7f2e6b532a2cdb7be5781fad51ba8c36235fbabcd7a5529f342c73c25cb2b9eade0ebcfb56876cff00ec62b96f1841f65d52397deaff00c33bef3b4f783fe79b9ab7e38b1f32cf7fa7f8d7e0f8b87b1c5ce3e67eb986a9ed30f07e469784efb74607b57a369373ba302bc3fc23a97968a9e8d5eb7a2dd79ca3e95e7d4dcf5284b43ac8e4dd81534df74553b46db8356594b0dc3ad71c8ed123fbc2ba1d35fcb50d5cc333abe4f4adfd264ddb4543d8d4ed34b3e62ad6c471ed19ac3d37ee8adbb7acb52cd1b7059703ad6be9b1b2ae5ba565dbfdd15a5633100a8eb46a2351add5e22475aa725a6e38a963bf68586efbbdeb4e0f2ca6ff005a35235395bdd3cb2b01d6b9ad534d951588ebff00d7af4ebab659318eb58d7da6975651d6819e41a8295dc1bef562c971e5ca05775e28d21d5735e5faaef866753d2acb2d5c36f626b12f60dcc589c0f5a2daf7cb908a6cd73fbcdd5a477409db51966ee8d8693f77deb5ad64dcc06fca60f1f8564dd5b2ac7e645d7a9a6437a18807ef0aea3a54b991d4ccbbadd049dd462bcabe23f803fb52433dbfa64d7a2dade6d8b3bb6f6cd68dbdac3756b2204deaa3e66ade064f547cbba26a12f84750304ffeab760ff9fad7a2473c7748244e8e3357bc7df0f3ed8af3a2631d3f3ae07c3fa949e1fbc36177fc2df2d6a657e53b38e3c3035621ba68645d870c3bd44251302ebd18542cdb5c1f7ae7944398f5ff0006ea86f2c7633e4e3a52ea8c16624f4ae3bc13a885bd553d39fe46baed6ee11991ab9647354dc486456c01d6a5621464f4aa36774bb4e3ad3e4d439d950416e795368acc959249368eb504f73b9f145ab6fcad05adcbf6f8dc10f435bfa7a24385fef561431ed20d6e59e360cf4a0db53774d5466c671cf5ad68363348824e4d63e97b71f2e33fed56842d22c921da8dc7414c1ec6c430f114bbf3b33fcb15a16f26e602b1acc9568e477f2d46723f0abeb212770195fefd69a981a538dcc07b1ae77528f6e0fbd6935c491a96924edc564ea126cb7ddbf39a35029de00d0907a62b97d4a24f28d6bdc6a4b1c403fddae7f52bc0e1cafddc51a81c3788e3558988eb5e37e306da653fe7ad7aef892ebf72dfe7bd78af8b6ebf7d2574d13cdc41e79ab4bc8fad7337d36d626b635ebae3f1ae6246df2035ed5289f2d8a96a231f35f34e58f69cd0bd69ebf785741e682fde14fe69c8a5980a7b3606da0d46479dc2acc8db7069b0d23aee6c505935942676c0eb5d069b0324c81beed52d3d1a08c2af56ad8d36d5e76fde9da87a9acdec06ac0aa92921779feed156adedfeceb941e581dbfbd45625172fb4b5b3da668ce00e7158cffeafee3819e09e95f5c7ed1dfb365e7847477d66c508863f9db1d7d3fad7ca570c8c0b3c8f2caee09cf6e2bf57ca710aa53f672e87cae2e0f9b9a2548f1fc5d2a290166940fbb5686dedd7150b02db00eb5ee4b6679eb7322e17cb6dd576d63f9a35033bbdc0fe74cba8d94927a55cb680b431b062a7d4570c63ef1d32f84b623491b2250b22b2e14ba1ee3d2b3e7873236e743364ee03eb5b5b9d6d0a9477191f31fa8aa575f7a1f931f275ff00815774be1315b9adf0d67db7d791d773ad45f6bb2fa0af34f05bfd9f5cc7aa37f3af52560f6f96e98afc4f3e8fb3c74bccfd472597b4c22479869f27d875274f56af54f0fdf65547b5798f896dcdbea5e60fbb9aea3c25a87cbb3e95e1cbde8dcf5e8fbb3b1ec16326e546ad7126eda2b94d36e37e07a8ae96cbeed79d2dcf5a3b09377abba4cfb485f7aa970db509a7e9b2fcc2a447a069f36d890d6d5bdd7ca2b9ad1e5f956b7239693d8d4deb5b9dd815a31cc5791d6b9b866db835a56f77b573596a59aeb78cac09e95a7677db88ae6bfb436f35620d5391408ec616f3306a39c165217ad63db6a8368cf4abb1de2bae475ab235286a5a7a4f1387ea4579578d3c2293a334432fd457b0bb6f6dd587ad5a89b208c82280d4f98ee8b59c8622986538cd34879e223d6bd1bc67e0f170a6444c30e457994864b39de29fa83c568b702f58ced6f956fbbde9d73a76e5696dfea6aaadc248bb7d6a4b795ad739ff00567ad6da8d4b525b4baf90a4a338addd3e587e5c47cd73378a518483eed59d3b5050a558023d0f4ad2274a96876ebe54f1c91bc7f2b0c1af29f891f0cd6ed5ae214c1ea0d7616fac491cca245454ec456ade4c9342a9bf3bf1c7e35d5139a67cebe1fd6a6d2ef1b4dd43efc6488ebab9261e5875e86aafc52f0c234ad756dfeb11b7562e8baefdbac555ff00d62fcb547239f2bb1de785eebfd2139c7cdd6bd03566f31633bf3c57947872e87da173d335e8faa5e2a69f1b0eb815c7523a97cc345d79754ee2fb7362b166d4f7498a9219bcdc564c946c4371bf02afdb7fac5acbb71b940ad4b78f6a83599a9a31e7b75ad34dfb573d2b22362a323ad685bcafb467a5069a9b1a73f9733356d5bcbf32be33cd73225fde2568473158890707d680773a456dea4eddbf37deab11965c1593e6ac0b6ba6da32f91573ed9b632683234dae268e6662f90074acdd427793613d29b35c06018f4ac9d42f1563623ad324a9a95e98f701d6b93d46fdfcc39e957b52bec8615cc5fde6ddc6b4d44f639ff14dff00ee4d78b78b350db2486bd23c5da86d818d784f8c358dccc9ea6bd1c3c0f0b1b5b963639bd52ebce99feb5497ef0a453f31ff006a9d5eda8f2a48f9272e663e85eb4f8feed3d33b855123d3eed397ad35ba54910ddc541aadc3a55db5b2dfb64f7abfa66826578e69d3cc507216b5bcb792eb90102310aa7a74acdec6a3ac74f48e418ff58c38ad6857cbc08ff1a6c168f1a626d9e7375c75ad2b5b1f2307d6b01c46c36ece416191e94569245f2d15251fb51f123c2f63e20f0bea3672c40c72dbba367e95f889ada9b1f146b1a7c5124691dc4912b0fee2bf15fb77f14b5a7d17c1fabde44a5e486d257451d73b4e3f5afc6ad5fe1b6a736a97b35c5bb93e6bb3e7a6e2777f5afabc2621e1e4a5d0f22ad3551348e2cc43cc197cb7a533c9dd2015a7a8696d67247130d8cbfc3558c71cbdf0e3a57e8d4abc31105389f392a72a72b1973c7e63e7fba6b464558ed959beef4fcf8aacf6abe72ef7cae72456678ab5a30ab244c54800061f5ac2ad4861e2ea48d231755a89d4d945009da2c6efde038dd8fe1f5acfb8564880cf9a70bbfe5d98e0e38fe2af368752bb594b0b89013e95d6687abff68daac0e55648ff0085bef3572e1f35a588f752b1d12c24a9be6b9afa2e4ea916d4c1c9e7f035e8f6176255443f7abceb41511eaf0b374c9fe46bba7b536f3acc3eee2bf36e25ff007b47dde43feeeca7e24b3fb4238ac7f0ede7d9ee36ff0074d74f7589a3f9ba115c66a16e6c3505947ddcd7cbc763e89ee7b2f876efcc816bb3b19bf735e4de15d532aa3e95e95a6cfbc03ed5c5563a9df4e5a1b6c9e6424d53824f2e6fc6aec126e4c553b8ff005d581a9d6e8d75f2ad7451dcee6415c169371b180aea2dee376c15406d196adc32feeeb2a293760549b8a73507444d4f369565f98738acb5b8c9c669eb3735251d0c171e5a6ef32ae477db8637e6b95f3b6f357adef0aae475a00ebe3b92caa075a1e17994e7a1ae7adb5075604f4ad7b7d43cc50b41064ebd61f237d2bc87c65e176914cc9f7979af74be87ed69bbd0572faa69a2484a91907b5590ee7cf76ec52462df7a3e3fa56847fbeae8fc47e196b792591530bd7f5ae7628d8139e8b56663f6adbf0e32a7a8aa77d07964322601ad98d77c78a46b5dca46335a1a731cdb5cbc6b8a6ff6c4b1f03ad69dee9eaca42a625ed5cedf5a4d1b1cf4ade322b9866b975fda09fbcf4af21d62f078675804ff00ab9db9af47bcdfb592bce3c65a4bdf32b1ce07a75ae886ba1e6e25d95d1dd784f5413488ebf75abb0f106b9f688e2b58fee28f9abe69d1b50bed1f52458ee1fcb0d8d86bd72c7568e485097cbb0e452ab4ecee7252aded3491d3dacdfbc5ae82c537a835cde8e166c30eb5d85841ba2c571cb73be05db58f6e0d68c6fe5fcd54517cb5c54f1d433a0d2864dd86ab91cdc565c7d055a8db6f3599a6a6a47d37d59126e422b32296a4f3680d4d48db6f38cfb5598e6dab9d98f7ac8497e5a1ae360dd403d8d76baf94f358fa85e6ddc698f7ff0029accd46f37c6a2839d999a8dc6e90b572da95e056627a62b5afe603713d2b83f156b51d8dbb484e3683cd6d0d7439273b2b9c4f8f35e4843fd0d7895d5d1bab8677eb93b6b5bc59e203ad5f3e1f2aadd2b097ad7d0e1e9fb38dcf8fc657f693b44753a35dd2014dddb79a9a2fdcfe35d879c3d9b6a95a7c748bd77d4b1c6669063ad41a8e8d433005770f4adbd17471248b24bc80788fd6a7d2f4269155cf4adb8ed4c50941d4f159bd8b12e24998a410f12f46ff00a643ff00afd3f1abba7d8881492b973d5aa7b1d2dad5467a3735a51dbed19ac0b21862e957618ba53e28f6f352af5a9284f2f6f3453e8a8d40fd8cf89d11d534c3661771978c7d083fd2bcb343f813657d2493cf6db8b76fad7ac6adfe997c47bd74fa3e9bf67b746f5afa18cf9558f3a50e6773e1cfda13f64cb4b885aff4f88acd1a92147bf1fd6be5a9be0fcd369ade75a3c33444c6d9e871cff4afd71f1669eb7e8d6eebb95c608af38ff854ba7c6d30107cb2fdeaeca55a74d5e12b184e9a7a33f26359f0c5d694ee91a6032e33f8d798f8b2c668664793b1afd57f8a3fb37e9f751493430e242322be27f8e9f0667d0b4eb99234c794377e4453af8bad595aa4b41469c23b23e60ab7612186e23603241aaf8db85ee46e356ad1774883de961fe24692f859e81a491fdab6e51301ba9fc2bd26d63325bb20eac715e6da136dd4ad57ebfc8d7a65a74fc2b8389bfde61e87d0f0ff00f025ea653c2d693184f41cd666ad6be729aea6fed4cb19c75c561f96264d87ef0af8dd8fa628785f50fb25c795ef5eada2de79ab19ff003d2bc7af2ddadee04a9f794e6bbcf08eac93246fdcf07f2a753de5734a3eebb1ea36726e502adcd0e543562e9f708630d5bb19491571d6b88ed2a4319ddc75cd6f69b7cf149b0f4ac5923db28356236f2f0d401d8dbcde62d4b591a6dcee502b5e296835d446e948adb4e68924dc715133155cd415cc4fe66ee2ac5bb6c60d59e921dc31d6a5123e79e95233556e773015a96326e6515cfc72f156f4f94f9c36f5a06f63b0b71918aaf7967bf26a28ae84aab9fbc2a659371c55996a735ab69fba371fe7ad79c6b9a49b7b82c3a9af58be50ec41e95cbeab6abf363ad06679bfd9dd240c7a5595fbb5a97506c666aa2ff7a810b1db09179e954ef2c139e33ed565ae3cb5c530b6f04d590ce7af74d8ed9598c7d4579cf8b2c4c9d130beb5ead7ca1e3607a5727aa69a8ecc6ba2333964afa1e1979a318ae0e3a935d8786f496922456e9572f34956bcc0eb9ae9f45d33f76ab5aba97d0ca9d3b3b9aba1696b0a2e3ad74d6ebb17159d669f6740b5684bcd627744b9534755639370c55a8eb377352d47f769e99dc2abaf5a923fbe2b302d2b6d6cd4892fcc2aac9f74d45e76df96811a4f36d526a07b9dca4554f3691a5e2993cc4cd36d526b3aeae864e7a53a6980c93d2b9bf116b7069f0c92cafe5c68325ab549bd11cd39a5ab2978935986cedda490e114124d7cd7e3ef1b49e22bc68e37cc08706adfc42f8892f892ea4b7b5931a7a9c15fef60ff008d706edbdb35ede170dc8b9a47cae3318ea5e9c3618cbb9b752afde14b8ddc52ac7b4e6bd23c51d4b1fde148a371c55bb7b73232a8ea4d2603a38fcec26339ed5d5e85a2cdb59ca00dfc24f4ab1e19f0efd9e4f3ee3af6fcaba95d90affb15cb291d118956dec44101794a285ebb7afd29f670ac9379c62f2625ff00569e9db34ad1c9aa4813fe58c4726b5638d55b68ea05646a44b6e64605faff000d5b8d762e29163dad9a917ef0a00106e602a5f2f6f342fde1527351a8115152f3451a81fb1d6762b25cb483a96aed2ca1f2e33f4ac2d16cf748ad5d432ec8715ef1c273b7d1896e829e8692fada3b78d642db40effa55b0375d62afc70ee18aa24e3357d1d7504f9937923e56af05f8c1f096dbc49a6dd44d16e6910a63eb5f4c5c5a659c5731e22d13ed16ac3b90714c4f63f077c79e1793c21e33d6347c6dfb24ec029fad67e9b672cd22cab1c92c4ac373ff000af35f557ede5f0adbc33e3eb7f12db438b3bd8c24effed839c7e278fc6bc1dacd341d1a0d208ff4fb9922bbbe5ff9f7c232a43f8ee0df857ad87a7cf389c927657343c36bbb5856d98da3fa1af44b4ff575c3783ed8c9a84ce3eea8aefed62e057cd71254e7c635d923ecf22a7cb86f526550cb86e86b075ab07b393ce4e9fe45742aa2360c7a525e431ceb8f515f26b73e9794e25d964525bef554d36edf47bb04ff00ab63cd5cd46dce9970c3f818f355e7852e1723ae2ba63b1cb25caee7aaf877515923523ab0aec74fb8dfb57d6bc33c25ae3e95702ce5e99e2bd7349bd5650c3ab0ae6944eda52e63a79fee8aaf53c67cc84535a3dab9ac4e8771f6b75e43afb57436375e728ae636eee2a5b1baf25b6d06675d82dc0eb50bc4fbb9e9552cefb7102b496e7726319f6a00afe595e475a55dd9e7a54ad2fcbf731ef514b27eecd41a8f171b4e2ad5bde156057ad6579d4be6d49674b6f782e0827ef0abf14db79ae56cef762915a70df6e8f1408d993f7aa6b0b537f2d5c55d5bc89572df7ab2afe4f389fee77ab219837d1f9d0d60dd2f96c4574d73b76941d4d635d45d683231ff00e5a0a7b74a95a3dad9aaf3506457b860aa49e95cfea522956c75ad4bce86b2e6b5f3bf1ab20e75b4ff003a42def5bd6b66521503ad5fb1d342b293d2b6a1b1458f347317ca624366cd807a55d8e0d8315a3f655edd68fb3f97f35059043185c13d2ae2ecdbc75a8aa54fbb57a80e55dcc05217d8f8a0b6de6ab492d6604af28ddcf4a634ab8e3ad43e66ee29acdb149a0cf9891a4f94d40f3621049031cf3d2ab5cdd7ca7e6da3d6bcff00c7ff00152c3c310bc51b19ef71f220ee7ffadd7f0ade14e5339aa578534ee747e2cf19d97872c5aeae2448931cc63ab76af9a3c7de3ebaf185e1c3f9762a7f771ff7ab2fc47e26d43c5379f69bfb869e404e14f441593b99791d6bdca18654d5e47cae2b1aeabe58ec31610c771e94ff002d5791d6a558de45c9e9566decd99805eb5da79ba9479a500b1c56ab68b2eddedf7694e9a1222c7a0a0394ce82dcc92aaaf535ddf87fc328b124927d6a0f0e69790b7120ce7a575caaf1aa844c0ae7948d23112399605745fbaa2982d5ef2419ff00567ad4fb45b48cc7ef9153da26d39f5ac8d47c28a91ed1d56a45ce69d8ddc54ab1ed5cd00317ef0a928a993a500201b948a163dad9a917ad3b1bb8a8d40663771453fcb2bc8eb451a81fb63a4dbf97f356d4a37478a8ec62f94559923da84d7b671192d17ef855a8e1cae2a051ba7c55d58be4ab033af6cde75468f1bd7a66b366b5721925d9d0938f6e6ba068fe5aa1a84266f997aad007ca7fb617c3c5d7bc1315dc5179d159dfdb5d4a9fec2cd1973f82827f0afcc8f1d591d2fe22788d22f9f75ec8cadea8c4328fc857ed6f8df424d7f46bdb29067ed113427fe0431fd6bf1fbe3a78667b7f8d7e21d28c7f3c73c2a7feb9a428057b980ad1837296c8e4ad49d46a0ba953c136661b1323261a573cd76b690eec0aada458adbdbc5146988c2e07d715b50d9eec0afce71f5de2b113a9dcfd270343d8d18c56f62b9b7da3355e48f6b66b58c1e58c554b88be535e59e89ce6a567f695753deb8f757d2ae181ff00579e6bd0ee23f94d73bac5879c4e7d2b684cc65030a58d6eb6b8ebd45755e12f133b39b5b838707087e95c3067d367607fd593cd5e602655953ef0e457435ce73c5f248f7bd2f540c402f918adb69964518eb5e39e13f1519152dee8e2553843fe7dabd1ecb50593a3e4e3a5724a3ca7a119731b27a540c70d9a23b8deb8a24fb86a4b65ab1bd11f07a56ddbde248bb47535ca6ef2fe6ab10de796437a569a999d9aca7c8381935048ceea414c0f5acfb1d4f728157566f3585201be5ede694e3bf4a9586e18a8de3daa4d6669cc4d0cab9083a9a9b25791d6b3c6ecf0714c86f2692e197cbf2a01f77dea41dcd2691f1cf4a8de4dca4554925a89a6daa4d064493305c93d2b36e24566c0eb51dd5c6e622ab3c9b948a0920b8fbc6abc9f70d4adf7852fd9f7734019af6fbdb3447a6f98e0d69adbed39a7ac7b5b3400db6b411af3d2a448d14311d696a097bd0012f7a89ba50dd29a5b68cd35b80374a6eedbcd4124b5119b68cd6da99f31334bf354124bcd579aebad529af3cbcb1dd81fddeb46a66e5a171a405b9381eb597aa7882db4b82496e26d9120cb35707e35f8b961e1ff00312ddd2eee40e117a03ef5e19e25f19ea5e2cba0d7770cd112711afdd15db470d2a9ab3c8c463a14748ee7a0f8ebe364b74d25ae8c4ac7d1a71dabc9a7ba96f26334b23c8ee724b74a3caa3cbc735ecd3a31a68f9cad889d677635402d86e9576cecc952c3eed5649096545ea4d759a658a416f24927f7735a98990da7f9511e71bb1cfe35ab6ecb6f00667f9475aafe609ae46d5dc02f4ad4b5d3fa4d7adb76f2ab50595ae9659e3dd2bf9717fcb28ffbd49a4e9bfda972865ff50a79fe9fae29de549ae5f3227fa85eb5d6e9d61f648d123fb9fc559b968593d9c49bc63fe598c2d5e5fbc29ab17cb53c71ed5cd625103af98db6ac2aecda2957ad3aa3501d1fde15360b714d8feed3d739a3501163e69eb1ed6cd2af5a72f5a35005eb4ea28a3501cbf78514980dc1e9451a81fb9d6b1edc1a2ebee354d6ff0074524dd0d7b5a9c465affae1f5abcc374605565ff587eb575bee8a3502b18f6f355efbfd59fa55f6e954af33e4bed1938a3503976b5f3a3604edddf2e7ebc57c17fb717c36b6d0fe26d8789ecedbcb4d6adf6cafeae9c57df96bb7cc7dc986dc39fc6bc5ff00698f8677bf143e1bdca69c9e6ea3a7c897b12fa80087ff00c77756756fece5e87561e7c95a2cfcf5b28f6a85ad9b4877605362b52b95923f2e453823dc1c1ad086df6c79af8e97bada3f43a6b6910c96bf21aa335af5add8d36ae6abdd5bef8d8d606fa9cb5d5bedc9ac8ba873915d4dc5afca6b1af2df682685b83d8e4352d2fce0d9ae69a47d2ee361ff00564f35dfdc4219483d2b02faca390b29e86bb21238e7132da459555d5b6b020835d6f87bc6924122dbdd8f657ae164864b0988ff009624f353065913206e3e95bb5ccac73aa9c8cf7ad3f54176bbd5f231d2b5e3b90d1e0d783e89e2cb9d148494f991faff0076bd1f42f15c37d00314be613d4ff76b9654f959d71a9cc762515c6475aad2c7b79a86df50f357efe6a6f3f7f19a9d4a1d1de7d9d73e95ad63ac06500f4ac09b3ce3ad519c4ad90bd7b5581e810ea4ad803ad4ff006cdff2d79ddb6b97362c037415a50f8b15b01bef504739d979db79a89ee37b6dae7935f491734bfdb494b945ce6f336d19aab34bd6b28eb4b8e3ad579355f37e5f5a8e52398d09a5eb54da5f9aab35d71d699f6aa8e51f31a91c9bb8a917ad674375d2a66b9dc31505f3971db6a935134d819aade6d4464dce055f295cc597b8dca466a2326e18a631dab9a6799bb8a08e610a7972799e9514973b8e2a576daa49e954e49901c838f7ad09d46b4bf35579260a724023deaa6a7ae5969d0c935c4fe5aa0e5bd2bc77c6df1c20b757b7d1ff0078dd3ccf4e6b6a74e537a1c35abc28eb267a57893c5fa7f87ede496ee64565190a3eb8af0af1afc5ed43c40cf6b647c8b53c13eb8e7fa5713aa6b97bac5d34f773f9c58f1ed55157cb207f7abd7a3848d3f799f3b88c7caafbb0d87331931231dee4f2d426770a957ee9a4aee3ccd4291977ae295ba530fbd005fd0ecd66ba667fbabd6b5efb54f3a3f26dff00d5818355f44d21ae63cb7faaef56a65b78e4f2c8c85ed59b34897346d3c5adbabb7de6e6964537f70b144db533f31fd69b6fe6de288e15da99c66baed2742874d8cc8b17ef0e32fe959b2c8b4fd345bc2a40f2d07dd1fdead3b78be614846e988ab3147b79ac8a17cbdbcd230dcb8a928c6ee28008a32bc8eb527cddfa53e28f6f352500431fdf153af5a4a913eed46a022f5a917ef0a17ef0a91739a35005ce69d452a8dc7140094539a3da3345581fba49f76a1b8fbad56a3fbb505c7dd35ebea711461fbc6ad0ff0057502ffae1577fe599a350205eb54aec6722b479aaf38dca456606247a7acf2e1c6573cd58d42dc2316440046b9f9ba7157a14d8ac6aaeae4f931c23ac9c500b467c05fb487c25d4fc37e2cd43c5315a23681a94e18490fdd8a4231cfd7a7e35e47e4ab0561d6bf51352d12d6e74f96c2e605bab595764b0bf46078af92fe327ecab7be1f925d57c1e92ea5a5f2cda6c2bba483d4a8fe7ed9af131b8597f1227d765d9945a54aae8fa1f38795504d1edc9ad1f2994b06c86dc55a365dac847622a168f6b66be7a5b9f551e592b98f35befc9acbbab5eb5d2c90ee3bab3aea1dd914c47257d6bf2b573fa95a9f29f69c1f5fc6bb4beb5f95ab0eead7ad6f139e6724d6a029dcf96f4ac8bcd2da162f074ef5d6dcdbed626a84f082a41e95d5191c3389cbf9c64f95ce08a4b6b9b9d3e4df04986ea2b4350d35244621b69f5fc6b2de392152b22e7d1ab68ec61a9da687f1102948ae06641c6faee6c7c4505e2236fcfb578635bef52d9c7bd3ec753bfd25ff72f95a4e0a4ae8bf6ce3b9f43c57714b1fcbd7b51e66ee2bc7f4bf884d0b2a5cb6df535d45978be2b950566dcbe958f2c8de35a333b29177fcb559adf6b66b3edb5c4600d5d8f52475cd05114909edd6a2691e3156dafa3618aad232bf23ad066352f1d5b34b1df3b641e955db1bf9e94bb9179a093461bae957edee7730158d1cabdbad4ab27cc2828dd13735662937715891de84183d2acadf26deb8f7a8e5035e85eb58cdad430825e550a3a96381f9d60ea5f13344d31889351891c7f0c6f93f853509dc87520b56767210a727a544f711c6a58e31efd2bc775dfda0b4fb55912c91ae3fda6e95e79ae7c6fd5f518ca40eb6d13775ea2baa1849cba1c73c75182dcfa1f58f18699a2b16bbb95040e14579578bbe3b40a1e3d31492380c2bc3f50d6aeb51999ee26794b1efd2a9f99bb8aeea78382d6478d5b339b4d5346d788fc5da97899f7dd4ee62cff00ab3d0d61af5a752a2798c16bbe318c57ba7912a92a9ac98b18dd20157557cb4dd4c8d7cb5c54ccbb8a8a08447b049c9e952a6ddbb075c51349e5a814db55dd96a0d352b46db4bad3c6e240519278a6c9f78fd6ac59a969900eb406a6dc2d3c767e5c498451f355fd2f41f386f93bf34b6b209cc51a74fe2fcababd3edf6db13ed5cf23488fd3ed228e64913ef6cc0ad1605971504517eed2aca4526dfde7e1591a8d8e3db2035617ad3a28f6e0d4bcd46a046bf7854ab9cd0b9cd3d7ad1a8094abd69d42f5a35005eb522fde142fde14fe68d4055ce69d4c39a917eed1a8094abd685eb4f5eb46a02514fa28d40fdcf68f68cd137f0d3973b78fb94927dc35ed6a711557fd68ab6bf74d451e778a9a877018dd2ab49576a1906ee2b334654e70703271d2aac90b4d7b14a530157fa568347f29fcea384e58bff7a8332a4915549adcdbfcd11c2f526b4ee3ee9aa8d8da73d280f53c53e377ecef61f12ad26d574944d3bc46a99138ff0057747fbadf8671ef8af8abc45a0dff0086b56bad3354b67b1beb77024b76e9bb1d457e9c790acfb9577ffb3ea3bfe95e6df19be0ae97f15f4b53218ac758807fa35fa8c9033f71ebcdc5e06355734773e872ecc9d17c957e13f3d641bb22a1922f90d751e38f05eb5e03d6a6d2f59b196d274638919311ccbd9d3eb5cdb7dd35f3538384b9647da4271ab1e783ba32aea1dd1915917b6bf30ae864ea6b36f06ec8a4632397bcb5eb58b796fb726ba8ba8f6e4d63de7dd35d113966737345d6a94d086c86e95af75d0d66dc7dd35d31d8e2918b7963242a4c7dea8b36d1b5fad6c5c5c08d483d2b36e592442475ade27248afb55b81d6990a329251b6b76355e6ba10e73d0540daec71a9cf4adb91f432e78a376df59bfb360565f3147f0d6bc1e389e14cc898f7af3eb8f11c3b4ed193e959d71e2298a9d8bb47ad74430d525d0c258b8c7ed1eba9f112dd1732b6d1dcd397e2569ccd837000f535e2135d5c5de77be54f5150f955db1cb54be239259aca2fdd3de3fe163e9439378a07b544df153488db1f6e3f875af0b31ed04d529bef544b2fa7012cd6a4ba1ee93fc64d2617f9649243eb59f3fc76b647c4568f21ec4f4af18a2b3585a7714b31ad73d52ebe3c6a3cfd9ecc47e8c7a560ea1f17bc4979b82dd8b753fc519c115c4d15b7b182d5239e78bad2fb469de788b53d4a4dd757934e0f50cf906a8c8ceed93d2a35eb4f5fbc2ace7e69497bcc4a31bb8a939a39a0cc67954795520058e29de5ede6802258773015721fdce0524552ee2bcd400eff006e9cadb5bccf4a8d54336e6e951c92997a7dd14cd19148dbd98d5ab7fbbf85562377156a38f6c64d519a2ab0dd211ef5aba7c1f67b776f5159b1db97932adb4e7ad75561a69585142ee91ba3543355b97bc3b63e7430aff789fe59aed963f26248bd4553d3f4f36b0c7bba915a51c5f2d71c8e98ec436d1ed93356aa1f2bf782acc71ed5cd67a886afde152ae7342e734f5eb46a305eb4ea17ad3a8d4b6357ad48bf7850bf78539b3b4d1a998bcd2ae734274a751a8052a8dc7142f5a7af5a350058f69cd3a8a55fbc28d4017ef0a29fcd146a07ee8c7f76926cf96d4fe69b26769af6b5388ad1e778ab606e522a05eb5613a50c06347b5734c3d2ac374a8db38eb8f7acc0a9703642c9fdec7f3a5f2f6c60d3d8f98fbf7e76d0d2f141a3b90b6715566b732723ad5d29e60cd5766dadb683328dc6e89864123dbad47e5f99ced653d416e99ed562ead9a58dc248626604071db3c5731a778c2de3d51f42d4cb41ab28f3555ba489d03d17b6a0647c4af873a5fc48d066d33558be750cd04e7fd64127f787b7afb66be10f1b7c26d67c0fe2e4d0b559ad2c5a453f66bb9a610dbdc0ea0973d09e9f522bf462eb56b5b6b8304a44930192a9d715c4fc48f04689f127c372697ac5bc92da9dc6deee13892dc9fe21f4efed9ae1c450a7595dee7b782c654c33b7d967c0779f0cfc516d25ca3e90e8902190ccae8d1c8a06731b8ff59fd05707717086250769ddce1bef035f4afc5cd16f7e0efc33bd82775b9b6510e9fa3deefcb799319bed521ff79015ff008157c817dab4711c29dac84283eaa062bc3a947d9bb1f4f4311eda376695ddea202075ae6eeafc6e7cf4aa1a96bbb830df9ae6af3582d2103ad38527d0caad5372eafd7271d6b0afb52d84b5655d6a6e722b22e6e1d989af6f0f96d6afb23c3c463a9d3dd9a375acf5ac7bad618e42fdea824477e4f4a67955ef52c91af899e155ccded144135d4b367774aaed0ee1baaff9548d17cb5ea52cb69c16c79b2c5ce7bb33fc90dc1e947d995791d6aef955198f6b835d0b0d1898fb52bac5f353c443bf4a999770c553b89bc85353351a7a8a2eed222d42458871d6b25dbcc6cd49713798d5157cfd6a9cd267a118f28abd69d4ca55eb5ca50ea55eb494a319e7a522c7afde152a02cc0511b220ce3356a3bb4519d98a9021f2a8f2aae477e9b850d3a3b6475a834d4a8b1ed39a76edbcd3cb6f7c546f1856c9e94c1dc5694ede3ad3e38de45c9e9512b22b6475a7336f5db54662493f98db7d29dff2ccd3a38f6ae6a361b9b14013429e6617daacaa958540eb4c8536a64d6858d8c97ecdfdc18cd43d8d6259d074569bf7adf773cd77ba5e931db2907bd57d134dfb3c519f4adb863da6435c7291b4620aa525603eed3dbee9fa52d18ddc567a9632d7f7b287feead5ba8eda3db9353d1a9a6a32957ef0a750bd68d4351d4e5fbc285fbc2a45ce68d44c4e695739a752af5a353312957ad3a957ad1a802f5a75148dd28d4072fde14fe6923fbb4e5ce68d462734549451a9a1fba54d93ee1a7799bb8df9f6a2bdad4f34817ad585fbb503f5a963acc0771dfa557999179ab2df74d5475f31b6d002dac091e58753561ba526dd9b452b74a0d3523605862abb45f3559e69b26769a03533e68f1ce71deb95f1c781ed7c6da725bcb2c967750b6fb5ba8fef46c7804576846e18aad2439cd2b5f41a3c4d6c7519ad7c98ee667d52d9d44b3b292d2ec619200f5008fc6b4747b9bdbebe9a3b46db0c2bb7ec73c8e8cae58162d9f6cd76fab6832c521bcb5192dd4562437d04c2e4487c995460bfa1ae26b959d3195d58c6f17f8474bf11dacba57882ce1d474dba5db242edb90e0e473eb9031ef8af893f688fd896ef40d1eefc45f0fa6b9d4a0858b4da1cc85e4893231e501d70483f406bedab8bc3703ecf3cc495fb8c3ad69e99709a82c904703aa451e198f7a9e58ccd215e74b48b3f143c63e11f147841a33af681a968d1cb8d92dddaba2c9919ea7a572335c2db82cf27ca7ad7ee16ade1db2d52d4dbdc5aa5c229c98e440eaddf907ad707a7fc0df0547afb5f47e16d122baf21a191e2b340c73cf35ece123470ef99abb39b1388ad5d59688fc649b56b45d84c25867ef0a9ff00b62c9940f31a3e3a374afd5df885fb1efc36f12d9cbbbc31a7d9dcb027cfb18115c1f5c8af89fe297ec4f3f84e79a7d26ea67b5c96588f4c57b91c7492f7523c5952d7de3e7f8563b8b52c92a38cfdd149f67dbcd3f53f8777da4dd61ddd240dc31e83156ad56e24575ba3bc631babbb0d9842abe5a8ac73ce8c96a8cd78be6a7491edc1ad1b9b72a548fbbb6ab3c5f29af66504e3cd1394ce6fbd50bfdeab9247b4e6a36e95c32896546fba6b26f06e908ad7986ec8aa37117ca6bccc4c3991d70918ef1ed6cd36acdc47b549aad5f33523cb23be2145145645851452af5a402c7f7854e8c5581a8685eb525a2d79db79c67da86b82c301307d69131b79e94f408cc00eb41a6a45e6bd1b19f93d2adac7b5b34b20dca45406a5458f6b669dbb6f3527954ab1f34011799bb8a519edd6a6119edd6ac5969ed70d863b54f5340728b6b1bdd633d338aefb49d2e3b58624fe37191fceaae8fa208e10c576c03eeaff007aba1b1b511b2cac9866e14d73ca46f18966d01e31d56ada8766c1e94f863f2307d69164f3a691bfbb59142f97b79a58fef8a21fbc6a6a8d4055eb4ea6afde152f3dbad1a80c5eb522fde14abbb3cd3b9a35015739a7535739a7af5a35005eb4ea2957ad1a802f5a751451a80514abf78548b9cd1a8c54e94e5eb42f5a75069a8514515607ee8afdda46e9450dd2bd7679a30e6a45fbb4c5ce69f5980d6fba6a383ef1a5baed5243f76801cdd29b4fa2834d46374a67352b74a6b74a0351982dc543247b4e6a6e695739a03533a4ebc8cd676a9a0db6b11b060f1b63ef47f7856f48377155258f6f348ccf3a3f0a6cfed45db51bb5527256ba9b0d161d3e10916442a3e52fd4d6cae3b9c0f5ae57c41e255d1cb80c589e303ad2518dcbe69197a844be749b7ae78ac4b68d94ca5beeefad386e1ae61f3151c3487bd5c5b129098c7ddead5b1060de4a9b7663391d2b89d7fc3f0df42c5e3ca9ea2bd0750b05de36fdeed5877f6322c6f8eb8ade3a19c8f8d3e367c1db5b8f3678e1c3f507f1af96f5bf0a7d86668f66369afd28f187836e35ab778d5cc65c7de1dbbd7c8ff197e01eb16e66bdb6b97675e403f5abb731929f2e87ce371a130462832d8e958579a798e4f9930db7ad6bea1fdaf672496f7127319c1ae7eeb52b9498095f31e7915ede071ce93f6757639f13878d55cd1dca9716fb5b354a68bad744196ea2f307576acebcb7da09afa471535cc9dd1e42724f96463b47c557922e6b49a2e2ab491579f5691d119997343bb22a8cd665b2075ade68772e2a336bc75af2eae1398eb85639a681d1c03d29cb0ee38adb96cf7645410dbe095af0ebe1654ddd1db0a9cc670b6e7a5598ed030c1e94b2c7b650b5d0f86ecd2e2468a41946e0d709d063269eacb81d69dfd975b9e22d0ae3c3378a163cdb4c3295941849c96dadfddac8d625336386db4e580a1c0eb5a70d889304f4ad55b543184c66b3e62b94e69626ddcf4a9161dc715af23a3ca23b65db274cd598f420bfbc964f9cd1cc1ca60fd977718a72e9fb980ae852ce546c3c595ecd56ac6c4cadb163e4d4731a7299163a3999950056279c374e95d1e93a1229123b3394eebf756afdbe9ed1ae123ccbdaaf456af1dbaa4adb777f0d67cc50d552d2201f745584203053d2962529803eed4a177fcb5203a5957845fbd4f8c3b0c1e952436fe5e1aa7a8d406a45f2d3d62f9a917ad3a8d405f2f6f34abf7850bf7853f9a3518734ab9cd260b714a91ed6068d4d351ebd69d452af5a350d417ad3a957ef0a7f346a26317ef0a7f34734ab9cd1a9982e734fa285eb46a00bd69ebd685eb4add28006e945368ab03f74923dab9a5a28af4ce2233feb29cbd69586e5c52edd91934015a4ff00582a74fbb51c2b962d53500148dd29691ba5003776de6a2697e6a7c9c213c8fa551b8b90ca493271e8714012b4bf3d3965f9ab1a6bc2ac7e5cafab31269b6b74cef8ed41a6a6f2c9b9b14e605862abc126e5c54d1fdf1403b95ae233b5b1d715e65a958b5d6ad2b9e8a6bd66e3fd4bfd2b8cb48435ccc7de833333ec7b0c2319a9638fcc6cecc6d63cfe15a925b037080f4ffeb53dec52152477ad44605cc5c9aa1716fe6291eb5d05c5b8da79acf9edc60d51273d7162369cf4ae17c79a2c771a6ca186415af45bc731ab015e77e34669ad244cfde15b437337b1f9d9f1f2c134fd5e74b64c65b9fcebc0ae60669998fdeafbafe207c32b6d72e259247504e7d6bc07c65f0a20b06678e55f97eb57288a323c1de5934d6df5a1a7dc0d523253a0fbd4cf15598b0260e0e4f51591a62947054e0e6bd0c1e3e787767ac4e7ab4154d51b2f6fb959bfbb54a68bad6d5b319b7464e091d4555b880461831dcdd9abeba94e35e3cd13c99c1d3766652c5f35472c55a1b71cd35c6e522a65485cc66345f2d549e2fdf256c3c7f29a861b7125d46b9eac2bccc552fdd33aa9cb5463cf1ffa50aeb7c196066bc5006496c62b3f52b111de16cf46af42f863a3adc6a0096eff00d2be2dc773dbfb276baa78162f10786d6295312dbf2a7eb5e49ac7c35bdb29098137804fcb5f61e9be1e8c697c907e5ae3f55f0fc4d36060726a792fa19aa96773e4eb7d1efec9d958ac4dfed8c8fcaae2e9335cae249b767a88d302be82d67c0965ad5b885c0491ba49e8473fd2bc9f54d2a4d16fe7b3322bf967ef8eadf5ae3ab4dc4eb854e630a1d352de3db16fcf7cf4ab30db3af356941dc326a4ae53a0a3e4b99056b69b6322a97150c76c2691726b6638fca8d545002a6db35cb7534d8d4bee0fd5ba548bc9a7aa0dd51a8c48edfcb60d52e37714d68d5948a72aec4c51a9a6a2a47b581a92913eed2d1a8985397ef0a6b74a7c7f768d4cc7ae734ea6ae734f5eb46a00bd69ebd692957ad1a8c751452afde146a69a82fde14fe68e695739a3513b82e734fa285eb46a660bd69d452af5a35005eb4ea2957ef0a350131bb8a2a5e68a3503ffd9, '2000-01-20', '04125972365', 'Masculino', 'NOMBRE DE MI MADRE', 'Maria', 'NOMBRE DE MI HERMANO MAYOR', 'Jose', 'activo');
INSERT INTO `usuario` (`id_usuario`, `usuario`, `tipo_doc`, `num_doc`, `correo`, `contraseña`, `nombre1`, `nombre2`, `apellido1`, `apellido2`, `foto`, `fecha_nac`, `telefono`, `sexo`, `pregunta_s1`, `respuesta_1`, `pregunta_s2`, `respuesta_2`, `status`) VALUES
(26, 'test1', 'P', '22198821', 'dunsuarez.ma@gmail.com', '202cb962ac59075b964b07152d234b70', 'test1', 'test1', 'test1', 'test1', NULL, '1995-02-02', '04125972365', 'Masculino', 'NOMBRE DE MI PRIMER COLEGIO', 's', 'NOMBRE DE MEJOR AMIGO DE LA INFANCIA', 'd', 'activo'),
(27, 'test2', 'P', '22198821', 'test2@hotmail.com', '202cb962ac59075b964b07152d234b70', 'Maria', 'Juana', 'Perez', '', NULL, '1995-12-02', '02514456248', 'Masculino', 'NOMBRE DE MI MASCOTA', 'Terry', 'PELICULA FAVORITA', 'Titanic', 'activo'),
(28, 'tes3', 'V', '22198821', 'test3@hotmail.com', '202cb962ac59075b964b07152d234b70', 'Maria', '', 'Rodriguez', '', NULL, '1995-01-06', '02517178172', 'Femenino', 'NOMBRE DE MI MASCOTA', 'Negro', 'NOMBRE DE MI HERMANO MAYOR', 'Jose', 'activo'),
(34, 'marce12322', 'V', '24325485', 'anais_asdm@hotmail.com', '202cb962ac59075b964b07152d234b70', 'Marcelis', 'Anais', 'Dun', 'Suarez', NULL, '1995-07-05', '04120515005', 'Femenino', 'NOMBRE DE MI MADRE', 'Nilda', 'NOMBRE DE MEJOR AMIGO DE LA INFANCIA', 'Roger', 'activo'),
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
  ADD PRIMARY KEY (`id_psicologo`);

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
  MODIFY `id_administrativo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `agenda`
--
ALTER TABLE `agenda`
  MODIFY `id_agenda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT de la tabla `direccion`
--
ALTER TABLE `direccion`
  MODIFY `id_direccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `paciente`
--
ALTER TABLE `paciente`
  MODIFY `id_paciente` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `paciente_relacion`
--
ALTER TABLE `paciente_relacion`
  MODIFY `id_paciente_relacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `pago_cita`
--
ALTER TABLE `pago_cita`
  MODIFY `id_pago_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT de la tabla `psicologo`
--
ALTER TABLE `psicologo`
  MODIFY `id_psicologo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tipo_cita`
--
ALTER TABLE `tipo_cita`
  MODIFY `id_tipo_cita` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=147;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
