<?php

namespace app\modelos;

require_once __DIR__ . '/principalModelo.php';

use app\modelos\principalModelo;

class listado_PacienteModelo extends principalModelo {
    // Método para listar todos los usuarios con estado activo
    public function listarUsuarios() {
        try {
            $sql = $this->conectar()->prepare("SELECT * FROM usuario WHERE status = 'activo'");
            $sql->execute();
            return $sql->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al listar usuarios: " . $e->getMessage());
            return [];
        }
    }

    // Método para buscar un usuario por su ID
    public function buscarUsuarioPorId($id_usuario) {
        try {
            $sql = $this->conectar()->prepare("SELECT * FROM usuario WHERE id_usuario = :id_usuario");
            $sql->bindParam(':id_usuario', $id_usuario, \PDO::PARAM_INT);
            $sql->execute();
            return $sql->fetch(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al buscar usuario por ID: " . $e->getMessage());
            return null;
        }
    }

    public function actualizarUsuarioPorId($id_usuario, $datos) {
        try {
            // Log de depuración para verificar los datos
            error_log("ID del usuario: " . $id_usuario);
            error_log("Datos recibidos para actualizar: " . print_r($datos, true));
    
            $sql = "UPDATE usuario SET 
                    nombre1 = :nombre1, 
                    nombre2 = :nombre2, 
                    apellido1 = :apellido1, 
                    apellido2 = :apellido2, 
                    sexo = :sexo, 
                    fecha_nac = :fecha_nac, 
                    num_doc = :num_doc, 
                    telefono = :telefono 
                    WHERE id_usuario = :id_usuario";
            $stmt = $this->conectar()->prepare($sql);
    
            // Asociar parámetros
            $stmt->bindParam(':id_usuario', $id_usuario, \PDO::PARAM_INT);
            $stmt->bindParam(':nombre1', $datos['nombre1']);
            $stmt->bindParam(':nombre2', $datos['nombre2']);
            $stmt->bindParam(':apellido1', $datos['apellido1']);
            $stmt->bindParam(':apellido2', $datos['apellido2']);
            $stmt->bindParam(':sexo', $datos['sexo']);
            $stmt->bindParam(':fecha_nac', $datos['fecha_nac']);
            $stmt->bindParam(':num_doc', $datos['num_doc']);
            $stmt->bindParam(':telefono', $datos['telefono']);
    
            // Ejecutar y devolver resultado
            return $stmt->execute();
        } catch (\PDOException $e) {
            error_log("Error al actualizar usuario: " . $e->getMessage());
            return false;
        }
    }
    

    // Método para cambiar el estado de un usuario (eliminar lógicamente)
    public function cambiarEstadoUsuario($id_usuario) {
        try {
            $sql = $this->conectar()->prepare("UPDATE usuario SET status = 'inactivo' WHERE id_usuario = :id_usuario");
            $sql->bindParam(':id_usuario', $id_usuario, \PDO::PARAM_INT);
            return $sql->execute();
        } catch (\PDOException $e) {
            error_log("Error al cambiar estado del usuario: " . $e->getMessage());
            return false;
        }
    }

    // Método para buscar usuarios filtrados por nombre o número de documento
    public function buscarUsuariosFiltrados($searchTerm) {
        try {
            // Crear un término de búsqueda con los comodines para la búsqueda parcial
            $searchTerm = "%" . $searchTerm . "%";

            // Preparar la consulta SQL para buscar en los campos nombre1 y num_doc
            $sql = $this->conectar()->prepare("SELECT * FROM usuario WHERE (nombre1 LIKE :searchTerm OR num_doc LIKE :searchTerm) AND status = 'activo'");
            $sql->bindParam(':searchTerm', $searchTerm, \PDO::PARAM_STR);
            $sql->execute();

            // Retornar los resultados filtrados
            return $sql->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al buscar usuarios filtrados: " . $e->getMessage());
            return [];
        }
    }
}
