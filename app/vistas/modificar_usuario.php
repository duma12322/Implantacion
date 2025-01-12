<?php
require_once __DIR__ . '/../controladores/listado_PacienteControlador.php';
require_once __DIR__ . '/../modelos/principalModelo.php';

use app\controladores\listado_PacienteControlador;

if (!isset($_GET['id_usuario']) || empty($_GET['id_usuario'])) {
    echo "ID de usuario no válido.";
    exit;
}

$id_usuario = htmlspecialchars($_GET['id_usuario']);

// Crear una instancia del controlador
$controller = new listado_PacienteControlador();

// Obtener los datos actuales del usuario
$usuario = $controller->obtenerUsuarioPorId($id_usuario);

if (!$usuario) {
    echo "Usuario no encontrado.";
    exit;
}

// Procesar el formulario de actualización
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nombre1 = htmlspecialchars($_POST['nombre1']);
    $nombre2 = htmlspecialchars($_POST['nombre2']);
    $apellido1 = htmlspecialchars($_POST['apellido1']);
    $apellido2 = htmlspecialchars($_POST['apellido2']);
    $sexo = htmlspecialchars($_POST['sexo']);
    $fecha_nac = htmlspecialchars($_POST['fecha_nac']);
    $num_doc = htmlspecialchars($_POST['num_doc']);
    $telefono = htmlspecialchars($_POST['telefono']);

    if (empty($nombre1)  || empty($apellido1)  ||  empty($sexo) || empty($fecha_nac) ||  empty($num_doc) || empty($telefono)) {
        $error = "Por favor, completa todos los campos obligatorios.";
    } else {
        // Corregir aquí las variables
        $resultado = $controller->actualizarUsuario($id_usuario, [
            'nombre1' => $nombre1,
            'nombre2' => $nombre2,
            'apellido1' => $apellido1,
            'apellido2' => $apellido2,
            'sexo' => $sexo,
            'fecha_nac' => $fecha_nac,
            'num_doc' => $num_doc,
            'telefono' => $telefono,
        ]);

        if ($resultado) {
            header("Location: listado_pacientes.php?mensaje=Usuario actualizado exitosamente");
            exit;
        } else {
            $error = "Ocurrió un error al actualizar el usuario.";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modificar Paciente</title>

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

        .sidebar {
            width: 250px;
            background-color: #343a40;
            color: #fff;
            padding: 20px;
            height: 100vh;
        }

        .main-content {
            flex: 1;
            padding: 20px;
            margin-left: 250px;
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

        form input,
        form select {
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
    <h1>Modificar Datos del Paciente</h1>
    <?php if (isset($error)) : ?>
        <p style="color: red;"><?= $error ?></p>
    <?php endif; ?>
    <form method="POST" action="">
    <label for="nombre1">Primer Nombre:</label>
    <input type="text" id="nombre1" name="nombre1" value="<?= htmlspecialchars($usuario['nombre1']) ?>" required><br>

    <label for="nombre2">Segundo Nombre:</label>
    <input type="text" id="nombre2" name="nombre2" value="<?= htmlspecialchars($usuario['nombre2']) ?>" ><br>

    <label for="apellido1">Primer Apellido:</label>
    <input type="text" id="apellido1" name="apellido1" value="<?= htmlspecialchars($usuario['apellido1']) ?>" required><br>

    <label for="apellido2">Segundo Apellido:</label>
    <input type="text" id="apellido2" name="apellido2" value="<?= htmlspecialchars($usuario['apellido2']) ?>" ><br>

    <label for="sexo">Sexo:</label>
        <select id="sexo" name="sexo" required>
            <option value="Masculino" <?= $usuario['sexo'] === 'Masculino' ? 'selected' : '' ?>>Masculino</option>
            <option value="Femenino" <?= $usuario['sexo'] === 'Femenino' ? 'selected' : '' ?>>Femenino</option>
        </select><br>

    <label for="fecha_nac">Fecha de Nacimiento:</label>
    <input type="date" id="fecha_nac" name="fecha_nac" value="<?= htmlspecialchars($usuario['fecha_nac']) ?>" required><br>

    <label for="num_doc">Número de Documento:</label>
    <input type="text" id="num_doc" name="num_doc" value="<?= htmlspecialchars($usuario['num_doc']) ?>" required><br>

    <label for="telefono">Teléfono:</label>
    <input type="text" id="telefono" name="telefono" value="<?= htmlspecialchars($usuario['telefono']) ?>" required><br>
    <button type="submit">Guardar Cambios</button>
</form>
    <a href="listado_pacientes.php">Volver al listado</a>
</body>
</html>