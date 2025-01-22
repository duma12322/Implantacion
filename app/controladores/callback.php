<?php
session_start();
require_once('../../vendor/autoload.php');

// Crear el cliente de Google
$client = new Google_Client();
$client->setApplicationName('Implantacion');
$client->setScopes(Google_Service_Calendar::CALENDAR);
$client->setAuthConfig('../../credentials.json');
$client->setAccessType('offline');

// Ruta del archivo del token
$tokenPath = '../../token.json';

// Obtener el código de autorización
if (isset($_GET['code'])) {
    $accessToken = $client->fetchAccessTokenWithAuthCode($_GET['code']);
    $client->setAccessToken($accessToken);

    // Guardar el token para uso futuro
    if (!file_exists(dirname($tokenPath))) {
        mkdir(dirname($tokenPath), 0700, true);
    }
    file_put_contents($tokenPath, json_encode($client->getAccessToken()));

    // Redirigir a redireccionar.php
    header("Location: /implantacion/app/controladores/redireccionar.php");
    exit;
}

// Leer el token de acceso del archivo
if (file_exists($tokenPath)) {
    $accessToken = json_decode(file_get_contents($tokenPath), true);
    $client->setAccessToken($accessToken);

    // Si el token ha expirado, refrescarlo
    if ($client->isAccessTokenExpired()) {
        $client->fetchAccessTokenWithRefreshToken($client->getRefreshToken());
        // Guardar el nuevo access token
        file_put_contents($tokenPath, json_encode($client->getAccessToken()));
    }

    // Redirigir a redireccionar.php
    header("Location: /implantacion/app/controladores/redireccionar.php");
    exit;
}

// Si no hay token, solicitar autorización
if (!$client->getAccessToken()) {
    $authUrl = $client->createAuthUrl();
    header("Location: $authUrl");
    exit;
}

echo "Error al obtener el código de autorización.";
