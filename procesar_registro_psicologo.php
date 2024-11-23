<?php
require_once "conexion/conexion.php";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nombre1 = $_POST['nombre1'];
    $apellido1 = $_POST['apellido1'];
    $correo = $_POST['correo'];
    $id_especialidad = $_POST['id_especialidad'];

    try {
        // Insertar en la tabla administrativo
        $queryAdmin = $conn->prepare("INSERT INTO administrativo (usuario, contraseña, Nombre1, Apellido1, tipo_doc, num_doc, correo, Fecha_Nac, telefono, status)
                                      VALUES ('', '', :nombre1, :apellido1, 'V', '', :correo, '2000-01-01', '', 'activo')");
        $queryAdmin->bindParam(':nombre1', $nombre1);
        $queryAdmin->bindParam(':apellido1', $apellido1);
        $queryAdmin->bindParam(':correo', $correo);
        $queryAdmin->execute();

        $id_administrativo = $conn->lastInsertId();

        // Insertar en la tabla psicologo
        $queryPsico = $conn->prepare("INSERT INTO psicologo (id_espe_psicologo, id_administrativo)
                                      VALUES (:id_especialidad, :id_administrativo)");
        $queryPsico->bindParam(':id_especialidad', $id_especialidad);
        $queryPsico->bindParam(':id_administrativo', $id_administrativo);
        $queryPsico->execute();

        echo "Psicólogo registrado exitosamente.";
    } catch (Exception $e) {
        die("Error al registrar psicólogo: " . $e->getMessage());
    }
}
