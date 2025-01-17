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

// Conexión a la base de datos
include '../../config/conexion.php'; // Asegúrate de que esta línea esté configurada para PDO

if (isset($_POST['tipo_cita'])) {
    // Inserta el tipo de cita seleccionado en la base de datos
    $tipoCita = $_POST['tipo_cita'];
    $sql = "INSERT INTO tipo_cita (tipo_cita, modalidad) VALUES (:tipoCita, '')";

    // Prepara la consulta
    $stmt = $conn->prepare($sql);

    // Ejecuta la consulta con el valor del tipo de cita
    if ($stmt->execute([':tipoCita' => $tipoCita])) {
        // Redirige a la página según el tipo de cita
        if ($tipoCita == 'individual') {
            header("Location: agendar_cita_individual.php");
        } elseif ($tipoCita == 'pareja') {
            header("Location: agendar_cita_pareja.php");
        } elseif ($tipoCita == 'infantil') {
            header("Location: agendar_cita_nino.php");
        } elseif ($tipoCita == 'adolescente') {
            header("Location: agendar_cita_adolescente.php");
        }
        exit;
    } else {
        echo "Error al guardar el tipo de cita.";
    }
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
    <?php include 'includes/header.php'; ?>
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
                            <button type="submit" class="btn btn-primary">
                                <img src="files/individual.png" alt="Cita Individual" class="img-fluid">
                                Agendar Cita
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
                            <button type="submit" class="btn btn-primary">
                                <img src="files/parejas.png" alt="Cita Pareja" class="img-fluid">
                                Agendar Cita
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
                    <div class="card-header">Cita Niño</div>
                    <div class="card-body">
                        <form action="agendar_cita.php" method="POST">
                            <input type="hidden" name="tipo_cita" value="infantil">
                            <button type="submit" class="btn btn-primary">
                                <img src="files/niños.png" alt="Cita Niño" class="img-fluid">
                                Agendar Cita
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
                            <button type="submit" class="btn btn-primary">
                                <img src="files/adolescentes.png" alt="Cita Adolescente" class="img-fluid">
                                Agendar Cita
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