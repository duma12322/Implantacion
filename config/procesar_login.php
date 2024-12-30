<?php
require_once __DIR__ . '/conexion.php';

session_start();

// Obtener datos del formulario
$usuario = $_POST['usuario'];
$contraseña = $_POST['contraseña'];

try {
    // Buscar en la tabla `usuario` (para pacientes)
    $query = $conn->prepare("SELECT * FROM usuario WHERE usuario = :usuario");
    $query->bindParam(':usuario', $usuario);
    $query->execute();
    $resultado = $query->fetch(PDO::FETCH_ASSOC);

    // Si no es un paciente, verificar en la tabla `psicologo` y obtener la contraseña desde `administrativo`
    if (!$resultado) {
        $query = $conn->prepare("SELECT * FROM psicologo WHERE id_administrativo IN (SELECT id_administrativo FROM administrativo WHERE usuario = :usuario)");
        $query->bindParam(':usuario', $usuario);
        $query->execute();
        $resultado = $query->fetch(PDO::FETCH_ASSOC);

        // Si es un psicologo, obtenemos la contraseña de la tabla `administrativo`
        if ($resultado) {
            $queryAdmin = $conn->prepare("SELECT * FROM administrativo WHERE id_administrativo = :id_administrativo");
            $queryAdmin->bindParam(':id_administrativo', $resultado['id_administrativo']);
            $queryAdmin->execute();
            $adminResult = $queryAdmin->fetch(PDO::FETCH_ASSOC);
            $resultado = array_merge($resultado, $adminResult); // Mezclar datos de psicologo con administrativo
        }
    }

    // Si no es un psicologo, verificar en la tabla `administrativo`
    if (!$resultado) {
        $query = $conn->prepare("SELECT * FROM administrativo WHERE usuario = :usuario");
        $query->bindParam(':usuario', $usuario);
        $query->execute();
        $resultado = $query->fetch(PDO::FETCH_ASSOC);
    }

    // Verificar si se obtuvo un resultado
    if ($resultado && isset($resultado['contraseña'])) {
        // Validar contraseña usando MD5
        if (md5($contraseña) === $resultado['contraseña']) {
            // Configurar variables de sesión
            $_SESSION['usuario'] = $resultado['usuario'];
            $_SESSION['nombre'] = $resultado['Nombre1'];

            // Establecer el tipo de usuario en la sesión
            if (isset($resultado['id_usuario'])) {
                // Si se encuentra en la tabla `usuario`, es un paciente
                $_SESSION['tipo_usuario'] = 'paciente'; // Guardamos el tipo de usuario
                // Redirigir al login del paciente
                header("Location: ../app/vistas/login_paciente.php");
                exit;
            } elseif (isset($resultado['id_psicologo'])) {
                // Si se encuentra en la tabla `psicologo`, es un psicólogo
                $_SESSION['tipo_usuario'] = 'psicologo'; // Guardamos el tipo de usuario
                header("Location: ../app/vistas/dashboard.php");
                exit;
            } elseif (isset($resultado['id_administrativo'])) {
                // Si se encuentra en la tabla `administrativo`, es un administrativo
                $_SESSION['tipo_usuario'] = 'administrativo'; // Guardamos el tipo de usuario
                header("Location: ../app/vistas/dashboard.php");
                exit;
            }
        } else {
            // Si la contraseña es incorrecta, mostramos un popup con SweetAlert2
            echo "<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.all.min.js'></script>";
            echo "<script>
                    window.onload = function() {
                        Swal.fire({
                            icon: 'error',
                            title: '¡Error!',
                            text: 'Usuario o contraseña incorrectos.',
                        }).then(function() {
                            window.location.href = '/implantacion/app/vistas/login_paciente.php'; // Redirigir a la página de login del paciente después del mensaje
                        });
                    }
                  </script>";
        }
    } else {
        // Si no se encontró el usuario o la columna 'contraseña' no existe
        echo "<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.all.min.js'></script>";
        echo "<script>
                window.onload = function() {
                    Swal.fire({
                        icon: 'error',
                        title: '¡Error!',
                        text: 'Usuario o contraseña incorrectos',
                    }).then(function() {
                        window.location.href = '/implantacion/app/vistas/login_paciente.php'; // Redirigir a la página de login del paciente después del mensaje
                    });
                }
              </script>";
    }
} catch (Exception $e) {
    die("Error: " . $e->getMessage());
}
