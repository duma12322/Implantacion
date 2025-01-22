<?php
session_start();

// Conexión a la base de datos
include '../../config/conexion.php';

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

// Mostrar la Foto
$stmt = $conn->prepare("SELECT foto FROM usuario WHERE usuario = :usuario");
$stmt->execute([':usuario' => $nombreUsuario]);
$usuario = $stmt->fetch(PDO::FETCH_ASSOC);

// Mostrar la Foto
$stmt = $conn->prepare("SELECT foto FROM administrativo  WHERE usuario = :usuario");
$stmt->execute([':usuario' => $nombreUsuario]);
$usuario = $stmt->fetch(PDO::FETCH_ASSOC);

if (isset($_POST['tipo_cita'])) {
    // Inserta el tipo de cita seleccionado en la base de datos y recupera el id_tipo_cita
    $tipoCita = $_POST['tipo_cita'];
    $sql = "INSERT INTO tipo_cita (tipo_cita, modalidad) VALUES (:tipoCita, '')";
    $stmt = $conn->prepare($sql);
    $stmt->execute([':tipoCita' => $tipoCita]);
    $id_tipo_cita = $conn->lastInsertId();

    // Guarda el id_tipo_cita en la sesión
    $_SESSION['id_tipo_cita'] = $id_tipo_cita;

    $_SESSION['tipoCita'] = $tipoCita;
    $_SESSION['modalidad'] = $modalidad;

    // Redirige a la página correspondiente según el tipo de cita
    // Redirige a la página correspondiente según el tipo de cita
    if ($tipoCita == 'pareja') {
        header("Location: agendar_cita_pareja.php");
    } else if ($tipoCita == 'individual') {
        header("Location: agendar_cita_individual.php");
    } else if ($tipoCita == 'infantil') {
        header("Location: agendar_cita_infantil.php");
    } else {
        header("Location: agendar_cita_adolescente.php");
    }
    exit;
}
?>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agenda tu cita</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/agendar_cita.css">
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
        <h4>Agenda tu cita</h4>
        <div class="row">
            <!-- Cita Individual -->
            <div class="col-md-6 mb-2">
                <div class="card">
                    <div class="card-header">Cita Individual</div>
                    <div class="card-body">
                        <form action="agendar_cita.php" method="POST">
                            <input type="hidden" name="tipo_cita" value="individual">
                            <button type="submit" class="btn-custom btn-block">
                                <img src="files/individual.png" alt="Cita Individual" class="img-fluid" style="width: 100%;">
                                <span>Agendar Cita</span>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            <!-- Cita Pareja -->
            <div class="col-md-6 mb-2">
                <div class="card">
                    <div class="card-header">Cita Pareja</div>
                    <div class="card-body">
                        <form action="agendar_cita.php" method="POST">
                            <input type="hidden" name="tipo_cita" value="pareja">
                            <button type="submit" class="btn-custom btn-block">
                                <img src="files/parejas.png" alt="Cita Pareja" class="img-fluid" style="width: 100%;">
                                <span>Agendar Cita</span>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- Cita Niño -->
            <div class="col-md-6 mb-2">
                <div class="card">
                    <div class="card-header">Cita Infantil</div>
                    <div class="card-body">
                        <form action="agendar_cita.php" method="POST">
                            <input type="hidden" name="tipo_cita" value="infantil">
                            <button type="submit" class="btn-custom btn-block">
                                <img src="files/niños.png" alt="Cita Infantil" class="img-fluid" style="width: 100%;">
                                <span>Agendar Cita</span>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            <!-- Cita Adolescente -->
            <div class="col-md-6 mb-2">
                <div class="card">
                    <div class="card-header">Cita Adolescente</div>
                    <div class="card-body">
                        <form action="agendar_cita.php" method="POST">
                            <input type="hidden" name="tipo_cita" value="adolescente">
                            <button type="submit" class="btn-custom btn-block">
                                <img src="files/adolescentes.png" alt="Cita Adolescente" class="img-fluid" style="width: 100%;">
                                <span>Agendar Cita</span>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Vinculamos los scripts de Bootstrap 4 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Script -->
    <script src="script/sidebarandheader.js"></script>
</body>

</html>