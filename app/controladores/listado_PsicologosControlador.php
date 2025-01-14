<?php

namespace app\controladores;

require_once __DIR__ . '/../modelos/listado_PsicologosModelo.php';

use app\modelos\listado_PsicologosModelo;

class listado_PsicologosControlador {
    private $listado_PsicologosModelo;

    public function __construct() {
        $this->listado_PsicologosModelo = new listado_PsicologosModelo();
    }

    public function obtenerPsicologos() {
        return $this->listado_PsicologosModelo->listarPsicologos();
    }
    public function obtenerPsicologoPorId($id_administrativo) {
        return $this->listado_PsicologosModelo->buscarPsicologoPorId($id_administrativo);
    }
    
    public function obtenerPsicologoFiltrados($searchTerm) {
    return $this->listado_PsicologosModelo->buscarPsicologosFiltrados($searchTerm);
}
    
     public function actualizarPsicologo($id_administrativo, $datos) {
        return $this->listado_PsicologosModelo->actualizarPsicologoPorId($id_administrativo, $datos);
    }

     public function eliminarPsicologo($id_administrativo) {
        $this->listado_PsicologosModelo->cambiarEstadoPsicologo($id_administrativo);
    }
}