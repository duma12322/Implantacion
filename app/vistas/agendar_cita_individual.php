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

$nombreUsuario = isset($_SESSION['nombre1']) ? $_SESSION['nombre1'] : 'Usuario';

// Conexión a la base de datos
include '../../config/conexion.php'; // Asegúrate de que esta línea esté configurada para PDO

if (isset($_POST['modalidad'])) {
    // Actualiza la modalidad en la tabla tipo_cita
    $modalidad = $_POST['modalidad'];
    $sql = "UPDATE tipo_cita SET modalidad = :modalidad WHERE id_tipo_cita = (SELECT id_tipo_cita FROM tipo_cita ORDER BY id_tipo_cita DESC LIMIT 1)";

    // Prepara la consulta
    $stmt = $conn->prepare($sql);

    // Ejecuta la consulta con el valor de modalidad
    if ($stmt->execute([':modalidad' => $modalidad])) {
        // Redirige a la página correspondiente según la modalidad
        if ($modalidad == 'presencial') {
            header("Location: agendar_cita_individual_presencial.php");
        } elseif ($modalidad == 'online') {
            header("Location: agendar_cita_individual_online.php");
        }
        exit;
    } else {
        echo "Error al actualizar la modalidad.";
    }
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seleccionar Modalidad</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/agendar_cita_individual.css">
    <link rel="stylesheet" href="css/sidebarandheader.css">
</head>

<body>
    <!-- Header -->
    <?php include 'includes/header.php'; ?>
    <!-- Sidebar -->
    <?php include 'includes/sidebar.php'; ?>

    <div class="container">
        <h4>Seleccione la modalidad de su cita:</h4>
        <form method="POST" action="">
            <div class="row">
                <!-- Cita Presencial -->
                <div class="col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header">Cita Presencial</div>
                        <div class="card-body">
                            <button type="submit" name="modalidad" value="presencial" class="btn btn-primary">
                                <img src="files/presencial.png" alt="Cita Presencial" class="img-fluid">
                            </button>
                            <a href="agendar_cita_presencial.php">Agendar Cita</a>
                        </div>
                    </div>
                </div>
                <!-- Cita Online -->
                <div class="col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header">Cita Online</div>
                        <div class="card-body">
                            <button type="submit" name="modalidad" value="online" class="btn btn-primary">
                                <img src="files/online.png" alt="Cita Online" class="img-fluid">
                            </button>
                            <a href="agendar_cita_online.php">Agendar Cita</a>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="script/sidebarandheader.js"></script>
</body>

</html>