<?php
require_once '../../config/conexion.php';

// Iniciar sesión 
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Verifica si el campo 'usuario_correo' está definido
    if (isset($_POST['usuario_correo']) && !empty($_POST['usuario_correo'])) {
        $usuarioCorreo = trim($_POST['usuario_correo']);

        // Consulta preparada para buscar solo por 'correo'
        $query = "SELECT * FROM usuario WHERE correo = :usuario_correo";
        $stmt = $conn->prepare($query);

        // Enlaza el parámetro con el valor ingresado
        $stmt->bindValue(':usuario_correo', $usuarioCorreo, PDO::PARAM_STR);

        // Ejecuta la consulta
        $stmt->execute();

        // Verifica si encontró un resultado
        if ($stmt->rowCount() > 0) {
            // Almacenar el correo en la sesión
            $_SESSION['usuarioCorreo'] = $usuarioCorreo;

            // Redirecciona a preguntas_seguridad.php
            header("Location: ../vistas/preguntas_seguridad.php?usuario=" . urlencode($usuarioCorreo));
            exit();
        } else {
            // Muestra un mensaje si no se encontró el correo
            echo "<script>
                    alert('Correo no encontrado.');
                    window.history.back();
                  </script>";
        }
    } else {
        // Muestra un mensaje si el campo está vacío
        echo "<script>
                alert('Por favor, ingresa un correo.');
                window.history.back();
              </script>";
    }
} else {
    // Mensaje en caso de que no sea un POST
    echo "<script>
            alert('Método no permitido.');
            window.history.back();
          </script>";
}
