<?php
session_start();
require_once __DIR__ . '/../controladores/listado_historiaClinicaControlador.php';
include '../controladores/log.php';

use app\controladores\listado_historiaClinicaControlador;

if (!isset($_SESSION['usuario'])) {
    header("Location: login_psicologo.admin.php");
    exit;
}

if (isset($_POST['cerrar_sesion'])) {
    session_unset();
    session_destroy();
    header("Location: login_psicologo_admin.php");
    exit;
}

$nombreUsuario = $_SESSION['usuario'];
$controller = new listado_historiaClinicaControlador();

$searchTerm = '';
if (isset($_POST['search']) && !empty($_POST['search'])) {
    $searchTerm = $_POST['search'];
}

if (!empty($searchTerm)) {
    $historias = $controller->buscarHistoriasFiltradas($searchTerm);
} else {
    $historias = $controller->obtenerHistoriaClinica();
}

?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Historias Clínicas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/listado.css">
    <link rel="stylesheet" href="css/sidebarandheader.css">
</head>

<body>
    <!-- Header -->
    <?php include 'includes/header.php'; ?>

    <!-- Sidebar -->
    <?php include 'includes/sidebar.php'; ?>


    <div class="container mt-5">
        <h1 class="text-center mb-4">Historias Clínicas</h1>

        <!-- Botones de acciones principales -->
        <div class="d-flex justify-content-between mb-3">
            <div>
                <a href="#" class="btn btn-primary me-2">
                    <i class="bi bi-person-fill-add"></i> Agregar Historia Clínica
                </a>
            </div>

            <!-- Barra de búsqueda -->
            <div class="ms-auto search-container">
                <form method="POST" class="d-flex w-100">
                    <input type="text" name="search" class="form-control" placeholder="Buscar por nombre o documento" value="<?= htmlspecialchars($searchTerm) ?>">
                    <button type="submit" class="btn btn-outline-primary ms-2">Buscar</button>
                </form>
            </div>
        </div>
        <table class="table table-striped table-hover table-wide">
            <thead class="table-primary">
                <tr>
                    <th>Nombres y Apellidos del Paciente</th>
                    <th>Cédula de Identidad</th>
                    <th>Sexo</th>
                    <th>Estado Civil</th>
                    <th>Fecha de Cita</th>
                    <th>Entrevistador</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($historias)) : ?>
                    <?php foreach ($historias as $historia) : ?>
                        <tr onclick="selectRow(<?= htmlspecialchars($historia['id_usuario']) ?>, this)">
                            <td><?= $historia['nombre1'] . ' ' . $historia['nombre2'] . ' ' .  $historia['apellido1'] . ' ' . $historia['apellido2']?></td>
                            <td><?= htmlspecialchars($historia['tipo_doc']) ?>-<?= htmlspecialchars($historia['num_doc']) ?></td>
                            <td><?= htmlspecialchars($historia['sexo']) ?></td>
                            <td><?= htmlspecialchars($historia['edo_civil']) ?></td>
                            <td><?= htmlspecialchars($historia['fecha_p_cita']) ?></td>
                            <td><?= htmlspecialchars($historia['entrevistador']) ?></td>
                            <td>
                                <a href="" class="btn btn-warning btn-sm">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <form method="POST" class="deleteForm d-inline">
                                    <input type="hidden" name="id_administrativo" id="id_usuario_to_delete" value="">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                <?php else : ?>
                    <tr>
                        <td colspan="12" class="text-center">No se encontraron resultados.</td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="script/sidebarandheader.js"></script>
    <script src="script/listado_psicologo.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>

</html>