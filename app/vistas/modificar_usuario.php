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
    $direccion = htmlspecialchars($_POST['direccion']);
    $estado = htmlspecialchars($_POST['estado']);
    $ciudad = htmlspecialchars($_POST['ciudad']);

    if (empty($nombre1) || empty($apellido1) || empty($sexo) || empty($fecha_nac) || empty($num_doc) || empty($telefono) || empty($direccion) || empty($estado) || empty($ciudad)) {
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
            'direccion' => $direccion,
            'id_estado' => $id_estado,
            'id_ciudad' => $ciudad,
            'id_municipio' => $id_municipio,
            'id_parroquia' => $id_parroquia,
            'descripcion' => $descripcion
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
    <meta charset="utf-8">
    <title>Editar Paciente</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/modificar.css">
</head>

<body>
    <div class="container-xl px-4 mt-4">

        <nav class="nav nav-borders">
            <a class="nav-link" href="listado_pacientes.php">Volver al listado</a>
        </nav>
        <hr class="mt-0 mb-4">
        <div class="row">
            <div class="col-xl-4">
                <!-- Profile picture card -->
                <div class="card mb-4 mb-xl-0">
                    <div class="card-header">Foto de Perfil</div>
                    <div class="card-body text-center">
                        <!-- Profile picture image -->
                        <img class="img-account-profile rounded-circle mb-2" src="http://bootdey.com/img/Content/avatar/avatar1.png" alt="Avatar">
                        <!-- Profile picture help block -->
                        <div class="small font-italic text-muted mb-4">JPG o PNG no mayor a 5 MB</div>
                        <!-- Profile picture upload button -->
                        <button class="btn btn-primary" type="button">Subir nueva imagen</button>
                    </div>
                </div>
            </div>
            <div class="col-xl-8">
                <!-- Formulario de edición -->
                <div class="card mb-4">
                    <div class="card-header">Detalles de la cuenta</div>
                    <div class="card-body">
                        <?php if (isset($error)): ?>
                            <div class="alert alert-danger"><?= $error ?></div>
                        <?php endif; ?>
                        <form method="POST" action="">
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1" for="nombre1">Primer Nombre</label>
                                    <input class="form-control" id="nombre1" name="nombre1" type="text" value="<?= htmlspecialchars( $usuario['nombre1']) ?>" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="small mb-1" for="nombre2">Segundo Nombre</label>
                                    <input class="form-control" id="nombre2" name="nombre2" type="text" value="<?= htmlspecialchars( $usuario['nombre2']) ?>">
                                </div>
                            </div>
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1" for="apellido1">Primer Apellido</label>
                                    <input class="form-control" id="apellido1" name="apellido1" type="text" value="<?= htmlspecialchars( $usuario['apellido1']) ?>" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="small mb-1" for="apellido2">Segundo Apellido</label>
                                    <input class="form-control" id="apellido2" name="apellido2" type="text" value="<?= htmlspecialchars($usuario['apellido2']) ?>">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="small mb-1" for="sexo">Sexo</label>
                                <select class="form-control" id="sexo" name="sexo" required>
                                    <option value="Masculino" <?= $usuario['sexo'] === 'Masculino' ? 'selected' : '' ?>>Masculino</option>
                                    <option value="Femenino" <?= $usuario['sexo'] === 'Femenino' ? 'selected' : '' ?>>Femenino</option>
                                </select>
                            </div>
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1" for="fecha_nac">Fecha de Nacimiento</label>
                                    <input class="form-control" id="fecha_nac" name="fecha_nac" type="date" value="<?= htmlspecialchars($usuario['fecha_nac']) ?>" required>
                                </div>
                                <div class="mb-3">
                                <label class="small mb-1" for="tipo_doc">Tipo de Documento</label>
                                <select class="form-control" id="tipo_doc" name="tipo_doc" required>
                                    <option value="V" <?= $usuario['tipo_doc'] === 'V' ? 'selected' : '' ?>>V</option>
                                    <option value="E" <?= $usuario['tipo_doc'] === 'E' ? 'selected' : '' ?>>E</option>
                                    <option value="J" <?= $usuario['tipo_doc'] === 'J' ? 'selected' : '' ?>>J</option>
                                    <option value="P" <?= $usuario['tipo_doc'] === 'P' ? 'selected' : '' ?>>P</option>
                                </select>
                            </div>
                                <div class="col-md-6">
                                    <label class="small mb-1" for="num_doc">Número de Documento</label>
                                    <input class="form-control" id="num_doc" name="num_doc" type="text" value="<?= htmlspecialchars($usuario['num_doc']) ?>" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="small mb-1" for="telefono">Teléfono</label>
                                <input class="form-control" id="telefono" name="telefono" type="text" value="<?= htmlspecialchars($usuario['telefono']) ?>" required>
                            </div>
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1" for="correo">Correo Electrónico</label>
                                    <input class="form-control" id="correo" name="correo" type="email" value="<?= htmlspecialchars($usuario['correo']) ?>" required>
                                </div>
                               <!-- Dirección -->
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1" for="id_estado">Estado</label>
                                    <select class="form-select" id="estado" name="id_estado" required>
                        <option value="" disabled selected>Seleccione el estado</option>
                        
                        <!-- Opciones dinámicas -->
                    </select>       
                  </div>
                  <div class="col-md-6 mb-3">
                    <label for="ciudad" class="form-label">Ciudad</label>
                    <select class="form-select" id="ciudad" name="id_ciudad" required>
                        <option value="" disabled selected>Seleccione la ciudad</option>
                        <!-- Opciones dinámicas -->
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="municipio" class="form-label">Municipio</label>
                    <select class="form-select" id="municipio" name="id_municipio" required>
                        <option value="" disabled selected>Seleccione el municipio</option>
                        <!-- Opciones dinámicas -->
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="parroquia" class="form-label">Parroquia</label>
                    <select class="form-select" id="parroquia" name="id_parroquia" required>
                        <option value="" disabled selected>Seleccione la parroquia</option>
                        <!-- Opciones dinámicas -->
                    </select>
                </div>

            <div class="col-md-6">
                <label for="otro" class="form-label">Descripción de Ubicación</label>
                <input type="text" class="form-control" id="otro" name="otro"></textarea>
            </div>
                            </div>
                            <button class="btn btn-primary" type="submit">Guardar Cambios</button>
                        </form>
                    </div>
                </div>
            </div>

        </div>
    </div>
</body>
<script src="script/registro.js"></script>
</html>