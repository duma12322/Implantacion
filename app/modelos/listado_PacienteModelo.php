<?php

namespace app\modelos;

require_once '../../config/conexion.php';

class listado_PacienteModelo
{
    private $conn;

    // Constructor que recibe la conexión
    public function __construct($conn)
    {
        $this->conn = $conn;
    }

    // Método para listar todos los usuarios con estado activo
    public function listarUsuarios()
    {
        try {
            $sql = $this->conn->prepare("SELECT * FROM usuario WHERE status = 'activo'");
            $sql->execute();
            return $sql->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al listar usuarios: " . $e->getMessage());
            return [];
        }
    }

    // Método para buscar un usuario por su ID
    public function buscarUsuarioPorId($id_usuario)
    {
        try {
            $sql = $this->conn->prepare("SELECT * FROM usuario WHERE id_usuario = :id_usuario");
            $sql->bindParam(':id_usuario', $id_usuario, \PDO::PARAM_INT);
            $sql->execute();
            return $sql->fetch(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al buscar usuario por ID: " . $e->getMessage());
            return null;
        }
    }

    // Método para actualizar un usuario por su ID
    public function actualizarUsuarioPorId($id_usuario, $datos)
{
    try {
        // Iniciar transacción
        $this->conn->beginTransaction();

        // Actualizar los datos del usuario
        $sqlUsuario = "UPDATE usuario SET 
                        nombre1 = :nombre1, 
                        nombre2 = :nombre2, 
                        apellido1 = :apellido1, 
                        apellido2 = :apellido2, 
                        sexo = :sexo, 
                        fecha_nac = :fecha_nac, 
                        tipo_doc =:tipo_doc
                        num_doc = :num_doc, 
                        telefono = :telefono 
                        WHERE id_usuario = :id_usuario";
        $stmtUsuario = $this->conn->prepare($sqlUsuario);

        // Asociar parámetros del usuario
        $stmtUsuario->bindParam(':id_usuario', $id_usuario, \PDO::PARAM_INT);
        $stmtUsuario->bindParam(':nombre1', $datos['nombre1']);
        $stmtUsuario->bindParam(':nombre2', $datos['nombre2']);
        $stmtUsuario->bindParam(':apellido1', $datos['apellido1']);
        $stmtUsuario->bindParam(':apellido2', $datos['apellido2']);
        $stmtUsuario->bindParam(':sexo', $datos['sexo']);
        $stmtUsuario->bindParam(':fecha_nac', $datos['fecha_nac']);
        $stmtUsuario->bindParam(':tipo_doc', $datos['tipo_doc']);
        $stmtUsuario->bindParam(':num_doc', $datos['num_doc']);
        $stmtUsuario->bindParam(':telefono', $datos['telefono']);

        // Ejecutar la actualización del usuario
        $stmtUsuario->execute();

        // Actualizar los datos de ubicación en la tabla `direccion`
        $sqlDireccion = "UPDATE direccion SET 
                            id_estado = :id_estado, 
                            id_ciudad = :id_ciudad, 
                            id_municipio = :id_municipio, 
                            id_parroquia = :id_parroquia, 
                            descripcion = :descripcion 
                            WHERE id_usuario = :id_usuario";
        $stmtDireccion = $this->conn->prepare($sqlDireccion);

        // Asociar parámetros de la dirección
        $stmtDireccion->bindParam(':id_usuario', $id_usuario, \PDO::PARAM_INT);
        $stmtDireccion->bindParam(':id_estado', $datos['id_estado'], \PDO::PARAM_INT);
        $stmtDireccion->bindParam(':id_ciudad', $datos['id_ciudad'], \PDO::PARAM_INT);
        $stmtDireccion->bindParam(':id_municipio', $datos['id_municipio'], \PDO::PARAM_INT);
        $stmtDireccion->bindParam(':id_parroquia', $datos['id_parroquia'], \PDO::PARAM_INT);
        $stmtDireccion->bindParam(':descripcion', $datos['descripcion']);

        // Ejecutar la actualización de la dirección
        $stmtDireccion->execute();

        // Confirmar la transacción
        $this->conn->commit();

        return true;
    } catch (\PDOException $e) {
        // Revertir transacción en caso de error
        $this->conn->rollBack();
        error_log("Error al actualizar usuario y dirección: " . $e->getMessage());
        return false;
    }
}

    // Método para cambiar el estado de un usuario (eliminar lógicamente)
    public function cambiarEstadoUsuario($id_usuario)
    {
        try {
            $sql = $this->conn->prepare("UPDATE usuario SET status = 'inactivo' WHERE id_usuario = :id_usuario");
            $sql->bindParam(':id_usuario', $id_usuario, \PDO::PARAM_INT);
            return $sql->execute();
        } catch (\PDOException $e) {
            error_log("Error al cambiar estado del usuario: " . $e->getMessage());
            return false;
        }
    }

    // Método para buscar usuarios filtrados por nombre o número de documento
    public function buscarUsuariosFiltrados($searchTerm)
    {
        try {
            // Crear un término de búsqueda con los comodines para la búsqueda parcial
            $searchTerm = "%" . $searchTerm . "%";

            // Preparar la consulta SQL para buscar en los campos nombre1 y num_doc
            $sql = $this->conn->prepare("SELECT * FROM usuario WHERE (nombre1 LIKE :searchTerm OR num_doc LIKE :searchTerm) AND status = 'activo'");
            $sql->bindParam(':searchTerm', $searchTerm, \PDO::PARAM_STR);
            $sql->execute();

            // Retornar los resultados filtrados
            return $sql->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al buscar usuarios filtrados: " . $e->getMessage());
            return [];
        }
    }

    public function registrarUsuario($datosUsuario, $datosPaciente)
    {
        try {
            // Iniciar una transacción
            $this->conn->beginTransaction();

            // Insertar datos en la tabla `usuario`
            $queryUsuario = $this->conn->prepare(
                "INSERT INTO usuario (usuario, correo, contraseña) VALUES (?, ?, ?)"
            );
            $queryUsuario->execute([
                $datosUsuario['usuario'],
                $datosUsuario['correo'],
                md5($datosUsuario['contraseña']) // Hash de la contraseña
            ]);

            // Obtener el ID del usuario recién insertado
            $idUsuario = $this->conn->lastInsertId();

            // Insertar o actualizar datos en la tabla `direccion`
            $queryDireccion = $this->conn->prepare(
                "INSERT INTO direccion (id_estado, id_ciudad, id_municipio, id_parroquia, descripcion) 
                 VALUES (?, ?, ?, ?, ?)"
            );
            $queryDireccion->execute([
                $datosPaciente['id_estado'],
                $datosPaciente['id_ciudad'],
                $datosPaciente['id_municipio'],
                $datosPaciente['id_parroquia'],
                $datosPaciente['otro']
            ]);

            // Obtener el ID de la dirección recién insertada
            $idDireccion = $this->conn->lastInsertId();

            // Actualizar el usuario con datos adicionales
            $queryActualizarUsuario = $this->conn->prepare(
                "UPDATE usuario 
                 SET tipo_doc = ?, num_doc = ?, nombre1 = ?, nombre2 = ?, apellido1 = ?, 
                     apellido2 = ?, fecha_nac = ?, telefono = ?, pregunta_s1 = ?, 
                     respuesta_1 = ?, pregunta_s2 = ?, respuesta_2 = ?, sexo = ? 
                 WHERE id_usuario = ?"
            );
            $queryActualizarUsuario->execute([
                $datosPaciente['tipo_doc'],
                $datosPaciente['num_doc'],
                $datosPaciente['nombre1'],
                $datosPaciente['nombre2'],
                $datosPaciente['apellido1'],
                $datosPaciente['apellido2'],
                $datosPaciente['fecha_nac'],
                $datosPaciente['telefono'],
                $datosPaciente['pregunta_s1'],
                $datosPaciente['respuesta_1'],
                $datosPaciente['pregunta_s2'],
                $datosPaciente['respuesta_2'],
                $datosPaciente['sexo'],
                $idUsuario
            ]);

           

            // Confirmar la transacción
            $this->conn->commit();

            return [
                'status' => 'success',
                'message' => '¡Registro exitoso!'
            ];
        } catch (Exception $e) {
            // Revertir la transacción en caso de error
            $this->conn->rollBack();

            return [
                'status' => 'error',
                'message' => 'Error en el registro: ' . $e->getMessage()
            ];
        }
    }

}
