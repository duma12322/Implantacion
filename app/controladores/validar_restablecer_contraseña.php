<?php
// Incluir la configuración de la base de datos
require_once "../../config/conexion.php";

// Verificar si el formulario fue enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Obtener los datos del formulario
    $nuevaContraseña = $_POST['nueva_contraseña']; // Nueva contraseña
    $confirmarContraseña = $_POST['confirmar_contraseña']; // Confirmación de la contraseña

    // Validar que las contraseñas coincidan
    if ($nuevaContraseña != $confirmarContraseña) {
        $mensaje = 'Las contraseñas no coinciden.';
        $tipo = 'error';
    } else {
        session_start();
        if (isset($_SESSION['usuarioCorreo'])) {
            $usuarioCorreo = $_SESSION['usuarioCorreo']; // Valor de correo guardado en sesión

            // Encriptar la nueva contraseña usando MD5
            $nuevaContraseñaHash = md5($nuevaContraseña);

            // Actualizar la contraseña en la base de datos
            $updateQuery = "UPDATE usuario SET contraseña = :new_password WHERE (usuario = :usuario OR correo = :correo)";
            $updateStmt = $conn->prepare($updateQuery);

            $updateStmt->bindValue(':new_password', $nuevaContraseñaHash, PDO::PARAM_STR);
            $updateStmt->bindValue(':usuario', $usuarioCorreo, PDO::PARAM_STR);
            $updateStmt->bindValue(':correo', $usuarioCorreo, PDO::PARAM_STR);

            try {
                if ($updateStmt->execute()) {
                    $mensaje = 'Contraseña actualizada correctamente.';
                    $tipo = 'success';
                } else {
                    $mensaje = 'Hubo un error al actualizar la contraseña.';
                    $tipo = 'error';
                }
            } catch (PDOException $e) {
                $mensaje = 'Error de base de datos: ' . $e->getMessage();
                $tipo = 'error';
            }
        } else {
            // Si no hay una sesión activa con el correo/usuario
            $mensaje = 'No se ha encontrado una sesión válida.';
            $tipo = 'error';
        }
    }

    // Mostrar la alerta con SweetAlert y redirigir después de hacer clic en OK
    echo "<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.4.11/dist/sweetalert2.all.min.js'></script>";
    echo "<script>
        document.addEventListener('DOMContentLoaded', function() {
            Swal.fire({
                icon: '$tipo',
                title: '$mensaje',
                confirmButtonText: 'OK'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Redirigir a login_paciente.php o a la página que corresponda
                    window.location.href = '../vistas/login_paciente.php';
                }
            });
        });
    </script>";
}
