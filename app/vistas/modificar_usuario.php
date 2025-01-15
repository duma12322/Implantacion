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

    if (empty($nombre1) || empty($apellido1) || empty($sexo) || empty($fecha_nac) || empty($num_doc) || empty($telefono)) {
        $error = "Por favor, completa todos los campos obligatorios.";
    } else {
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/modificar_paciente.css">
</head>

<body>
    <div class="container">
        <h1>Modificar Datos del Paciente</h1>
        <?php if (isset($error)) : ?>
            <p class="error"><?= $error ?></p>
        <?php endif; ?>

        <form method="POST" action="">
            <label for="nombre1">Primer Nombre:</label>
            <input type="text" id="nombre1" name="nombre1" value="<?= htmlspecialchars($usuario['nombre1']) ?>" required>

            <label for="nombre2">Segundo Nombre:</label>
            <input type="text" id="nombre2" name="nombre2" value="<?= htmlspecialchars($usuario['nombre2']) ?>">

            <label for="apellido1">Primer Apellido:</label>
            <input type="text" id="apellido1" name="apellido1" value="<?= htmlspecialchars($usuario['apellido1']) ?>" required>

            <label for="apellido2">Segundo Apellido:</label>
            <input type="text" id="apellido2" name="apellido2" value="<?= htmlspecialchars($usuario['apellido2']) ?>">

            <label for="sexo">Sexo:</label>
            <select id="sexo" name="sexo" required>
                <option value="Masculino" <?= $usuario['sexo'] === 'Masculino' ? 'selected' : '' ?>>Masculino</option>
                <option value="Femenino" <?= $usuario['sexo'] === 'Femenino' ? 'selected' : '' ?>>Femenino</option>
            </select>

            <label for="fecha_nac">Fecha de Nacimiento:</label>
            <input type="date" id="fecha_nac" name="fecha_nac" value="<?= htmlspecialchars($usuario['fecha_nac']) ?>" required>

            <label for="num_doc">Número de Documento:</label>
            <input type="text" id="num_doc" name="num_doc" value="<?= htmlspecialchars($usuario['num_doc']) ?>" required>

            <label for="telefono">Teléfono:</label>
            <input type="text" id="telefono" name="telefono" value="<?= htmlspecialchars($usuario['telefono']) ?>" required>

            <button type="submit">Guardar Cambios</button>
        </form>

        <a href="listado_pacientes.php" class="back-link">Volver al listado</a>
    </div>

    <!-- Vincula el archivo JS -->
    <script src="script.js"></script>
</body>

</html>