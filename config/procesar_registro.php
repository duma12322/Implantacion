<?php
// config/procesar_registro.php
require_once 'conexion.php'; // Conexión a la base de datos

// Recibir datos del formulario
$usuario = $_POST['usuario'];
$correo = $_POST['correo'];
$contraseña = md5($_POST['contraseña']); // Contraseña con MD5

// Insertar datos en la tabla usuario
$query = $conn->prepare("INSERT INTO usuario (usuario, correo, contraseña) VALUES (?, ?, ?)");
$query->execute([$usuario, $correo, $contraseña]);

// Obtener el ID del usuario insertado
$id_usuario = $conn->lastInsertId();

// Guardar el ID del usuario en la sesión para usarlo en el segundo paso del registro
session_start();
$_SESSION['id_usuario'] = $id_usuario;

header("Location: ../app/vistas/registro_paciente2.php");
exit;
