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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Editar Datos del Psicólogo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/modificar.css">
</head>

<body>
    <div class="container-xl px-4 mt-4">
        <!-- Navigation -->
        <nav class="nav nav-borders">
            <a class="nav-link" href="listado_psicologos.php" target="_self">Volver al listado</a>
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
                <!-- Account details card -->
                <div class="card mb-4">
                    <div class="card-header">Detalles del Psicólogo</div>
                    <div class="card-body">
                        <form method="POST" action="">
                            <div class="mb-3">
                                <label class="small mb-1" for="Nombre1">Primer Nombre</label>
                                <input class="form-control" id="Nombre1" name="Nombre1" type="text" placeholder="Ingrese el primer nombre" value="<?= htmlspecialchars($psicologo['Nombre1']) ?>" required>
                            </div>
                            <div class="mb-3">
                                <label class="small mb-1" for="Nombre2">Segundo Nombre</label>
                                <input class="form-control" id="Nombre2" name="Nombre2" type="text" placeholder="Ingrese el segundo nombre" value="<?= htmlspecialchars($psicologo['Nombre2']) ?>">
                            </div>
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1" for="Apellido1">Primer Apellido</label>
                                    <input class="form-control" id="Apellido1" name="Apellido1" type="text" placeholder="Ingrese el primer apellido" value="<?= htmlspecialchars($psicologo['Apellido1']) ?>" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="small mb-1" for="Apellido2">Segundo Apellido</label>
                                    <input class="form-control" id="Apellido2" name="Apellido2" type="text" placeholder="Ingrese el segundo apellido" value="<?= htmlspecialchars($psicologo['Apellido2']) ?>">
                                </div>
                            </div>
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1" for="num_doc">Número de Documento</label>
                                    <input class="form-control" id="num_doc" name="num_doc" type="text" placeholder="Ingrese el número de documento" value="<?= htmlspecialchars($psicologo['num_doc']) ?>" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="small mb-1" for="Fecha_Nac">Fecha de Nacimiento</label>
                                    <input class="form-control" id="Fecha_Nac" name="Fecha_Nac" type="date" value="<?= htmlspecialchars($psicologo['Fecha_Nac']) ?>" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="small mb-1" for="telefono">Teléfono</label>
                                <input class="form-control" id="telefono" name="telefono" type="text" placeholder="Ingrese el número de teléfono" value="<?= htmlspecialchars($psicologo['telefono']) ?>" required>
                            </div>
                            <button class="btn btn-primary" type="submit">Guardar Cambios</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>