<?php
require_once __DIR__ . '/../app/controladores/listado_PacienteControlador.php';

use app\controladores\listado_PacienteControlador;

if (isset($_POST['id_usuario'])) {
    $id_usuario = $_POST['id_usuario'];

    $controlador = new listado_PacienteControlador();
    $controlador->eliminarUsuario($id_usuario);
    echo "Usuario eliminado correctamente";
        // Redirigir después de la eliminación
        header('Location: /Implantacion/app/vistas/listado_pacientes.php');
        exit();
    }
?>