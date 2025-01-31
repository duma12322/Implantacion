<?php

namespace app\modelos;

require_once '../../config/conexion.php';

class listado_historiaClinicaModelo
{
    private $conn;

    public function __construct($conn)
    {
        $this->conn = $conn;
    }

    public function listarHistorialClinico()
    {
        try {
            $sql = $this->conn->prepare("SELECT h.ID_HistorialM,
                                                u.id_usuario,
                                                u.tipo_doc,
                                                u.num_doc,
                                                u.nombre1,
                                                u.nombre2,
                                                u.apellido1,
                                                u.apellido2,
                                                u.sexo,
                                                h.fecha_p_cita,
                                                h.edad,
                                                h.edo_civil,
                                                h.entrevistador
                                        FROM historial_medico h
                                        INNER JOIN usuario u ON h.id_usuario = u.id_usuario");
            $sql->execute();
            return $sql->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al listar el historial clínico: " . $e->getMessage());
            return [];
        }
    }
    public function buscarHistoriasFiltradas($searchTerm)
    {
        try {
            $searchTerm = "%" . $searchTerm . "%";

            $sql = $this->conn->prepare("SELECT u.*
                                        FROM usuario u
                                        JOIN historial_medico h ON u.id_usuario = h.ID_HistorialM
                                        WHERE (a.Nombre1 LIKE :searchTerm OR a.num_doc LIKE :searchTerm) 
                                        AND a.status = 'activo'");
            $sql->bindParam(':searchTerm', $searchTerm, \PDO::PARAM_STR);
            $sql->execute();

            return $sql->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al buscar psicólogos filtrados: " . $e->getMessage());
            return [];
        }
    }
}