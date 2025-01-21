<?php
include '../../config/conexion.php';

if (!isset($_GET['id_usuario']) || empty($_GET['id_usuario'])) {
    echo "ID de usuario no válido.";
    exit;
}

$id_usuario = htmlspecialchars($_GET['id_usuario']);

// Obtener los datos actuales del usuario
$sql_usuario = "SELECT u.*, d.id_estado, d.id_ciudad, d.id_municipio, d.id_parroquia, d.descripcion
                FROM usuario u 
                LEFT JOIN paciente p ON u.id_usuario = p.id_usuario 
                LEFT JOIN direccion d ON p.id_direccion = d.id_direccion
                WHERE u.id_usuario = :id_usuario";
$stmt_usuario = $conn->prepare($sql_usuario);
$stmt_usuario->bindParam(':id_usuario', $id_usuario);
$stmt_usuario->execute();
$usuario = $stmt_usuario->fetch(PDO::FETCH_ASSOC);

if (!$usuario) {
    echo "Usuario no encontrado.";
    exit;
}

// Consultar los estados, ciudades, municipios y parroquias disponibles
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
    $municipio = htmlspecialchars($_POST['municipio']);
    $parroquia = htmlspecialchars($_POST['parroquia']);

    if (empty($nombre1) || empty($apellido1) || empty($sexo) || empty($fecha_nac) || empty($num_doc) || empty($telefono) || empty($direccion) || empty($estado) || empty($ciudad) || empty($municipio) || empty($parroquia)) {
        $error = "Por favor, completa todos los campos obligatorios.";
    } else {
        // Actualizar la información del usuario
        $sql_update_usuario = "
            UPDATE usuario 
            SET nombre1 = :nombre1, nombre2 = :nombre2, apellido1 = :apellido1, apellido2 = :apellido2,
                sexo = :sexo, fecha_nac = :fecha_nac, num_doc = :num_doc, telefono = :telefono
            WHERE id_usuario = :id_usuario";

        $stmt_update_usuario = $conn->prepare($sql_update_usuario);
        $stmt_update_usuario->bindParam(':nombre1', $nombre1);
        $stmt_update_usuario->bindParam(':nombre2', $nombre2);
        $stmt_update_usuario->bindParam(':apellido1', $apellido1);
        $stmt_update_usuario->bindParam(':apellido2', $apellido2);
        $stmt_update_usuario->bindParam(':sexo', $sexo);
        $stmt_update_usuario->bindParam(':fecha_nac', $fecha_nac);
        $stmt_update_usuario->bindParam(':num_doc', $num_doc);
        $stmt_update_usuario->bindParam(':telefono', $telefono);
        $stmt_update_usuario->bindParam(':id_usuario', $id_usuario);

        $resultado = $stmt_update_usuario->execute();

        // Si la actualización fue exitosa
        if ($resultado) {
            // Actualizar la dirección
            $sql_update_direccion = "
                UPDATE direccion 
                SET id_estado = :id_estado, id_ciudad = :id_ciudad, id_municipio = :id_municipio, id_parroquia = :id_parroquia, descripcion = :descripcion
                WHERE id_direccion = :id_direccion";

            $stmt_update_direccion = $conn->prepare($sql_update_direccion);
            $stmt_update_direccion->bindParam(':id_estado', $estado);
            $stmt_update_direccion->bindParam(':id_ciudad', $ciudad);
            $stmt_update_direccion->bindParam(':id_municipio', $municipio);
            $stmt_update_direccion->bindParam(':id_parroquia', $parroquia);
            $stmt_update_direccion->bindParam(':descripcion', $direccion);
            $stmt_update_direccion->bindParam(':id_direccion', $usuario['id_direccion']);
            $stmt_update_direccion->execute();
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
                        <?php if (!empty($usuario['foto'])): ?>
                            <img class="img-account-profile rounded-circle mb-2" src="data:image/jpeg;base64,<?= base64_encode($usuario['foto']) ?>" alt="Avatar">
                        <?php else: ?>
                            <img class="img-account-profile rounded-circle mb-2" src="http://bootdey.com/img/Content/avatar/avatar1.png" alt="Avatar">
                        <?php endif; ?>

                        <div class="small font-italic text-muted mb-4">JPG o PNG no mayor a 5 MB</div>
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
                        <form method="POST" action="" enctype="multipart/form-data">
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1" for="nombre1">Primer Nombre</label>
                                    <input class="form-control" id="nombre1" name="nombre1" type="text" value="<?= htmlspecialchars($usuario['nombre1']) ?>" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="small mb-1" for="nombre2">Segundo Nombre</label>
                                    <input class="form-control" id="nombre2" name="nombre2" type="text" value="<?= htmlspecialchars($usuario['nombre2']) ?>">
                                </div>
                            </div>
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1" for="apellido1">Primer Apellido</label>
                                    <input class="form-control" id="apellido1" name="apellido1" type="text" value="<?= htmlspecialchars($usuario['apellido1']) ?>" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="small mb-1" for="apellido2">Segundo Apellido</label>
                                    <input class="form-control" id="apellido2" name="apellido2" type="text" value="<?= htmlspecialchars($usuario['apellido2']) ?>">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="small mb-1" for="sexo">Sexo</label>
                                <select class="form-control" id="sexo" name="sexo" required>
                                    <option value="M" <?= $usuario['sexo'] === 'M' ? 'selected' : '' ?>>Masculino</option>
                                    <option value="F" <?= $usuario['sexo'] === 'F' ? 'selected' : '' ?>>Femenino</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="small mb-1" for="fecha_nac">Fecha de nacimiento</label>
                                <input class="form-control" id="fecha_nac" name="fecha_nac" type="date" value="<?= htmlspecialchars($usuario['fecha_nac']) ?>" required>
                            </div>
                            <div class="mb-3">
                                <label class="small mb-1" for="num_doc">Número de documento</label>
                                <input class="form-control" id="num_doc" name="num_doc" type="text" value="<?= htmlspecialchars($usuario['num_doc']) ?>" required>
                            </div>
                            <div class="mb-3">
                                <label class="small mb-1" for="telefono">Teléfono</label>
                                <input class="form-control" id="telefono" name="telefono" type="text" value="<?= htmlspecialchars($usuario['telefono']) ?>" required>
                            </div>
                            <div class="form-group">
                                <label for="estado">
                                    <h4>Estado</h4>
                                </label>
                                <select class="form-control" name="estado">
                                    <option value="">Selecciona un Estado</option>
                                    <?php foreach ($estados as $estado) { ?>
                                        <option value="<?php echo $estado['id_estado']; ?>" <?php echo $usuario['id_estado'] == $estado['id_estado'] ? 'selected' : ''; ?>>
                                            <?php echo $estado['estado']; ?>
                                        </option>
                                    <?php } ?>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="ciudad">
                                    <h4>Ciudad</h4>
                                </label>
                                <select class="form-control" name="ciudad">
                                    <option value="">Selecciona una Ciudad</option>
                                    <?php foreach ($ciudades as $ciudad) { ?>
                                        <option value="<?php echo $ciudad['id_ciudad']; ?>" <?php echo $usuario['id_ciudad'] == $ciudad['id_ciudad'] ? 'selected' : ''; ?>>
                                            <?php echo $ciudad['ciudad']; ?>
                                        </option>
                                    <?php } ?>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="municipio">
                                    <h4>Municipio</h4>
                                </label>
                                <select class="form-control" name="municipio">
                                    <option value="">Selecciona un Municipio</option>
                                    <?php foreach ($municipios as $municipio) { ?>
                                        <option value="<?php echo $municipio['id_municipio']; ?>" <?php echo $usuario['id_municipio'] == $municipio['id_municipio'] ? 'selected' : ''; ?>>
                                            <?php echo $municipio['municipio']; ?>
                                        </option>
                                    <?php } ?>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="parroquia">
                                    <h4>Parroquia</h4>
                                </label>
                                <select class="form-control" name="parroquia">
                                    <option value="">Selecciona una Parroquia</option>
                                    <?php foreach ($parroquias as $parroquia) { ?>
                                        <option value="<?php echo $parroquia['id_parroquia']; ?>" <?php echo $usuario['id_parroquia'] == $parroquia['id_parroquia'] ? 'selected' : ''; ?>>
                                            <?php echo $parroquia['parroquia']; ?>
                                        </option>
                                    <?php } ?>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1" for="descripcion">Descripción</label>
                                <input class="form-control" id="descripcion" name="descripcion" type="text" value="<?= htmlspecialchars($usuario['descripcion']) ?>">
                            </div>

                            <hr>
                            <button class="btn btn-primary" type="submit">Actualizar información</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>