<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil de Usuario</title>
    <link rel="stylesheet" href="ruta/a/tu/estilo.css">
</head>

<body>

    <header class="header">
        <div class="dropdown">
            <!-- Botón del dropdown con la foto y el nombre del usuario -->
            <button class="dropbtn">
                <!-- Aquí se muestra la foto del usuario -->
                <?php if (!empty($usuario['foto'])): ?>
                    <img src="data:image/jpeg;base64,<?php echo base64_encode($usuario['foto']); ?>" class="patient-photo" alt="Foto del usuario" />
                <?php else: ?>
                    <!-- Si no hay foto, se muestra la del avatar -->
                    <img src="files/avatar.png" class="patient-photo" alt="Avatar por defecto" />
                <?php endif; ?>

                <!-- Mostrar el nombre del usuario -->
                <?php echo htmlspecialchars($nombreUsuario); ?>
            </button>
            <div class="dropdown-content">
                <a href="../../config/redirect.php">Perfil</a>
                <a href="../../config/logout.php">Cerrar Sesion</a>
            </div>
        </div>
    </header>

</body>

</html>
