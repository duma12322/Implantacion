<!DOCTYPE html>
<html lang="es">

<header class="header">
    <div class="dropdown">
        <!-- Botón del dropdown con la foto y el nombre del usuario -->
        <button class="dropbtn">
            <img src="ruta/a/la/foto.jpg" class="patient-photo" />
            <?php echo $nombreUsuario; // Aquí se muestra el nombre del usuario 
            ?>
        </button>
        <div class="dropdown-content">
            <a href="#">Perfil</a>
            <a href="../../config/logout.php">Cerrar Sesion</a>
        </div>
    </div>
</header>


<body>