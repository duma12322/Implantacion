<?php
require_once "../../config/conexion.php";

// Iniciar sesión al principio
session_start();

// Validar si el formulario fue enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Obtener los datos del formulario
    $usuarioCorreo = $_POST['usuario_correo'];
    $respuesta1 = $_POST['respuesta1'];
    $respuesta2 = $_POST['respuesta2'];

    // Consulta para obtener las respuestas de seguridad solo por el correo
    $query = "SELECT respuesta_1, respuesta_2 FROM usuario WHERE correo = :dato";
    $stmt = $conn->prepare($query);

    // Enlazar el parámetro
    $stmt->bindValue(':dato', $usuarioCorreo, PDO::PARAM_STR);

    // Ejecutar la consulta
    $stmt->execute();

    // Verificar si se encontraron las respuestas
    if ($stmt->rowCount() > 0) {
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $respuesta1_db = $result['respuesta_1'];
        $respuesta2_db = $result['respuesta_2'];

        // Comparar las respuestas
        if (strtolower(trim($respuesta1)) == strtolower(trim($respuesta1_db)) && strtolower(trim($respuesta2)) == strtolower(trim($respuesta2_db))) {
            // Respuestas correctas, redirigir a la página para modificar la contraseña
            header("Location: ../vistas/restablecer_contraseña.php?usuario=" . urlencode($usuarioCorreo));
            exit();
        } else {
            // Respuestas incorrectas
            echo "
            <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.17/dist/sweetalert2.all.min.js'></script>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    Swal.fire({
                        icon: 'error',
                        title: 'Respuestas incorrectas',
                        text: 'Las respuestas proporcionadas no son correctas.',
                        showConfirmButton: true
                    });
                });
            </script>";
        }
    } else {
        // Usuario no encontrado
        echo "
        <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.17/dist/sweetalert2.all.min.js'></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                Swal.fire({
                    icon: 'error',
                    title: 'Usuario no encontrado',
                    text: 'No se encontraron respuestas de seguridad para este correo.',
                    showConfirmButton: true
                });
            });
        </script>";
    }
} else {
    // Acceso no permitido
    echo "Acceso no permitido.";
}
