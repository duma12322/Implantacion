<?php
require_once "../../config/conexion.php";

// Validar si el parámetro 'usuario' está presente
if (!isset($_GET['usuario']) || empty($_GET['usuario'])) {
    echo "Acceso no permitido.";
    exit();
}

// Obtener el dato del usuario o correo desde la URL
$usuarioCorreo = $_GET['usuario'];

// Consulta para obtener las preguntas de seguridad
try {
    $query = "SELECT pregunta_s1, pregunta_s2 FROM usuario WHERE usuario = :dato OR correo = :dato";
    $stmt = $conn->prepare($query);

    // Enlazar el parámetro
    $stmt->bindValue(':dato', $usuarioCorreo, PDO::PARAM_STR);

    // Ejecutar la consulta
    $stmt->execute();

    // Verificar si se encontraron las preguntas
    if ($stmt->rowCount() > 0) {
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $pregunta1 = $result['pregunta_s1'];
        $pregunta2 = $result['pregunta_s2'];
    } else {
        echo "No se encontraron preguntas de seguridad para este usuario o correo.";
        exit();
    }
} catch (PDOException $e) {
    echo "Error en la consulta: " . $e->getMessage();
    exit();
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Preguntas de Seguridad</title>
    <link rel="stylesheet" href="css/preguntas.css">
</head>

<body>
    <div class="container">
        <div class="form-content">
            <form action="../controladores/validar_respuestas.php" method="POST">
                <div class="title">Preguntas de Seguridad</div>
                <!-- htmlspecialchars para evitar problemas de seguridad -->
                <input type="hidden" name="usuario_correo" value="<?php echo htmlspecialchars($usuarioCorreo); ?>">
                <div class="input-boxes">
                    <div class="input-box">
                        <label for="respuesta1"><?php echo htmlspecialchars($pregunta1); ?></label>
                        <input type="text" id="respuesta1" name="respuesta1" placeholder="Respuesta a la primera pregunta" required>
                    </div>
                    <div class="input-box">
                        <label for="respuesta2"><?php echo htmlspecialchars($pregunta2); ?></label>
                        <input type="text" id="respuesta2" name="respuesta2" placeholder="Respuesta a la segunda pregunta" required>
                    </div>
                    <div class="button input-box">
                        <input type="submit" value="Validar Respuestas">
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>

</html>