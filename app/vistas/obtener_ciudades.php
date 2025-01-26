<?php
require_once '../../config/conexion.php';
$estadoId = $_GET['estado']; // Obtén el ID del estado
$ciudades = $conn->prepare("SELECT DISTINCT  id_ciudad, ciudad FROM ciudades WHERE id_estado = ? ORDER BY ciudad");
$ciudades->execute([$estadoId]);
echo json_encode($ciudades->fetchAll(PDO::FETCH_ASSOC));
