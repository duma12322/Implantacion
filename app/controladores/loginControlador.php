<?php

namespace app\controladores;
use app\modelos\principalModelo;

class loginControlador extends principalModelo {
    /*----------  Controlador iniciar sesión  ----------*/
    public function iniciarSesionControlador() {
        $usuario = $this->limpiarCadena($_POST['usuario']);
        $contrasena = $this->limpiarCadena($_POST['contraseña']);

        if ($usuario == "" || $contrasena == "") {
            echo "<script>
                Swal.fire({
                    icon: 'error',
                    title: 'Ocurrió un error inesperado',
                    text: 'No has llenado todos los campos que son obligatorios'
                });
            </script>";
            return;
        }

        if ($this->verificarDatos("[a-zA-Z0-9]{1,20}", $usuario)) {
            echo "<script>
                Swal.fire({
                    icon: 'error',
                    title: 'Ocurrió un error inesperado',
                    text: 'El USUARIO no coincide con el formato solicitado'
                });
            </script>";
            return;
        }

        if ($this->verificarDatos("[a-zA-Z0-9$@.-]{1,100}", $contrasena)) {
            echo "<script>
                Swal.fire({
                    icon: 'error',
                    title: 'Ocurrió un error inesperado',
                    text: 'La CLAVE no coincide con el formato solicitado'
                });
            </script>";
            return;
        }

        // Verificar en la tabla de pacientes
        $check_usuario = $this->ejecutarConsulta("SELECT * FROM usuario WHERE usuario='$usuario'");
        if ($check_usuario->rowCount() == 1) {
            $this->iniciarSesionUsuario($check_usuario, $contrasena, "usuario", "inicio-paciente/");
            return;
        }

        // Verificar en la tabla de administrativos
        $check_admin = $this->ejecutarConsulta("SELECT * FROM administrativo WHERE usuario='$usuario'");
        if ($check_admin->rowCount() == 1) {
            $this->iniciarSesionUsuario($check_admin, $contrasena, "administrativo", "inicio-psicologo-admin/");
            return;
        }

        $check_psicologo = $this->ejecutarConsulta("SELECT * FROM psicologo 
        WHERE id_administrativo IN (SELECT id_administrativo 
        FROM administrativo WHERE usuario = $usuario");
        if ($check_psicologo->rowCount() == 1) {
            $this->iniciarSesionUsuario($check_psicologo, $contrasena, "psicologo", "inicio-psicologo/");
            return;
        }

        // Si no coincide con ningún tipo de usuario
        echo "<script>
            Swal.fire({
                icon: 'error',
                title: 'Ocurrió un error inesperado',
                text: 'Usuario o clave incorrectos'
            });
        </script>";
    }

    /*----------  Método auxiliar para iniciar sesión según el tipo de usuario  ----------*/
    private function iniciarSesionUsuario($resultado, $contrasena, $tipo, $redirect) {
        $usuario_data = $resultado->fetch();

        //if (password_verify($contrasena, $usuario_data['contraseña'])) {
        if (md5($contrasena) === $usuario_data['contraseña']) {
            $_SESSION['id'] = $usuario_data['id_' . $tipo];
            $_SESSION['nombre1'] = $usuario_data['Nombre1'];
            $_SESSION['apellido1'] = $usuario_data['Apellido1'];
            $_SESSION['usuario'] = $usuario_data['usuario'];
            $_SESSION['foto'] = $usuario_data['foto'];
            $_SESSION['tipo_usuario'] = $tipo;

            if (headers_sent()) {
                echo "<script> window.location.href='" . APP_URL . "$redirect'; </script>";
            } else {
                header("Location: " . APP_URL . "$redirect");
            }
        } else {
            echo "<script>
                Swal.fire({
                    icon: 'error',
                    title: 'Ocurrió un error inesperado',
                    text: 'Usuario o clave incorrectos'
                });
            </script>";
        }
    }

    /*----------  Controlador cerrar sesión  ----------*/
    public function cerrarSesionControlador() {
        session_destroy();

        if (headers_sent()) {
            echo "<script> window.location.href='" . APP_URL . "login-paciente/';</script>";
        } else {
            header("Location: " . APP_URL . "login-paciente/");
        }
    }
}