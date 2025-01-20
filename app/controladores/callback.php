<?php
session_start();
require_once('../../vendor/autoload.php');

// Crear el cliente de Google
$client = new Google_Client();
$client->setApplicationName('Implantacion');
$client->setScopes(Google_Service_Calendar::CALENDAR);
$client->setAuthConfig('../../credentials.json');
$client->setAccessType('offline');

// Obtener el código de autorización
if (isset($_GET['code'])) {
    $tokenPath = '../../token.json';
    $accessToken = $client->fetchAccessTokenWithAuthCode($_GET['code']);
    $client->setAccessToken($accessToken);

    // Guardar el token para uso futuro
    if (!file_exists(dirname($tokenPath))) {
        mkdir(dirname($tokenPath), 0700, true);
    }
    file_put_contents($tokenPath, json_encode($client->getAccessToken()));

    // Redirigir al script de procesamiento de la cita
    $tipoCita = $_SESSION['tipoCita'];
    $modalidad = $_SESSION['modalidad'];
    $tipoUsuario = $_SESSION['tipo_usuario'];

    if ($tipoCita == 'pareja') {
        if ($modalidad == 'presencial') {
            if ($tipoUsuario === 'paciente') {
                header("Location: /implantacion/app/controladores/procesar_cita_pareja_presencial.php");
            } elseif ($tipoUsuario === 'administrativo' || $tipoUsuario === 'psicologo') {
                header("Location: /implantacion/app/controladores/procesar_cita_pareja_presencial2.php");
            }
        } elseif ($modalidad == 'online') {
            if ($tipoUsuario === 'paciente') {
                header("Location: /implantacion/app/controladores/procesar_cita_pareja_online.php");
            } elseif ($tipoUsuario === 'administrativo' || $tipoUsuario === 'psicologo') {
                header("Location: /implantacion/app/controladores/procesar_cita_pareja_online2.php");
            }
        }
    } elseif ($tipoCita == 'infantil') {
        if ($modalidad == 'presencial') {
            if ($tipoUsuario === 'paciente') {
                header("Location: /implantacion/app/controladores/procesar_cita_infantil_presencial.php");
            } elseif ($tipoUsuario === 'administrativo' || $tipoUsuario === 'psicologo') {
                header("Location: /implantacion/app/controladores/procesar_cita_infantil_presencial2.php");
            }
        } elseif ($modalidad == 'online') {
            if ($tipoUsuario === 'paciente') {
                header("Location: /implantacion/app/controladores/procesar_cita_infantil_online.php");
            } elseif ($tipoUsuario === 'administrativo' || $tipoUsuario === 'psicologo') {
                header("Location: /implantacion/app/controladores/procesar_cita_infantil_online2.php");
            }
        }
    } elseif ($tipoCita == 'adolescente') {
        if ($modalidad == 'presencial') {
            if ($tipoUsuario === 'paciente') {
                header("Location: /implantacion/app/controladores/procesar_cita_adolescente_presencial.php");
            } elseif ($tipoUsuario === 'administrativo' || $tipoUsuario === 'psicologo') {
                header("Location: /implantacion/app/controladores/procesar_cita_adolescente_presencial2.php");
            }
        } elseif ($modalidad == 'online') {
            if ($tipoUsuario === 'paciente') {
                header("Location: /implantacion/app/controladores/procesar_cita_adolescente_online.php");
            } elseif ($tipoUsuario === 'administrativo' || $tipoUsuario === 'psicologo') {
                header("Location: /implantacion/app/controladores/procesar_cita_adolescente_online2.php");
            }
        }
    } else { // Por defecto, se asume que es una cita individual
        if ($modalidad == 'presencial') {
            if ($tipoUsuario === 'paciente') {
                header("Location: /implantacion/app/controladores/procesar_agendar_cita.php");
            } elseif ($tipoUsuario === 'administrativo' || $tipoUsuario === 'psicologo') {
                header("Location: /implantacion/app/controladores/procesar_agendar_cita2.php");
            }
        } elseif ($modalidad == 'online') {
            if ($tipoUsuario === 'paciente') {
                header("Location: /implantacion/app/controladores/procesar_agendar_cita_online.php");
            } elseif ($tipoUsuario === 'administrativo' || $tipoUsuario === 'psicologo') {
                header("Location: /implantacion/app/controladores/procesar_agendar_cita_online2.php");
            }
        }
    }
    exit;
}

echo "Error al obtener el código de autorización.";
