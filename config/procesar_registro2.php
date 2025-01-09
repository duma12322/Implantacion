<?php
require_once 'conexion.php'; // Conexión a la base de datos
session_start();

// Verificar si el id_usuario está presente en la sesión
if (!isset($_SESSION['id_usuario'])) {
    header("Location: registro_paciente.php"); // Si no, redirigir al primer paso
    exit;
}

// Recibir datos del formulario
$nombre1 = $_POST['nombre1'] ?? null;
$tipo_doc = $_POST['tipo_doc'] ?? null;
$id_estado = $_POST['id_estado'] ?? null;
$nombre2 = $_POST['nombre2'] ?? null;
$num_doc = $_POST['num_doc'] ?? null;
$id_ciudad = $_POST['id_ciudad'] ?? null;
$apellido1 = $_POST['apellido1'] ?? null;
$fecha_nac = $_POST['fecha_nac'] ?? null;
$id_parroquia = $_POST['id_parroquia'] ?? null;
$apellido2 = $_POST['apellido2'] ?? null;
$sexo = $_POST['sexo'] ?? null;
$id_municipio = $_POST['id_municipio'] ?? null;
$otro = $_POST['otro'] ?? null;
$telefono = $_POST['telefono'] ?? null;

// Recibir las respuestas de seguridad
$pregunta_s1 = $_POST['pregunta_s1'] ?? null;
$respuesta_1 = $_POST['respuesta_1'] ?? null;
$pregunta_s2 = $_POST['pregunta_s2'] ?? null;
$respuesta_2 = $_POST['respuesta_2'] ?? null;

// Validar campos requeridos
if (!$nombre1 || !$tipo_doc || !$id_estado || !$num_doc || !$id_ciudad || !$apellido1 || !$fecha_nac || !$id_parroquia || !$sexo || !$id_municipio || !$pregunta_s1 || !$respuesta_1 || !$pregunta_s2 || !$respuesta_2) {
    $_SESSION['mensaje'] = 'Por favor completa todos los campos requeridos.';
    $_SESSION['mensaje_tipo'] = 'error';
    header("Location: ../app/vistas/registro_completo.php");
    exit;
}

try {
    // Iniciar una transacción para asegurar que ambas inserciones se realicen correctamente
    $conn->beginTransaction();

    // Obtener el id_usuario desde la sesión
    $id_usuario = $_SESSION['id_usuario'];

    // Actualizar el usuario existente
    $queryUsuario = $conn->prepare("UPDATE usuario SET 
                                tipo_doc = ?, num_doc = ?, nombre1 = ?, nombre2 = ?, apellido1 = ?, 
                                apellido2 = ?, fecha_nac = ?, telefono = ?, pregunta_s1 = ?, 
                                respuesta_1 = ?, pregunta_s2 = ?, respuesta_2 = ?, sexo = ? 
                                WHERE id_usuario = ?");
    $queryUsuario->execute([
        $tipo_doc,
        $num_doc,
        $nombre1,
        $nombre2,
        $apellido1,
        $apellido2,
        $fecha_nac,
        $telefono,
        $pregunta_s1,
        $respuesta_1,
        $pregunta_s2,
        $respuesta_2,
        $sexo,  // Asegúrate de que este campo sea el correcto
        $id_usuario
    ]);


    // Verificar si hubo algún error en la actualización
    if ($queryUsuario->errorCode() != '00000') {
        die('Error en consulta de usuario: ' . implode(", ", $queryUsuario->errorInfo()));
    }

    // Insertar o actualizar la dirección
    $queryDireccion = $conn->prepare("INSERT INTO direccion (id_estado, id_ciudad, id_municipio, id_parroquia, descripcion) 
                                      VALUES (?, ?, ?, ?, ?)");
    $queryDireccion->execute([$id_estado, $id_ciudad, $id_municipio, $id_parroquia, $otro]);

    if ($queryDireccion->errorCode() != '00000') {
        die('Error en consulta de dirección: ' . implode(", ", $queryDireccion->errorInfo()));
    }

    // Obtener el id_direccion recién insertado
    $id_direccion = $conn->lastInsertId();

    // Insertar datos en la tabla paciente
    $queryPaciente = $conn->prepare("INSERT INTO paciente (id_usuario, num_hijos, dispacitado, descrip_disca, id_direccion) 
                                    VALUES (?, ?, ?, ?, ?)");
    $queryPaciente->execute([
        $id_usuario,
        $_POST['num_hijos'],
        $_POST['dispacitado'],
        $_POST['descrip_disca'],
        $id_direccion
    ]);

    // Verificar si hubo algún error en la inserción
    if ($queryPaciente->errorCode() != '00000') {
        die('Error en consulta de paciente: ' . implode(", ", $queryPaciente->errorInfo()));
    }

    // Confirmar la transacción
    $conn->commit();

    // Mensaje de éxito
    $_SESSION['mensaje'] = '¡Registro exitoso!';
    $_SESSION['mensaje_tipo'] = 'success';
    header("Location: ../app/vistas/registro_completo.php");
    exit;
} catch (Exception $e) {
    // Si ocurre un error, revertir la transacción
    $conn->rollBack();
    $_SESSION['mensaje'] = 'Error en el registro: ' . $e->getMessage();
    $_SESSION['mensaje_tipo'] = 'error';
    header("Location: ../app/vistas/registro_completo.php");
    exit;
}
