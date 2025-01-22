<?php
session_start();
require_once __DIR__ . '/conexion.php';

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

// Verificar si el ID existe en la tabla administrativo
$sql_admin = "SELECT * FROM administrativo WHERE id_administrativo = :id_administrativo";
$stmt_admin = $conn->prepare($sql_admin);
$stmt_admin->bindParam(':id_administrativo', $id_administrativo);
$stmt_admin->execute();
$admin_data = $stmt_admin->fetch(PDO::FETCH_ASSOC);

// Verificar si el ID existe en la tabla psicologo
$sql_psicologo = "SELECT * FROM psicologo WHERE id_administrativo = :id_administrativo";
$stmt_psicologo = $conn->prepare($sql_psicologo);
$stmt_psicologo->bindParam(':id_administrativo', $id_administrativo);
$stmt_psicologo->execute();
$psicologo_data = $stmt_psicologo->fetch(PDO::FETCH_ASSOC);

// Condicionar la redirección
if ($admin_data) {
    if ($psicologo_data) {
        // Si existe en ambas tablas, redirigir a la página de perfil del psicólogo
        header("Location: ../app/vistas/perfil_psicologo.php" );
        exit;
    } else {
        // Si solo existe en la tabla administrativo, redirigir a la página de perfil del administrador
        header("Location: ../app/vistas/perfil_administrador.php");
        exit;
    }
} 
?>