<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="CSS/registro_paciente.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                <div class="login-form">
                    <div class="title">Parte 1: Registro</div>
                    <form action="registro_paciente2.php" method="POST">
                        <div class="input-boxes">
                            <div class="input-box">
                                <i class="bi bi-person-fill"></i>
                                <input type="usuario" name="usuario" id="usuario" placeholder="Ingresa un usuario" required>
                            </div>
                            <div class="input-box">
                                <i class="bi bi-envelope-fill"></i>
                                <input type="usuario" name="correo" id="correo" placeholder="Ingresa un correo" required>
                            </div>
                            <div class="input-box">
                                <i class="bi bi-lock-fill"></i>
                                <input type="password" name="contraseña" id="contraseña" placeholder="Ingresa una contraseña" required>
                            </div>
                            <div class="button input-box">
                                <input type="submit" value="Siguiente">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>


</html>