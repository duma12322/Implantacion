<?php

require_once "./config/app.php";
require_once "./autoload.php";

/*---------- Iniciando sesion ----------*/
require_once "./app/vistas/inc/session_start.php";

if (isset($_GET['views'])) {
    $url = explode("/", $_GET['views']);
} else {
    $url = ["inicio"];
}

?>
<!DOCTYPE html>
<html lang="es">
<head>
<?php require_once "./app/vistas/inc/head.php"; ?>
</head>
<body>
<?php
use app\controladores\vistaControlador;
use app\controladores\loginControlador;

$insLogin = new loginControlador();

$vistaControlador = new vistaControlador();
$vista = $vistaControlador->obtenerVistasControlador($url[0]);

if ($vista == "inicio" || $vista == "404") {
    require_once "./app/vistas/contenido/" . $vista . "-view.php";
} else {
    
    if (empty($_SESSION['id']) || empty($_SESSION['usuario'])) {
        if (!in_array($url[0], ['inicio', 'login-paciente'])) {
            header("Location: " . APP_URL . "login-paciente/");
            exit();
        }
    }

    // Aqui excluyo el nav-admin en la página "inicio"... Preguntar a Marce si dejamos 
    // un solo nav-bar general
    $paginaActual = $url[0]; // Este fragmento obtiene la página actual, ojo al detalle
    if ($paginaActual !== 'inicio') { 
        // Cargar nav según el usuario... Sugerir a las chicas modificar algunas tablas(usuarios, psicologo, paciente, administrativo)
        if (isset($_SESSION['usuario'])) {
            require_once "./app/vistas/inc/nav-admin.php";
        }
    }

    require_once $vista;
}
?>
<?php
$scripts_paginas = [
    "inicio" => "./app/vistas/scripts/inicio-scripts.php",
    "inicio-paciente" => "./app/vistas/scripts/inicio-paciente-scripts.php",
    "inicio-psicologo-admin" => "./app/vistas/scripts/inicio-psicologo-admin-scripts.php",
    "registro-paciente" => "./app/vistas/scripts/inicio-psicologo-admin-scripts.php",
];
$scripts_generales = "./app/vistas/scripts/general-scripts.php";
?>
<?php require_once $scripts_generales; ?>
<?php $pagina_actual = $url[0];
if (isset($scripts_paginas[$pagina_actual])): ?>
<?php require_once $scripts_paginas[$pagina_actual]; ?>
<?php endif; ?>
</body>
</html>