<?php

namespace app\controladores;

require_once __DIR__ . '/../modelos/listado_PacienteModelo.php';

use app\modelos\listado_PacienteModelo;

class listado_PacienteControlador {
    private $listado_PacienteModelo;

    public function __construct() {
        $this->listado_PacienteModelo = new listado_PacienteModelo();
    }

    public function obtenerUsuarios() {
        return $this->listado_PacienteModelo->listarUsuarios();
    }
    public function obtenerUsuarioPorId($id_usuario) {
        return $this->listado_PacienteModelo->buscarUsuarioPorId($id_usuario);
    }
    // Método para obtener usuarios filtrados por término de búsqueda
    public function obtenerUsuariosFiltrados($searchTerm) {
    return $this->listado_PacienteModelo->buscarUsuariosFiltrados($searchTerm);
}
     // Método para actualizar un usuario por su ID
     public function actualizarUsuario($id_usuario, $datos) {
        return $this->listado_PacienteModelo->actualizarUsuarioPorId($id_usuario, $datos);
    }

     // Método para eliminar un usuario (cambiar su estado a inactivo)
     public function eliminarUsuario($id_usuario) {
        $this->listado_PacienteModelo->cambiarEstadoUsuario($id_usuario);
    }
}