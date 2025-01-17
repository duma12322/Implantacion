<?php
require_once '../../config/conexion.php';
require_once '../../app/controladores/listado_PacienteControlador.php';

use app\controladores\listado_PacienteControlador;

// Crear una instancia del controlador
$controlador = new listado_PacienteControlador();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Obtener datos enviados desde el formulario
    $datosUsuario = [
        'usuario' => $_POST['usuario'] ?? null,
        'correo' => $_POST['correo'] ?? null,
        'contraseña' => md5($_POST['contraseña'] ?? '') // Encriptar contraseña con MD5
    ];

    $datosPaciente = [
        'nombre1' => $_POST['nombre1'] ?? null,
        'tipo_doc' => $_POST['tipo_doc'] ?? null,
        'id_estado' => $_POST['id_estado'] ?? null,
        'nombre2' => $_POST['nombre2'] ?? null,
        'num_doc' => $_POST['num_doc'] ?? null,
        'id_ciudad' => $_POST['id_ciudad'] ?? null,
        'apellido1' => $_POST['apellido1'] ?? null,
        'fecha_nac' => $_POST['fecha_nac'] ?? null,
        'id_parroquia' => $_POST['id_parroquia'] ?? null,
        'apellido2' => $_POST['apellido2'] ?? null,
        'sexo' => $_POST['sexo'] ?? null,
        'id_municipio' => $_POST['id_municipio'] ?? null,
        'otro' => $_POST['otro'] ?? null,
        'telefono' => $_POST['telefono'] ?? null,
        'pregunta_s1' => $_POST['pregunta_s1'] ?? null,
        'respuesta_1' => $_POST['respuesta_1'] ?? null,
        'pregunta_s2' => $_POST['pregunta_s2'] ?? null,
        'respuesta_2' => $_POST['respuesta_2'] ?? null,
        'num_hijos' => $_POST['num_hijos'] ?? null,
        'dispacitado' => $_POST['dispacitado'] ?? null,
        'descrip_disca' => $_POST['descrip_disca'] ?? null
    ];

    // Llamar al método registrarPaciente del controlador
    $resultado = $controlador->registrarPaciente($datosUsuario, $datosPaciente);

    // Mostrar el mensaje de resultado
    $mensaje = $resultado['mensaje'];
    $tipoMensaje = $resultado['tipo'];

    if ($tipoMensaje == 'success') {
        header("Location: listado_pacientes.php");
        exit;
     }

}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <title>Agregar Paciente</title>
    <style>
        body {
            background-color: #f9f9f9;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 800px;
            background: #fff;
            padding: 20px;
            margin-top: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        header {
            font-size: 1.5rem;
            font-weight: bold;
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-section {
            margin-bottom: 20px;
        }

        .form-section .section-title {
            font-size: 1.2rem;
            font-weight: bold;
            color: #495057;
            margin-bottom: 15px;
            border-bottom: 2px solid #dee2e6;
            padding-bottom: 5px;
        }

        .form-control {
            border-radius: 5px;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
</head>

<body>


    <div class="container">
        <header>Agregar de Paciente</header>
        <form action="" method="POST">

            <!-- Datos de Usuario -->
            <div class="form-section">
                <div class="section-title">Datos de Usuario</div>
                <div class="mb-3">
                    <label for="usuario" class="form-label">Usuario</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                        <input type="text" id="usuario" name="usuario" class="form-control" placeholder="Ingrese un usuario" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="correo" class="form-label">Correo</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                        <input type="email" id="correo" name="correo" class="form-control" placeholder="Ingrese un correo" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="contraseña" class="form-label">Contraseña</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" id="contraseña" name="contraseña" class="form-control" placeholder="Ingrese una contraseña" required>
                    </div>
                </div>
            </div>

            <!-- Datos Personales -->
            <div class="form-section">
                <div class="section-title">Datos Personales</div>
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
                        <label for="num_doc" class="form-label">Número de Documento</label>
                        <input type="text" id="num_doc" name="num_doc" class="form-control" placeholder="Ingrese su número de documento" required>
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
                        <label for="fecha_nac" class="form-label">Fecha de Nacimiento</label>
                        <input type="date" id="fecha_nac" name="fecha_nac" class="form-control" required>
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
                <input type="text" class="form-control" id="otro" name="otro"  placeholder="Ingrese detalles de su ubicación."></textarea>
            </div>


            <!-- Seguridad -->
            <div class="form-section">
                <div class="section-title">Preguntas de Seguridad</div>
                <div class="mb-3">
                    <label for="pregunta_s1" class="form-label">Pregunta de Seguridad 1</label>
                    <select id="pregunta_s1" name="pregunta_s1" class="form-select" required>
                        <option disabled selected>Seleccione una pregunta</option>
                        <option value="madre">Nombre de mi madre</option>
                        <option value="mascota">Nombre de mi mascota</option>
                        <option value="colegio">Nombre de mi primer colegio</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="respuesta_1" class="form-label">Respuesta</label>
                    <input type="text" id="respuesta_1" name="respuesta_1" class="form-control" placeholder="Ingrese su respuesta" required>
                </div>
                <div class="mb-3">
                    <label for="pregunta_s2" class="form-label">Pregunta de Seguridad 2</label>
                    <select id="pregunta_s2" name="pregunta_s2" class="form-select" required>
                        <option disabled selected>Seleccione una pregunta</option>
                        <option value="hermano">Nombre de mi hermano mayor</option>
                        <option value="pelicula">Película favorita</option>
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
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>

<script src="script/registro.js"></script>

</html>
