<?php
session_start();

// Incluir el archivo controlador
include_once('../controladores/validar_consultar_cita.php');

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

// Mostrar la Foto
$stmt = $conn->prepare("SELECT foto FROM usuario WHERE usuario = :usuario");
$stmt->execute([':usuario' => $nombreUsuario]);
$usuario = $stmt->fetch(PDO::FETCH_ASSOC);

// Mostrar la Foto
$stmt = $conn->prepare("SELECT foto FROM administrativo  WHERE usuario = :usuario");
$stmt->execute([':usuario' => $nombreUsuario]);
$usuario = $stmt->fetch(PDO::FETCH_ASSOC);


?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultar Citas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/consultar_cita.css">
    <link rel="stylesheet" href="css/sidebarandheader.css">
</head>

<body>
    <!-- Header -->
    <?php include 'includes/header.php'; ?>

    <!-- Sidebar -->
    <?php include 'includes/sidebar.php'; ?>

    <div class="container mt-5">
        <h1 class="text-center mb-4">Consultar Citas</h1>

        <!-- Barra de búsqueda -->
        <form method="GET" action="consultar_cita.php" class="d-flex justify-content-between mb-4">
            <input type="text" name="search" class="form-control me-2" placeholder="Buscar psicólogo o paciente..." value="<?= htmlspecialchars($_GET['search'] ?? '') ?>">
            <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Buscar</button>
        </form>

        <!-- Filtros -->
        <form method="GET" action="consultar_cita.php" class="mb-4">
            <div class="row">
                <div class="col">
                    <label for="status">Estado:</label>
                    <select name="status" id="status" class="form-select">
                        <option value="">Todos</option>
                        <option value="Pendiente" <?= ($_GET['status'] ?? '') === 'Pendiente' ? 'selected' : '' ?>>Pendiente</option>
                        <option value="Confirmada" <?= ($_GET['status'] ?? '') === 'Confirmada' ? 'selected' : '' ?>>Confirmada</option>
                        <option value="Completada" <?= ($_GET['status'] ?? '') === 'Completada' ? 'selected' : '' ?>>Completada</option>
                        <option value="Cancelada" <?= ($_GET['status'] ?? '') === 'Cancelada' ? 'selected' : '' ?>>Cancelada</option>
                        <option value="Reprogramada" <?= ($_GET['status'] ?? '') === 'Reprogramada' ? 'selected' : '' ?>>Reprogramada</option>
                    </select>
                </div>
                <div class="col">
                    <label for="fecha_inicio">Fecha Inicio:</label>
                    <input type="date" name="fecha_inicio" id="fecha_inicio" class="form-control" value="<?= htmlspecialchars($_GET['fecha_inicio'] ?? '') ?>">
                </div>
                <div class="col">
                    <label for="fecha_fin">Fecha Fin:</label>
                    <input type="date" name="fecha_fin" id="fecha_fin" class="form-control" value="<?= htmlspecialchars($_GET['fecha_fin'] ?? '') ?>">
                </div>
            </div>
            <button type="submit" class="btn btn-success mt-3">Filtrar</button>
        </form>

        <!-- Tabla de citas -->
        <table class="table table-striped table-hover">
            <thead class="table-primary">
                <tr>
                    <th>Paciente</th>
                    <th>Psicólogo</th>
                    <th>Fecha</th>
                    <th>Hora Inicio</th>
                    <th>Hora Final</th>
                    <th>Motivo</th>
                    <th>Tipo de Cita</th>
                    <th>Modalidad</th>
                    <th>Pago</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($result)): ?>
                    <?php foreach ($result as $row): ?>
                        <tr>
                            <td><?= htmlspecialchars($row['nombre_paciente'] . ' ' . $row['apellido_paciente']) ?></td>
                            <td><?= htmlspecialchars($row['nombre_psicologo'] . ' ' . $row['apellido_psicologo']) ?></td>
                            <td><?= htmlspecialchars($row['fecha']) ?></td>
                            <td><?= htmlspecialchars($row['hora_inicio']) ?></td>
                            <td><?= htmlspecialchars($row['hora_final']) ?></td>
                            <td><?= htmlspecialchars($row['motivo']) ?></td>
                            <td><?= htmlspecialchars($row['tipo_cita']) ?></td>
                            <td><?= htmlspecialchars($row['modalidad']) ?></td>
                            <td><?= htmlspecialchars($row['tipo_pago']) . ' - $' . number_format($row['monto'], 2) ?></td>
                            <td>
                                <form method="POST" action="consultar_cita.php">
                                    <select name="status" class="form-select">
                                        <option value="Pendiente" <?= $row['status'] === 'Pendiente' ? 'selected' : '' ?>>Pendiente</option>
                                        <option value="Confirmada" <?= $row['status'] === 'Confirmada' ? 'selected' : '' ?>>Confirmada</option>
                                        <option value="Completada" <?= $row['status'] === 'Completada' ? 'selected' : '' ?>>Completada</option>
                                        <option value="Cancelada" <?= $row['status'] === 'Cancelada' ? 'selected' : '' ?>>Cancelada</option>
                                        <option value="Reprogramada" <?= $row['status'] === 'Reprogramada' ? 'selected' : '' ?>>Reprogramada</option>
                                    </select>
                                    <input type="hidden" name="id_agenda" value="<?= $row['id_agenda'] ?>">
                                    <button type="submit" name="update_status" class="btn btn-primary mt-2">Guardar</button>
                                </form>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                <?php else: ?>
                    <tr>
                        <td colspan="11" class="text-center text-muted">No se encontraron citas con los filtros seleccionados.</td>
                    </tr>
                <?php endif; ?>
            </tbody>

            <!-- Paginación -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item <?= ($page == 1) ? 'disabled' : '' ?>">
                        <a class="page-link" href="?page=<?= $page - 1 ?>">Anterior</a>
                    </li>
                    <?php for ($i = 1; $i <= $total_pages; $i++): ?>
                        <li class="page-item <?= ($i == $page) ? 'active' : '' ?>">
                            <a class="page-link" href="?page=<?= $i ?>"><?= $i ?></a>
                        </li>
                    <?php endfor; ?>
                    <li class="page-item <?= ($page == $total_pages) ? 'disabled' : '' ?>">
                        <a class="page-link" href="?page=<?= $page + 1 ?>">Siguiente</a>
                    </li>
                </ul>
            </nav>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>