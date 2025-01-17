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

// Verificar el número de citas pendientes del paciente para el día
$query_verificar_citas = "SELECT MAX(contador_cita) as max_citas FROM agenda WHERE fecha = :fecha AND id_paciente = :id_paciente AND status = 'Pendiente'";
$stmt_verificar_citas = $conn->prepare($query_verificar_citas);
$stmt_verificar_citas->bindParam(':fecha', $fecha);
$stmt_verificar_citas->bindParam(':id_paciente', $id_paciente);
$stmt_verificar_citas->execute();
$max_citas = $stmt_verificar_citas->fetch(PDO::FETCH_ASSOC)['max_citas'];

if ($max_citas >= 3) {
    echo "Has alcanzado el máximo de citas permitidas para el día.";
    exit;
}

// Verificar si hay una agenda disponible para la hora y fecha dadas
$query_agenda = "SELECT id_agenda, contador_cita FROM agenda WHERE fecha = :fecha AND hora_inicio = :hora_inicio AND id_paciente = :id_paciente AND status = 'Pendiente'";
$stmt_agenda = $conn->prepare($query_agenda);
$stmt_agenda->bindParam(':fecha', $fecha);
$stmt_agenda->bindParam(':hora_inicio', $hora_inicio);
$stmt_agenda->bindParam(':id_paciente', $id_paciente);
$stmt_agenda->execute();
$agenda = $stmt_agenda->fetch(PDO::FETCH_ASSOC);

if ($agenda) {
    // Incrementar el contador de citas si ya existe una agenda
    if ($agenda['contador_cita'] < 3) {
        $query_update_contador = "UPDATE agenda SET contador_cita = contador_cita + 1 WHERE id_agenda = :id_agenda";
        $stmt_update_contador = $conn->prepare($query_update_contador);
        $stmt_update_contador->bindParam(':id_agenda', $agenda['id_agenda']);
        $stmt_update_contador->execute();
        $id_agenda = $agenda['id_agenda'];
    } else {
        echo "El paciente ya tiene 3 citas pendientes para el día.";
        exit;
    }
} else {
    // Insertar nueva agenda
    $contador_cita = is_null($max_citas) ? 1 : $max_citas + 1;
    $query_new_agenda = "INSERT INTO agenda (fecha, hora_inicio, hora_final, contador_cita, status, id_paciente) VALUES (:fecha, :hora_inicio, :hora_final, :contador_cita, 'Pendiente', :id_paciente)";
    $stmt_new_agenda = $conn->prepare($query_new_agenda);
    $stmt_new_agenda->bindParam(':fecha', $fecha);
    $stmt_new_agenda->bindParam(':hora_inicio', $hora_inicio);
    $stmt_new_agenda->bindParam(':hora_final', $hora_final);
    $stmt_new_agenda->bindParam(':contador_cita', $contador_cita);
    $stmt_new_agenda->bindParam(':id_paciente', $id_paciente);
    $stmt_new_agenda->execute();
    $id_agenda = $conn->lastInsertId();
}

// Insertar nueva cita
$query_cita = "INSERT INTO cita (id_agenda, id_psicologo, id_paciente, fecha, motivo, id_tipo_cita) VALUES (:id_agenda, :id_psicologo, :id_paciente, :fecha, :motivo, 1)";
$stmt_cita = $conn->prepare($query_cita);
$stmt_cita->bindParam(':id_agenda', $id_agenda);
$stmt_cita->bindParam(':id_psicologo', $id_psicologo);
$stmt_cita->bindParam(':id_paciente', $id_paciente);
$stmt_cita->bindParam(':fecha', $fecha);
$stmt_cita->bindParam(':motivo', $motivo);

if ($stmt_cita->execute()) {
    $id_cita = $conn->lastInsertId();

    // Registrar pago
    $query_pago = "INSERT INTO pago_cita (id_cita, tipo_pago, monto, fecha_pago, referencia_bancaria) VALUES (:id_cita, :tipo_pago, :monto, CURDATE(), :referencia_bancaria)";
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
