<?php
include '../../config/conexion.php'; // Ajusta la ruta si es necesario

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
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th,
        td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        input[type="text"],
        button {
            padding: 8px;
            margin-top: 5px;
        }

        .container {
            width: 80%;
            margin: auto;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>Bitácora de Acciones</h2>
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
</body>

</html>