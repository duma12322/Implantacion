<?php

include_once('../../config/conexion.php');

// Verificar si el usuario está logueado
if (!isset($_SESSION['id_usuario'])) {
    header("Location: login_paciente.php");
    exit;
}

// Función para verificar la disponibilidad de horarios
function isTimeSlotAvailable($conn, $fecha, $hora_inicio, $hora_final)
{
    $query = "SELECT COUNT(*) as count 
              FROM agenda 
              WHERE fecha = :fecha 
              AND hora_inicio < :hora_final 
              AND hora_final > :hora_inicio 
              AND (status = 'Pendiente' OR status = 'Confirmada')";

    $stmt = $conn->prepare($query);
    $stmt->bindValue(':fecha', $fecha);
    $stmt->bindValue(':hora_inicio', $hora_inicio);
    $stmt->bindValue(':hora_final', $hora_final);
    $stmt->execute();

    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    return $result['count'] == 0;
}

// Procesar filtros si se envían
$where_clauses = [];
$params = [];

// Filtro por estado
if (!empty($_GET['status'])) {
    $where_clauses[] = "a.status = :status";
    $params[':status'] = $_GET['status'];
}

// Filtro por rango de fechas
if (!empty($_GET['fecha_inicio']) && !empty($_GET['fecha_fin'])) {
    $where_clauses[] = "a.fecha BETWEEN :fecha_inicio AND :fecha_fin";
    $params[':fecha_inicio'] = $_GET['fecha_inicio'];
    $params[':fecha_fin'] = $_GET['fecha_fin'];
}

// Filtro por búsqueda general
if (!empty($_GET['search'])) {
    $search = "%" . $_GET['search'] . "%";
    $where_clauses[] = "(u.nombre1 LIKE :search OR u.apellido1 LIKE :search OR u.num_doc LIKE :search OR adm.Nombre1 LIKE :search OR adm.Apellido1 LIKE :search OR adm.num_doc LIKE :search)";
    $params[':search'] = $search;
}

// Construir consulta
$query = " 
    SELECT a.id_agenda, a.fecha, a.hora_inicio, a.hora_final, a.status, 
           c.id_cita, c.motivo, c.fecha AS fecha_cita, 
           u.nombre1 AS nombre_paciente, u.apellido1 AS apellido_paciente, 
           adm.nombre1 AS nombre_psicologo, adm.apellido1 AS apellido_psicologo, 
           pc.tipo_pago, pc.monto, pc.referencia_bancaria, 
           t.tipo_cita, t.modalidad 
    FROM agenda a 
    JOIN cita c ON a.id_agenda = c.id_agenda 
    JOIN paciente p ON a.id_paciente = p.id_paciente 
    JOIN usuario u ON p.id_usuario = u.id_usuario 
    JOIN psicologo ps ON c.id_psicologo = ps.id_psicologo 
    JOIN administrativo adm ON ps.id_administrativo = adm.id_administrativo 
    LEFT JOIN pago_cita pc ON c.id_cita = pc.id_cita
    LEFT JOIN tipo_cita t ON c.id_tipo_cita = t.id_tipo_cita
    " . (count($where_clauses) > 0 ? " WHERE " . implode(" AND ", $where_clauses) : "");

$stmt = $conn->prepare($query);
foreach ($params as $param => $value) {
    $stmt->bindValue($param, $value);
}
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);