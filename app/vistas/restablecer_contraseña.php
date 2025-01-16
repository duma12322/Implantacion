<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restablecer Contraseña</title>
    <link rel="stylesheet" href="css/preguntas.css">
</head>

<body>
    <div class="container">
        <div class="form-content">
            <form id="resetPasswordForm" action="../controladores/validar_restablecer_contraseña.php" method="POST">
                <div class="title">Restablecer Contraseña</div>
                <div class="input-box">
                    <label for="nueva_contraseña">Nueva Contraseña:</label>
                    <input type="password" id="nueva_contraseña" name="nueva_contraseña" placeholder="Ingresa la nueva contraseña" required>
                </div>

                <div class="input-box">
                    <label for="confirmar_contraseña">Confirmar Contraseña:</label>
                    <input type="password" id="confirmar_contraseña" name="confirmar_contraseña" placeholder="Confirma tu nueva contraseña" required>
                </div>

                <div class="button input-box">
                    <input type="submit" value="Actualizar Contraseña">
                </div>
            </form>
        </div>
    </div>
</body>

</html>