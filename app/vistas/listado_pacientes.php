<?php
session_start();
require_once __DIR__ . '/../controladores/listado_PacienteControlador.php';


use app\controladores\listado_PacienteControlador;

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

$nombreUsuario = $_SESSION['usuario'];
// Inicializar el controlador y obtener usuarios
$controller = new listado_PacienteControlador();

// Mostrar la Foto
$stmt = $conn->prepare("SELECT foto FROM administrativo  WHERE usuario = :usuario");
$stmt->execute([':usuario' => $nombreUsuario]);
$usuario = $stmt->fetch(PDO::FETCH_ASSOC);

$searchTerm = '';
if (isset($_POST['search']) && !empty($_POST['search'])) {
    $searchTerm = $_POST['search'];
}

// Obtener usuarios con o sin filtro
if (!empty($searchTerm)) {
    $usuarios = $controller->obtenerUsuariosFiltrados($searchTerm);
} else {
    $usuarios = $controller->obtenerUsuarios();
}

if (isset($_POST['id_usuario'])) {
    $id_usuario = $_POST['id_usuario'];

    $controller = new listado_PacienteControlador();
    $controller->eliminarUsuario($id_usuario);
    echo "Usuario eliminado correctamente";
    // Redirigir después de la eliminación
    header('Location: /Implantacion/app/vistas/listado_pacientes.php');
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Pacientes</title>
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
        <h1 class="text-center mb-4">Listado de Pacientes</h1>

        <!-- Botones de acciones principales -->
        <div class="d-flex justify-content-between mb-3">
            <div>
                <a href="agregar_paciente.php" class="btn btn-primary me-2">
                    <i class="bi bi-person-fill-add"></i> Agregar Paciente
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

        <!-- Tabla de pacientes -->
        <table class="table table-striped table-hover table-wide" id="tablaPacientes">
            <thead class="table-primary">
                <tr>
                    <th>Primer Nombre</th>
                    <th>Segundo Nombre</th>
                    <th>Primer Apellido</th>
                    <th>Segundo Apellido</th>
                    <th>Sexo</th>
                    <th>Fecha de Nacimiento</th>
                    <th>Tipo de Documento</th>
                    <th>Número de Documento</th>
                    <th>Teléfono</th>
                    <th>Foto</th>
                    <th>Historial Medico</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($usuarios)) : ?>
                    <?php foreach ($usuarios as $usuario) : ?>
                        <tr onclick="selectRow(<?= htmlspecialchars($usuario['id_usuario']) ?>, this)">
                            <td><?= htmlspecialchars($usuario['nombre1']) ?></td>
                            <td><?= htmlspecialchars($usuario['nombre2']) ?></td>
                            <td><?= htmlspecialchars($usuario['apellido1']) ?></td>
                            <td><?= htmlspecialchars($usuario['apellido2']) ?></td>
                            <td><?= htmlspecialchars($usuario['sexo']) ?></td>
                            <td><?= htmlspecialchars($usuario['fecha_nac']) ?></td>
                            <td><?= htmlspecialchars($usuario['tipo_doc']) ?></td>
                            <td><?= htmlspecialchars($usuario['num_doc']) ?></td>
                            <td><?= htmlspecialchars($usuario['telefono']) ?></td>
                            <td>
                                <?php if ($usuario['foto']) : ?>
                                    <img src="data:image/jpeg;base64,<?= base64_encode($usuario['foto']) ?>" alt="Foto" class="img-thumbnail" width="50" height="50" />
                                <?php else : ?>
                                    <span class="text-muted">No disponible</span>
                                <?php endif; ?>
                            </td>
                            <td>
                                <a href="historial_medico.php?id_usuario=<?= htmlspecialchars($usuario['id_usuario']) ?>" class="btn btn-warning btn-sm">
                                    <i class="bi bi-plus"></i>
                                </a>
                                <a href="Modificar_historial_medico.php?id_usuario=<?= htmlspecialchars($usuario['id_usuario']) ?>" class="btn btn-warning btn-sm">
                                    <i class="bi bi-pen"></i>
                                </a>
                            </td>
                            <td>
                                <a href="modificar_usuario.php?id_usuario=<?= htmlspecialchars($usuario['id_usuario']) ?>" class="btn btn-warning btn-sm">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <form method="POST" class="d-inline deleteForm" id="deleteForm">
                                    <input type="hidden" name="id_usuario" value="<?= htmlspecialchars($usuario['id_usuario']) ?>" id="id_usuario_to_delete">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                <?php else : ?>
                    <tr>
                        <td colspan="12" class="text-center text-muted">No hay usuarios registrados.</td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Incluir SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- Incluir archivo JS -->
    <script src="script/sidebarandheader.js "></script>
    <script src="script/listado_psicologo.js"></script>
</body>

</html>
