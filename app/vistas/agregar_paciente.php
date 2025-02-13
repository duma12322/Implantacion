<?php
session_start();

require_once '../../config/conexion.php';
require_once '../../app/controladores/listado_PacienteControlador.php';
include '../controladores/log.php';

use app\controladores\listado_PacienteControlador;

// Crear una instancia del controlador
$controlador = new listado_PacienteControlador();

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

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Obtener datos enviados desde el formulario
    $datosUsuario = [
        'usuario' => $_POST['usuario'] ?? null,
        'correo' => $_POST['correo'] ?? null,
        'contraseña' => $_POST['contraseña'] ?? '',
        'nombre1' => $_POST['nombre1'] ?? null,
        'nombre2' => $_POST['nombre2'] ?? null,
        'apellido1' => $_POST['apellido1'] ?? null,
        'apellido2' => $_POST['apellido2'] ?? null,
        'sexo' => $_POST['sexo'] ?? null,
        'fecha_nac' => $_POST['fecha_nac'] ?? null,
        'tipo_doc' => $_POST['tipo_doc'] ?? null,
        'num_doc' => $_POST['num_doc'] ?? null,
        'telefono' => $_POST['telefono'] ?? null,
        'pregunta_s1' => $_POST['pregunta_s1'] ?? null,
        'respuesta_1' => $_POST['respuesta_1'] ?? null,
        'pregunta_s2' => $_POST['pregunta_s2'] ?? null,
        'respuesta_2' => $_POST['respuesta_2'] ?? null,
        'status' => 'activo'
    ];

    $datosPaciente = [
        'id_estado' => $_POST['id_estado'] ?? null,
        'id_ciudad' => $_POST['id_ciudad'] ?? null,
        'id_municipio' => $_POST['id_municipio'] ?? null,
        'id_parroquia' => $_POST['id_parroquia'] ?? null,
        'otro' => $_POST['otro'] ?? null,
        'num_hijos' => $_POST['num_hijos'] ?? null,
        'discapacitado' => isset($_POST['discapacitado']) && $_POST['discapacitado'] === 'Sí' ? 1 : 0,
        'descrip_disca' => $_POST['descrip_disca'] ?? null
    ];

    // Llamar al método registrarUsuario del controlador
    $resultado = $controlador->registrarUsuario($datosUsuario, $datosPaciente);

    // Verificar si el usuario fue registrado exitosamente
    if ($resultado) {
        // Obtener el ID del usuario creado
        $id_usuario = $controlador->obtenerUsuarioPorId($datosUsuario['usuario']); // Asumiendo que el método retorna el ID del usuario

        // Mostrar el ID y nombre del usuario creado
        echo "Usuario creado con éxito! ID: $id_usuario - Nombre: {$datosUsuario['nombre1']} {$datosUsuario['apellido1']}";

        // Registrar el log
        registrar_log($_SESSION['usuario'], "Registró un nuevo psicólogo con el nombre: {$datosUsuario['nombre1']} {$datosUsuario['apellido1']}");

        // Redirigir al listado de pacientes después de éxito
        header('Location: listado_pacientes.php');
        exit(); // Asegurarse de detener la ejecución después de la redirección
    } else {
        echo "Error en el registro.";
    }

    // Subir la foto si se proporciona
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
                $conn = new PDO($dsn, $username, $password); // Asegúrate de usar la conexión adecuada
                $sql_update_foto = "UPDATE usuario SET foto = :foto WHERE id_usuario = :id_usuario";
                $stmt_update_foto = $conn->prepare($sql_update_foto);
                $stmt_update_foto->bindParam(':foto', $foto_binaria, PDO::PARAM_LOB);
                $stmt_update_foto->bindParam(':id_usuario', $id_usuario, PDO::PARAM_INT);
                $stmt_update_foto->execute();
            } else {
                echo "Error al leer el archivo de la foto.";
            }
        } else {
            echo "Tipo de archivo no permitido.";
        }
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
    <link rel="stylesheet" href="css/bootstrap-4.5.2/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-icons/bootstrap-icons.min.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/perfil_usuario.css">
    <link rel="stylesheet" href="css/modificar.css">
</head>

<body>
    <div class="container-xl px-4 mt-4">
        <nav class="nav nav-borders">
            <a class="nav-link" href="listado_pacientes.php">Volver al listado</a>
        </nav>
        <hr class="mt-0 mb-4">
        <form action="" method="POST">
            <div class="row">
                <div class="col-lg-4">
                    <div class="card mb-4 mb-lg-0">
                        <div class="card-header">Foto de Perfil</div>
                        <div class="card-body text-center">
                            <div class="avatar default-avatar">A</div>
                            <h6>Cambiar foto</h6>
                            <input type="file" name="foto" class="text-center center-block file-upload">
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
                                        <label for="nombre1" class="form-label">Primer Nombre</label>
                                        <input type="text" id="nombre1" name="nombre1" class="form-control" placeholder="Ingrese su primer nombre" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="nombre2" class="form-label">Segundo Nombre</label>
                                        <input type="text" id="nombre2" name="nombre2" class="form-control" placeholder="Ingrese su segundo nombre">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="apellido1" class="form-label">Primer Apellido</label>
                                        <input type="text" id="apellido1" name="apellido1" class="form-control" placeholder="Ingrese su primer apellido" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="apellido2" class="form-label">Segundo Apellido</label>
                                        <input type="text" id="apellido2" name="apellido2" class="form-control" placeholder="Ingrese su segundo apellido">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="telefono" class="form-label">Telefono</label>
                                        <input type="text" id="telefono" name="telefono" class="form-control" placeholder="Ingrese su numero de telefono" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="tipo_doc" class="form-label">Tipo de Documento</label>
                                        <select id="tipo_doc" name="tipo_doc" class="form-select" required>
                                            <option disabled selected>Seleccione su tipo de documento</option>
                                            <option value="V">V</option>
                                            <option value="E">E</option>
                                            <option value="J">J</option>
                                            <option value="P">P</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="sexo" class="form-label">Sexo</label>
                                        <select id="sexo" name="sexo" class="form-select" required>
                                            <option disabled selected>Seleccione su sexo</option>
                                            <option value="Masculino">Masculino</option>
                                            <option value="Femenino">Femenino</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="num_doc" class="form-label">Número de Documento</label>
                                        <input type="text" id="num_doc" name="num_doc" class="form-control" placeholder="Ingrese su número de documento" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="fecha_nac" class="form-label">Fecha de Nacimiento</label>
                                        <input type="date" id="fecha_nac" name="fecha_nac" class="form-control" required>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="discapacitado" class="form-label">Discapacitado</label>
                                        <select id="discapacitado" name="discapacitado" class="form-control form-control-lg" required>
                                            <option value="#">Seleccione</option>
                                            <option value="No">No</option>
                                            <option value="Sí">Sí</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="descrip_disca" class="form-label">Descripción de discapacidad</label>
                                        <input type="text" id="descrip_disca" name="descrip_disca" class="form-control" placeholder="Descripción de la discapacidad">
                                    </div>

                                    <div class="col-md-6">
                                        <label for="otro" class="form-label">Numero de hijos</label>
                                        <input type="number" class="form-control" id="num_hijos" name="num_hijos" placeholder="Ingrese la cantidad de hijos" value="0" required>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="estado" class="form-label">Estado</label>
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
                                        <input type="text" class="form-control" id="otro" name="otro" placeholder="Ingrese detalles de su ubicación.">
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="form-section">
                                <h2>Preguntas de Seguridad</h2>
                                <div class="mb-3">
                                    <label>Preguntas de seguridad 1</label>
                                    <select id="pregunta_s1" name="pregunta_s1" class="form-select" required>
                                        <option disabled selected>Seleccione la primera pregunta de seguridad</option>
                                        <option>NOMBRE DE MI MADRE</option>
                                        <option>NOMBRE DE MI MASCOTA</option>
                                        <option>NOMBRE DE MI PRIMER COLEGIO</option>
                                        <option>NOMBRE DE MI PRIMER TRABAJO</option>
                                        <option>NOMBRE DE MI PADRE</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="respuesta_1" class="form-label">Respuesta</label>
                                    <input type="text" id="respuesta_1" name="respuesta_1" class="form-control" placeholder="Ingrese su respuesta" required>
                                </div>
                                <div class="mb-3">
                                    <label>Pregunta de Seguridad 2</label>
                                    <select id="pregunta_s2" name="pregunta_s2" class="form-select" required>
                                        <option disabled selected>Seleccione la segunda pregunta de seguridad</option>
                                        <option>NOMBRE DE MI HERMANO MAYOR</option>
                                        <option>DONDE NACIO SU MADRE</option>
                                        <option>NOMBRE DE MEJOR AMIGO DE LA INFANCIA</option>
                                        <option>PELICULA FAVORITA</option>
                                        <option>SEGUNDO APELLIDO DE MI MADRE</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="respuesta_2" class="form-label">Respuesta</label>
                                    <input type="text" id="respuesta_2" name="respuesta_2" class="form-control" placeholder="Ingrese su respuesta" required>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end">
                                <button type="submit" class="btn btn-primary">Guardar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <script src="script/bootstrap.min.js/bootstrap.min.js"></script>
</body>

<script src="script/registro.js"></script>

</html>