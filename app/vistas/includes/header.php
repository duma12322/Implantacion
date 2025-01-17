<!DOCTYPE html>
<html lang="es">
<header class="header">
    <div class="dropdown">
        <!-- Botón del dropdown con la foto y el nombre del usuario -->
        <button class="dropbtn">
            <img src="ruta/a/la/foto.jpg" class="patient-photo" />
            <?php echo htmlspecialchars($nombreUsuario); ?>
        </button>
        <div class="dropdown-content">
            <a href="perfil.php">Perfil</a>
            <a href="../../config/logout.php">Cerrar Sesion</a>
        </div>
    </div>
</header>

<body>
    <!-- Aquí el contenido de tu página -->
</body>

</html>