<?php
require_once '../../config/conexion.php';
$estadoId = $_GET['estado']; // Obtén el ID del estado
$municipios = $conn->prepare("SELECT id_municipio, municipio FROM municipios WHERE id_estado = ? ORDER BY municipio");
$municipios->execute([$estadoId]);
echo json_encode($municipios->fetchAll(PDO::FETCH_ASSOC));
