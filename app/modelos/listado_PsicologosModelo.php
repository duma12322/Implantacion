<?php

namespace app\modelos;

require_once '../../config/conexion.php';

class listado_PsicologosModelo
{
    private $conn;

    // Constructor que recibe la conexión
    public function __construct($conn)
    {
        $this->conn = $conn;
    }

    // Método para listar todos los psicólogos con estado activo
    public function listarPsicologos()
    {
        try {
            $sql = $this->conn->prepare("SELECT p.*, a.*, e.*
                                        FROM psicologo p
                                        JOIN administrativo a ON p.id_administrativo = a.id_administrativo
                                        LEFT JOIN especialidad_psicologo ep ON p.id_psicologo = ep.id_psicologo
                                        LEFT JOIN especialidad e ON ep.id_especialidad = e.id_especialidad
                                        WHERE a.status = 'activo'
                                        GROUP BY p.id_psicologo");
            $sql->execute();
            return $sql->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al listar psicólogos: " . $e->getMessage());
            return [];
        }
    }

    // Método para buscar un psicólogo por su ID
    public function buscarPsicologoPorId($id_administrativo)
    {
        try {
            $sql = $this->conn->prepare("SELECT a.* 
                                         FROM administrativo a
                                         INNER JOIN psicologo p ON a.id_administrativo = p.id_administrativo
                                         WHERE a.id_administrativo = :id_administrativo");
            $sql->bindParam(':id_administrativo', $id_administrativo, \PDO::PARAM_INT);
            $sql->execute();
            return $sql->fetch(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al buscar psicólogo por ID: " . $e->getMessage());
            return null;
        }
    }

    // Método para actualizar un psicólogo por su ID
    public function actualizarPsicologoPorId($id_administrativo, $datos)
    {
        try {
            $sql = "UPDATE administrativo SET 
                    Nombre1 = :Nombre1, 
                    Nombre2 = :Nombre2, 
                    Apellido1 = :Apellido1, 
                    Apellido2 = :Apellido2, 
                    Fecha_Nac = :Fecha_Nac, 
                    num_doc = :num_doc, 
                    telefono = :telefono 
                    WHERE id_administrativo = :id_administrativo";
            $stmt = $this->conn->prepare($sql);

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
            error_log("Error al actualizar psicólogo: " . $e->getMessage());
            return false;
        }
    }

    // Método para cambiar el estado de un psicólogo (eliminar lógicamente)
    public function cambiarEstadoPsicologo($id_administrativo)
    {
        try {
            $sql = $this->conn->prepare("UPDATE administrativo SET status = 'inactivo' WHERE id_administrativo = :id_administrativo");
            $sql->bindParam(':id_administrativo', $id_administrativo, \PDO::PARAM_INT);
            return $sql->execute();
        } catch (\PDOException $e) {
            error_log("Error al cambiar estado del psicólogo: " . $e->getMessage());
            return false;
        }
    }

    // Método para buscar psicólogos filtrados por nombre o número de documento
    public function buscarPsicologosFiltrados($searchTerm)
    {
        try {
            // Crear un término de búsqueda con los comodines para la búsqueda parcial
            $searchTerm = "%" . $searchTerm . "%";

            // Preparar la consulta SQL para buscar en los campos Nombre1 y num_doc
            $sql = $this->conn->prepare("SELECT p.*, a.*, e.*
                                        FROM psicologo p
                                        JOIN administrativo a ON p.id_administrativo = a.id_administrativo
                                        LEFT JOIN especialidad_psicologo ep ON p.id_psicologo = ep.id_psicologo
                                        LEFT JOIN especialidad e ON ep.id_especialidad = e.id_especialidad
                                        WHERE (a.Nombre1 LIKE :searchTerm OR a.num_doc LIKE :searchTerm) 
                                        AND a.status = 'activo'");
            $sql->bindParam(':searchTerm', $searchTerm, \PDO::PARAM_STR);
            $sql->execute();

            // Retornar los resultados filtrados
            return $sql->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al buscar psicólogos filtrados: " . $e->getMessage());
            return [];
        }
    }

    public function obtenerEspecialidades()
    {
        try {
            $sql = $this->conn->prepare("SELECT id_especialidad, Tipo_Esp FROM especialidad");
            $sql->execute();
            return $sql->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al obtener especialidades: " . $e->getMessage());
            return [];
        }
    }

    public function registrarPsicologo($usuario, $contraseña, $nombre1, $nombre2, $apellido1, $apellido2, $tipo_doc, $num_doc, $correo, $fecha_nac, $telefono, $estatus, $id_especialidad, $descripcion, $foto)
    {
        try {
            $this->conn->beginTransaction();

            $sql = $this->conn->prepare("INSERT INTO administrativo (usuario, contraseña, Nombre1, Nombre2, Apellido1, Apellido2, tipo_doc, num_doc, correo, Fecha_Nac, telefono, status, foto) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            $sql->execute([$usuario, $contraseña, $nombre1, $nombre2, $apellido1, $apellido2, $tipo_doc, $num_doc, $correo, $fecha_nac, $telefono, $estatus, $foto]);

            $id_administrativo = $this->conn->lastInsertId();

            $sql = $this->conn->prepare("INSERT INTO psicologo (id_administrativo) VALUES (?)");
            $sql->execute([$id_administrativo]);

            $id_psicologo = $this->conn->lastInsertId();

            $sql = $this->conn->prepare("INSERT INTO especialidad_psicologo (id_especialidad, id_psicologo) VALUES (?, ?)");
            $result = $sql->execute([$id_especialidad, $id_psicologo]);

            $this->conn->commit();
            return $result;
        } catch (\PDOException $e) {
            $this->conn->rollBack();
            error_log("Error al registrar psicólogo: " . $e->getMessage());
            return false;
        }
    }

    public function actualizarPsicologo($id_psicologo, $usuario, $contraseña, $nombre1, $nombre2, $apellido1, $apellido2, $tipo_doc, $num_doc, $correo, $fecha_nac, $telefono, $estatus, $id_especialidad, $foto)
    {
        try {
            $this->conn->beginTransaction();

            $sql = "UPDATE administrativo SET usuario = ?, Nombre1 = ?, Nombre2 = ?, Apellido1 = ?, Apellido2 = ?, tipo_doc = ?, num_doc = ?, correo = ?, Fecha_Nac = ?, telefono = ?, status = ?";
            $params = [$usuario, $nombre1, $nombre2, $apellido1, $apellido2, $tipo_doc, $num_doc, $correo, $fecha_nac, $telefono, $estatus];

            if ($contraseña) {
                $sql .= ", contraseña = ?";
                $params[] = $contraseña;
            }

            if ($foto) {
                $sql .= ", foto = ?";
                $params[] = $foto;
            }

            $sql .= " WHERE id_administrativo = (SELECT id_administrativo FROM psicologo WHERE id_psicologo = ?)";
            $params[] = $id_psicologo;

            $stmt = $this->conn->prepare($sql);
            $stmt->execute($params);

            $sql = "UPDATE especialidad_psicologo SET id_especialidad = ? WHERE id_psicologo = ?";
            $stmt = $this->conn->prepare($sql);
            $result = $stmt->execute([$id_especialidad, $id_psicologo]);

            $this->conn->commit();
            return $result;
        } catch (\PDOException $e) {
            $this->conn->rollBack();
            error_log("Error al actualizar psicólogo: " . $e->getMessage());
            return false;
        }
    }

    public function obtenerPsicologoPorIdAdministrativo($id_administrativo)
    {
        try {
            $sql = $this->conn->prepare("SELECT a.*, p.*, e.Tipo_Esp 
                                         FROM administrativo a
                                         INNER JOIN psicologo p ON a.id_administrativo = p.id_administrativo
                                         LEFT JOIN especialidad_psicologo ep ON p.id_psicologo = ep.id_psicologo
                                         LEFT JOIN especialidad e ON ep.id_especialidad = e.id_especialidad
                                         WHERE a.id_administrativo = ?");
            $sql->execute([$id_administrativo]);
            return $sql->fetch(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al obtener psicólogo: " . $e->getMessage());
            return false;
        }
    }

    public function eliminacionDefinitivaPsicologo($id_administrativo)
    {
        try {
            $this->conn->beginTransaction();

            // Eliminar de la tabla especialidad_psicologo
            $sql = "DELETE FROM especialidad_psicologo WHERE id_psicologo = (SELECT id_psicologo FROM psicologo WHERE id_administrativo = ?)";
            $stmt = $this->conn->prepare($sql);
            $stmt->execute([$id_administrativo]);

            // Eliminar de la tabla psicologo
            $sql = "DELETE FROM psicologo WHERE id_administrativo = ?";
            $stmt = $this->conn->prepare($sql);
            $stmt->execute([$id_administrativo]);

            // Eliminar de la tabla administrativo
            $sql = "DELETE FROM administrativo WHERE id_administrativo = ?";
            $stmt = $this->conn->prepare($sql);
            $result = $stmt->execute([$id_administrativo]);

            $this->conn->commit();
            return $result;
        } catch (\PDOException $e) {
            $this->conn->rollBack();
            error_log("Error al eliminar psicólogo: " . $e->getMessage());
            return false;
        }
    }

}

