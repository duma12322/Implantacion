<?php
session_start();

// Verifica si la sesión está activa
if (!isset($_SESSION['id_usuario'])) {
  header("Location: login_paciente.php");
  exit;
}

include_once('../../config/conexion.php');

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
                willClose: () => { window.location.href = '../vistas/agendar_cita_individual_presencial.php'; }
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

    // Insertar nueva cita
    $query_cita = "
            INSERT INTO cita (id_agenda, id_psicologo, id_paciente, fecha, motivo, id_tipo_cita) 
            VALUES (:id_agenda, :id_psicologo, :id_paciente, :fecha, :motivo, 1)
        ";
    $stmt_cita = $conn->prepare($query_cita);
    $stmt_cita->bindParam(':id_agenda', $id_agenda);
    $stmt_cita->bindParam(':id_psicologo', $id_psicologo);
    $stmt_cita->bindParam(':id_paciente', $id_paciente);
    $stmt_cita->bindParam(':fecha', $fecha);
    $stmt_cita->bindParam(':motivo', $motivo);

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

      // Mensaje de éxito y redirección
      echo "
            <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.17/dist/sweetalert2.all.min.js'></script>
            <script>
              window.onload = function() {
                Swal.fire({
                    icon: 'success',
                    title: 'Cita agendada correctamente.',
                     showConfirmButton: true,
        confirmButtonText: 'OK',
                    timer: 3000,
                    willClose: () => { window.location.href = '../vistas/agendar_cita.php'; }
                });
              }
            </script>";
    } else {
      // Mensaje de error y redirección
      echo "
            <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.17/dist/sweetalert2.all.min.js'></script>
            <script>
              window.onload = function() {
                Swal.fire({
                    icon: 'error',
                    title: 'Error al agendar la cita: " . $stmt_cita->errorInfo()[2] . "',
                     showConfirmButton: true,
        confirmButtonText: 'OK',
                    timer: 3000,
                    willClose: () => { window.location.href = '../vistas/agendar_cita_individual_presencial.php'; }
                });
              }
            </script>";
    }
  }
}
