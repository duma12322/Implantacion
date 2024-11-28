<?php
require_once __DIR__ . '/../conexion/conexion.php';

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

    // Depurar el contenido de $resultado
    if ($resultado) {
        echo "<pre>";
        print_r($resultado); // Esto muestra los datos que devuelve la consulta
        echo "</pre>";
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
                header("Location: inicio_paciente.php");
            } elseif (isset($resultado['id_psicologo'])) {
                // Si se encuentra en la tabla `psicologo`, es un psicólogo
                $_SESSION['tipo_usuario'] = 'psicologo'; // Guardamos el tipo de usuario
                header("Location: inicio_psicologo_admin.php");
            } elseif (isset($resultado['id_administrativo'])) {
                // Si se encuentra en la tabla `administrativo`, es un administrativo
                $_SESSION['tipo_usuario'] = 'administrativo'; // Guardamos el tipo de usuario
                header("Location: inicio_psicologo_admin.php");
            }
            exit;
        } else {
            echo "Usuario o contraseña incorrectos.";
        }
    } else {
        echo "Usuario o contraseña incorrectos o la columna 'contraseña' no existe en el resultado.";
    }
} catch (Exception $e) {
    die("Error: " . $e->getMessage());
}