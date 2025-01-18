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
    header('Location: ../vistas/agendar_cita_online_individual.php');
    exit;
}

echo "Error al obtener el código de autorización.";
