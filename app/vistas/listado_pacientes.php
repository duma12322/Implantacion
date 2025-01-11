<?php
require_once __DIR__ . '/../controladores/listado_PacienteControlador.php';

use app\controladores\listado_PacienteControlador;

// Inicializar el controlador y obtener usuarios
$controller = new listado_PacienteControlador();
$usuarios = $controller->obtenerUsuarios();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado Pacientes</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
    <h1>Listado Pacientes</h1>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Primer Nombre</th>
                <th>Segundo Nombre</th>
                <th>Primer Apellido</th>
                <th>Segundo Apellido</th>
                <th>Sexo</th>
                <th>Fecha de Nacimiento</th>
                <th>Número de Documento</th>
                <th>Teléfono</th>
                <th>Foto</th>
            </tr>
        </thead>
        <tbody>
            <?php if (!empty($usuarios)) : ?>
                <?php foreach ($usuarios as $usuario) : ?>
                    <tr>
                        <td><?= htmlspecialchars($usuario['id_usuario']) ?></td>
                        <td><?= htmlspecialchars($usuario['Nombre1']) ?></td>
                        <td><?= htmlspecialchars($usuario['Nombre2']) ?></td>
                        <td><?= htmlspecialchars($usuario['Apellido1']) ?></td>
                        <td><?= htmlspecialchars($usuario['Apellido2']) ?></td>
                        <td><?= htmlspecialchars($usuario['sexo']) ?></td>
                        <td><?= htmlspecialchars($usuario['Fecha_Nac']) ?></td>
                        <td><?= htmlspecialchars($usuario['num_doc']) ?></td>
                        <td><?= htmlspecialchars($usuario['Telefono']) ?></td>
                        <td>
                            <?php if ($usuario['foto']) : ?>
                                <img src="data:image/jpeg;base64,<?= base64_encode($usuario['foto']) ?>" alt="foto" width="50" height="50" />
                            <?php else : ?>
                                No disponible
                            <?php endif; ?>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php else : ?>
                <tr>
                    <td colspan="10">No hay usuarios registrados.</td>
                </tr>
            <?php endif; ?>
        </tbody>
    </table>
</body>
</html>
