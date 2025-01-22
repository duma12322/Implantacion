<?php
session_start();
// Conexión a la base de datos
include '../../config/conexion.php';

// Verifica si la sesión está activa
if (!isset($_SESSION['usuario'])) {
    header("Location: login_psicologo_admin.php");
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

$nombreUsuario = $_SESSION['usuario'];

// Mostrar la Foto
$stmt = $conn->prepare("SELECT foto FROM administrativo  WHERE usuario = :usuario");
$stmt->execute([':usuario' => $nombreUsuario]);
$usuario = $stmt->fetch(PDO::FETCH_ASSOC);

// Consulta SQL para obtener las citas por tipo y modalidad desde la tabla tipo_cita
$sql = "SELECT 
            t.tipo_cita, 
            t.modalidad, 
            COUNT(c.id_cita) AS cantidad
        FROM 
            tipo_cita t
        LEFT JOIN 
            cita c ON c.id_tipo_cita = t.id_tipo_cita
        GROUP BY 
            t.tipo_cita, t.modalidad";

$stmt = $conn->query($sql);

// Preparar los datos para el frontend
$citasPorTipoYModalidad = [
    'tipo_cita' => [],
    'modalidad' => [],
    'cantidad' => []
];

// Cambiar a PDO fetch() en lugar de fetch_assoc()
while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    $citasPorTipoYModalidad['tipo_cita'][] = $row['tipo_cita'];
    $citasPorTipoYModalidad['modalidad'][] = $row['modalidad'];
    $citasPorTipoYModalidad['cantidad'][] = $row['cantidad'];
}

$conn = null; // Cerrar la conexión
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
        <div class="text-center mb-4">
            <h1 class="dashboard-title">EmocionVital</h1>
            <h4>Resumen de citas del mes</h4>
        </div>

        <div class="row text-center mb-4">
            <!-- Citas Individuales -->
            <div class="col-md-3">
                <div class="card counter-card">
                    <div class="card-body">
                        <h5 class="card-title">Citas Individuales</h5>
                        <p class="card-text counter" id="individual_total">0</p>
                    </div>
                </div>
            </div>

            <!-- Citas de Pareja -->
            <div class="col-md-3">
                <div class="card counter-card">
                    <div class="card-body">
                        <h5 class="card-title">Citas de Pareja</h5>
                        <p class="card-text counter" id="pareja_total">0</p>
                    </div>
                </div>
            </div>

            <!-- Citas con Adolescentes -->
            <div class="col-md-3">
                <div class="card counter-card">
                    <div class="card-body">
                        <h5 class="card-title">Citas con Adolescentes</h5>
                        <p class="card-text counter" id="adolescente_total">0</p>
                    </div>
                </div>
            </div>

            <!-- Citas infantil -->
            <div class="col-md-3">
                <div class="card counter-card">
                    <div class="card-body">
                        <h5 class="card-title">Citas infantil</h5>
                        <p class="card-text counter" id="niños_total">0</p>
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
                        <h5 class="card-title">Citas por Tipo y Modalidad</h5>
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
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Datos de citas (obtenidos del backend)
            const citas = <?php echo json_encode($citasPorTipoYModalidad); ?>;

            // Inicialización de contadores
            const tipos = ["individual", "pareja", "adolescente", "infantil"];
            const modalidades = ["presencial", "online"];

            // Crear un objeto para almacenar las cantidades por tipo
            let citasPorContador = {
                "individual_total": 0,
                "pareja_total": 0,
                "adolescente_total": 0,
                "niños_total": 0
            };

            // Asignar las cantidades de citas a los contadores correspondientes
            citas['tipo_cita'].forEach((tipo, index) => {
                const modalidad = citas['modalidad'][index];
                const cantidad = citas['cantidad'][index];

                // Sumar las cantidades de 'presencial' y 'online' por tipo
                let contadorId = tipo.toLowerCase() + "_total"; // Total por tipo de cita
                if (contadorId === "infantil_total") {
                    contadorId = "niños_total"; // Cambiar a "niños_total" si es de tipo "infantil"
                }

                if (citasPorContador[contadorId] !== undefined) {
                    citasPorContador[contadorId] += cantidad;
                }
            });

            // Actualizar los contadores en el frontend
            Object.keys(citasPorContador).forEach(contadorId => {
                const element = document.getElementById(contadorId);
                if (element) {
                    element.innerText = citasPorContador[contadorId];
                }
            });

            // Gráfico de Barras (tipos por modalidad)
            new Chart(document.getElementById("barChart"), {
                type: "bar",
                data: {
                    labels: modalidades,
                    datasets: tipos.map((tipo) => ({
                        label: tipo,
                        data: modalidades.map((modalidad) => {
                            return citas['cantidad'].filter((_, index) => citas['tipo_cita'][index] === tipo && citas['modalidad'][index] === modalidad)
                                .reduce((acc, curr) => acc + curr, 0);
                        }),
                        backgroundColor: ["#007bff", "#28a745", "#ffc107", "#dc3545"],
                        borderColor: ["#0056b3", "#19692c", "#b38600", "#8b1a1a"],
                        borderWidth: 1
                    }))
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            // Gráfico de Pastel (distribución general)
            const totalCitas = citas['cantidad'].reduce((acc, curr) => acc + curr, 0);
            new Chart(document.getElementById("pieChart"), {
                type: "pie",
                data: {
                    labels: [...tipos],
                    datasets: [{
                        data: tipos.map(tipo => citas['cantidad'].filter((_, index) => citas['tipo_cita'][index] === tipo)
                            .reduce((acc, curr) => acc + curr, 0)),
                        backgroundColor: ["#007bff", "#28a745", "#ffc107", "#dc3545"]
                    }]
                },
                options: {
                    responsive: true
                }
            });
        });
    </script>
</body>

</html>
