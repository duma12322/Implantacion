<?php
session_start();
// Conexión a la base de datos
require_once '../../config/conexion.php';
include '../controladores/log.php';


if (!isset($_SESSION['usuario'])) {
    header("Location: login_psicologo.admin.php");
    exit;
}

if (isset($_POST['cerrar_sesion'])) {
    session_unset();
    session_destroy();
    header("Location: login_psicologo_admin.php");
    exit;
}


// Verificar si el ID de usuario está presente
if (!isset($_GET['id_usuario']) || empty($_GET['id_usuario'])) {
    echo "ID de usuario no válido.";
    exit;
}

$id_usuario = htmlspecialchars($_GET['id_usuario']);

// Obtener los datos del usuario
$query_usuario = "SELECT usuario, correo, contraseña, nombre1, nombre2, apellido1, apellido2, sexo, fecha_nac, num_doc, tipo_doc, foto, telefono FROM usuario WHERE id_usuario = :id_usuario";
$stmt_usuario = $conn->prepare($query_usuario);
$stmt_usuario->bindParam(':id_usuario', $id_usuario, PDO::PARAM_INT);
$stmt_usuario->execute();
$usuario = $stmt_usuario->fetch(PDO::FETCH_ASSOC);

if (!$usuario) {
    echo "Usuario no encontrado.";
    exit;
}

// Obtener los datos del paciente
$query_paciente = "SELECT id_direccion, num_hijos, discapacitado, descrip_disca FROM paciente WHERE id_usuario = :id_usuario";
$stmt_paciente = $conn->prepare($query_paciente);
$stmt_paciente->bindParam(':id_usuario', $id_usuario, PDO::PARAM_INT);
$stmt_paciente->execute();
$paciente = $stmt_paciente->fetch(PDO::FETCH_ASSOC);

if (!$paciente) {
    echo "Paciente no encontrado.";
    exit;
}

// Obtener los datos de la dirección del paciente
$query_direccion = "
    SELECT d.*, e.estado, c.ciudad, m.municipio, pr.parroquia
    FROM direccion d
    LEFT JOIN estados e ON d.id_estado = e.id_estado
    LEFT JOIN ciudades c ON d.id_ciudad = c.id_ciudad
    LEFT JOIN municipios m ON d.id_municipio = m.id_municipio
    LEFT JOIN parroquias pr ON d.id_parroquia = pr.id_parroquia
    WHERE d.id_direccion = :id_direccion";
$stmt_direccion = $conn->prepare($query_direccion);
$stmt_direccion->bindParam(':id_direccion', $paciente['id_direccion'], PDO::PARAM_INT);
$stmt_direccion->execute();
$direccion = $stmt_direccion->fetch(PDO::FETCH_ASSOC);

// Consultas para obtener los estados, ciudades, municipios y parroquias
$sql_estados = "SELECT * FROM estados";
$stmt_estados = $conn->prepare($sql_estados);
$stmt_estados->execute();
$estados = $stmt_estados->fetchAll(PDO::FETCH_ASSOC);

$sql_ciudades = "SELECT * FROM ciudades";
$stmt_ciudades = $conn->prepare($sql_ciudades);
$stmt_ciudades->execute();
$ciudades = $stmt_ciudades->fetchAll(PDO::FETCH_ASSOC);

$sql_municipios = "SELECT * FROM municipios";
$stmt_municipios = $conn->prepare($sql_municipios);
$stmt_municipios->execute();
$municipios = $stmt_municipios->fetchAll(PDO::FETCH_ASSOC);

$sql_parroquias = "SELECT * FROM parroquias";
$stmt_parroquias = $conn->prepare($sql_parroquias);
$stmt_parroquias->execute();
$parroquias = $stmt_parroquias->fetchAll(PDO::FETCH_ASSOC);

// Procesar el formulario de actualización
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Recoger los datos del formulario
    $usuario_nombre = htmlspecialchars($_POST['usuario']);
    $correo = htmlspecialchars($_POST['correo']);
    $contraseña = htmlspecialchars($_POST['contraseña']);
    $nombre1 = htmlspecialchars($_POST['nombre1']);
    $nombre2 = htmlspecialchars($_POST['nombre2']);
    $apellido1 = htmlspecialchars($_POST['apellido1']);
    $apellido2 = htmlspecialchars($_POST['apellido2']);
    $sexo = htmlspecialchars($_POST['sexo']);
    $fecha_nac = htmlspecialchars($_POST['fecha_nac']);
    $num_doc = htmlspecialchars($_POST['num_doc']);
    $tipo_doc = htmlspecialchars($_POST['tipo_doc']);
    $telefono = htmlspecialchars($_POST['telefono']);
    $estado = htmlspecialchars($_POST['estado']);
    $ciudad = htmlspecialchars($_POST['ciudad']);
    $municipio = htmlspecialchars($_POST['municipio']);
    $parroquia = htmlspecialchars($_POST['parroquia']);
    $descripcion = htmlspecialchars($_POST['descripcion']);
    $num_hijos = htmlspecialchars($_POST['num_hijos']);
    $discapacitado = htmlspecialchars($_POST['discapacitado']);
    $descrip_disca = htmlspecialchars($_POST['descrip_disca']);

    // Validar los campos obligatorios
    if (empty($nombre1) || empty($apellido1) || empty($sexo) || empty($fecha_nac) || empty($num_doc) || empty($tipo_doc) || empty($telefono) || empty($estado) || empty($ciudad)) {
        $error = "Por favor, completa todos los campos obligatorios.";
    } else {
        // Encriptar la contraseña
        $contraseña_encriptada = password_hash($contraseña, PASSWORD_DEFAULT);
        // Actualizar los datos del usuario
        $query_update_usuario = "
            UPDATE usuario 
            SET usuario = :usuario, correo = :correo, contraseña = :contrasena, nombre1 = :nombre1, nombre2 = :nombre2,
                apellido1 = :apellido1, apellido2 = :apellido2, sexo = :sexo, fecha_nac = :fecha_nac,
                num_doc = :num_doc, tipo_doc = :tipo_doc, telefono = :telefono
            WHERE id_usuario = :id_usuario";
        $stmt_update_usuario = $conn->prepare($query_update_usuario);
        $stmt_update_usuario->bindParam(':usuario', $usuario_nombre);
        $stmt_update_usuario->bindParam(':correo', $correo);
        $stmt_update_usuario->bindParam(':contrasena', $contrasena);
        $stmt_update_usuario->bindParam(':nombre1', $nombre1);
        $stmt_update_usuario->bindParam(':nombre2', $nombre2);
        $stmt_update_usuario->bindParam(':apellido1', $apellido1);
        $stmt_update_usuario->bindParam(':apellido2', $apellido2);
        $stmt_update_usuario->bindParam(':sexo', $sexo);
        $stmt_update_usuario->bindParam(':fecha_nac', $fecha_nac);
        $stmt_update_usuario->bindParam(':num_doc', $num_doc);
        $stmt_update_usuario->bindParam(':tipo_doc', $tipo_doc);
        $stmt_update_usuario->bindParam(':telefono', $telefono);
        $stmt_update_usuario->bindParam(':id_usuario', $id_usuario, PDO::PARAM_INT);
        $stmt_update_usuario->execute();

        // Actualizar los datos del paciente
        $query_update_paciente = "
            UPDATE paciente 
            SET num_hijos = :num_hijos, discapacitado = :discapacitado, descrip_disca = :descrip_disca
            WHERE id_usuario = :id_usuario";
        $stmt_update_paciente = $conn->prepare($query_update_paciente);
        $stmt_update_paciente->bindParam(':num_hijos', $num_hijos);
        $stmt_update_paciente->bindParam(':discapacitado', $discapacitado);
        $stmt_update_paciente->bindParam(':descrip_disca', $descrip_disca);
        $stmt_update_paciente->bindParam(':id_usuario', $id_usuario, PDO::PARAM_INT);
        $stmt_update_paciente->execute();

        // Actualizar los datos de la dirección
        $query_update_direccion = "
            UPDATE direccion
            SET id_estado = :estado, id_ciudad = :ciudad, id_municipio = :municipio, id_parroquia = :parroquia, descripcion = :descripcion
            WHERE id_direccion = :id_direccion";
        $stmt_update_direccion = $conn->prepare($query_update_direccion);
        $stmt_update_direccion->bindParam(':estado', $estado);
        $stmt_update_direccion->bindParam(':ciudad', $ciudad);
        $stmt_update_direccion->bindParam(':municipio', $municipio);
        $stmt_update_direccion->bindParam(':parroquia', $parroquia);
        $stmt_update_direccion->bindParam(':descripcion', $descripcion);
        $stmt_update_direccion->bindParam(':id_direccion', $paciente['id_direccion'], PDO::PARAM_INT);
        $stmt_update_direccion->execute();

        registrar_log($_SESSION['usuario'], "Actualizó los datos del psicólogo: $nombre1 $apellido1");
        // Redirigir si la actualización es exitosa
        header("Location: listado_pacientes.php?mensaje=Usuario actualizado exitosamente");
        exit;
    }
}
?>


<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Editar Paciente</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/perfil_usuario.css">
    <link rel="stylesheet" href="css/modificar.css">
</head>

<body>
    <div class="container-xl px-4 mt-4">
        <nav class="nav nav-borders"> <a class="nav-link" href="listado_pacientes.php">Volver al listado</a> </nav>
        <hr class="mt-0 mb-4">
        <form action="modificar_usuario.php?id_usuario=<?= $id_usuario ?>" method="POST" enctype="multipart/form-data">
            <div class="row">
                <div class="col-lg-4">
                    <div class="card mb-4 mb-lg-0">
                        <div class="card-header">Foto de Perfil</div>
                        <div class="card-body text-center"> <?php if (!empty($usuario['foto'])): ?> <img src="data:image/jpeg;base64,<?php echo base64_encode($usuario['foto']); ?>" class="avatar img-circle img-thumbnail" alt="avatar"> <?php else: ?> <div class="avatar default-avatar">A</div> <?php endif; ?> <h6>Cambiar foto</h6> <input type="file" name="foto" class="text-center center-block file-upload"> </div>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="card mb-4">
                        <div class="card-header">Detalles de la cuenta</div>

                        <div class="card-body"> <?php if (isset($error)): ?> <div class="alert alert-danger"><?= $error ?></div> <?php endif; ?> <div class="row">
                                <div class="form-section">
                                    <h2>Datos de Usuario</h2>
                                    <div class="mb-3">
                                        <label for="usuario" class="form-label">Usuario</label>
                                        <input type="text" id="usuario" name="usuario" class="form-control" placeholder="Ingrese un usuario" value="<?= htmlspecialchars($usuario['usuario']) ?>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="correo" class="form-label">Correo</label>
                                        <input type="email" id="correo" name="correo" class="form-control" placeholder="Ingrese un correo" value="<?= htmlspecialchars($usuario['correo']) ?>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="contraseña" class="form-label">Contraseña</label>
                                        <input type="password" id="contraseña" name="contraseña" class="form-control" placeholder="Ingrese una contraseña" value="<?= htmlspecialchars($usuario['contraseña']) ?>" required>
                                    </div>
                                </div>
                                <hr>
                                <h2>Datos Personales</h2>
                                <div class="col-md-6">
                                    <div class="mb-3"> <label for="nombre1" class="form-label">Primer Nombre</label> <input type="text" class="form-control" id="nombre1" name="nombre1" value="<?= $usuario['nombre1'] ?>" required> </div>
                                    <div class="mb-3"> <label for="nombre2" class="form-label">Segundo Nombre</label> <input type="text" class="form-control" id="nombre2" name="nombre2" value="<?= $usuario['nombre2'] ?>"> </div>
                                    <div class="mb-3"> <label for="apellido1" class="form-label">Primer Apellido</label> <input type="text" class="form-control" id="apellido1" name="apellido1" value="<?= $usuario['apellido1'] ?>" required> </div>
                                    <div class="mb-3"> <label for="apellido2" class="form-label">Segundo Apellido</label> <input type="text" class="form-control" id="apellido2" name="apellido2" value="<?= $usuario['apellido2'] ?>"> </div>
                                    <div class="mb-3">
                                        <label for="discapacitado" class="form-label">Discapacitado</label>
                                        <select id="discapacitado" name="discapacitado" class="form-control" required>
                                            <option value="#">Seleccione</option>
                                            <option value="0" <?= $paciente['discapacitado'] == 0 ? 'selected' : '' ?>>No</option>
                                            <option value="1" <?= $paciente['discapacitado'] == 1 ? 'selected' : '' ?>>Sí</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="descrip_disca" class="form-label">Descripción de discapacidad</label>
                                        <input type="text" id="descrip_disca" name="descrip_disca" class="form-control" placeholder="Descripción de la discapacidad" value="<?= htmlspecialchars($paciente['descrip_disca']) ?>">
                                    </div>

                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3"> <label for="sexo" class="form-label">Sexo</label> <select id="sexo" name="sexo" class="form-select" required>
                                            <option value="Masculino" <?= ($usuario['sexo'] == 'Masculino') ? 'selected' : '' ?>>Masculino</option>
                                            <option value="Femenino" <?= ($usuario['sexo'] == 'Femenino') ? 'selected' : '' ?>>Femenino</option>
                                        </select> </div>
                                    <div class="mb-3"> <label for="fecha_nac" class="form-label">Fecha de Nacimiento</label> <input type="date" class="form-control" id="fecha_nac" name="fecha_nac" value="<?= $usuario['fecha_nac'] ?>" required> </div>
                                    <div class="mb-3"> <label for="num_doc" class="form-label">Número de Documento</label> <input type="text" class="form-control" id="num_doc" name="num_doc" value="<?= $usuario['num_doc'] ?>" required> </div>
                                    <div class="mb-3"> <label for="tipo_doc" class="form-label">Tipo de Documento</label> <select id="tipo_doc" name="tipo_doc" class="form-select" required>
                                            <option value="V" <?= ($usuario['tipo_doc'] == 'V') ? 'selected' : '' ?>>V</option>
                                            <option value="E" <?= ($usuario['tipo_doc'] == 'E') ? 'selected' : '' ?>>E</option>
                                            <option value="J" <?= ($usuario['tipo_doc'] == 'J') ? 'selected' : '' ?>>J</option>
                                            <option value="P" <?= ($usuario['tipo_doc'] == 'P') ? 'selected' : '' ?>>P</option>
                                        </select> </div>
                                    <div class="mb-3"> <label for="telefono" class="form-label">Teléfono</label> <input type="text" class="form-control" id="telefono" name="telefono" value="<?= $usuario['telefono'] ?>" required></div>
                                    <div class="mb-3"> <label for="num_hijos" class="form-label">Numero de Hijos</label> <input type="text" class="form-control" id="num_hijos" name="num_hijos" value="<?= $paciente['num_hijos'] ?>" required></div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3"> <label for="estado" class="form-label">Estado</label> <select class="form-control" id="estado" name="estado" required>
                                            <option value="">Selecciona un Estado</option> <?php foreach ($estados as $estado): ?> <option value="<?= $estado['id_estado'] ?>" <?= $direccion['id_estado'] == $estado['id_estado'] ? 'selected' : '' ?>><?= $estado['estado'] ?></option> <?php endforeach; ?>
                                        </select> </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3"> <label for="ciudad" class="form-label">Ciudad</label> <select class="form-control" id="ciudad" name="ciudad" required>
                                            <option value="">Selecciona una Ciudad</option> <?php foreach ($ciudades as $ciudad): ?> <option value="<?= $ciudad['id_ciudad'] ?>" <?= $direccion['id_ciudad'] == $ciudad['id_ciudad'] ? 'selected' : '' ?>><?= $ciudad['ciudad'] ?></option> <?php endforeach; ?>
                                        </select> </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3"> <label for="municipio" class="form-label">Municipio</label> <select class="form-control" id="municipio" name="municipio" required>
                                            <option value="">Selecciona un Municipio</option> <?php foreach ($municipios as $municipio): ?> <option value="<?= $municipio['id_municipio'] ?>" <?= $direccion['id_municipio'] == $municipio['id_municipio'] ? 'selected' : '' ?>><?= $municipio['municipio'] ?></option> <?php endforeach; ?>
                                        </select> </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3"> <label for="parroquia" class="form-label">Parroquia</label> <select class="form-control" id="parroquia" name="parroquia" required>
                                            <option value="">Selecciona una Parroquia</option> <?php foreach ($parroquias as $parroquia): ?> <option value="<?= $parroquia['id_parroquia'] ?>" <?= $direccion['id_parroquia'] == $parroquia['id_parroquia'] ? 'selected' : '' ?>><?= $parroquia['parroquia'] ?></option> <?php endforeach; ?>
                                        </select> </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="mb-3"> <label for="descripcion" class="form-label">Descripción</label> <textarea class="form-control" id="descripcion" name="descripcion" rows="3"><?= htmlspecialchars($direccion['descripcion']) ?></textarea> </div>
                                </div>
                            </div> <button type="submit" class="btn btn-primary mt-3">Actualizar</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <script src="script/bootstrap.bundle.min.js"></script>

</body>

</html>