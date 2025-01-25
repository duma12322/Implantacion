<?php
session_start();
include '../../config/conexion.php';

// Verificar si el usuario está autenticado
if (!isset($_SESSION['usuario'])) {
    header("Location: login_paciente.php");
    exit;
}

// Verificar si el usuario cerró sesión
if (isset($_POST['cerrar_sesion'])) {
    session_unset();
    session_destroy();
    header("Location: login_paciente.php");
    exit;
}

// Variables de sesión
$nombreUsuario = $_SESSION['usuario'];
$tipoUsuario = $_SESSION['tipo_usuario'] ?? 'paciente';

// Manejar la modalidad seleccionada
if (isset($_POST['modalidad'])) {
    $id_tipo_cita = $_SESSION['id_tipo_cita'] ?? null;
    $modalidad = $_POST['modalidad'];
    $_SESSION['modalidad'] = $modalidad;

    // Actualizar la modalidad en la base de datos
    if ($id_tipo_cita) {
        $sql = "UPDATE tipo_cita SET modalidad = :modalidad WHERE id_tipo_cita = :id_tipo_cita";
        $stmt = $conn->prepare($sql);

        if ($stmt->execute([':modalidad' => $modalidad, ':id_tipo_cita' => $id_tipo_cita])) {
            // Redirigir según la modalidad y el tipo de usuario
            if ($modalidad === 'presencial') {
                header("Location: " . ($tipoUsuario === 'paciente' ? "agendar_cita_individual_presencial.php" : "agendar_cita_individual_presencial2.php"));
            } elseif ($modalidad === 'online') {
                header("Location: " . ($tipoUsuario === 'paciente' ? "agendar_cita_individual_online.php" : "agendar_cita_individual_online2.php"));
            }
            exit;
        } else {
            echo "Error al actualizar la modalidad: " . $stmt->errorInfo()[2];
        }
    } else {
        echo "ID de tipo de cita no encontrado.";
    }
}

// Mostrar la foto del usuario según su tipo
$stmt = $conn->prepare(
    $tipoUsuario === 'administrativo' || $tipoUsuario === 'psicologo'
        ? "SELECT foto FROM administrativo WHERE usuario = :usuario"
        : "SELECT foto FROM usuario WHERE usuario = :usuario"
);
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
    <header class="header">
        <div class="dropdown">
            <button class="dropbtn">
                <?php if (!empty($usuario['foto'])): ?>
                    <img src="data:image/jpeg;base64,<?php echo base64_encode($usuario['foto']); ?>" class="patient-photo" alt="Foto del usuario" />
                <?php else: ?>
                    <img src="files/avatar.png" class="patient-photo" alt="Avatar por defecto" />
                <?php endif; ?>
                <?php echo htmlspecialchars($nombreUsuario); ?>
            </button>
            <div class="dropdown-content">
                <a href="perfil_usuario.php">Perfil</a>
                <a href="../../config/logout.php">Cerrar Sesión</a>
            </div>
        </div>
    </header>

    <!-- Sidebar -->
    <?php include 'includes/sidebar.php'; ?>

    <!-- Contenido principal -->
    <div class="container">
        <h4>Seleccione el tipo de cita:</h4>
        <div class="row">
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