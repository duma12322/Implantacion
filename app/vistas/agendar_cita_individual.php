<?php session_start();
if (!isset($_SESSION['usuario'])) {
    header("Location: login_paciente.php");
    exit;
}
if (isset($_POST['cerrar_sesion'])) {
    session_unset();
    session_destroy();
    header("Location: login_paciente.php");
    exit;
}
$nombreUsuario = $_SESSION['usuario'];

$tipoUsuario = $_SESSION['tipo_usuario'];
include '../../config/conexion.php';
if (isset($_POST['modalidad'])) {
    // Recupera el id_tipo_cita de la sesión 
    $id_tipo_cita = $_SESSION['id_tipo_cita'];
    $modalidad = $_POST['modalidad'];

    $sql = "UPDATE tipo_cita SET modalidad = :modalidad WHERE id_tipo_cita = :id_tipo_cita";
    $stmt = $conn->prepare($sql); // Ejecuta la consulta con los valores de la modalidad 
    if ($stmt->execute([':modalidad' => $modalidad, ':id_tipo_cita' => $id_tipo_cita])) {
        // Redirige a la página según la modalidad seleccionada 
        if ($modalidad == 'presencial') {
            if ($tipoUsuario === 'paciente') {
                header("Location: agendar_cita_individual_presencial.php");
            } elseif ($tipoUsuario === 'administrativo' || $tipoUsuario === 'psicologo') {
                header("Location: agendar_cita_individual_presencial2.php");
            }
        } elseif ($modalidad == 'online') {
            if ($tipoUsuario === 'paciente') {
                header("Location: agendar_cita_individual_online.php");
            } elseif ($tipoUsuario === 'administrativo' || $tipoUsuario === 'psicologo') {
                header("Location: agendar_cita_individual_online2.php");
            }
        }
        exit;
    } else {
        echo "Error al actualizar la modalidad: " . $stmt->errorInfo()[2];
    }
}

// Mostrar la Foto
$stmt = $conn->prepare("SELECT foto FROM usuario WHERE usuario = :usuario");
$stmt->execute([':usuario' => $nombreUsuario]);
$usuario = $stmt->fetch(PDO::FETCH_ASSOC);

?>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cita Individual</title>
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
        <h4>Seleccione el tipo de cita:</h4>

        <div class="row">

            <!-- Cita Presencial -->
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-header">Cita Presencial</div>
                    <div class="card-body">
                        <form action="agendar_cita_individual.php" method="POST">
                            <input type="hidden" name="modalidad" value="presencial">
                            <button type="submit" class="btn-custom btn-block">
                                <img src="files/presencial.png" alt="Cita Presencial" class="img-fluid" style="width: 100%;">
                                <span>Agendar Cita</span>
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Cita Online -->
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-header">Cita Online</div>
                    <div class="card-body">
                        <form action="agendar_cita_individual.php" method="POST">
                            <input type="hidden" name="modalidad" value="online">
                            <button type="submit" class="btn-custom btn-block">
                                <img src="files/online.png" alt="Cita Online" class="img-fluid" style="width: 100%;">
                                <span>Agendar Cita</span>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Política de Citas -->
        <div class="policy-box mt-4">
            <h5>Política de Citas</h5>
            <p>Todas las citas tienen una duración máxima de 45 minutos. Por favor, llegue puntual para aprovechar al máximo su tiempo.</p>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="script/agendar_cita_individual.js"></script>
    <script src="script/sidebarandheader.js"></script>

</body>

</html>