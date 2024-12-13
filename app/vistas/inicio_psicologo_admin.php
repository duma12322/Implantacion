<?php
session_start();

// Muestra el contenido de la sesión para depuración (si lo necesitas)
//echo '<pre>';
//print_r($_SESSION);
//echo '</pre>';

// Verifica si la sesión está activa
if (!isset($_SESSION['usuario'])) {
    header("Location: login_psicologo.admin.php");
    exit;
}

// Verifica si se hizo clic en el botón de cerrar sesión
if (isset($_POST['cerrar_sesion'])) {
    // Destruye la sesión y redirige al login
    session_unset();
    session_destroy();
    header("Location: login_psicologo_admin.php");
    exit;
}

$nombreUsuario = $_SESSION['nombre']
?>
<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/inicio_psicologo_admin.css">
</head>

<body>

    <!-- Header -->
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

    <aside class="sidebar">
        <!-- Sidebar header -->
        <header class="sidebar-header">
            <a href="#" class="header-logo">
                <img src="files/logo.png" alt="Psicologia">
            </a>
            <button class="toggler sidebar-toggler">
                <i class="bi bi-caret-left-square-fill"></i>
            </button>
            <button class="toggler menu-toggler">
                <span class="material-symbols-rounded">menu</span>
            </button>
        </header>

        <nav class="sidebar-nav">
            <!-- Primary top nav -->
            <ul class="nav-list primary-nav">
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-house-fill"></i>
                        <span class="nav-label">Inicio</span>
                    </a>
                    <span class="nav-tooltip">Inicio</span>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-calendar-plus-fill"></i>
                        <span class="nav-label">Agendar Cita</span>
                    </a>
                    <span class="nav-tooltip">Agendar Cita</span>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-person-hearts"></i>
                        <span class="nav-label">Agregar Psicologo</span>
                    </a>
                    <span class="nav-tooltip">Agregar Psicologo</span>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-person-plus-fill"></i>
                        <span class="nav-label">Agregar Paciente</span>
                    </a>
                    <span class="nav-tooltip">Agregar Paciente</span>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-clipboard-heart-fill"></i>
                        <span class="nav-label">Consultar Citas</span>
                    </a>
                    <span class="nav-tooltip">Consultar Citas</span>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-person-vcard-fill"></i>
                        <span class="nav-label">Historial</span>
                    </a>
                    <span class="nav-tooltip">Historial</span>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-file-earmark-text-fill"></i>
                        <span class="nav-label">Reportes</span>
                    </a>
                    <span class="nav-tooltip">Reportes</span>
                </li>
                <?php if ($_SESSION['tipo_usuario'] === 'administrativo') : ?>
                    <!-- Solo administrativo puede ver Logs -->
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="bi bi-gear-fill"></i>
                            <span class="nav-label">Logs</span>
                        </a>
                        <span class="nav-tooltip">Logs</span>
                    </li>
                <?php endif; ?>
            </ul>

            <!-- <ul class="nav-list secondary-nav">
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <span class="nav-icon material-symbols-rounded">account_circle</span>
                        <span class="nav-label">Profile</span>
                    </a>
                    <span class="nav-tooltip">Profile</span>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <span class="nav-icon material-symbols-rounded">logout</span>
                        <span class="nav-label">Logout</span>
                    </a>
                    <span class="nav-tooltip">Logout</span>
                </li>
            </ul>-->
        </nav>
    </aside>

    <!-- Footer -->
    <!-- <footer>
        <div class="container">
            <p class="mb-0">&copy; <?php echo date("Y"); ?> Todos los derechos reservados.</p>
        </div>
    </footer> -->

    <!-- Script -->
    <script src="script/inicio_paciente.js"></script>
</body>

</html>