<?php
session_start();

include_once('../../config/conexion.php');
require_once('../../vendor/autoload.php');

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// Verifica si la sesión está activa
if (!isset($_SESSION['id_usuario'])) {
    header("Location: login_paciente.php");
    exit;
}

$id_usuario = (int)$_SESSION['id_usuario'];

// Crear el cliente de Google
$client = new Google_Client();
$client->setApplicationName('Implantacion');
$client->setScopes(Google_Service_Calendar::CALENDAR);
$client->setAuthConfig('../../credentials.json');
$client->setAccessType('offline');

// Verificar si ya tenemos un token de acceso guardado
$tokenPath = '../../token.json';
if (file_exists($tokenPath)) {
    $accessToken = json_decode(file_get_contents($tokenPath), true);
    $client->setAccessToken($accessToken);
}

// Si el token ha caducado o no existe, redirigir a la autorización
if ($client->isAccessTokenExpired() || !$client->getAccessToken()) {
    $authUrl = $client->createAuthUrl();
    header('Location: ' . filter_var($authUrl, FILTER_SANITIZE_URL));
    exit;
}

// Crear servicio de Google Calendar
$service = new Google_Service_Calendar($client);

// Obtener datos del formulario
$id_psicologo = $_POST['id_psicologo'];
$id_paciente = $_POST['id_paciente'];
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

// Verificar si el paciente tiene el máximo de citas permitidas para el día
$query_verificar_citas = "
        SELECT MAX(contador_cita) AS max_citas 
        FROM agenda 
        WHERE fecha = :fecha 
        AND id_paciente = :id_paciente 
        AND status = 'Pendiente'
    ";
$stmt_verificar_citas = $conn->prepare($query_verificar_citas);
$stmt_verificar_citas->bindParam(':fecha', $fecha);
$stmt_verificar_citas->bindParam(':id_paciente', $id_paciente);
$stmt_verificar_citas->execute();
$max_citas = $stmt_verificar_citas->fetch(PDO::FETCH_ASSOC)['max_citas'];

if ($max_citas >= 3) {
    // Mensaje con SweetAlert si el paciente ha alcanzado el máximo de citas
    echo "
        <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.17/dist/sweetalert2.all.min.js'></script>
        <script>
          window.onload = function() {
            Swal.fire({
                icon: 'warning',
                title: 'Has alcanzado el máximo de citas permitidas para el día.',
                 showConfirmButton: true,
        confirmButtonText: 'OK',
                timer: 3000,
                willClose: () => { window.location.href = '../vistas/agendar_cita.php'; }
            });
          }
        </script>";
    exit;
}

// Verificar si ya hay una cita en el horario
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
$agenda = $stmt_agenda->fetch(PDO::FETCH_ASSOC);

if ($agenda) {
    // Mensaje con SweetAlert si ya hay una cita agendada en ese horario
    echo "
        <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.17/dist/sweetalert2.all.min.js'></script>
        <script>
          window.onload = function() {
            Swal.fire({
                icon: 'warning',
                title: 'Ya hay una cita agendada en este horario.',
                 showConfirmButton: true,
        confirmButtonText: 'OK',
                timer: 10000,
                willClose: () => { window.location.href = '../vistas/agendar_cita_individual_online.php'; }
            });
          }
        </script>";
    exit;
} else {
    $contador_cita = is_null($max_citas) ? 1 : $max_citas + 1;
}

// Crear evento en Google Calendar
$event = new Google_Service_Calendar_Event([
    'summary' => 'Cita con Psicólogo',
    'location' => 'Online',
    'description' => $motivo,
    'start' => [
        'dateTime' => $fecha . 'T' . $hora_inicio,
        'timeZone' => 'America/Caracas',
    ],
    'end' => [
        'dateTime' => $fecha . 'T' . $hora_final,
        'timeZone' => 'America/Caracas',
    ],
    'conferenceData' => [
        'createRequest' => [
            'requestId' => uniqid(),
            'conferenceSolutionKey' => ['type' => 'hangoutsMeet']
        ]
    ]
]);

$calendarId = 'primary';
$event = $service->events->insert($calendarId, $event, ['conferenceDataVersion' => 1]);

// Obtener el enlace de Google Meet
$link_meet = $event->getHangoutLink();

// Obtener correo del usuario logueado
$query_usuario = "
    SELECT correo FROM usuario WHERE id_usuario = :id_usuario
";
$stmt_usuario = $conn->prepare($query_usuario);
$stmt_usuario->bindParam(':id_usuario', $id_usuario);
$stmt_usuario->execute();
$usuario = $stmt_usuario->fetch(PDO::FETCH_ASSOC);

if ($usuario) {
    $to = $usuario['correo'];
    $subject =
        "Cita Online Programada";
    $message =
        " <html> <head> <title>Cita Online Programada</title> 
    </head> <body> <p>Estimado(a) paciente,</p> 
    <p>Nos complace informarte que tu cita online con el psicólogo ha sido programada exitosamente.</p> 
    <p><strong>Detalles de la cita:</strong></p> <ul> <li><strong>Fecha:</strong> $fecha</li> 
    <li><strong>Hora de Inicio:</strong> $hora_inicio $ampm</li> 
    <li><strong>Hora de Finalización:</strong> $hora_final $ampm</li> 
    <li><strong>Motivo:</strong> $motivo</li> </ul> <p>Por favor, únete a la sesión usando el siguiente enlace:</p>
     <p><a href='$link_meet'>$link_meet</a></p> <p><strong>Advertencia:</strong> Ingrese al enlace a la hora y fecha agendada, por favor.</p> 
     <p>Te recomendamos conectarte unos minutos antes para asegurarte de que todo funciona correctamente.</p> 
     <p>Si tienes alguna pregunta o necesitas reprogramar la cita, no dudes en contactarnos.</p> 
     <p>Saludos cordiales,<br>El equipo de EmocionVital</p> </body> </html> ";

    // Configura PHPMailer
    $mail = new PHPMailer(true);
    try {
        // Configuración del servidor
        $mail->isSMTP();
        $mail->Host = 'smtp.gmail.com';
        $mail->SMTPAuth = true;
        $mail->Username = 'dunsuarez.ma@gmail.com';
        $mail->Password = 'bctefgaywbterpcy';
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port = 587;

        // Remitente
        $mail->setFrom('dunsuarez.ma@gmail.com', 'EmocionVital');

        // Destinatario
        $mail->addAddress($to);

        // Contenido
        $mail->isHTML(true);
        $mail->Subject = $subject;
        $mail->Body = $message;

        $mail->send();
        echo 'El mensaje ha sido enviado';
    } catch (Exception $e) {
        echo "No se pudo enviar el mensaje. Error de PHPMailer: {$mail->ErrorInfo}";
    }
}

// Guardar la cita en la base de datos (en la tabla agenda)
$query_new_agenda = "
    INSERT INTO agenda (id_paciente, fecha, hora_inicio, hora_final, contador_cita, status, link_meet) 
    VALUES (:id_paciente, :fecha, :hora_inicio, :hora_final, :contador_cita, 'Pendiente', :link_meet)
";
$stmt_new_agenda = $conn->prepare($query_new_agenda);
$stmt_new_agenda->bindParam(':id_paciente', $id_paciente);
$stmt_new_agenda->bindParam(':fecha', $fecha);
$stmt_new_agenda->bindParam(':hora_inicio', $hora_inicio);
$stmt_new_agenda->bindParam(':hora_final', $hora_final);
$stmt_new_agenda->bindParam(':contador_cita', $contador_cita); // Vincula el parámetro contador_cita
$stmt_new_agenda->bindParam(':link_meet', $link_meet);
$stmt_new_agenda->execute();


// Obtener el ID de la cita recién creada en la agenda
$id_agenda = $conn->lastInsertId();

// Guardar la cita en la base de datos (en la tabla cita)
$query_new_cita = "
    INSERT INTO cita (id_agenda, id_psicologo, id_paciente, fecha, motivo, id_tipo_cita) 
    VALUES (:id_agenda, :id_psicologo, :id_paciente, :fecha, :motivo, 1)
";
$stmt_new_cita = $conn->prepare($query_new_cita);
$stmt_new_cita->bindParam(':id_agenda', $id_agenda);
$stmt_new_cita->bindParam(':id_psicologo', $id_psicologo);
$stmt_new_cita->bindParam(':id_paciente', $id_paciente);
$stmt_new_cita->bindParam(':fecha', $fecha);
$stmt_new_cita->bindParam(':motivo', $motivo);
$stmt_new_cita->execute();

$id_cita = $conn->lastInsertId();

// Insertar pago de cita
$query_pago = "
    INSERT INTO pago_cita (id_cita, tipo_pago, monto, fecha_pago, referencia_bancaria) 
    VALUES (:id_cita, :tipo_pago, :monto, CURDATE(), :referencia_bancaria)
";
$stmt_pago = $conn->prepare($query_pago);
$stmt_pago->bindParam(':id_cita', $id_cita);
$stmt_pago->bindParam(':tipo_pago', $tipo_pago);
$stmt_pago->bindParam(':monto', $monto);
$stmt_pago->bindParam(':referencia_bancaria', $referencia_bancaria);
$stmt_pago->execute();


echo "Cita agendada correctamente. Revisa tu correo para el enlace de la reunión.";