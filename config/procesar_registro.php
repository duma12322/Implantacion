<?php
// config/procesar_registro.php
require_once 'conexion.php'; // Conexión a la base de datos

// Recibir datos del formulario
$usuario = $_POST['usuario'];
$correo = $_POST['correo'];
$contraseña = md5($_POST['contraseña']); // Contraseña con MD5

// Verificar si el usuario o el correo ya existen
$query = $conn->prepare("SELECT COUNT(*) FROM usuario WHERE usuario = ? OR correo = ?");
$query->execute([$usuario, $correo]);
$count = $query->fetchColumn();

if ($count > 0) {
    // Si ya existe, mostrar el mensaje de error con SweetAlert
    echo "
        <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'El usuario o correo ya existe. Por favor, elige otro.',
                    showConfirmButton: true,
                    confirmButtonText: 'Aceptar'
                }).then(function() {
                    window.history.back();
                });
            });
        </script>
    ";
    exit;
}

// Insertar datos en la tabla usuario
$query = $conn->prepare("INSERT INTO usuario (usuario, correo, contraseña) VALUES (?, ?, ?)");
$query->execute([$usuario, $correo, $contraseña]);

// Obtener el ID del usuario insertado
$id_usuario = $conn->lastInsertId();

// Guardar el ID del usuario en la sesión para usarlo en el segundo paso del registro
session_start();
$_SESSION['id_usuario'] = $id_usuario;

// Redirigir a la siguiente página
header("Location: ../app/vistas/registro_paciente2.php");
exit;
