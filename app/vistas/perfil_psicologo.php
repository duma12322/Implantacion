<?php
session_start();
include '../../config/conexion.php';

// Verifica si la sesión está activa
if (!isset($_SESSION['usuario'])) {
    header("Location: login_psicologo_admin.php");
    exit;
}

$usuario = $_SESSION['usuario']; // El valor del usuario en la sesión

$nombreUsuario = $_SESSION['usuario'];

// Obtener el id_usuario a partir del valor de usuario
$sql_admintrativo = "SELECT id_administrativo FROM administrativo WHERE usuario = :usuario";
$stmt_administrativo = $conn->prepare($sql_admintrativo);
$stmt_administrativo->bindParam(':usuario', $usuario);
$stmt_administrativo->execute();
$usuario_data = $stmt_administrativo->fetch(PDO::FETCH_ASSOC);

if (!$usuario_data) {
    echo "No se encontraron datos del usuario con el nombre: $usuario";
    exit;
}

$id_administrativo = $usuario_data['id_administrativo']; // Obtener el id_usuario

//Obtener los datos del usuario
$sql = "SELECT a.*, p.*, e.Descripcion AS especialidad, e.Tipo_Esp AS estado
        FROM administrativo a
        LEFT JOIN psicologo p ON a.id_administrativo = p.id_administrativo
        LEFT JOIN especialidad_psicologo es ON p.id_psicologo = es.id_psicologo
        LEFT JOIN especialidad e ON es.id_especialidad = e.id_especialidad
        WHERE a.id_administrativo = :id_administrativo";
$stmt = $conn->prepare($sql);
$stmt->bindParam(':id_administrativo', $id_administrativo);
$stmt->execute();



// Verificar si la consulta devolvió resultados
$usuario = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$usuario) {
    echo "No se encontraron datos del usuario con el ID: $id_administrativo";
    exit;
}

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
    $especialidad = $_POST['especialidad'];
    
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
                $sql_update_foto = "UPDATE administrativo SET foto = :foto WHERE id_administrativo = :id_administrativo";
                $stmt_update_foto = $conn->prepare($sql_update_foto);
                $stmt_update_foto->bindParam(':foto', $foto_binaria, PDO::PARAM_LOB);
                $stmt_update_foto->bindParam(':id_administrativo', $id_administrativo);
                $stmt_update_foto->execute();
            } else {
                echo "Error al leer el archivo de la foto.";
            }
        } else {
            echo "Tipo de archivo no permitido.";
        }
    }

    // Actualizar los datos del usuario (sin la foto)
    $sql_update = "UPDATE administrativo SET 
                        tipo_doc = :tipo_doc,
                        num_doc = :num_doc,
                        nombre1 = :nombre1,
                        nombre2 = :nombre2,
                        apellido1 = :apellido1,
                        apellido2 = :apellido2,
                        fecha_nac = :fecha_nac,
                        telefono = :telefono,
                        correo = :correo 
                    WHERE id_administrativo = :id_administrativo";

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
    
    $stmt_update->bindParam(':id_administrativo', $id_administrativo);
    $stmt_update->execute();


    /*// Actualizar la especialidad
    $sql_update_especialidad = "UPDATE especialidad SET 
                                     especialidad =:especialidad
                              WHERE id_especialidad = :id_especialidad";

    $stmt_update_direccion = $conn->prepare($sql_update_especialidad);
    $stmt_update_direccion->bindParam(':especialidad', $especialidad);
    $stmt_update_direccion->bindParam(':id_especialidad', $usuario['id_especialidad']);
    $stmt_update_direccion->execute();*/

    // Redirigir a la misma página para reflejar los cambios
    header("Location: perfil_psicologo.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
                <form action="perfil_psicologo.php" method="POST" enctype="multipart/form-data">
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
                            <input type="text" class="form-control" name="nombre1" value="<?php echo $usuario['Nombre1']; ?>" placeholder="Introduce tu primer nombre">
                        </div>
                        <div class="form-group">
                            <label for="apellido1">
                                <h4>Primer Apellido</h4>
                            </label>
                            <input type="text" class="form-control" name="apellido1" value="<?php echo $usuario['Apellido1']; ?>" placeholder="Introduce tu primer apellido">
                        </div>
                        <!-- Segundo Nombre y Segundo Apellido -->
                        <div class="form-group">
                            <label for="nombre2">
                                <h4>Segundo Nombre</h4>
                            </label>
                            <input type="text" class="form-control" name="nombre2" value="<?php echo $usuario['Nombre2']; ?>" placeholder="Introduce tu segundo nombre">
                        </div>
                        <div class="form-group">
                            <label for="apellido2">
                                <h4>Segundo Apellido</h4>
                            </label>
                            <input type="text" class="form-control" name="apellido2" value="<?php echo $usuario['Apellido2']; ?>" placeholder="Introduce tu segundo apellido">
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
                            <input type="date" class="form-control" name="fecha_nac" value="<?php echo $usuario['Fecha_Nac']; ?>">
                        </div>
                        <div class="form-group">
                            <label for="Tipo_Esp">
                                <h4>Especialidad</h4>
                            </label>
                            <input type="text" class="form-control" name="Tipo_Esp" value="<?php echo isset($usuario['Tipo_Esp']) ? htmlspecialchars($usuario['Tipo_Esp']) : ''; ?>">
                        </div>
                        <div class="form-group">
                            <label for="Descripcion">
                                <h4>Descripcion de especialidad</h4>
                            </label>
                            <input type="Text" class="form-control" name="Descripcion" value="<?php echo isset($usuario['Descripcion']) ? htmlspecialchars($usuario['Descripcion']) : ''; ?>"> 
                        </div>
                        <hr>
                    </div>
                    <button type="submit" class="btn btn-primary">Actualizar Perfil</button>
                </form>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script src="script/sidebarandheader.js"></script>
</body>

</html>