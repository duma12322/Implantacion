<?php
session_start();
require_once __DIR__ . '/../controladores/listado_PsicologosControlador.php';

use app\controladores\listado_PsicologosControlador;

if (!isset($_SESSION['usuario'])) {
    header("Location: login_psicologo.admin.php");
    exit;
}

// Verifica si se hizo clic en el botón de cerrar sesión
if (isset($_POST['cerrar_sesion'])) {
    session_unset();
    session_destroy();
    header("Location: login_psicologo_admin.php");
    exit;
}

$nombreUsuario = $_SESSION['usuario'];
$controller = new listado_PsicologosControlador();
$searchTerm = '';
if (isset($_POST['search']) && !empty($_POST['search'])) {
    $searchTerm = $_POST['search'];
}

if (!empty($searchTerm)) {
    $psicologos = $controller->obtenerPsicologoFiltrados($searchTerm);
} else {
    $psicologos = $controller->obtenerPsicologos();
}

if (isset($_POST['id_administrativo'])) {
    $id_administrativo = $_POST['id_administrativo'];
    $resultado = $controller->eliminarPsicologo($id_administrativo);

    header('Location: /Implantacion/app/vistas/listado_Psicologos.php');
    exit();
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Psicólogos</title>
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
        <h1 class="text-center mb-4">Listado de Psicólogos</h1>

        <!-- Botones de acciones principales -->
        <div class="d-flex justify-content-between mb-3">
            <div>
                <a href="#" class="btn btn-primary me-2">
                    <i class="bi bi-person-fill-add"></i> Agregar Psicologo
                </a>
                <!-- Botón de Eliminar Psicólogo -->
                <form method="POST" class="d-inline deleteForm" id="deleteForm">
                    <input type="hidden" name="id_administrativo" id="id_usuario_to_delete">
                    <button type="submit" class="btn btn-danger" name="eliminar">
                        <i class="bi bi-trash-fill"></i> Eliminar
                    </button>
                </form>
            </div>

            <!-- Barra de búsqueda -->
            <div class="ms-auto search-container">
                <form method="POST" class="d-flex w-100">
                    <input type="text" name="search" class="form-control" placeholder="Buscar por nombre o documento" value="<?= htmlspecialchars($searchTerm) ?>">
                    <button type="submit" class="btn btn-outline-primary ms-2">Buscar</button>
                </form>
            </div>
        </div>


        <!-- Tabla de psicólogos -->
        <table class="table table-striped table-hover table-wide">
            <thead class="table-primary">
                <tr>
                    <th>Primer Nombre</th>
                    <th>Segundo Nombre</th>
                    <th>Primer Apellido</th>
                    <th>Segundo Apellido</th>
                    <th>Fecha de Nacimiento</th>
                    <th>Tipo de Documento</th>
                    <th>Número de Documento</th>
                    <th>Teléfono</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($psicologos)) : ?>
                    <?php foreach ($psicologos as $psicologo) : ?>
                        <tr onclick="selectRow(<?= htmlspecialchars($psicologo['id_administrativo']) ?>, this)">
                            <td><?= htmlspecialchars($psicologo['Nombre1']) ?></td>
                            <td><?= htmlspecialchars($psicologo['Nombre2']) ?></td>
                            <td><?= htmlspecialchars($psicologo['Apellido1']) ?></td>
                            <td><?= htmlspecialchars($psicologo['Apellido2']) ?></td>
                            <td><?= htmlspecialchars($psicologo['Fecha_Nac']) ?></td>
                            <td><?= htmlspecialchars($psicologo['tipo_doc']) ?></td>
                            <td><?= htmlspecialchars($psicologo['num_doc']) ?></td>
                            <td><?= htmlspecialchars($psicologo['telefono']) ?></td>
                            <td>
                                <a href="modificar_psicologo.php?id_administrativo=<?= htmlspecialchars($psicologo['id_administrativo']) ?>" class="btn btn-warning btn-sm">
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