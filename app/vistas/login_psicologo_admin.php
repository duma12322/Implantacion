<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Psicologo/Admin</title>
    <link rel="stylesheet" href="css/login_psicologo_admin.css">
</head>

<body>
    <div class="wrapper">
        <form action="../../config/procesar_login.php" method="POST">
            <h2>Login Psicologo/Admin</h2>
            <div class="input-field">
                <input type="text" name="usuario" id="usuario" placeholder=" " required>
                <label for="usuario">Usuario</label>
            </div>
            <div class="input-field">
                <input type="password" name="contraseña" id="contraseña" placeholder=" " required>
                <label for="contraseña">Contraseña</label>
            </div>
            <input type="hidden" name="tipo" value="psicologo_admin">
            <div class="forget">
                <label for="remember">
                    <input type="checkbox" id="remember">
                    <p>Recuérdame</p>
                </label>
                <!--<a href="#">¿Olvidaste tu contraseña?</a>-->
            </div>
            <button type="submit">Iniciar Sesión</button>
            <!--<div class="register">
                <p>¿No tienes una cuenta? <a href="#">Regístrate</a></p>
            </div> -->
        </form>
    </div>
</body>

</html>