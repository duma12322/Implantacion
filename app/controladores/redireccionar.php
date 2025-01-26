<?php
session_start();
include '../../config/conexion.php';

// Verificar si el usuario está autenticado
if (!isset($_SESSION['usuario'])) {
    header("Location: login_paciente.php");
    exit;
}

// Obtener y establecer modalidad desde POST o la sesión
if (isset($_POST['modalidad'])) {
    $_SESSION['modalidad'] = $_POST['modalidad'];
}

// Asignar valores predeterminados si las variables de sesión no están establecidas
$tipoCita = $_SESSION['tipoCita'] ?? 'individual';
$modalidad = $_SESSION['modalidad'] ?? 'presencial';
$tipoUsuario = $_SESSION['tipo_usuario'] ?? 'paciente';

// Mensajes de depuración
// Puedes desactivar esto en producción
// echo "tipoCita: $tipoCita<br>";
// echo "modalidad: $modalidad<br>";
// echo "tipoUsuario: $tipoUsuario<br>";

// Ruta base para redirecciones
$rutaBase = '/implantacion/app/controladores/';

// Definir la ruta de redirección
if ($tipoCita === 'pareja') {
    $ruta = ($modalidad === 'presencial')
        ? (($tipoUsuario === 'paciente') ? 'procesar_agendar_cita_pareja.php' : 'procesar_agendar_cita_pareja2.php')
        : (($tipoUsuario === 'paciente') ? 'procesar_cita_online_pareja.php' : 'procesar_cita_online_pareja2.php');
} elseif ($tipoCita === 'infantil') {
    $ruta = ($modalidad === 'presencial')
        ? (($tipoUsuario === 'paciente') ? 'procesar_agendar_cita_infantil.php' : 'procesar_agendar_cita_infantil2.php')
        : (($tipoUsuario === 'paciente') ? 'procesar_cita_infantil_online.php' : 'procesar_cita_infantil_online2.php');
} elseif ($tipoCita === 'adolescente') {
    $ruta = ($modalidad === 'presencial')
        ? (($tipoUsuario === 'paciente') ? 'procesar_agendar_cita_adolescente.php' : 'procesar_agendar_cita_adolescente2.php')
        : (($tipoUsuario === 'paciente') ? 'procesar_cita_adolescente_online.php' : 'procesar_cita_adolescente_online2.php');
} else {
    $ruta = ($modalidad === 'presencial')
        ? (($tipoUsuario === 'paciente') ? 'procesar_agendar_cita.php' : 'procesar_agendar_cita2.php')
        : (($tipoUsuario === 'paciente') ? 'procesar_cita_online.php' : 'procesar_cita_online2.php');
}

// Redirigir al archivo correspondiente
header("Location: " . $rutaBase . $ruta);
exit;
