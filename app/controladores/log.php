<?php

function registrar_log($usuario, $accion)
{
    include '../../config/conexion.php'; // Incluye la conexión a la base de datos

    try {
        $query = "INSERT INTO logs (usuario, accion, fecha) VALUES (:usuario, :accion, NOW())";
        $stmt = $conn->prepare($query);
        $stmt->bindValue(':usuario', $usuario, PDO::PARAM_STR);
        $stmt->bindValue(':accion', $accion, PDO::PARAM_STR);
        $stmt->execute();
    } catch (PDOException $e) {
        die("Error al registrar en la bitácora: " . $e->getMessage());
    }
}
