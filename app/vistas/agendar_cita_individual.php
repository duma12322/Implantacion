<?php
session_start();

// Verifica si la sesión está activa
if (!isset($_SESSION['usuario'])) {
    header("Location: login_paciente.php");
    exit;
}

// Verifica si se hizo clic en el botón de cerrar sesión
if (isset($_POST['cerrar_sesion'])) {
    // Destruye la sesión y redirige al login
    session_unset();
    session_destroy();
    header("Location: login_paciente.php");
    exit;
}

$nombreUsuario = $_SESSION['usuario'];
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
                    <div class="card-header">
                        Cita Presencial
                    </div>
                    <div class="card-body">
                        <a href="agendar_cita_individual_presencial.php">
                            <img src="files/presencial.png" alt="Cita Presencial" class="img-fluid">
                        </a>
                        <a href="agendar_cita_individual_presencial.php">Agendar Cita</a>
                    </div>
                </div>
            </div>

            <!-- Cita Online -->
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-header">
                        Cita Online
                    </div>
                    <div class="card-body">
                        <a href="agendar_cita_online.php">
                            <img src="files/online.png" alt="Cita Online" class="img-fluid">
                        </a>
                        <a href="agendar_cita_online.php">Agendar Cita</a>
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
    <!-- Script -->
    <script src="script/sidebarandheader.js"></script>
</body>

</html>