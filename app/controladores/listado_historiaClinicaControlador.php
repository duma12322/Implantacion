<?php

namespace app\controladores;

require_once __DIR__ . '/../modelos/listado_historiaClinicaModelo.php';
require_once '../../config/conexion.php';

use app\modelos\listado_historiaClinicaModelo;

class listado_historiaClinicaControlador
{
    private $listado_historiaClinicaModelo;

    public function __construct()
    {
        global $conn; 
        $this->listado_historiaClinicaModelo = new listado_historiaClinicaModelo($conn);
    }

    public function obtenerHistoriaClinica()
    {
        return $this->listado_historiaClinicaModelo->listarHistorialClinico();
    }

    public function obtenerHistoriaClinicaFiltrada($searchTerm)
    {
        return $this->listado_historiaClinicaModelo->buscarHistoriasFiltradas($searchTerm);
    }
}
    
