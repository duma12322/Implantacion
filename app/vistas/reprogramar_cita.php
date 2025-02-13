<?php
session_start();

// Verifica si la sesión está activa
if (!isset($_SESSION['usuario'])) {
    header("Location: login_paciente.php");
    exit;
}

// Verifica si se hizo clic en el botón de cerrar sesión
if (isset($_POST['cerrar_sesion'])) {
    session_unset();
    session_destroy();
    header("Location: login_paciente.php");
    exit;
}

$nombreUsuario = $_SESSION['usuario'];
include_once('../../config/conexion.php');

// Mostrar la Foto
$stmt = $conn->prepare("SELECT foto FROM administrativo WHERE usuario = :usuario");
$stmt->execute([':usuario' => $nombreUsuario]);
$usuario = $stmt->fetch(PDO::FETCH_ASSOC);

// Verifica si se ha recibido el parámetro 'id_agenda' en la URL
$id_agenda = isset($_GET['id_agenda']) ? $_GET['id_agenda'] : null;

if ($id_agenda) {
    // Consulta la cita si existe el id_agenda
    $query_cita = "
    SELECT c.*, ag.fecha AS fecha_agenda, ag.hora_inicio, 
           p.id_paciente, CONCAT(u.nombre1, ' ', u.apellido1) AS nombre_completo, 
           a.nombre1 AS psicologo_nombre, a.apellido1 AS psicologo_apellido
    FROM cita c
    JOIN agenda ag ON c.id_agenda = ag.id_agenda
    JOIN paciente p ON c.id_paciente = p.id_paciente
    JOIN usuario u ON p.id_usuario = u.id_usuario
    JOIN psicologo s ON c.id_psicologo = s.id_psicologo
    JOIN administrativo a ON s.id_administrativo = a.id_administrativo
    WHERE ag.id_agenda = :id_agenda
    ";
    $stmt_cita = $conn->prepare($query_cita);
    $stmt_cita->execute([':id_agenda' => $id_agenda]);
    $cita = $stmt_cita->fetch(PDO::FETCH_ASSOC);

    if (!$cita) {
        // Redirige a la página de reprogramación si no se encuentra una cita válida
        header("Location: reprogramar_cita.php");
        exit;
    }

    // Asegúrate de que la fecha y hora estén en el formato correcto para los inputs
    $fecha = date('Y-m-d', strtotime($cita['fecha_agenda'])); // Usar 'fecha_agenda'
    $hora = date('H:i', strtotime($cita['hora_inicio'])); // Usar 'hora_inicio'
} else {
    // Si no se proporciona una cita, redirige a la página de reprogramación
    header("Location: consultar_cita.php");
    exit;
}
?>


<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reprogramar Cita</title>
    <link rel="stylesheet" href="css/bootstrap-4.5.2/bootstrap.min.css">
</head>

<body>
    <div class="container">
        <nav class="nav nav-borders">
            <a class="nav-link" href="consultar_cita.php">Volver al listado</a>
        </nav>
        <h2 class="my-4">Reprogramar Cita</h2>
        <form action="../controladores/procesar_reprogramar_cita.php" method="POST">

            <input type="hidden" name="id_cita" value="<?= $cita['id_cita']; ?>">

            <div class="form-group">
                <label for="id_psicologo">Psicólogo</label>
                <select name="id_psicologo" id="id_psicologo" class="form-control" required>
                    <option value="<?= $cita['id_psicologo']; ?>">
                        <?= $cita['psicologo_nombre'] . ' ' . $cita['psicologo_apellido']; ?>
                    </option>
                    <?php foreach ($result_psicologos as $row_psicologo): ?>
                        <option value="<?= $row_psicologo['id_psicologo']; ?>">
                            <?= $row_psicologo['nombre1'] . ' ' . $row_psicologo['apellido1']; ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="form-group">
                <label for="id_paciente">Paciente</label>
                <select name="id_paciente" id="id_paciente" class="form-control" required>
                    <option value="<?= $cita['id_paciente']; ?>"><?= $cita['nombre_completo']; ?></option>
                    <?php foreach ($result_pacientes as $row_paciente): ?>
                        <option value="<?= $row_paciente['id_paciente']; ?>"><?= $row_paciente['nombre_completo']; ?></option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="form-group">
                <label for="fecha">Fecha de la Cita</label>
                <input type="date" name="fecha" id="fecha" class="form-control" value="<?= $fecha; ?>" required>
            </div>

            <div class="form-group">
                <label for="hora">Hora de inicio</label>
                <div class="row">
                    <div class="col">
                        <input type="number" name="hora" id="hora" class="form-control" placeholder="Hora (1-12)" min="1" max="12" value="<?= date('g', strtotime($hora)); ?>" required>
                    </div>
                    <div class="col">
                        <input type="number" name="minutos" id="minutos" class="form-control" placeholder="Minutos (00-59)" min="0" max="59" value="<?= date('i', strtotime($hora)); ?>" required>
                    </div>
                    <div class="col">
                        <select name="am_pm" id="am_pm" class="form-control" required>
                            <option value="AM" <?= (date('A', strtotime($hora)) == 'AM') ? 'selected' : ''; ?>>AM</option>
                            <option value="PM" <?= (date('A', strtotime($hora)) == 'PM') ? 'selected' : ''; ?>>PM</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="motivo">Motivo</label>
                <textarea name="motivo" id="motivo" class="form-control" required><?= $cita['motivo']; ?></textarea>
            </div>

            <button type="submit" class="btn btn-success">Reprogramar Cita</button>
        </form>
    </div>

    <script src="script/jquery.min.js"></script>
    <script src="script/popper.min.js"></script>
    <script src="script/bootstrap.min.js/bootstrap.min.js"></script>

</body>

</html>