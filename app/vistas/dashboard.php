<?php
session_start();

// Verifica si la sesión está activa
if (!isset($_SESSION['usuario'])) {
    header("Location: login_psicologo.admin.php");
    exit;
}

// Verifica si se hizo clic en el botón de cerrar sesión
if (isset($_POST['cerrar_sesion'])) {
    // Destruye la sesión y redirige al login
    session_unset();
    session_destroy();
    header("Location: login_psicologo_admin.php");
    exit;
}

$nombreUsuario = $_SESSION['usuario']
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Consultorio Psicológico</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="css/sidebarandheader.css">
</head>

<body>
    <!-- Header -->
    <?php include 'includes/header.php'; ?>

    <!-- Sidebar -->
    <?php include 'includes/sidebar.php'; ?>

    <div class="container my-5">
        <div class=" text-center mb-4">
            <h1 class="dashboard-title">EmocionVital</h1>
            <h4>Resumen de citas del mes</h4>
        </div>

        <div class="row text-center mb-4">
            <!-- Citas Individuales -->
            <div class="col-md-3">
                <div class="card counter-card">
                    <div class="card-body">
                        <h5 class="card-title">Citas Individuales</h5>
                        <p class="card-text counter" id="individuales">0</p>
                    </div>
                </div>
            </div>
            <!-- Citas de Pareja -->
            <div class="col-md-3">
                <div class="card counter-card">
                    <div class="card-body">
                        <h5 class="card-title">Citas de Pareja</h5>
                        <p class="card-text counter" id="pareja">0</p>
                    </div>
                </div>
            </div>
            <!-- Citas con Adolescentes -->
            <div class="col-md-3">
                <div class="card counter-card">
                    <div class="card-body">
                        <h5 class="card-title">Citas con Adolescentes</h5>
                        <p class="card-text counter" id="adolescentes">0</p>
                    </div>
                </div>
            </div>
            <!-- Citas con Niños -->
            <div class="col-md-3">
                <div class="card counter-card">
                    <div class="card-body">
                        <h5 class="card-title">Citas con Niños</h5>
                        <p class="card-text counter" id="niños">0</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Gráficos -->
        <div class="row">
            <!-- Gráfico de Barras -->
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Citas por Tipo</h5>
                        <canvas id="barChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Gráfico de Pastel -->
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Distribución de Citas</h5>
                        <canvas id="pieChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="script/dashboard.js"></script>
    <script src="script/sidebarandheader.js"></script>
</body>

</html>