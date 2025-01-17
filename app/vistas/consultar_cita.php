<?php
session_start();

if (!isset($_SESSION['id_usuario'])) {
    header("Location: login_paciente.php");
    exit;
}

include_once('../../config/conexion.php');

// Procesar filtros si se envían
$where_clauses = [];
$params = [];

// Filtro por estado
if (!empty($_GET['status'])) {
    $where_clauses[] = "a.status = :status";
    $params[':status'] = $_GET['status'];
}

// Filtro por paciente
if (!empty($_GET['id_paciente'])) {
    $where_clauses[] = "a.id_paciente = :id_paciente";
    $params[':id_paciente'] = $_GET['id_paciente'];
}

// Filtro por psicólogo
if (!empty($_GET['id_psicologo'])) {
    $where_clauses[] = "c.id_psicologo = :id_psicologo";
    $params[':id_psicologo'] = $_GET['id_psicologo'];
}

// Filtro por rango de fechas
if (!empty($_GET['fecha_inicio']) && !empty($_GET['fecha_fin'])) {
    $where_clauses[] = "a.fecha BETWEEN :fecha_inicio AND :fecha_fin";
    $params[':fecha_inicio'] = $_GET['fecha_inicio'];
    $params[':fecha_fin'] = $_GET['fecha_fin'];
}

// Construir consulta
$query = "
    SELECT 
        a.id_agenda, 
        a.fecha, 
        a.hora_inicio, 
        a.hora_final, 
        a.status, 
        c.id_cita, 
        c.motivo, 
        c.fecha AS fecha_cita, 
        u.nombre1 AS nombre_paciente, 
        u.apellido1 AS apellido_paciente, 
        adm.nombre1 AS nombre_psicologo, 
        adm.apellido1 AS apellido_psicologo, 
        pc.tipo_pago, 
        pc.monto, 
        pc.referencia_bancaria, 
        t.tipo_cita, 
        t.modalidad 
    FROM agenda a
    JOIN cita c ON a.id_agenda = c.id_agenda
    JOIN paciente p ON a.id_paciente = p.id_paciente
    JOIN usuario u ON p.id_usuario = u.id_usuario
    JOIN psicologo ps ON c.id_psicologo = ps.id_psicologo
    JOIN administrativo adm ON ps.id_administrativo = adm.id_administrativo
    JOIN pago_cita pc ON c.id_cita = pc.id_cita
    JOIN tipo_cita t ON c.id_tipo_cita = t.id_tipo_cita
";


if (!empty($where_clauses)) {
    $query .= " WHERE " . implode(" AND ", $where_clauses);
}

try {
    $stmt = $conn->prepare($query);

    foreach ($params as $key => $value) {
        $stmt->bindValue($key, $value);
    }

    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die("Error en la consulta: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultar Citas</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        table,
        th,
        td {
            border: 1px solid black;
        }

        th,
        td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>

<body>
    <h1>Consultar Citas</h1>

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

        <label for="id_paciente">Paciente:</label>
        <input type="text" name="id_paciente" id="id_paciente" value="<?= htmlspecialchars($_GET['id_paciente'] ?? '') ?>">

        <label for="id_psicologo">Psicólogo:</label>
        <input type="text" name="id_psicologo" id="id_psicologo" value="<?= htmlspecialchars($_GET['id_psicologo'] ?? '') ?>">

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
                <th>Acciones</th>
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
                        <td><?= htmlspecialchars($row['status']) ?></td>
                        <td>
                            <a href="editar_cita.php?id=<?= htmlspecialchars($row['id_cita']) ?>">Editar</a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr>
                    <td colspan="12">No se encontraron citas con los filtros seleccionados.</td>
                </tr>
            <?php endif; ?>
        </tbody>
    </table>
</body>

</html>