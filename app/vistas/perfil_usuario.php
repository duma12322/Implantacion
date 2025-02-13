<?php
session_start();
include '../../config/conexion.php';

// Verifica si la sesión está activa
if (!isset($_SESSION['usuario'])) {
    header("Location: login_paciente.php");
    exit;
}

$usuario = $_SESSION['usuario']; // El valor del usuario en la sesión

$nombreUsuario = $_SESSION['usuario'];

// Obtener el id_usuario a partir del valor de usuario
$sql_usuario = "SELECT id_usuario FROM usuario WHERE usuario = :usuario";
$stmt_usuario = $conn->prepare($sql_usuario);
$stmt_usuario->bindParam(':usuario', $usuario);
$stmt_usuario->execute();
$usuario_data = $stmt_usuario->fetch(PDO::FETCH_ASSOC);

if (!$usuario_data) {
    echo "No se encontraron datos del usuario con el nombre: $usuario";
    exit;
}

$id_usuario = $usuario_data['id_usuario']; // Obtener el id_usuario

// Obtener los datos del usuario
$sql = "SELECT u.*, d.descripcion, e.estado AS estado, c.ciudad AS ciudad, m.municipio AS municipio, pr.parroquia AS parroquia
        FROM usuario u
        LEFT JOIN paciente p ON u.id_usuario = p.id_usuario  
        LEFT JOIN direccion d ON p.id_direccion = d.id_direccion  
        LEFT JOIN ciudades c ON d.id_ciudad = c.id_ciudad  
        LEFT JOIN municipios m ON d.id_municipio = m.id_municipio  
        LEFT JOIN parroquias pr ON d.id_parroquia = pr.id_parroquia
        LEFT JOIN estados e ON d.id_estado = e.id_estado
        WHERE u.id_usuario = :id_usuario";
$stmt = $conn->prepare($sql);
$stmt->bindParam(':id_usuario', $id_usuario);
$stmt->execute();

// Verificar si la consulta devolvió resultados
$usuario = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$usuario) {
    echo "No se encontraron datos del usuario con el ID: $id_usuario";
    exit;
}

// Consultas para obtener estados, ciudades, municipios y parroquias
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

// Actualizar los datos del usuario
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Obtener los datos del formulario
    $tipo_doc = $_POST['tipo_doc'];  // Obtener tipo de documento
    $num_doc = $_POST['num_doc'];  // Obtener número de documento
    $nombre1 = $_POST['nombre1'];
    $nombre2 = $_POST['nombre2'];
    $apellido1 = $_POST['apellido1'];
    $apellido2 = $_POST['apellido2'];
    $fecha_nac = $_POST['fecha_nac'];
    $telefono = $_POST['telefono'];
    $correo = $_POST['correo'];
    $estado = $_POST['estado'];
    $ciudad = $_POST['ciudad'];
    $municipio = $_POST['municipio'];
    $parroquia = $_POST['parroquia'];

    // Verificar si hay una foto nueva
    if (isset($_FILES['foto']) && $_FILES['foto']['error'] == 0) {
        $foto_tmp = $_FILES['foto']['tmp_name'];
        $foto_tipo = $_FILES['foto']['type'];

        // Validar el tipo de archivo
        $permitidos = ['image/jpeg', 'image/png', 'image/gif'];

        if (in_array($foto_tipo, $permitidos)) {
            // Leer la imagen y convertirla en binario
            $foto_binaria = file_get_contents($foto_tmp);

            // Verifica que se ha leído correctamente
            if ($foto_binaria !== false) {
                // Actualizar la foto en la base de datos
                $sql_update_foto = "UPDATE usuario SET foto = :foto WHERE id_usuario = :id_usuario";
                $stmt_update_foto = $conn->prepare($sql_update_foto);
                $stmt_update_foto->bindParam(':foto', $foto_binaria, PDO::PARAM_LOB);
                $stmt_update_foto->bindParam(':id_usuario', $id_usuario);
                $stmt_update_foto->execute();
            } else {
                echo "Error al leer el archivo de la foto.";
            }
        } else {
            echo "Tipo de archivo no permitido.";
        }
    }

    // Actualizar los datos del usuario (sin la foto)
    $sql_update = "UPDATE usuario SET 
                        tipo_doc = :tipo_doc,
                        num_doc = :num_doc,
                        nombre1 = :nombre1,
                        nombre2 = :nombre2,
                        apellido1 = :apellido1,
                        apellido2 = :apellido2,
                        fecha_nac = :fecha_nac,
                        telefono = :telefono,
                        correo = :correo 
                    WHERE id_usuario = :id_usuario";

    $stmt_update = $conn->prepare($sql_update);
    $stmt_update->bindParam(':tipo_doc', $tipo_doc);
    $stmt_update->bindParam(':num_doc', $num_doc);
    $stmt_update->bindParam(':nombre1', $nombre1);
    $stmt_update->bindParam(':nombre2', $nombre2);
    $stmt_update->bindParam(':apellido1', $apellido1);
    $stmt_update->bindParam(':apellido2', $apellido2);
    $stmt_update->bindParam(':fecha_nac', $fecha_nac);
    $stmt_update->bindParam(':telefono', $telefono);
    $stmt_update->bindParam(':correo', $correo);
    $stmt_update->bindParam(':id_usuario', $id_usuario);
    $stmt_update->execute();


    // Actualizar la dirección
    $sql_update_direccion = "UPDATE direccion SET 
                                    id_estado = :estado, 
                                    id_ciudad = :ciudad, 
                                    id_municipio = :municipio, 
                                    id_parroquia = :parroquia
                              WHERE id_direccion = :id_direccion";

    $stmt_update_direccion = $conn->prepare($sql_update_direccion);
    $stmt_update_direccion->bindParam(':estado', $estado);
    $stmt_update_direccion->bindParam(':ciudad', $ciudad);
    $stmt_update_direccion->bindParam(':municipio', $municipio);
    $stmt_update_direccion->bindParam(':parroquia', $parroquia);
    $stmt_update_direccion->bindParam(':id_direccion', $usuario['id_direccion']);
    $stmt_update_direccion->execute();

    // Redirigir a la misma página para reflejar los cambios
    header("Location: perfil_usuario.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil</title>
    <link rel="stylesheet" href="css/bootstrap-4.5.2/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-icons/bootstrap-icons.min.css">
    <script src="script/jquery3.3.1.min.js"></script>
    <script src="script/bootstrap3.3.7.min.js"></script>
    <link rel="stylesheet" href="css/sidebarandheader.css">
    <link rel="stylesheet" href="css/perfil_usuario.css">
</head>

<body>
    <?php include 'includes/header.php'; ?>
    <?php include 'includes/sidebar.php'; ?>

    <div class="container">
        <div class="row">
            <div class="col-sm-5" style="margin-top: 50px;">
                <!-- Formulario para cambiar foto -->
                <form action="perfil_usuario.php" method="POST" enctype="multipart/form-data">
                    <div class="card">
                        <div class="card-body text-center">
                            <!-- Mostrar la foto almacenada o avatar por defecto si no hay foto -->
                            <?php if (!empty($usuario['foto'])): ?>
                                <img src="data:image/jpeg;base64,<?php echo base64_encode($usuario['foto']); ?>" class="avatar img-circle img-thumbnail" alt="avatar">
                            <?php else: ?>
                                <div class="avatar default-avatar">A</div>
                            <?php endif; ?>
                            <h6>Cambiar foto</h6>
                            <input type="file" name="foto" class="text-center center-block file-upload">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="num_doc">
                            <h4>Documento</h4>
                        </label>
                        <input type="text" class="form-control" name="num_doc" value="<?php echo $usuario['num_doc']; ?>" placeholder="Introduce tu número de documento">
                    </div>

                    <div class="form-group">
                        <label for="tipo_doc">
                            <h4>Tipo de Documento</h4>
                        </label>
                        <select name="tipo_doc" class="form-control">
                            <option value="V" <?php echo $usuario['tipo_doc'] == 'V' ? 'selected' : ''; ?>>V</option>
                            <option value="E" <?php echo $usuario['tipo_doc'] == 'E' ? 'selected' : ''; ?>>E</option>
                            <option value="J" <?php echo $usuario['tipo_doc'] == 'J' ? 'selected' : ''; ?>>J</option>
                            <option value="P" <?php echo $usuario['tipo_doc'] == 'P' ? 'selected' : ''; ?>>P</option>
                        </select>
                    </div>
            </div>
            </hr><br>

            <div class="col-sm-7" style="margin-top: 50px;">
                <h4 class="perfil-title">Perfil</h4>
                <form class="form" action="perfil_usuario.php" method="post" enctype="multipart/form-data">
                    <div class="form-container">
                        <!-- Primer Nombre y Primer Apellido -->
                        <div class="form-group">
                            <label for="nombre1">
                                <h4>Primer Nombre</h4>
                            </label>
                            <input type="text" class="form-control" name="nombre1" value="<?php echo $usuario['nombre1']; ?>" placeholder="Introduce tu primer nombre">
                        </div>
                        <div class="form-group">
                            <label for="apellido1">
                                <h4>Primer Apellido</h4>
                            </label>
                            <input type="text" class="form-control" name="apellido1" value="<?php echo $usuario['apellido1']; ?>" placeholder="Introduce tu primer apellido">
                        </div>
                        <!-- Segundo Nombre y Segundo Apellido -->
                        <div class="form-group">
                            <label for="nombre2">
                                <h4>Segundo Nombre</h4>
                            </label>
                            <input type="text" class="form-control" name="nombre2" value="<?php echo $usuario['nombre2']; ?>" placeholder="Introduce tu segundo nombre">
                        </div>
                        <div class="form-group">
                            <label for="apellido2">
                                <h4>Segundo Apellido</h4>
                            </label>
                            <input type="text" class="form-control" name="apellido2" value="<?php echo $usuario['apellido2']; ?>" placeholder="Introduce tu segundo apellido">
                        </div>
                        <!-- Otros campos como teléfono, correo, etc. -->
                        <div class="form-group">
                            <label for="telefono">
                                <h4>Teléfono</h4>
                            </label>
                            <input type="text" class="form-control" name="telefono" value="<?php echo $usuario['telefono']; ?>" placeholder="Introduce tu número de teléfono">
                        </div>
                        <div class="form-group">
                            <label for="correo">
                                <h4>Correo</h4>
                            </label>
                            <input type="email" class="form-control" name="correo" value="<?php echo $usuario['correo']; ?>" placeholder="Introduce tu correo electrónico">
                        </div>
                        <div class="form-group">
                            <label for="fecha_nac">
                                <h4>Fecha de Nacimiento</h4>
                            </label>
                            <input type="date" class="form-control" name="fecha_nac" value="<?php echo $usuario['fecha_nac']; ?>">
                        </div>
                        <!-- Estados y otros selectores -->
                        <div class="form-group">
                            <div class="col-xs-6">
                                <label for="estado">
                                    <h4>Estado</h4>
                                </label>
                                <select class="form-control" name="estado">
                                    <option value="">Selecciona un Estado</option>
                                    <?php foreach ($estados as $estado) { ?>
                                        <option value="<?php echo $estado['id_estado']; ?>" <?php echo $usuario['estado'] == $estado['estado'] ? 'selected' : ''; ?>>
                                            <?php echo $estado['estado']; ?>
                                        </option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>

                        <!-- Agregar campos similares para ciudad, municipio y parroquia -->
                        <div class="form-group">
                            <div class="col-xs-6">
                                <label for="ciudad">
                                    <h4>Ciudad</h4>
                                </label>
                                <select class="form-control" name="ciudad">
                                    <option value="">Selecciona una Ciudad</option>
                                    <?php foreach ($ciudades as $ciudad) { ?>
                                        <option value="<?php echo $ciudad['id_ciudad']; ?>" <?php echo $usuario['ciudad'] == $ciudad['ciudad'] ? 'selected' : ''; ?>>
                                            <?php echo $ciudad['ciudad']; ?>
                                        </option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-xs-6">
                                <label for="municipio">
                                    <h4>Municipio</h4>
                                </label>
                                <select class="form-control" name="municipio">
                                    <option value="">Selecciona un Municipio</option>
                                    <?php foreach ($municipios as $municipio) { ?>
                                        <option value="<?php echo $municipio['id_municipio']; ?>" <?php echo $usuario['municipio'] == $municipio['municipio'] ? 'selected' : ''; ?>>
                                            <?php echo $municipio['municipio']; ?>
                                        </option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-xs-6">
                                <label for="parroquia">
                                    <h4>Parroquia</h4>
                                </label>
                                <select class="form-control" name="parroquia">
                                    <option value="">Selecciona una Parroquia</option>
                                    <?php foreach ($parroquias as $parroquia) { ?>
                                        <option value="<?php echo $parroquia['id_parroquia']; ?>" <?php echo $usuario['parroquia'] == $parroquia['parroquia'] ? 'selected' : ''; ?>>
                                            <?php echo $parroquia['parroquia']; ?>
                                        </option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>

                        <hr>
                    </div>
                    <button type="submit" class="btn btn-primary">Actualizar Perfil</button>
                </form>
            </div>
        </div>
    </div>
    <script src="script/jquery.min.js"></script>
    <script src="script/popper.min.js"></script>
    <script src="script/bootstrap.min.js/bootstrap.min.js"></script>

    <script src="script/chart.min.js"></script>

    <script src="script/sidebarandheader.js"></script>
</body>

</html>