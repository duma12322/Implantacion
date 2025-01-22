<?php
session_start();

// Verificar y establecer valores predeterminados para las claves de sesión
$tipoCita = isset($_SESSION['tipoCita']) ? $_SESSION['tipoCita'] : 'individual';
$modalidad = isset($_SESSION['modalidad']) ? $_SESSION['modalidad'] : 'presencial';
$tipoUsuario = isset($_SESSION['tipo_usuario']) ? $_SESSION['tipo_usuario'] : 'paciente';

// Mensajes de depuración
echo "tipoCita: $tipoCita<br>";
echo "modalidad: $modalidad<br>";
echo "tipoUsuario: $tipoUsuario<br>";

// Definir la ruta base de redirección
$rutaBase = '/implantacion/app/controladores/';

// Lógica de redirección
if ($tipoCita == 'pareja') {
    if ($modalidad == 'presencial') {
        if ($tipoUsuario === 'paciente') {
            $ruta = 'procesar_cita_pareja_presencial.php';
        } else {
            $ruta = 'procesar_cita_pareja_presencial2.php';
        }
    } else {
        if ($tipoUsuario === 'paciente') {
            $ruta = 'procesar_cita_pareja_online.php';
        } else {
            $ruta = 'procesar_cita_pareja_online2.php';
        }
    }
} elseif ($tipoCita == 'infantil') {
    if ($modalidad == 'presencial') {
        if ($tipoUsuario === 'paciente') {
            $ruta = 'procesar_cita_infantil_presencial.php';
        } else {
            $ruta = 'procesar_cita_infantil_presencial2.php';
        }
    } else {
        if ($tipoUsuario === 'paciente') {
            $ruta = 'procesar_cita_infantil_online.php';
        } else {
            $ruta = 'procesar_cita_infantil_online2.php';
        }
    }
} elseif ($tipoCita == 'adolescente') {
    if ($modalidad == 'presencial') {
        if ($tipoUsuario === 'paciente') {
            $ruta = 'procesar_cita_adolescente_presencial.php';
        } else {
            $ruta = 'procesar_cita_adolescente_presencial2.php';
        }
    } else {
        if ($tipoUsuario === 'paciente') {
            $ruta = 'procesar_cita_adolescente_online.php';
        } else {
            $ruta = 'procesar_cita_adolescente_online2.php';
        }
    }
} else {
    // Por defecto, se asume que es una cita individual
    if ($modalidad == 'presencial') {
        if ($tipoUsuario === 'paciente') {
            $ruta = 'procesar_agendar_cita.php';
        } else {
            $ruta = 'procesar_agendar_cita2.php';
        }
    } elseif ($modalidad == 'online') {
        if ($tipoUsuario === 'paciente') {
            $ruta = 'procesar_agendar_cita_online.php';
        } else {
            $ruta = 'procesar_agendar_cita_online2.php';
        }
    }
}

// Redirigir a la ruta adecuada
echo "Redirigiendo a: " . $rutaBase . $ruta;
header("Location: " . $rutaBase . $ruta);
exit;
