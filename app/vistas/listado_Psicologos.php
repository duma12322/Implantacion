<?php
session_start();
require_once __DIR__ . '/../controladores/listado_PsicologosControlador.php';
include '../controladores/log.php';

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

// Mostrar la Foto
$stmt = $conn->prepare("SELECT foto FROM administrativo  WHERE usuario = :usuario");
$stmt->execute([':usuario' => $nombreUsuario]);
$usuario = $stmt->fetch(PDO::FETCH_ASSOC);

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

    // Obtener los detalles del psicólogo a eliminar (nombre y apellido)
    $stmt = $conn->prepare("SELECT nombre1, apellido1 FROM administrativo WHERE id_administrativo = :id_administrativo");
    $stmt->execute([':id_administrativo' => $id_administrativo]);
    $usuarioAEliminar = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($usuarioAEliminar) {
        $nombreUsuarioEliminar = $usuarioAEliminar['nombre1'] . ' ' . $usuarioAEliminar['apellido1'];
    }

    // Llamar al método para eliminar al psicólogo
    $resultado = $controller->eliminarPsicologo($id_administrativo);

    // Registrar el log de la eliminación
    registrar_log($_SESSION['usuario'], "Eliminó al psicologo: $nombreUsuarioEliminar");

    // Redirigir al listado de psicólogos después de la eliminación
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
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-icons/bootstrap-icons.min.css">
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
                <a href="registrar_psicologo.php" class="btn btn-primary me-2">
                    <i class="bi bi-person-fill-add"></i> Agregar Psicologo
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


        <!-- Tabla de psicólogos -->
        <table class="table table-striped table-hover table-wide">
            <thead class="table-primary">
                <tr>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Fecha de Nacimiento</th>
                    <th>Cédula de Identidad</th>
                    <th>Teléfono</th>
                    <th>Especialidad</th>
                    <th>Foto</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($psicologos)) : ?>
                    <?php foreach ($psicologos as $psicologo) : ?>
                        <tr onclick="selectRow(<?= htmlspecialchars($psicologo['id_administrativo']) ?>, this)">
                            <td><?= $psicologo['Nombre1'] . ' ' . $psicologo['Nombre2'] ?></td>
                            <td><?= $psicologo['Apellido1'] . ' ' . $psicologo['Apellido2'] ?></td>
                            <td><?= htmlspecialchars($psicologo['Fecha_Nac']) ?></td>
                            <td><?= htmlspecialchars($psicologo['tipo_doc']) ?>-<?= htmlspecialchars($psicologo['num_doc']) ?></td>
                            <td><?= htmlspecialchars($psicologo['telefono']) ?></td>
                            <td><?= htmlspecialchars($psicologo['Tipo_Esp']) ?></td>
                            <td>
                                <?php if (!empty($psicologo['foto'])) : ?>
                                    <img src="data:image/jpeg;base64,<?= base64_encode($psicologo['foto']) ?>" alt="Foto" class="img-thumbnail" width="50" height="50" />
                                <?php else : ?>
                                    <span class="text-muted">No disponible</span>
                                <?php endif; ?>
                            </td>
                            <td>
                                <a href="modificar_psicologo.php?id_administrativo=<?= htmlspecialchars($psicologo['id_administrativo']) ?>" class="btn btn-warning btn-sm">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <form method="POST" class="deleteForm d-inline">
                                    <input type="hidden" name="id_administrativo" id="id_usuario_to_delete" value="<?= htmlspecialchars($psicologo['id_administrativo']) ?>">
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

    <script src="script/bootstrap.bundle.min.js"></script>
    <script src="script/sidebarandheader.js"></script>
    <script src="script/listado_psicologo.js"></script>
    <script src="script/sweetalert2.min.js"></script>
</body>

</html>