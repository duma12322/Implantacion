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
    // Destruye la sesión y redirige al login
    session_unset();
    session_destroy();
    header("Location: login_psicologo_admin.php");
    exit;
}

$nombreUsuario = $_SESSION['usuario'];
// Inicializar el controlador y obtener usuarios
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

    echo "Psicologo eliminado correctamente";
        // Redirigir después de la eliminación
        header('Location: /Implantacion/app/vistas/listado_psicologos.php');
        exit();
    }

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Psicologos</title>
    <style>
        .main-content {
            margin-left: 250px; /* Ajusta según el ancho de tu menú lateral */
            padding: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #f4f4f4;
        }

        .search-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .search-bar input[type="text"] {
            width: 70%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .search-bar button {
            padding: 8px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .search-bar button:hover {
            background-color: #0056b3;
        }

        .actions {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .btn-delete {
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-delete:hover {
            background-color: #c82333;
        }

        .btn-modificar {
            background-color: #28a745;
            color: #fff;
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 5px;
            display: inline-block;
        }

        .btn-modificar:hover {
            background-color: #218838;
        }

        .btn-registrar {
            display: inline-block;
            margin: 20px 0;
            padding: 10px 20px;
            background-color: #ffc107;
            color: #000;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
        }

        .btn-registrar:hover {
            background-color: #e0a800;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
    </style>
</head>
<body>

<div class="main-container">
    <div class="main-content">
        <h1>Listado de Psicólogos</h1>

        <!-- Formulario de búsqueda -->
        <div class="search-bar">
            <form method="POST">
                <input type="text" name="search" placeholder="Buscar por nombre o documento" value="<?= htmlspecialchars($searchTerm) ?>">
                <button type="submit">Buscar</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Primer Nombre</th>
                    <th>Segundo Nombre</th>
                    <th>Primer Apellido</th>
                    <th>Segundo Apellido</th>
                    <th>Fecha de Nacimiento</th>
                    <th>Número de Documento</th>
                    <th>Teléfono</th>
                    <th>Acciones</th> <!-- Columna para los botones de acción -->
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($psicologos)) : ?>
                    <?php foreach ($psicologos as $psicologo) : ?>
                        <tr>
                            <td><?= htmlspecialchars($psicologo['id_administrativo']) ?></td>
                            <td><?= htmlspecialchars($psicologo['Nombre1']) ?></td>
                            <td><?= htmlspecialchars($psicologo['Nombre2']) ?></td>
                            <td><?= htmlspecialchars($psicologo['Apellido1']) ?></td>
                            <td><?= htmlspecialchars($psicologo['Apellido2']) ?></td>
                            <td><?= htmlspecialchars($psicologo['Fecha_Nac']) ?></td>
                            <td><?= htmlspecialchars($psicologo['num_doc']) ?></td>
                            <td><?= htmlspecialchars($psicologo['telefono']) ?></td>
                            <td class="action-buttons">
                                <!-- Botón para eliminar -->
                                <form method="POST" action="#">
                                    <input type="hidden" name="id_administrativo" value="<?= htmlspecialchars($psicologo['id_administrativo']) ?>">
                                    <button type="submit" class="btn-delete">Eliminar</button>
                                </form>

                                <!-- Botón para modificar -->
                                <a href="modificar_psicologo.php?id_administrativo=<?= htmlspecialchars($psicologo['id_administrativo']) ?>" class="btn-modificar">Modificar</a>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                <?php else : ?>
                    <tr>
                        <td colspan="9">No hay usuarios registrados.</td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>

        <!-- Botón para redirigir al registro -->
        <a href="#" class="btn-registrar">
            <button type="button">Registrar nuevo Psicólogo</button>
        </a>
    </div>
</div>

</body>
</html>