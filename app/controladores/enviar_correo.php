<?php
require_once('../../vendor/autoload.php');
include_once('../../config/conexion.php');  // Asegúrate de incluir la conexión a la base de datos

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

function enviarCorreo($paciente_email, $asunto, $mensaje)
{
    $mail = new PHPMailer(true);

    try {
        // Configuración del servidor de correo
        $mail->isSMTP();
        $mail->Host = 'smtp.gmail.com';
        $mail->SMTPAuth = true;
        $mail->Username = 'dunsuarez.ma@gmail.com';  // Reemplaza con tu correo
        $mail->Password = 'bctefgaywbterpcy';        // Reemplaza con tu contraseña de aplicación
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port = 587;

        // Remitente y destinatario
        $mail->setFrom('dunsuarez.ma@gmail.com', 'EmocionVital');
        $mail->addAddress($paciente_email); // El correo del paciente

        // Contenido del correo
        $mail->isHTML(true);
        $mail->Subject = $asunto;
        $mail->Body    = $mensaje;

        // Intentamos enviar el correo
        if ($mail->send()) {
            echo "
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.17/dist/sweetalert2.all.min.js'></script>
<script>
  window.onload = function() {
    Swal.fire({
      icon: 'success',
      title: 'El mensaje ha sido enviado',
      showConfirmButton: true,
      confirmButtonText: 'OK',
      timer: 3000,
      willClose: () => { window.location.href = '../vistas/consultar_cita.php'; }
    });
  }
</script>";
            return true;
        } else {
            echo "
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.17/dist/sweetalert2.all.min.js'></script>
<script>
  window.onload = function() {
    Swal.fire({
      icon: 'error',
      title: 'No se pudo enviar el mensaje',
      text: 'Error de PHPMailer: {$mail->ErrorInfo}',
      showConfirmButton: true,
      confirmButtonText: 'OK',
      timer: 5000,
      willClose: () => { window.location.href = '../vistas/agendar_cita_individual_online.php'; }
    });
  }
</script>";
            return false;
        }
    } catch (Exception $e) {
        // Capturamos y mostramos el error
        echo "Error al enviar el correo: {$mail->ErrorInfo}";
        return false;
    }
}

// Obtener el id_agenda desde el formulario
if (isset($_POST['id_agenda'])) {
    $id_agenda = $_POST['id_agenda'];

    // Obtener los detalles de la cita (fecha, hora, motivo, etc.) y el correo del paciente
    $sql = "SELECT a.fecha, a.hora_inicio, a.hora_final, c.motivo, a.status, u.correo
            FROM usuario u
            INNER JOIN paciente p ON p.id_usuario = u.id_usuario
            INNER JOIN agenda a ON a.id_paciente = p.id_paciente
            INNER JOIN cita c ON c.id_agenda = a.id_agenda
            WHERE a.id_agenda = :id_agenda";

    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':id_agenda', $id_agenda, PDO::PARAM_INT);
    $stmt->execute();
    $row_cita = $stmt->fetch(PDO::FETCH_ASSOC);  // Ejecutamos la consulta y asignamos el resultado a $row_cita

    if ($row_cita) {
        // Obtener los detalles de la cita
        $fecha = $row_cita['fecha'];
        $hora_inicio = $row_cita['hora_inicio'];
        $hora_final = $row_cita['hora_final'];
        $motivo = $row_cita['motivo'];
        $status = $row_cita['status'];
        $paciente_email = $row_cita['correo'];

        // Aquí decides el asunto y el mensaje según el estado de la cita
        $asunto = "Confirmación de Cita";  // O lo que corresponda según el caso
        $mensaje =
            "  <html> 
        <head> <title>Cita Presencial Programada</title> </head> 
        <body> 
            <p>Estimado(a) paciente,</p> 
            <p>Nos complace informarte que el estatus de tu cita ha sido actualizado. A continuación, te proporcionamos los detalles de la misma:</p> 
            <p><strong>Detalles de la cita:</strong></p> 
            <ul> 
                <li><strong>Fecha:</strong> $fecha</li> 
                <li><strong>Hora de Inicio:</strong> $hora_inicio</li> 
                <li><strong>Hora de Finalización:</strong> $hora_final</li> 
                <li><strong>Motivo:</strong> $motivo</li> 
                <li><strong>Con un Status:</strong> $status</li> 
            </ul> 
            <p>Si tu cita ha sido confirmada, te esperamos en la siguiente dirección:</p>
            <p>Carrera 90 entre Calles 80 y 77, Edificio Flores, Piso 8, Consultorio 8-2</p> 
            <p>En caso de que tu cita haya sido cancelada, por favor, contáctanos para reprogramarla o resolver cualquier duda que puedas tener.</p> 
            <p><strong>Advertencia:</strong> Es importante que llegues a la hora y fecha agendada. Si por alguna razón no puedes asistir, te rogamos informarnos con antelación.</p> 
            <p>Para cualquier pregunta o solicitud de reprogramación, no dudes en ponerte en contacto con nosotros a través del siguiente número:</p> 
            <p>+58-0418-001-00-11</p> 
<p>Agradecemos tu comprensión y te esperamos en tu cita.</p>
<p>Atentamente, El equipo de EmocionVital</p>
        </body> 
        </html>
    ";  // Personaliza el mensaje

        // Llamar a la función para enviar el correo
        enviarCorreo($paciente_email, $asunto, $mensaje);
    } else {
        echo "No se encontró la cita para esta agenda.";
    }
} else {
    echo "No se recibió el ID de la agenda.";
}
