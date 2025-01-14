<?php

namespace app\modelos;

require_once __DIR__ . '/principalModelo.php';

use app\modelos\principalModelo;

class listado_PsicologosModelo extends principalModelo {
    // Método para listar todos los Psicologos con estado activo
    public function listarPsicologos() {
        try {
            $sql = $this->conectar()->prepare("
                SELECT a.* 
                FROM administrativo a
                INNER JOIN psicologo p ON a.id_administrativo = p.id_administrativo
                WHERE a.status = 'activo'
            ");
            $sql->execute();
            return $sql->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al listar psicólogos: " . $e->getMessage());
            return [];
        }
    }

    // Método para buscar un Psicologo por su ID
    public function buscarPsicologoPorId($id_administrativo) { 
        try {
            $sql = $this->conectar()->prepare("
                SELECT a.* 
                FROM administrativo a
                INNER JOIN psicologo p ON a.id_administrativo = p.id_administrativo
                WHERE a.id_administrativo = :id_administrativo
            ");
            $sql->bindParam(':id_administrativo', $id_administrativo, \PDO::PARAM_INT);
            $sql->execute();
            return $sql->fetch(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al buscar Psicólogo por ID: " . $e->getMessage());
            return null;
        }
    }
    
    public function actualizarPsicologoPorId($id_administrativo, $datos) {
        try {
        
            error_log("ID del usuario: " . $id_administrativo);
            error_log("Datos recibidos para actualizar: " . print_r($datos, true));
    
            $sql = "UPDATE administrativo SET 
                    Nombre1 = :Nombre1, 
                    Nombre2 = :Nombre2, 
                    Apellido1 = :Apellido1, 
                    Apellido2 = :Apellido2, 
                    Fecha_Nac = :Fecha_Nac, 
                    num_doc = :num_doc, 
                    telefono = :telefono 
                    WHERE id_administrativo = :id_administrativo";
            $stmt = $this->conectar()->prepare($sql);
    
            // Asociar parámetros
            $stmt->bindParam(':id_administrativo', $id_administrativo, \PDO::PARAM_INT);
            $stmt->bindParam(':Nombre1', $datos['Nombre1']);
            $stmt->bindParam(':Nombre2', $datos['Nombre2']);
            $stmt->bindParam(':Apellido1', $datos['Apellido1']);
            $stmt->bindParam(':Apellido2', $datos['Apellido2']);
            $stmt->bindParam(':Fecha_Nac', $datos['Fecha_Nac']);
            $stmt->bindParam(':num_doc', $datos['num_doc']);
            $stmt->bindParam(':telefono', $datos['telefono']);
    
            // Ejecutar y devolver resultado
            return $stmt->execute();
        } catch (\PDOException $e) {
            error_log("Error al actualizar usuario: " . $e->getMessage());
            return false;
        }
    }
    

    // Método para cambiar el estado de un Psicologo (eliminar lógicamente)
    public function cambiarEstadoPsicologo($id_administrativo) {
        try {
            $sql = $this->conectar()->prepare("UPDATE administrativo SET status = 'inactivo' WHERE id_administrativo = :id_administrativo");
            $sql->bindParam(':id_administrativo', $id_administrativo, \PDO::PARAM_INT);
            return $sql->execute();
        } catch (\PDOException $e) {
            error_log("Error al cambiar estado del usuario: " . $e->getMessage());
            return false;
        }
    }

    // Método para buscar Psicologos filtrados por nombre o número de documento
    public function buscarPsicologosFiltrados($searchTerm) {
        try {
            // Crear un término de búsqueda con comodines para la búsqueda parcial
            $searchTerm = "%" . $searchTerm . "%";
    
            // Preparar la consulta SQL con un INNER JOIN para incluir solo los administrativos que estén en la tabla psicologo
            $sql = $this->conectar()->prepare("
                SELECT a.* 
                FROM administrativo a
                INNER JOIN psicologo p ON a.id_administrativo = p.id_administrativo
                WHERE (a.Nombre1 LIKE :searchTerm OR a.num_doc LIKE :searchTerm) 
                AND a.status = 'activo'
            ");
            $sql->bindParam(':searchTerm', $searchTerm, \PDO::PARAM_STR);
            $sql->execute();
    
            // Retornar los resultados filtrados
            return $sql->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al buscar psicólogos filtrados: " . $e->getMessage());
            return [];
        }
    }
    
}
