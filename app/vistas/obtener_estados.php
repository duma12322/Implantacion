<?php
require_once '../../config/conexion.php'; // Conexion a la base de datos
$estados = $conn->query("SELECT DISTINCT id_estado, estado FROM estados ORDER BY estado")->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($estados);
