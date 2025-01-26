<?php
session_start();
include_once('../../config/conexion.php');

// Verifica si el usuario está autenticado
if (!isset($_SESSION['usuario'])) {
    header("Location: login_paciente.php");
    exit;
}

// Recibe los datos del formulario
$id_cita = $_POST['id_cita'];
$id_psicologo = $_POST['id_psicologo'];
$id_paciente = $_POST['id_paciente'];
$fecha = $_POST['fecha'];
$hora = $_POST['hora'];
$minutos = $_POST['minutos'];
$am_pm = $_POST['am_pm'];
$motivo = $_POST['motivo'];

// Convierte la hora y minutos a formato de 24 horas
$hora24 = ($am_pm == 'PM' && $hora != 12) ? $hora + 12 : (($am_pm == 'AM' && $hora == 12) ? 0 : $hora);
$hora_inicio = sprintf("%02d:%02d:00", $hora24, $minutos);

// Calcular hora final sumando 45 minutos
$minutos_totales = ($hora24 * 60) + $minutos + 45;
$hora_final24 = intdiv($minutos_totales, 60);
$minutos_finales = $minutos_totales % 60;
$hora_final = sprintf("%02d:%02d:00", $hora_final24, $minutos_finales);

// Actualiza la tabla `cita`
$query_cita = "UPDATE cita SET id_psicologo = :id_psicologo, id_paciente = :id_paciente, motivo = :motivo WHERE id_cita = :id_cita";
$stmt_cita = $conn->prepare($query_cita);
$stmt_cita->execute([
    ':id_psicologo' => $id_psicologo,
    ':id_paciente' => $id_paciente,
    ':motivo' => $motivo,
    ':id_cita' => $id_cita
]);

if ($stmt_cita->execute()) {
    // Actualiza la hora y fecha en la tabla `agenda`
    $query_agenda = "UPDATE agenda SET fecha = :fecha, hora_inicio = :hora_inicio, hora_final = :hora_final WHERE id_agenda = (SELECT id_agenda FROM cita WHERE id_cita = :id_cita)";
    $stmt_agenda = $conn->prepare($query_agenda);
    $stmt_agenda->execute([
        ':fecha' => $fecha,
        ':hora_inicio' => $hora_inicio,
        ':hora_final' => $hora_final,
        ':id_cita' => $id_cita
    ]);

    // Redirige a la página de confirmación o listado
    echo "
        <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.17/dist/sweetalert2.all.min.js'></script>
        <script>
          window.onload = function() {
            Swal.fire({
                icon: 'success',
                title: 'Cita reprogramada exitosamente',
                showConfirmButton: true,
                confirmButtonText: 'OK',
                timer: 3000,
                willClose: () => { window.location.href = '../vistas/agendar_cita.php'; }
            });
          }
        </script>";
} else {
    // Mensaje de error
    echo "
        <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.17/dist/sweetalert2.all.min.js'></script>
        <script>
          window.onload = function() {
            Swal.fire({
                icon: 'error',
                title: 'Error al reprogramar la cita: " . $stmt_cita->errorInfo()[2] . "',
                showConfirmButton: true,
                confirmButtonText: 'OK',
                timer: 3000,
                willClose: () => { window.location.href = '../vistas/agendar_cita_individual_presencial.php'; }
            });
          }
        </script>";
}
