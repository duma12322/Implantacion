<?php

namespace app\controladores;

require_once __DIR__ . '/../modelos/listado_PsicologosModelo.php';
require_once '../../config/conexion.php';

use app\modelos\listado_PsicologosModelo;

class listado_PsicologosControlador
{
    private $listado_PsicologosModelo;

    public function __construct()
    {
        global $conn;  // Asegurarte de que la conexión esté disponible
        $this->listado_PsicologosModelo = new listado_PsicologosModelo($conn);
    }

    // Método para obtener todos los psicólogos
    public function obtenerPsicologos()
    {
        return $this->listado_PsicologosModelo->listarPsicologos();
    }

    // Método para obtener un psicólogo por su ID
    public function obtenerPsicologoPorId($id_administrativo)
    {
        return $this->listado_PsicologosModelo->buscarPsicologoPorId($id_administrativo);
    }

    // Método para obtener psicólogos filtrados
    public function obtenerPsicologoFiltrados($searchTerm)
    {
        return $this->listado_PsicologosModelo->buscarPsicologosFiltrados($searchTerm);
    }

    // Método para actualizar un psicólogo
    public function actualizarPsicologo($id_administrativo, $datos)
    {
        return $this->listado_PsicologosModelo->actualizarPsicologoPorId($id_administrativo, $datos);
    }

    // Método para eliminar (cambiar el estado) un psicólogo
    public function eliminarPsicologo($id_administrativo)
    {
        return $this->listado_PsicologosModelo->cambiarEstadoPsicologo($id_administrativo);
    }

   
        }
    
