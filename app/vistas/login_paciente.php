<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Paciente</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/login_paciente.css">
</head>

<body>
    <div class="container">
        <input type="checkbox" id="flip">
        <div class="cover">
            <div class="front">
                <img src="files/logo.png" alt="">
            </div>
        </div>
        <div class="forms">
            <div class="form-content">
                <!-- Formulario único -->
                <form action="../../config/procesar_login.php" method="POST">
                    <div class="login-form">
                        <div class="title">Login</div>
                        <div class="input-boxes">
                            <div class="input-box">
                                <i class="bi bi-person-fill"></i>
                                <input type="text" name="usuario" placeholder="Ingresa un usuario" required>
                            </div>
                            <div class="input-box">
                                <i class="bi bi-lock-fill"></i>
                                <input type="password" name="contraseña" placeholder="Ingresa la contraseña" required>
                            </div>
                            <input type="hidden" name="tipo" value="paciente">
                            <div class="text"><a href="#">¿Olvidaste tu contraseña?</a></div>
                            <div class="button input-box">
                                <input type="submit" value="Iniciar Sesión">
                            </div>
                            <div class="text sign-up-text2">
                                ¿No tienes una cuenta?
                                <a href="registro_paciente.php">Regístrate ahora</a>
                            </div>
                        </div>

                    </div>

                </form>
            </div>
        </div>
    </div>

</body>

</html>