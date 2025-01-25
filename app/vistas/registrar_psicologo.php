<?php
require_once __DIR__ . '/../../config/conexion.php';
require_once __DIR__ . '/../controladores/listado_PsicologosControlador.php';

use app\controladores\listado_PsicologosControlador;

session_start();

$controller = new listado_PsicologosControlador();

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

$especialidades = $controller->obtenerEspecialidades();

$psicologo = null;
if (isset($_GET['id_psicologo'])) {
    $psicologo = $controller->obtenerPsicologoPorId($_GET['id_psicologo']);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $usuario = $_POST['usuario'] ?? '';
    $contraseña = $_POST['contraseña'] ?? '';
    $nombre1 = $_POST['Nombre1'] ?? '';
    $nombre2 = $_POST['Nombre2'] ?? '';
    $apellido1 = $_POST['Apellido1'] ?? '';
    $apellido2 = $_POST['Apellido2'] ?? '';
    $tipo_doc = $_POST['tipo_doc'] ?? '';
    $num_doc = $_POST['num_doc'] ?? '';
    $correo = $_POST['correo'] ?? '';
    $fecha_nac = $_POST['Fecha_Nac'] ?? '';
    $telefono = $_POST['telefono'] ?? '';
    $estatus = $_POST['estatus'] ?? '';
    $id_especialidad = $_POST['especialidad'] ?? '';
    $descripcion = $_POST['Descripcion'] ?? '';
    $fotografia = $_FILES['foto'];
    $foto = '';

    if ($fotografia['error'] == UPLOAD_ERR_OK) {
        $foto = file_get_contents($fotografia['tmp_name']);
    } else {
        echo "Error al subir la foto: " . $fotografia['error'];
    }
    
    $result = $controller->registrarPsicologo($usuario, $contraseña, $nombre1, $nombre2, $apellido1, $apellido2, $tipo_doc, $num_doc, $correo, $fecha_nac, $telefono, $estatus, $id_especialidad, $descripcion, $foto);

    if ($result) {
        header('Location: /Implantacion/app/vistas/listado_Psicologos.php');
        exit();
    } else {
        echo "Error al registrar el psicólogo.";
    }
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Paciente</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/perfil_usuario.css">
    <link rel="stylesheet" href="css/modificar.css">
</head>

<body>
    <div class="container-xl px-4 mt-4">
        <nav class="nav nav-borders">
            <a class="nav-link" href="listado_Psicologos.php">Volver al listado</a>
        </nav>
        <hr class="mt-0 mb-4">
        <form method="POST" action="" enctype="multipart/form-data">
            <div class="row">
                <div class="col-lg-4">
                    <div class="card mb-4 mb-lg-0">
                        <div class="card-header">Foto de Perfil</div>
                        <div class="card-body text-center">
                            <div class="avatar default-avatar">A</div>
                            <h6>Fotografía</h6>
                            <input type="file" name="foto" id="foto" class="text-center center-block file-upload form-control-file">
                        </div>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="card mb-4">
                        <div class="card-header">Detalles del Paciente</div>
                        <div class="card-body">
                            <div class="form-section">
                                <h2>Datos de Usuario</h2>
                                <div class="mb-3">
                                    <label for="usuario" class="form-label">Usuario</label>
                                    <input type="text" id="usuario" name="usuario" class="form-control" placeholder="Ingrese un usuario" required>
                                </div>
                                <div class="mb-3">
                                    <label for="correo" class="form-label">Correo</label>
                                    <input type="email" id="correo" name="correo" class="form-control" placeholder="Ingrese un correo" required>
                                </div>
                                <div class="mb-3">
                                    <label for="contraseña" class="form-label">Contraseña</label>
                                    <input type="password" id="contraseña" name="contraseña" class="form-control" placeholder="Ingrese una contraseña" required>
                                </div>
                            </div>
                            <hr>
                            <div class="form-section">
                                <h2>Datos Personales</h2>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="Nombre1" class="form-label">Primer Nombre</label>
                                        <input type="text" id="Nombre1" name="Nombre1" class="form-control" placeholder="Ingrese su primer nombre" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="Nombre2" class="form-label">Segundo Nombre</label>
                                        <input type="text" id="Nombre2" name="Nombre2" class="form-control" placeholder="Ingrese su segundo nombre">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="Apellido1" class="form-label">Primer Apellido</label>
                                        <input type="text" id="Apellido1" name="Apellido1" class="form-control" placeholder="Ingrese su primer apellido" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="Apellido2" class="form-label">Segundo Apellido</label>
                                        <input type="text" id="Apellido2" name="Apellido2" class="form-control" placeholder="Ingrese su segundo apellido">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="tipo_doc" class="form-label">Tipo de Documento</label>
                                        <select id="tipo_doc" name="tipo_doc" class="form-select" required>
                                        <option disabled selected>Seleccione su tipo de documento</option>
                                        <option value="V" <?= isset($psicologo['tipo_doc']) && $psicologo['tipo_doc'] == 'V' ? 'selected' : '' ?>>V</option>
                                        <option value="E" <?= isset($psicologo['tipo_doc']) && $psicologo['tipo_doc'] == 'E' ? 'selected' : '' ?>>E</option>
                                        <option value="J" <?= isset($psicologo['tipo_doc']) && $psicologo['tipo_doc'] == 'J' ? 'selected' : '' ?>>J</option>
                                        <option value="P" <?= isset($psicologo['tipo_doc']) && $psicologo['tipo_doc'] == 'P' ? 'selected' : '' ?>>P</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="num_doc" class="form-label">Número de Documento</label>
                                        <input type="text" id="num_doc" name="num_doc" class="form-control" placeholder="Ingrese su número de documento" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="Fecha_Nac" class="form-label">Fecha de Nacimiento</label>
                                        <input type="date" id="Fecha_Nac" name="Fecha_Nac" class="form-control" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="telefono" class="form-label">Número de Teléfono</label>
                                        <input type="text" id="telefono" name="telefono" class="form-control" placeholder="Ingrese su número telefónico" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="estatus" class="form-label">Estatus</label>
                                        <select id="estatus" name="estatus" class="form-select" required>
                                            <option disabled selected>Seleccione estatus</option>
                                            <option value="activo" <?= isset($psicologo['estatus']) && $psicologo['estatus'] == 'activo' ? 'selected' : '' ?>>Activo</option>
                                            <option value="inactivo" <?= isset($psicologo['estatus']) && $psicologo['estatus'] == 'inactivo' ? 'selected' : '' ?>>Inactivo</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="form-section">
                                <h2>Especialidad</h2>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="nombre1" class="form-label">Nombre</label>
                                        <select class="form-select" id="especialidad" name="especialidad" required>
                                            <option disabled selected>Seleccione la especialidad</option>
                                            <?php foreach ($especialidades as $especialidad): ?>
                                                <option value="<?= $especialidad['id_especialidad'] ?>"><?= $especialidad['Tipo_Esp'] ?></option>
                                            <?php endforeach; ?>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="nombre2" class="form-label">Descripción</label>
                                        <textarea name="" id="" class="form-control"></textarea>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-end">
                                <button type="submit" class="btn btn-primary">Guardar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>

<script src="script/registro.js"></script>

</html>