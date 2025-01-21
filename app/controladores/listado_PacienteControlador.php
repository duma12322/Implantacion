<?php

namespace app\controladores;

require_once('../modelos/listado_PacienteModelo.php');
require_once '../../config/conexion.php';

use app\modelos\listado_PacienteModelo;

class listado_PacienteControlador
{
    private $listado_PacienteModelo;

    public function __construct()
    {
        global $conn;  // Asegurarte de que la conexión esté disponible
        $this->listado_PacienteModelo = new listado_PacienteModelo($conn);
    }

    public function obtenerUsuarios()
    {
        return $this->listado_PacienteModelo->listarUsuarios();
    }

    public function obtenerUsuarioPorId($id_usuario)
    {
        return $this->listado_PacienteModelo->buscarUsuarioPorId($id_usuario);
    }

    // Método para obtener usuarios filtrados por término de búsqueda
    public function obtenerUsuariosFiltrados($searchTerm)
    {
        return $this->listado_PacienteModelo->buscarUsuariosFiltrados($searchTerm);
    }

    // Método para actualizar un usuario por su ID
    public function actualizarUsuario($id_usuario, $datos)
    {
        return $this->listado_PacienteModelo->actualizarUsuarioPorId($id_usuario, $datos);
    }

    // Método para eliminar un usuario (cambiar su estado a inactivo)
    public function eliminarUsuario($id_usuario)
    {
        $this->listado_PacienteModelo->cambiarEstadoUsuario($id_usuario);
    }

    public function registrarPaciente($datosUsuario, $datosPaciente)
    {
        try {
            $this->listado_PacienteModelo->registrarUsuario($datosUsuario, $datosPaciente);
            return [
                'mensaje' => '¡Registro exitoso!',
                'tipo' => 'success'
            ];
        } catch (\Exception $e) {
            return [
                'mensaje' => 'Error en el registro: ' . $e->getMessage(),
                'tipo' => 'error'
            ];
        }
    }

    public function obtenerEstados()
    {
        try {
            // Obtener todos los estados desde la base de datos
            $sql = $this->listado_PacienteModelo->listarEstados();
            return $sql;  // Retornar los resultados
        } catch (\Exception $e) {
            error_log("Error al obtener estados: " . $e->getMessage());
            return [];
        }
    }

    // Método para obtener las ciudades
    public function obtenerCiudades()
    {
        try {
            return $this->listado_PacienteModelo->listarCiudades();
        } catch (\Exception $e) {
            error_log("Error al obtener ciudades: " . $e->getMessage());
            return [];
        }
    }

    public function obtenerMunicipios($id_estado)
    {
        return $this->listado_PacienteModelo->listarMunicipios($id_estado);
    }

    public function obtenerParroquias($id_municipio)
    {
        return $this->listado_PacienteModelo->listarParroquias($id_municipio);
    }

    public function obtenerDireccionPorUsuario($id_usuario)
    {
        try {
            // Crear una instancia del modelo
            $modelo = new PrincipalModelo(); // O la clase que se encargue de la base de datos

            // Llamar al método que consulta la dirección
            return $modelo->buscarDireccionPorUsuario($id_usuario);
        } catch (\Exception $e) {
            error_log("Error al obtener dirección por usuario: " . $e->getMessage());
            return null;
        }
    }
}
