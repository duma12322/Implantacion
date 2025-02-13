<?php
require_once __DIR__ . '/conexion.php';

session_start();

// Obtener datos del formulario
$usuario = $_POST['usuario'];
$contraseña = $_POST['contraseña'];
$tipo = $_POST['tipo']; // Obtener el tipo de login del formulario

try {
    if ($tipo === 'paciente') {
        // Buscar en la tabla usuario (para pacientes)
        $query = $conn->prepare("SELECT * FROM usuario WHERE usuario = :usuario");
        $query->bindParam(':usuario', $usuario);
        $query->execute();
        $resultado = $query->fetch(PDO::FETCH_ASSOC);

        if ($resultado && md5($contraseña) === $resultado['contraseña']) {
            // Configurar variables de sesión
            $_SESSION['usuario'] = $resultado['usuario'];
            $_SESSION['id_usuario'] = $resultado['id_usuario']; // Almacenar el ID del usuario en la sesión
            $_SESSION['nombre1'] = $resultado['nombre1'];
            $_SESSION['tipo_usuario'] = 'paciente';
            header("Location: ../app/vistas/agendar_cita.php");
            exit;
        } else {
            // Contraseña incorrecta o usuario no encontrado
            echo "<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.all.min.js'></script>";
            echo "<script>
                    window.onload = function() {
                        Swal.fire({
                            icon: 'error',
                            title: '¡Error!',
                            text: 'Usuario o contraseña incorrectos.',
                        }).then(function() {
                            window.location.href = '/implantacion/app/vistas/login_paciente.php';
                        });
                    }
                  </script>";
        }
    } elseif ($tipo === 'psicologo_admin') {
        // Buscar en la tabla psicologo y en la tabla administrativo
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
        } else {
            $query = $conn->prepare("SELECT * FROM administrativo WHERE usuario = :usuario");
            $query->bindParam(':usuario', $usuario);
            $query->execute();
            $resultado = $query->fetch(PDO::FETCH_ASSOC);
        }

        if ($resultado && md5($contraseña) === $resultado['contraseña']) {
            // Configurar variables de sesión
            $_SESSION['usuario'] = $resultado['usuario'];
            $_SESSION['id_usuario'] = $resultado['id_usuario']; // Almacenar el ID del usuario en la sesión
            $_SESSION['nombre1'] = $resultado['nombre1'];

            if (isset($resultado['id_psicologo'])) {
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
            // Contraseña incorrecta o usuario no encontrado
            echo "<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.all.min.js'></script>";
            echo "<script>
                    window.onload = function() {
                        Swal.fire({
                            icon: 'error',
                            title: '¡Error!',
                            text: 'Usuario o contraseña incorrectos.',
                        }).then(function() {
                            window.location.href = '/implantacion/app/vistas/login_psicologo_admin.php';
                        });
                    }
                  </script>";
        }
    } else {
        // Tipo de usuario no válido
        echo "<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.all.min.js'></script>";
        echo "<script>
                window.onload = function() {
                    Swal.fire({
                        icon: 'error',
                        title: '¡Error!',
                        text: 'Tipo de usuario no válido.',
                    }).then(function() {
                        window.location.href = '/implantacion/app/vistas/login_paciente.php';
                    });
                }
              </script>";
    }
} catch (Exception $e) {
    die("Error: " . $e->getMessage());
}
