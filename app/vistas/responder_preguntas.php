<?php
session_start();

if (!isset($_SESSION['id_usuario'])) {
    header('Location: recuperar_contraseña.php');
    exit();
}

$pregunta1 = $_SESSION['pregunta_s1'];
$pregunta2 = $_SESSION['pregunta_s2'];
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responde las Preguntas</title>
    <link rel="stylesheet" href="css/login_paciente.css">
</head>

<body>
    <div class="container">
        <div class="forms">
            <div class="form-content">
                <form action="verificar_respuestas.php" method="POST">
                    <div class="title">Preguntas de Seguridad</div>
                    <div class="input-boxes">
                        <div class="input-box">
                            <label for="respuesta1"><?php echo $pregunta1; ?></label>
                            <input type="text" name="respuesta1" placeholder="Tu respuesta" required>
                        </div>
                        <div class="input-box">
                            <label for="respuesta2"><?php echo $pregunta2; ?></label>
                            <input type="text" name="respuesta2" placeholder="Tu respuesta" required>
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