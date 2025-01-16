<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recuperar Contraseña</title>
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
                <form action="../controladores/verificar_usuario.php" method="POST">
                    <div class="title">Recuperar Contraseña</div>
                    <div class="input-boxes">
                        <div class="input-box">
                            <i class="bi bi-envelope-fill"></i>
                            <input type="text" name="usuario_correo" placeholder="Ingresa tu correo" required>
                        </div>
                        <div class="button input-box">
                            <input type="submit" value="Siguiente">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>

</html>