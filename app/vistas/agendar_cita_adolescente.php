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
    $stmt = $conn->prepare($sql);

    // Ejecuta la consulta con los valores de la modalidad 
    if ($stmt->execute([':modalidad' => $modalidad, ':id_tipo_cita' => $id_tipo_cita])) {
        // Redirige a la página según la modalidad seleccionada 
        if ($modalidad == 'presencial') {
            if ($tipoUsuario === 'paciente') {
                header("Location: agendar_cita_adolescente_presencial.php");
            } elseif ($tipoUsuario === 'administrativo' || $tipoUsuario === 'psicologo') {
                header("Location: agendar_cita_adolescente_presencial2.php");
            }
        } else {
            echo "Modalidad no reconocida.";
        }
        exit;
    } else {
        echo "Error al actualizar la modalidad: " . $stmt->errorInfo()[2];
    }
}

// Mostrar la foto según el tipo de usuario
if ($tipoUsuario === 'administrativo' || $tipoUsuario === 'psicologo') {
    $stmt = $conn->prepare("SELECT foto FROM administrativo WHERE usuario = :usuario");
} else {
    $stmt = $conn->prepare("SELECT foto FROM usuario WHERE usuario = :usuario");
}

$stmt->execute([':usuario' => $nombreUsuario]);
$usuario = $stmt->fetch(PDO::FETCH_ASSOC);

?>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cita Individual</title>
    <link rel="stylesheet" href="css/bootstrap-4.5.2/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-icons/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/agendar_cita_infantil.css">
    <link rel="stylesheet" href="css/sidebarandheader.css">
</head>

<body>
    <!-- Header -->
    <header class="header">
        <div class="dropdown">
            <!-- Botón del dropdown con la foto y el nombre del usuario -->
            <button class="dropbtn">
                <!-- Aquí se muestra la foto del usuario -->
                <?php if (!empty($usuario['foto'])): ?>
                    <img src="data:image/jpeg;base64,<?php echo base64_encode($usuario['foto']); ?>" class="patient-photo" alt="Foto del usuario" />
                <?php else: ?>
                    <!-- Si no hay foto, se muestra la del avatar -->
                    <img src="files/avatar.png" class="patient-photo" alt="Avatar por defecto" />
                <?php endif; ?>

                <!-- Mostrar el nombre del usuario -->
                <?php echo htmlspecialchars($nombreUsuario); ?>
            </button>
            <div class="dropdown-content">
                <a href="perfil_usuario.php">Perfil</a>
                <a href="../../config/logout.php">Cerrar Sesion</a>
            </div>
        </div>
    </header>

    <!-- Sidebar -->
    <?php include 'includes/sidebar.php'; ?>

    <div class="container">
        <h4>Seleccione el tipo de cita:</h4>

        <!-- Cita Presencial -->
        <div class="col-md-6 mb-6">
            <div class="card">
                <div class="card-header">Cita Presencial</div>
                <div class="card-body">
                    <form action="agendar_cita_adolescente.php" method="POST">
                        <input type="hidden" name="modalidad" value="presencial">
                        <button type="submit" class="btn-custom btn-block">
                            <img src="files/presencial.png" alt="Cita Presencial" class="img-fluid" style="width: 80%; display: block; margin: 0 auto;">
                            <span style="display: block; text-align: center; margin-top: 10px;">Agendar Cita</span>
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Política de Citas -->
        <div class="policy-box mt-4">
            <h5>Política de Citas</h5>
            <p>Todas las citas tienen una duración máxima de 45 minutos. Por favor, llegue puntual para aprovechar al máximo su tiempo.</p>
            <p>El menor de edad debe estar acompañado de su representante legal.</p>
        </div>
    </div>

    <!-- Scripts -->
    <script src="script/jquery.min.js"></script>
    <script src="script/popper.min.js"></script>
    <script src="script/bootstrap.min.js/bootstrap.min.js"></script>
    <script src="script/agendar_cita_individual.js"></script>
    <script src="script/sidebarandheader.js"></script>

</body>

</html>