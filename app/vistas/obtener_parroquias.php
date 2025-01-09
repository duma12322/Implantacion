<?php
require_once '../../config/conexion.php';
$municipioId = $_GET['municipio']; // Obtén el ID del municipio
$parroquias = $conn->prepare("SELECT id_parroquia, parroquia FROM parroquias WHERE id_municipio = ? ORDER BY parroquia");
$parroquias->execute([$municipioId]);
echo json_encode($parroquias->fetchAll(PDO::FETCH_ASSOC));
