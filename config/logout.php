<?php
// Iniciar sesión
session_start();

// Verificar si existe la variable de sesión 'tipo_usuario'
if (isset($_SESSION['tipo_usuario'])) {
    // Redirigir a la página correspondiente dependiendo del tipo de usuario
    if ($_SESSION['tipo_usuario'] === 'paciente') {
        header("Location: ../app/vistas/login_paciente.php"); // Redirigir a login de paciente
    } elseif ($_SESSION['tipo_usuario'] === 'psicologo') {
        header("Location: ../app/vistas/login_psicologo_admin.php"); // Redirigir a login de psicólogo
    } elseif ($_SESSION['tipo_usuario'] === 'administrativo') {
        header("Location: ../app/vistas/login_psicologo_admin.php"); // Redirigir a login de administrativo
    }
} else {
    // Si no hay tipo de usuario, redirigir al login general
    header("Location: login.php");
}

// Destruir todas las variables de sesión
session_unset();

// Destruir la sesión
session_destroy();

// Asegurarse de que la ejecución del script se detenga después de la redirección
exit;
