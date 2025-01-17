<?php
include_once('../../config/conexion.php');

// Recibir los datos del formulario
$id_psicologo = $_POST['id_psicologo'];
$id_paciente = $_POST['id_paciente'];
$fecha = $_POST['fecha'];
$hora = $_POST['hora'];
$minutos = $_POST['minutos'];
$ampm = $_POST['am_pm'];
$motivo = $_POST['motivo'];
$tipo_pago = $_POST['tipo_pago'];
$referencia_bancaria = $_POST['referencia_bancaria'];

// Definir el monto para citas individuales presenciales
$monto = 30;

// Convertir la hora a formato 24 horas
$hora24 = ($ampm == 'PM' && $hora != 12) ? $hora + 12 : (($ampm == 'AM' && $hora == 12) ? 0 : $hora);
$hora_inicio = sprintf("%02d:%02d:00", $hora24, $minutos);
$hora_final = sprintf("%02d:%02d:00", ($hora24 + 1) % 24, $minutos); // Ejemplo: Duración de 1 hora

// Verificar si hay una agenda disponible para la hora y fecha dadas
$query_agenda = "SELECT id_agenda FROM agenda WHERE hora_inicio = :hora_inicio AND fecha = :fecha AND status = 'Pendiente'";
$stmt_agenda = $conn->prepare($query_agenda);
$stmt_agenda->bindParam(':hora_inicio', $hora_inicio);
$stmt_agenda->bindParam(':fecha', $fecha);
$stmt_agenda->execute();
$agenda = $stmt_agenda->fetch(PDO::FETCH_ASSOC);

if ($agenda) {
    echo "Ya existe una cita programada para esta fecha y hora.";
    exit;
}

$query_new_agenda = "INSERT INTO agenda (fecha, hora_inicio, hora_final, status) VALUES (:fecha, :hora_inicio, :hora_final, 'Pendiente')";
$stmt_new_agenda = $conn->prepare($query_new_agenda);
$stmt_new_agenda->bindParam(':fecha', $fecha);
$stmt_new_agenda->bindParam(':hora_inicio', $hora_inicio);
$stmt_new_agenda->bindParam(':hora_final', $hora_final);
if (!$stmt_new_agenda->execute()) {
    echo "Error al insertar nueva agenda: " . $stmt_new_agenda->errorInfo()[2];
    exit;
}
$id_agenda = $conn->lastInsertId();

$query_cita = "INSERT INTO cita (id_agenda, id_psicologo, id_paciente, fecha, motivo, id_tipo_cita) 
               VALUES (:id_agenda, :id_psicologo, :id_paciente, :fecha, :motivo, 1)";
$stmt_cita = $conn->prepare($query_cita);
$stmt_cita->bindParam(':id_agenda', $id_agenda);
$stmt_cita->bindParam(':id_psicologo', $id_psicologo);
$stmt_cita->bindParam(':id_paciente', $id_paciente);
$stmt_cita->bindParam(':fecha', $fecha);
$stmt_cita->bindParam(':motivo', $motivo);

if ($stmt_cita->execute()) {
    $id_cita = $conn->lastInsertId();

    $query_pago = "INSERT INTO pago_cita (id_cita, tipo_pago, monto, fecha_pago, referencia_bancaria)
                   VALUES (:id_cita, :tipo_pago, :monto, CURDATE(), :referencia_bancaria)";
    $stmt_pago = $conn->prepare($query_pago);
    $stmt_pago->bindParam(':id_cita', $id_cita);
    $stmt_pago->bindParam(':tipo_pago', $tipo_pago);
    $stmt_pago->bindParam(':monto', $monto);
    $stmt_pago->bindParam(':referencia_bancaria', $referencia_bancaria);
    $stmt_pago->execute();

    echo "Cita agendada correctamente.";
} else {
    echo "Error al agendar la cita: " . $stmt_cita->errorInfo()[2];
}
