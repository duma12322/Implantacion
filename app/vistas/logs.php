<?php
session_start();
include '../../config/conexion.php';

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

// Mostrar la Foto
$stmt = $conn->prepare("SELECT foto FROM administrativo WHERE usuario = :usuario");
$stmt->execute([':usuario' => $nombreUsuario]);
$usuario = $stmt->fetch(PDO::FETCH_ASSOC);

// Filtro por usuario si se envía desde el formulario
$usuario_filtro = isset($_GET['usuario']) ? $_GET['usuario'] : '';

$query = "SELECT * FROM logs";
if (!empty($usuario_filtro)) {
    $query .= " WHERE usuario LIKE :usuario";
}
$query .= " ORDER BY fecha DESC";

$stmt = $conn->prepare($query);

// Si hay un filtro, lo vinculamos
if (!empty($usuario_filtro)) {
    $usuario_filtro = "%$usuario_filtro%";
    $stmt->bindParam(':usuario', $usuario_filtro, PDO::PARAM_STR);
}

$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bitácora de Acciones</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/logs.css">
    <link rel="stylesheet" href="css/sidebarandheader.css">
</head>

<body>
    <div class="container mt-5">
        <nav class="nav nav-borders">
            <a class="nav-link" href="dashboard.php">Volver al listado</a>
        </nav>
        <hr>
        <h1 class="text-center mb-4">Bitacora de acciones</h1>
        <form method="GET">
            <input type="text" name="usuario" placeholder="Filtrar por usuario" value="<?= htmlspecialchars($_GET['usuario'] ?? '') ?>">
            <button type="submit">Buscar</button>
            <a href="logs.php"><button type="button">Limpiar</button></a>
        </form>

        <table>
            <tr>
                <th>ID</th>
                <th>Usuario</th>
                <th>Acción</th>
                <th>Fecha</th>
            </tr>
            <?php foreach ($result as $row) : ?>
                <tr>
                    <td><?= $row['id'] ?></td>
                    <td><?= htmlspecialchars($row['usuario']) ?></td>
                    <td><?= htmlspecialchars($row['accion']) ?></td>
                    <td><?= $row['fecha'] ?></td>
                </tr>
            <?php endforeach; ?>
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