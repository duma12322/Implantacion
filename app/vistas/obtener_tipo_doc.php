<?php
require_once '../../config/conexion.php'; // Conexión a la base de datos
$tipo_doc = ['V', 'E', 'J', 'P'];
echo json_encode($tipo_doc);
