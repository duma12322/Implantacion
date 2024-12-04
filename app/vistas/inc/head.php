<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?php echo APP_NAME; ?></title>
<?php

$pagina_actual = $url[0] ?? "inicio"; // Página por defecto: "inicio"

$links_paginas = [
    "inicio" => "./app/vistas/links/inicio-links.php",
    "inicio-paciente" => "./app/vistas/links/inicio-paciente-links.php",
    "login-paciente" => "./app/vistas/links/login-paciente-links.php",
    "inicio-psicologo-admin" => "./app/vistas/links/inicio-psicologo-admin-link.php",
];

$links_generales = "./app/vistas/links/general-links.php";
?>
<?php require_once $links_generales; ?>
<?php if (isset($links_paginas[$pagina_actual])): ?>
<?php require_once $links_paginas[$pagina_actual]; ?>
<?php endif; ?>