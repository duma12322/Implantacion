<header class="header">
        <div class="dropdown">
            <!-- Botón del dropdown con la foto y el nombre del usuario -->
            <button class="dropbtn">
                <img src="ruta/a/la/foto.jpg" class="patient-photo" />
                <?php echo $usuario; // Aquí se muestra el nombre del usuario 
                ?>
            </button>
            <div class="dropdown-content">
                <a href="#">Perfil</a>
                <a href="logout.php">Cerrar Sesion</a>
            </div>
        </div>
</header>