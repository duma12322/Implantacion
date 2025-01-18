<!DOCTYPE html>
<html lang="es">
<header class="header">
    <div class="dropdown">
        <!-- Botón del dropdown con la foto y el nombre del usuario -->
        <button class="dropbtn">
            <!-- Aquí se muestra la foto del usuario -->
            <?php if (!empty($usuario['foto'])): ?>
                <img src="data:image/jpeg;base64,<?php echo base64_encode($usuario['foto']); ?>" class="patient-photo" alt="Foto del usuario" />
            <?php else: ?>
                <img src="../files/avatar.png" class="patient-photo" alt="Foto por defecto" />
            <?php endif; ?>

            <?php echo htmlspecialchars($nombreUsuario); ?>
        </button>
        <div class="dropdown-content">
            <a href="perfil_usuario.php">Perfil</a>
            <a href="../../config/logout.php">Cerrar Sesion</a>
        </div>
    </div>
</header>

<body>

</body>

</html>