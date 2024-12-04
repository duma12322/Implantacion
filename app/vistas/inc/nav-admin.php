
<header class="header">
        <div class="dropdown">
            <!-- Botón del dropdown con la foto y el nombre del usuario -->
            <button class="dropbtn">
                <img src="" class="patient-photo" />
                <?php //echo $nombreUsuario; // Aquí se muestra el nombre del usuario 
                ?>
            </button>
            <div class="dropdown-content">
                <a href="#">Perfil</a>
                <a href="<?php echo APP_URL."cerrar-sesion/"; ?>">Cerrar Sesion</a>
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
            <?php if ($_SESSION['tipo_usuario'] === 'administrativo'): ?>
                <li class="nav-item">
                    <a href="<?php echo APP_URL."inicio-psicologo-admin"; ?>" class="nav-link">
                        <i class="bi bi-house-fill"></i>
                        <span class="nav-label">Inicio</span>
                    </a>
                    <span class="nav-tooltip">Inicio</span>
                </li>
            <?php endif; ?>
            <?php if ($_SESSION['tipo_usuario'] === 'usuario'): ?>
                <li class="nav-item">
                    <a href="<?php echo APP_URL."inicio-paciente"; ?>" class="nav-link">
                        <i class="bi bi-house-fill"></i>
                        <span class="nav-label">Inicio</span>
                    </a>
                    <span class="nav-tooltip">Inicio</span>
                </li>
            <?php endif; ?>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-calendar-plus-fill"></i>
                        <span class="nav-label">Agendar Cita</span>
                    </a>
                    <span class="nav-tooltip">Agendar Cita</span>
                </li>
                <?php if($_SESSION['tipo_usuario'] === 'administrativo') : ?>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-person-hearts"></i>
                        <span class="nav-label">Agregar Psicologo</span>
                    </a>
                    <span class="nav-tooltip">Agregar Psicologo</span>
                </li>
                <?php endif; ?>          
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-clipboard-heart-fill"></i>
                        <span class="nav-label">Consultar Citas</span>
                    </a>
                    <span class="nav-tooltip">Consultar Citas</span>
                </li>
                <?php if($_SESSION['tipo_usuario'] === 'administrativo') : ?>
                <li class="nav-item">
                    <a href="<?php echo APP_URL."registro-paciente/"; ?>" class="nav-link">
                        <i class="bi bi-person-plus-fill"></i>
                        <span class="nav-label">Agregar Paciente</span>
                    </a>
                    <span class="nav-tooltip">Agregar Paciente</span>
                </li>
                <?php endif; ?>  
                <?php if($_SESSION['tipo_usuario'] === 'administrativo') : ?>      
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-person-vcard-fill"></i>
                        <span class="nav-label">Historial</span>
                    </a>
                    <span class="nav-tooltip">Historial</span>
                </li>
                <?php endif ?>
                <?php if($_SESSION['tipo_usuario'] === 'administrativo') : ?>
                    <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-file-earmark-text-fill"></i>
                        <span class="nav-label">Reportes</span>
                    </a>
                    <span class="nav-tooltip">Reportes</span>
                </li>        
                <?php endif ?>
                <?php if($_SESSION['tipo_usuario'] === 'administrativo') : ?>
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
        </nav>
    </aside>