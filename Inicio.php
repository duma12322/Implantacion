<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio Psicólogo</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/inicio.css">
</head>

<body>
    <!-- Navegación -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto"> <!-- Centra los elementos en la barra -->
                <li class="nav-item">
                    <a class="nav-link nav-custom" href="Inicio.php">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-custom" href="#acercademi">Acerca de mi</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-custom" href="#services">Servicios</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-custom" href="#contact">Contacto</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Encabezado -->
    <header class="py-5 text-white" style="background: linear-gradient(to bottom, #4D774E, #164A41);">
        <div class="container">
            <div class="row align-items-center">
                <!-- Columna izquierda: Logo y botones -->
                <div class="col-md-6 d-flex flex-column justify-content-center text-center text-md-left">
                    <h1 class="display-4">Bienvenido a "nombre de la empresa"</h1>
                    <p class="lead">Cuidar tu salud mental es el primer paso hacia una vida plena.</p>
                    <div class="d-flex justify-content-start">
                        <a href="login_paciente.php" class="btn btn-light btn-lg mt-3 mr-2">Ingresa</a>
                        <a href="registro_paciente.php" class="btn btn-light btn-lg mt-3">Registrate</a>
                    </div>
                </div>

                <!-- Columna derecha: Imagen con servicios -->
                <div class="col-md-6" style="position: relative; left: 60px;">
                    <img src="files/collage.png" alt="Servicios" class="img-fluid rounded shadow">
                </div>

            </div>
        </div>
    </header>

    <!-- Acerca de mi (psicologa) -->
    <section id="acercademi" class="py-5" style="background-color: #9DC88D;">
        <div class="container text-center">
            <h2 class="mb-4">Acerca de mí</h2>
            <div class="perfil-cuadro" style="max-width: 400px; margin: 0 auto; border: 2px solid #ccc; padding: 15px; border-radius: 10px; background-color: #fff;">
                <img src="files/Marce.png" alt="Foto de la psicóloga" style="width: 150px; height: 150px; object-fit: cover; border-radius: 50%; margin-bottom: 15px;">
                <p>
                    Soy una psicóloga con amplia experiencia en terapia cognitivo-conductual, ayudando a mis pacientes a
                    superar sus desafíos emocionales y mejorar su calidad de vida.
                </p>
            </div>
        </div>
    </section>


    <!-- Servicios -->
    <section id="services" class="py-5" style="background-color: #FFFFFF;">
        <div class=" container text-center">
            <h2 class="mb-4">Servicios</h2>
            <div class="row row-cols-1 row-cols-md-2 g-4"> <!-- Ajuste para 2 columnas -->
                <div class="col">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Terapia Individual</h5>
                            <p class="card-text">Sesiones diseñadas para ayudarte a afrontar tus desafíos personales.</p>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Terapia Infantil</h5>
                            <p class="card-text">Ayudamos a los niños a expresar sus emociones y superar desafíos.</p>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Terapia de Pareja</h5>
                            <p class="card-text">Fortalece tu relación y mejora la comunicación con tu pareja.</p>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Orientación Familiar</h5>
                            <p class="card-text">Trabajemos juntos para fomentar la armonía en tu hogar.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contacto -->
    <section id="contact" class="py-3 text-white" style="background-color: #D88E3C;">
        <div class=" container text-center">
            <h2 class="mb-4">Contacto</h2>

            <!-- Información de contacto -->
            <div class="row">
                <div class="col-md-4">
                    <h5>Correo Electrónico</h5>
                    <p><a href="mailto:contacto@psicologo.com" class="text-white">contacto@psicologo.com</a></p>
                </div>
                <div class="col-md-4">
                    <h5>Teléfonos</h5>
                    <p>0412-0515005 | 0251-7178172</p>
                </div>
                <div class="col-md-4">
                    <h5>Visítanos</h5>
                    <a href="https://www.google.com/maps?q=40.730610,-73.997318" target="_blank" rel="noopener noreferrer">
                        <i class="bi bi-geo-alt" style="font-size: 2rem; color: #007bff;"></i>
                    </a>
                    <p class="mt-2 small">Ver mapa</p>
                </div>
            </div>

            <h3 class="mt-4">Síguenos en nuestras redes sociales</h3>
            <div class="d-flex justify-content-center mt-3">
                <a href="https://www.facebook.com/psicologo" class="mx-2" target="_blank" aria-label="Facebook">
                    <i class="bi bi-facebook" style="font-size: 2rem; color: #3b5998;"></i>
                </a>
                <a href="https://www.instagram.com/psicologo" class="mx-2" target="_blank" aria-label="Instagram">
                    <i class="bi bi-instagram" style="font-size: 2rem; color: #E1306C;"></i>
                </a>
                <a href="https://www.x.com/psicologo" class="mx-2" target="_blank" aria-label="X">
                    <i class="bi bi-twitter" style="font-size: 2rem; color: #1DA1F2;"></i>
                </a>
            </div>
        </div>
    </section>

    <!-- Footer de página -->
    <footer class="py-2 text-white text-center" style="background-color: #D88E3C;">
        <p>© 2024 Psicólogo. Todos los derechos reservados.</p>
    </footer>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>