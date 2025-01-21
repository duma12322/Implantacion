<aside class="sidebar collapsed">
    <!-- Sidebar header -->
    <header class="sidebar-header">
        <a href="<?php echo ($_SESSION['tipo_usuario'] === 'paciente') ? 'agendar_cita.php' : 'dashboard.php'; ?>" class="header-logo">
            <img src="files/logo.png" alt="Psicologia">
        </a>
        <button class="toggler sidebar-toggler">
            <i class="bi bi-caret-right-square-fill"></i>
        </button>
        <button class="toggler menu-toggler">
            <span class="material-symbols-rounded">menu</span>
        </button>
    </header>

    <nav class="sidebar-nav">
        <!-- Primary top nav -->
        <ul class="nav-list primary-nav">
            <?php if ($_SESSION['tipo_usuario'] === 'administrativo' || $_SESSION['tipo_usuario'] === 'psicologo') : ?>
                <li class="nav-item">
                    <a href="dashboard.php" class="nav-link">
                        <i class="bi bi-house-fill"></i>
                        <span class="nav-label">Inicio</span>
                    </a>
                    <span class="nav-tooltip">Inicio</span>
                </li>
            <?php endif; ?>

            <?php if ($_SESSION['tipo_usuario'] === 'administrativo' || $_SESSION['tipo_usuario'] === 'psicologo') : ?>
                <li class="nav-item">
                    <a href="agendar_cita.php" class="nav-link">
                        <i class="bi bi-calendar-plus-fill"></i>
                        <span class="nav-label">Agendar Cita</span>
                    </a>
                    <span class="nav-tooltip">Agendar Cita</span>
                </li>
                <li class="nav-item">
                    <a href="consultar_cita.php" class="nav-link">
                        <i class="bi bi-clipboard-heart-fill"></i>
                        <span class="nav-label">Consultar Citas</span>
                    </a>
                    <span class="nav-tooltip">Consultar Citas</span>
                </li>
            <?php endif; ?>

            <?php if ($_SESSION['tipo_usuario'] === 'paciente') : ?>
                <li class="nav-item">
                    <a href="agendar_cita.php" class="nav-link">
                        <i class="bi bi-calendar-plus-fill"></i>
                        <span class="nav-label">Agendar Cita</span>
                    </a>
                    <span class="nav-tooltip">Agendar Cita</span>
                </li>
                <li class="nav-item">
                    <a href="consultar_cita_paciente.php" class="nav-link">
                        <i class="bi bi-clipboard-heart-fill"></i>
                        <span class="nav-label">Consultar Citas</span>
                    </a>
                    <span class="nav-tooltip">Consultar Citas</span>
                </li>
            <?php endif; ?>

            <?php if ($_SESSION['tipo_usuario'] === 'administrativo' || $_SESSION['tipo_usuario'] === 'psicologo') : ?>
                <li class="nav-item">
                    <a href="../vistas/listado_Psicologos.php" class="nav-link">
                        <i class="bi bi-person-hearts"></i>
                        <span class="nav-label">Psicologos</span>
                    </a>
                    <span class="nav-tooltip">Psicologos</span>
                </li>
                <li class="nav-item">
                    <a href="../vistas/listado_pacientes.php" class="nav-link">
                        <i class="bi bi-person-plus-fill"></i>
                        <span class="nav-label">Pacientes</span>
                    </a>
                    <span class="nav-tooltip">Pacientes</span>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-person-vcard-fill"></i>
                        <span class="nav-label">Historiales</span>
                    </a>
                    <span class="nav-tooltip">Historiales</span>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="bi bi-file-earmark-text-fill"></i>
                        <span class="nav-label">Reportes</span>
                    </a>
                    <span class="nav-tooltip">Reportes</span>
                </li>
            <?php endif; ?>

            <?php if ($_SESSION['tipo_usuario'] === 'administrativo') : ?>
                <!-- Solo administrativo puede ver Logs -->
                <li class="nav-item">
                    <a href="bitacora_front.php" class="nav-link">
                        <i class="bi bi-gear-fill"></i>
                        <span class="nav-label">Logs</span>
                    </a>
                    <span class="nav-tooltip">Logs</span>
                </li>
            <?php endif; ?>
        </ul>
    </nav>
</aside>