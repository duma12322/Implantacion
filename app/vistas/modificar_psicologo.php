<?php
require_once __DIR__ . '/../controladores/listado_PsicologosControlador.php';

use app\controladores\listado_PsicologosControlador;

if (!isset($_GET['id_administrativo']) || empty($_GET['id_administrativo'])) {
    echo "ID del psicólogo no válido.";
    exit;
}

$id_administrativo = htmlspecialchars($_GET['id_administrativo']);

// Crear una instancia del controlador
$controller = new listado_PsicologosControlador();

// Obtener los datos actuales del psicólogo
$psicologo = $controller->obtenerPsicologoPorId($id_administrativo);

if (!$psicologo) {
    echo "Psicólogo no encontrado.";
    exit;
}

// Procesar el formulario de actualización
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nombre1 = isset($_POST['Nombre1']) ? $_POST['Nombre1'] : '';
    $nombre2 = isset($_POST['Nombre2']) ? $_POST['Nombre2'] : '';
    $apellido1 = isset($_POST['Apellido1']) ? $_POST['Apellido1'] : '';
    $apellido2 = isset($_POST['Apellido2']) ? $_POST['Apellido2'] : '';
    $num_doc = isset($_POST['num_doc']) ? $_POST['num_doc'] : '';
    $fecha_nac = isset($_POST['Fecha_Nac']) ? $_POST['Fecha_Nac'] : '';
    $telefono = isset($_POST['telefono']) ? $_POST['telefono'] : '';

    if (empty($nombre1) || empty($apellido1) || empty($fecha_nac) || empty($num_doc) || empty($telefono)) {
        $error = "Por favor, completa todos los campos obligatorios.";
    } else {
        $resultado = $controller->actualizarPsicologo($id_administrativo, [
            'Nombre1' => $nombre1,
            'Nombre2' => $nombre2,
            'Apellido1' => $apellido1,
            'Apellido2' => $apellido2,
            'num_doc' => $num_doc,
            'Fecha_Nac' => $fecha_nac,
            'telefono' => $telefono,
        ]);

        if ($resultado) {
            header("Location: listado_Psicologos.php?mensaje=Usuario actualizado exitosamente");
            exit;
        } else {
            $error = "Ocurrió un error al actualizar el usuario.";
        }
    }
}

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modificar Psicólogo</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .main-container {
            display: flex;
        }

        .main-content {
            margin-left: 250px;
            padding: 20px;
        }

        h1 {
            color: #333;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }

        form label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        form input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        form button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        form button:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            font-size: 14px;
            margin-bottom: 15px;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="main-content">
        <h1>Modificar Datos del Psicólogo</h1>
        <form method="POST" action="">
            <label for="Nombre1">Primer Nombre:</label>
            <input type="text" id="Nombre1" name="Nombre1" value="<?= htmlspecialchars($psicologo['Nombre1']) ?>" required>

            <label for="Nombre2">Segundo Nombre:</label>
            <input type="text" id="Nombre2" name="Nombre2" value="<?= htmlspecialchars($psicologo['Nombre2']) ?>">

            <label for="Apellido1">Primer Apellido:</label>
            <input type="text" id="Apellido1" name="Apellido1" value="<?= htmlspecialchars($psicologo['Apellido1']) ?>" required>

            <label for="Apellido2">Segundo Apellido:</label>
            <input type="text" id="Apellido2" name="Apellido2" value="<?= htmlspecialchars($psicologo['Apellido2']) ?>">

            <label for="num_doc">Número de Documento:</label>
            <input type="text" id="num_doc" name="num_doc" value="<?= htmlspecialchars($psicologo['num_doc']) ?>" required>

            <label for="Fecha_Nac">Fecha de Nacimiento:</label>
            <input type="date" id="Fecha_Nac" name="Fecha_Nac" value="<?= htmlspecialchars($psicologo['Fecha_Nac']) ?>" required>

            <label for="telefono">Teléfono:</label>
            <input type="text" id="telefono" name="telefono" value="<?= htmlspecialchars($psicologo['telefono']) ?>" required>

            <button type="submit">Guardar Cambios</button>
        </form>
        <a href="listado_psicologos.php" class="back-link">Volver al listado</a>
    </div>
</body>
</html>
