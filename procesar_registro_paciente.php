<?php
require_once "conexion/conexion.php";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $usuario = $_POST['usuario'];
    $contraseña = password_hash($_POST['contraseña'], PASSWORD_DEFAULT);
    $correo = $_POST['correo'];
    $nombre1 = $_POST['nombre1'];
    $apellido1 = $_POST['apellido1'];
    $num_doc = $_POST['num_doc'];
    $telefono = $_POST['telefono'];

    try {
        $query = $conn->prepare("INSERT INTO usuario (usuario, contraseña, correo, Nombre1, Apellido1, num_doc, Telefono, status)
                                 VALUES (:usuario, :contraseña, :correo, :nombre1, :apellido1, :num_doc, :telefono, 'activo')");
        $query->bindParam(':usuario', $usuario);
        $query->bindParam(':contraseña', $contraseña);
        $query->bindParam(':correo', $correo);
        $query->bindParam(':nombre1', $nombre1);
        $query->bindParam(':apellido1', $apellido1);
        $query->bindParam(':num_doc', $num_doc);
        $query->bindParam(':telefono', $telefono);
        $query->execute();

        echo "Paciente registrado exitosamente.";
    } catch (Exception $e) {
        die("Error al registrar paciente: " . $e->getMessage());
    }
}
