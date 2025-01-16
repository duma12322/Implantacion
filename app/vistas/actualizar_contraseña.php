<?php
require_once '../../config/conexion.php';
session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_usuario = $_SESSION['id_usuario'];
    $nueva_contraseña = md5($_POST['nueva_contraseña']); // Cambiar hashing si es necesario

    $sql = "UPDATE usuario SET contraseña = ? WHERE id_usuario = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('si', $nueva_contraseña, $id_usuario);

    if ($stmt->execute()) {
        session_destroy();
        echo "<script>alert('Contraseña actualizada exitosamente.'); window.location.href='../../index.php';</script>";
    } else {
        echo "<script>alert('Hubo un error. Intenta de nuevo.'); window.location.href='restablecer_contraseña.php';</script>";
    }
}
