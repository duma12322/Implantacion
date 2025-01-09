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

    $tipoUsuario = "paciente"; // Por defecto asumimos que es un paciente

    // Si no es un paciente, verificar en la tabla `psicologo` y en la tabla `administrativo`
    if (!$resultado) {
        $query = $conn->prepare("SELECT * FROM psicologo WHERE id_administrativo IN (SELECT id_administrativo FROM administrativo WHERE usuario = :usuario)");
        $query->bindParam(':usuario', $usuario);
        $query->execute();
        $resultado = $query->fetch(PDO::FETCH_ASSOC);

        if ($resultado) {
            $queryAdmin = $conn->prepare("SELECT * FROM administrativo WHERE id_administrativo = :id_administrativo");
            $queryAdmin->bindParam(':id_administrativo', $resultado['id_administrativo']);
            $queryAdmin->execute();
            $adminResult = $queryAdmin->fetch(PDO::FETCH_ASSOC);
            $resultado = array_merge($resultado, $adminResult); // Combinar datos de psicólogo con administrativo
            $tipoUsuario = "psicologo_admin";
        }
    }

    if (!$resultado) {
        $query = $conn->prepare("SELECT * FROM administrativo WHERE usuario = :usuario");
        $query->bindParam(':usuario', $usuario);
        $query->execute();
        $resultado = $query->fetch(PDO::FETCH_ASSOC);

        if ($resultado) {
            $tipoUsuario = "psicologo_admin";
        }
    }

    // Verificar si se encontró un resultado y validar contraseña
    if ($resultado && isset($resultado['contraseña'])) {
        if (md5($contraseña) === $resultado['contraseña']) {
            // Configurar variables de sesión
            $_SESSION['usuario'] = $resultado['usuario'];
            $_SESSION['nombre1'] = $resultado['nombre1'];

            if (isset($resultado['id_usuario'])) {
                // Usuario es un paciente
                $_SESSION['tipo_usuario'] = 'paciente';
                header("Location: ../app/vistas/agendar_cita.php");
                exit;
            } elseif (isset($resultado['id_psicologo'])) {
                // Usuario es un psicólogo
                $_SESSION['tipo_usuario'] = 'psicologo';
                header("Location: ../app/vistas/dashboard.php");
                exit;
            } elseif (isset($resultado['id_administrativo'])) {
                // Usuario es un administrativo
                $_SESSION['tipo_usuario'] = 'administrativo';
                header("Location: ../app/vistas/dashboard.php");
                exit;
            }
        } else {
            // Contraseña incorrecta
            $redirectUrl = ($tipoUsuario === "paciente")
                ? '/implantacion/app/vistas/login_paciente.php'
                : '/implantacion/app/vistas/login_psicologo_admin.php';

            echo "<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.all.min.js'></script>";
            echo "<script>
                    window.onload = function() {
                        Swal.fire({
                            icon: 'error',
                            title: '¡Error!',
                            text: 'Usuario o contraseña incorrectos.',
                        }).then(function() {
                            window.location.href = '$redirectUrl';
                        });
                    }
                  </script>";
        }
    } else {
        // Usuario no encontrado
        $redirectUrl = ($tipoUsuario === "paciente")
            ? '/implantacion/app/vistas/login_paciente.php'
            : '/implantacion/app/vistas/login_psicologo_admin.php';

        echo "<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.all.min.js'></script>";
        echo "<script>
                window.onload = function() {
                    Swal.fire({
                        icon: 'error',
                        title: '¡Error!',
                        text: 'Usuario o contraseña incorrectos.',
                    }).then(function() {
                        window.location.href = '$redirectUrl';
                    });
                }
              </script>";
    }
} catch (Exception $e) {
    die("Error: " . $e->getMessage());
}
