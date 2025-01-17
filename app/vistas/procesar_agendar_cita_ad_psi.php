<?php
session_start();
include_once('../../config/conexion.php');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_psicologo = $_POST['id_psicologo'];
    $id_paciente = $_POST['id_paciente']; // Se obtiene del formulario
    $fecha = $_POST['fecha'];
    $hora = $_POST['hora'];
    $minutos = $_POST['minutos'];
    $ampm = $_POST['am_pm'];
    $motivo = $_POST['motivo'];
    $tipo_pago = $_POST['tipo_pago'];
    $referencia_bancaria = $_POST['referencia_bancaria'];
    $monto = 30;

    // Convertir hora AM/PM a formato 24 horas
    $hora24 = ($ampm == 'PM' && $hora != 12) ? $hora + 12 : (($ampm == 'AM' && $hora == 12) ? 0 : $hora);
    $hora_inicio = sprintf("%02d:%02d:00", $hora24, $minutos);

    // Calcular hora final sumando 45 minutos
    $minutos_totales = ($hora24 * 60) + $minutos + 45;
    $hora_final24 = intdiv($minutos_totales, 60);
    $minutos_finales = $minutos_totales % 60;
    $hora_final = sprintf("%02d:%02d:00", $hora_final24, $minutos_finales);

    // Verificar si hay una cita agendada en el horario seleccionado
    $query_agenda = "
        SELECT id_agenda, contador_cita 
        FROM agenda 
        WHERE fecha = :fecha 
        AND (hora_inicio < :hora_final AND hora_final > :hora_inicio) 
        AND (status = 'Pendiente' OR status = 'Confirmada')
    ";
    $stmt_agenda = $conn->prepare($query_agenda);
    $stmt_agenda->bindParam(':fecha', $fecha);
    $stmt_agenda->bindParam(':hora_inicio', $hora_inicio);
    $stmt_agenda->bindParam(':hora_final', $hora_final);
    $stmt_agenda->execute();

    if ($stmt_agenda->rowCount() > 0) {
        echo "Ya existe una cita en ese horario.";
        exit;
    }

    // Insertar nueva cita
    $query_agendar = "
        INSERT INTO agenda (id_paciente, id_psicologo, fecha, hora_inicio, hora_final, motivo, tipo_pago, referencia_bancaria, monto, status)
        VALUES (:id_paciente, :id_psicologo, :fecha, :hora_inicio, :hora_final, :motivo, :tipo_pago, :referencia_bancaria, :monto, 'Pendiente')
    ";
    $stmt_agendar = $conn->prepare($query_agendar);
    $stmt_agendar->bindParam(':id_paciente', $id_paciente);
    $stmt_agendar->bindParam(':id_psicologo', $id_psicologo);
    $stmt_agendar->bindParam(':fecha', $fecha);
    $stmt_agendar->bindParam(':hora_inicio', $hora_inicio);
    $stmt_agendar->bindParam(':hora_final', $hora_final);
    $stmt_agendar->bindParam(':motivo', $motivo);
    $stmt_agendar->bindParam(':tipo_pago', $tipo_pago);
    $stmt_agendar->bindParam(':referencia_bancaria', $referencia_bancaria);
    $stmt_agendar->bindParam(':monto', $monto);

    if ($stmt_agendar->execute()) {
        echo "Cita agendada con éxito.";
    } else {
        echo "Error al agendar la cita.";
    }
}
