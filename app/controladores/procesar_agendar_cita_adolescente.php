<?php
session_start();

// Verifica si la sesión está activa
if (!isset($_SESSION['id_usuario'])) {
  header("Location: login_paciente.php");
  exit;
}

include_once('../../config/conexion.php');
require_once('../../vendor/autoload.php');

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// Obtener el ID de usuario desde la sesión
$id_usuario = $_SESSION['id_usuario'];  // Asegúrate de que esto esté disponible en la sesión

// Consultar información del paciente
$query_paciente = "
    SELECT u.id_usuario, u.nombre1, u.nombre2, u.apellido1, u.apellido2, p.id_paciente 
    FROM usuario u 
    JOIN paciente p ON u.id_usuario = p.id_usuario
    WHERE u.id_usuario = :id_usuario
";
$stmt_paciente = $conn->prepare($query_paciente);
$stmt_paciente->bindParam(':id_usuario', $id_usuario, PDO::PARAM_INT);
$stmt_paciente->execute();
$paciente = $stmt_paciente->fetch(PDO::FETCH_ASSOC);

if (!$paciente) {
  // Mostrar mensaje con SweetAlert si no se encuentra información del paciente
  echo "
    <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.17/dist/sweetalert2.all.min.js'></script>
    <script>
      window.onload = function() {
        Swal.fire({
            icon: 'error',
            title: 'No se encontró información para el paciente.',
            showConfirmButton: false,
            timer: 3000,
            willClose: () => { window.location.href = 'login_paciente.php'; }
        });
      }
    </script>";
  exit;
}

// Consultar información de psicólogos
$query_psicologos = "
    SELECT p.id_psicologo, a.Nombre1, a.Apellido1 
    FROM psicologo p 
    JOIN administrativo a ON p.id_administrativo = a.id_administrativo
";
$stmt_psicologos = $conn->prepare($query_psicologos);
$stmt_psicologos->execute();
$result_psicologos = $stmt_psicologos->fetchAll(PDO::FETCH_ASSOC);

// Procesar formulario de cita
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $id_psicologo = $_POST['id_psicologo'];
  $id_paciente = $_POST['id_paciente'];
  $fecha = $_POST['fecha'];
  $hora = $_POST['hora'];
  $minutos = $_POST['minutos'];
  $ampm = $_POST['am_pm'];
  $motivo = $_POST['motivo'];
  $tipo_pago = $_POST['tipo_pago'];
  $referencia_bancaria = $_POST['referencia_bancaria'] ?? '0000'; // Valor por defecto

  // Verificar si el tipo de pago es efectivo y ajustar el valor de referencia
  if ($_POST['tipo_pago'] === 'EFECTIVO $') {
    $referencia_bancaria = '0000';
  }

  $monto = 30;

  // Datos del infante 
  $relacion_nombre1 = $_POST['relacion_nombre1'];
  $relacion_nombre2 = $_POST['relacion_nombre2'];
  $relacion_apellido1 = $_POST['relacion_apellido1'];
  $relacion_apellido2 = $_POST['relacion_apellido2'];
  $relacion_fecha_nac = $_POST['relacion_fecha_nac'];
  $relacion_tipo_doc = $_POST['relacion_tipo_doc'];
  $relacion_numero_doc = $_POST['relacion_numero_doc'];
  $relacion_discapacitado = $_POST['relacion_discapacitado'];
  $relacion_descrip_disca = $_POST['relacion_descrip_disca'];
  $relacion_familiar = $_POST['relacion_familiar'];

  // Convertir hora AM/PM a formato 24 horas
  $hora24 = ($ampm == 'PM' && $hora != 12) ? $hora + 12 : (($ampm == 'AM' && $hora == 12) ? 0 : $hora);
  $hora_inicio = sprintf("%02d:%02d:00", $hora24, $minutos);

  // Calcular hora final sumando 45 minutos
  $minutos_totales = ($hora24 * 60) + $minutos + 45;
  $hora_final24 = intdiv($minutos_totales, 60);
  $minutos_finales = $minutos_totales % 60;
  $hora_final = sprintf("%02d:%02d:00", $hora_final24, $minutos_finales);

  // Actualizar información del paciente
  $query_update_paciente = "
    UPDATE paciente
    SET discapacitado = :discapacitado, descrip_disca = :descrip_disca
    WHERE id_paciente = :id_paciente
  ";
  $stmt_update_paciente = $conn->prepare($query_update_paciente);
  $stmt_update_paciente->bindParam(':discapacitado', $discapacitado, PDO::PARAM_INT);
  $stmt_update_paciente->bindParam(':descrip_disca', $descrip_disca, PDO::PARAM_STR);
  $stmt_update_paciente->bindParam(':id_paciente', $id_paciente, PDO::PARAM_INT);

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
                willClose: () => { window.location.href = '../vistas/agendar_cita_adolescente_presencial.php'; }
            });
          }
        </script>";
    exit;
  } else {
    $contador_cita = is_null($max_citas) ? 1 : $max_citas + 1;

    // Insertar nueva agenda
    $query_new_agenda = "
            INSERT INTO agenda (fecha, hora_inicio, hora_final, contador_cita, status, id_paciente) 
            VALUES (:fecha, :hora_inicio, :hora_final, :contador_cita, 'Pendiente', :id_paciente)
        ";
    $stmt_new_agenda = $conn->prepare($query_new_agenda);
    $stmt_new_agenda->bindParam(':fecha', $fecha);
    $stmt_new_agenda->bindParam(':hora_inicio', $hora_inicio);
    $stmt_new_agenda->bindParam(':hora_final', $hora_final);
    $stmt_new_agenda->bindParam(':contador_cita', $contador_cita);
    $stmt_new_agenda->bindParam(':id_paciente', $id_paciente);
    $stmt_new_agenda->execute();
    $id_agenda = $conn->lastInsertId();

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
        "Cita Presencial Programada";
      $message =
        " <html> <head> <title>Cita Presencial Programada</title> 
    </head> <body> <p>Estimado(a) paciente,</p> 
    <p>Nos complace informarte que tu cita presencial con el psicólogo ha sido programada exitosamente.</p> 
    <p><strong>Detalles de la cita:</strong></p> <ul> <li><strong>Fecha:</strong> $fecha</li> 
    <li><strong>Hora de Inicio:</strong> $hora_inicio $ampm</li> 
    <li><strong>Hora de Finalización:</strong> $hora_final $ampm</li> 
    <li><strong>Motivo:</strong> $motivo</li> 
      <li><strong>Con un Status:</strong> Pendiente</li> 
    </ul> 
     <p>Por favor, dirijase a la direccion indicada a continuacion:</p>
     <p>Carrera 90 entre Calles 80 y 77 Edificio Flores, Piso 8 Consultorio 8-2</p> <p><strong>Advertencia:</strong> Dirijase a la hora y fecha agendada, por favor.</p> 
     <p>Si tienes alguna pregunta o necesitas reprogramar la cita, no dudes en contactarnos.</p> 
     <p>+58-0418-001-00-11</p> 
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
        // Mensaje de éxito al enviar el correo
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
      willClose: () => { window.location.href = '../vistas/agendar_cita.php'; }
    });
  }
</script>";
      } catch (Exception $e) {
        // Mensaje de error al no poder enviar el correo
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
      }
    }

    // Insertar nueva cita
    $id_tipo_cita = $_SESSION['id_tipo_cita']; // Inserta la nueva cita utilizando el id_tipo_cita existente
    $query_cita = " INSERT INTO cita (id_agenda, id_psicologo, id_paciente, fecha, motivo, id_tipo_cita) 
   VALUES (:id_agenda, :id_psicologo, :id_paciente, :fecha, :motivo, :id_tipo_cita) ";
    $stmt_cita = $conn->prepare($query_cita);
    $stmt_cita->bindParam(':id_agenda', $id_agenda);
    $stmt_cita->bindParam(':id_psicologo', $id_psicologo);
    $stmt_cita->bindParam(':id_paciente', $id_paciente);
    $stmt_cita->bindParam(':fecha', $fecha);
    $stmt_cita->bindParam(':motivo', $motivo);
    $stmt_cita->bindParam(':id_tipo_cita', $id_tipo_cita);

    // Solo insertamos el pago si la cita se inserta correctamente
    if ($stmt_cita->execute()) {
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

      $query_relacion = "INSERT INTO paciente_relacion (id_paciente, relacion_familiar, relacion_nombre1, relacion_nombre2, relacion_apellido1, relacion_apellido2, relacion_fecha_nac, relacion_tipo_doc, relacion_numero_doc, relacion_discapacitado, relacion_descrip_disca) 
    VALUES 
    (:id_paciente, :relacion_familiar, :relacion_nombre1, :relacion_nombre2, :relacion_apellido1, :relacion_apellido2, :relacion_fecha_nac, :relacion_tipo_doc, :relacion_numero_doc, :relacion_discapacitado, :relacion_descrip_disca)";
      $stmt_relacion = $conn->prepare($query_relacion);
      $stmt_relacion->bindParam(':id_paciente', $id_paciente);
      $stmt_relacion->bindParam(':relacion_familiar', $relacion_familiar);
      $stmt_relacion->bindParam(':relacion_nombre1', $relacion_nombre1);
      $stmt_relacion->bindParam(':relacion_nombre2', $relacion_nombre2);
      $stmt_relacion->bindParam(':relacion_apellido1', $relacion_apellido1);
      $stmt_relacion->bindParam(':relacion_apellido2', $relacion_apellido2);
      $stmt_relacion->bindParam(':relacion_fecha_nac', $relacion_fecha_nac);
      $stmt_relacion->bindParam(':relacion_tipo_doc', $relacion_tipo_doc);
      $stmt_relacion->bindParam(':relacion_numero_doc', $relacion_numero_doc);
      $stmt_relacion->bindParam(':relacion_discapacitado', $relacion_discapacitado);
      $stmt_relacion->bindParam(':relacion_descrip_disca', $relacion_descrip_disca);
      $stmt_relacion->execute(); // Mensaje de éxito

      // Mensaje de éxito
      echo "
        <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.17/dist/sweetalert2.all.min.js'></script>
        <script>
          window.onload = function() {
            Swal.fire({
                icon: 'success',
                title: 'Cita agendada correctamente. Revisa tu correo para el enlace de la reunión.',
                showConfirmButton: true,
                confirmButtonText: 'OK',
                timer: 20000,
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
                title: 'Error al agendar la cita: " . $stmt_cita->errorInfo()[2] . "',
                showConfirmButton: true,
                confirmButtonText: 'OK',
                timer: 20000,
                willClose: () => { window.location.href = '../vistas/agendar_cita_adolescente_presencial.php'; }
            });
          }
        </script>";
    }
  }
}
