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
}