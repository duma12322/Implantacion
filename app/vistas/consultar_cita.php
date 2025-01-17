<?php include_once('../controladores/validar_consultar_cita.php'); ?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultar Citas</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/consultar_cita.css">
    <link rel="stylesheet" href="css/sidebarandheader.css">
</head>

<body>
    <!-- Header -->
    <?php include 'includes/header.php'; ?>
    <!-- Sidebar -->
    <?php include 'includes/sidebar.php'; ?>

    <h1>Consultar Citas</h1>

    <!-- Barra de búsqueda -->
    <form method="GET" action="../controladores/validar_consultar_cita.php" class="search-bar">
        <input type="text" name="search" placeholder="Buscar psicólogo o paciente..." value="<?= htmlspecialchars($_GET['search'] ?? '') ?>">
        <button type="submit">Buscar</button>
    </form>

    <!-- Filtros -->
    <form method="GET" action="consultar_cita.php">
        <label for="status">Estado:</label>
        <select name="status" id="status">
            <option value="">Todos</option>
            <option value="Pendiente" <?= ($_GET['status'] ?? '') === 'Pendiente' ? 'selected' : '' ?>>Pendiente</option>
            <option value="Confirmada" <?= ($_GET['status'] ?? '') === 'Confirmada' ? 'selected' : '' ?>>Confirmada</option>
            <option value="Completada" <?= ($_GET['status'] ?? '') === 'Completada' ? 'selected' : '' ?>>Completada</option>
            <option value="Cancelada" <?= ($_GET['status'] ?? '') === 'Cancelada' ? 'selected' : '' ?>>Cancelada</option>
            <option value="Reprogramada" <?= ($_GET['status'] ?? '') === 'Reprogramada' ? 'selected' : '' ?>>Reprogramada</option>
        </select>

        <label for="fecha_inicio">Fecha Inicio:</label>
        <input type="date" name="fecha_inicio" id="fecha_inicio" value="<?= htmlspecialchars($_GET['fecha_inicio'] ?? '') ?>">

        <label for="fecha_fin">Fecha Fin:</label>
        <input type="date" name="fecha_fin" id="fecha_fin" value="<?= htmlspecialchars($_GET['fecha_fin'] ?? '') ?>">

        <button type="submit">Filtrar</button>
    </form>

    <!-- Resultados -->
    <table>
        <thead>
            <tr>
                <th>ID Cita</th>
                <th>Fecha</th>
                <th>Hora Inicio</th>
                <th>Hora Final</th>
                <th>Paciente</th>
                <th>Psicólogo</th>
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
                        <td><?= htmlspecialchars($row['id_cita']) ?></td>
                        <td><?= htmlspecialchars($row['fecha']) ?></td>
                        <td><?= htmlspecialchars($row['hora_inicio']) ?></td>
                        <td><?= htmlspecialchars($row['hora_final']) ?></td>
                        <td><?= htmlspecialchars($row['nombre_paciente'] . ' ' . $row['apellido_paciente']) ?></td>
                        <td><?= htmlspecialchars($row['nombre_psicologo'] . ' ' . $row['apellido_psicologo']) ?></td>
                        <td><?= htmlspecialchars($row['motivo']) ?></td>
                        <td><?= htmlspecialchars($row['tipo_cita']) ?></td>
                        <td><?= htmlspecialchars($row['modalidad']) ?></td>
                        <td><?= htmlspecialchars($row['tipo_pago']) . ' - $' . number_format($row['monto'], 2) ?></td>
                        <td>
                            <form method="POST" action="consultar_cita.php">
                                <select name="status" class="status-dropdown">
                                    <option value="Pendiente" <?= $row['status'] === 'Pendiente' ? 'selected' : '' ?>>Pendiente</option>
                                    <option value="Confirmada" <?= $row['status'] === 'Confirmada' ? 'selected' : '' ?>>Confirmada</option>
                                    <option value="Completada" <?= $row['status'] === 'Completada' ? 'selected' : '' ?>>Completada</option>
                                    <option value="Cancelada" <?= $row['status'] === 'Cancelada' ? 'selected' : '' ?>>Cancelada</option>
                                    <option value="Reprogramada" <?= $row['status'] === 'Reprogramada' ? 'selected' : '' ?>>Reprogramada</option>
                                </select>
                                <input type="hidden" name="id_agenda" value="<?= $row['id_agenda'] ?>">
                                <button type="submit" name="update_status" class="save-button">Guardar</button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr>
                    <td colspan="11">No se encontraron citas con los filtros seleccionados.</td>
                </tr>
            <?php endif; ?>
        </tbody>
    </table>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Script -->
    <script src="script/sidebarandheader.js"></script>
</body>

</html>