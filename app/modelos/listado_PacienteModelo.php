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
                        tipo_doc = :tipo_doc,
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

    // Método para buscar la dirección de un usuario por su ID

    public function buscarDireccionPorUsuario($id_usuario)
    {
        try {
            $sql = $this->conn->prepare("
                SELECT 
                    d.id_direccion, 
                    e.estado, 
                    c.ciudad, 
                    m.municipio, 
                    p.parroquia, 
                    d.descripcion
                FROM direccion d
                INNER JOIN estados e ON d.id_estado = e.id_estado
                INNER JOIN ciudades c ON d.id_ciudad = c.id_ciudad
                INNER JOIN municipios m ON d.id_municipio = m.id_municipio
                INNER JOIN parroquias p ON d.id_parroquia = p.id_parroquia
                INNER JOIN paciente pa ON pa.id_direccion = d.id_direccion
                WHERE pa.id_usuario = :id_usuario");

            $sql->bindParam(':id_usuario', $id_usuario, \PDO::PARAM_INT);
            $sql->execute();

            return $sql->fetch(\PDO::FETCH_ASSOC);
        } catch (\PDOException $e) {
            error_log("Error al buscar dirección por usuario: " . $e->getMessage());
            return null;
        }
    }

    public function registrarUsuario($datosUsuario, $datosPaciente)
    {
        try {
            // Iniciar una transacción
            $this->conn->beginTransaction();
            echo "Transacción iniciada.\n";

            // Insertar datos en la tabla `usuario`
            $queryUsuario = $this->conn->prepare(
                "INSERT INTO usuario (usuario, correo, contraseña, nombre1, nombre2, apellido1, apellido2, sexo, fecha_nac, tipo_doc, num_doc, telefono, pregunta_s1, respuesta_1, pregunta_s2, respuesta_2, status) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
            );
            if (!$queryUsuario->execute([
                $datosUsuario['usuario'],
                $datosUsuario['correo'],
                md5($datosUsuario['contraseña']), // Hash de la contraseña
                $datosUsuario['nombre1'],
                $datosUsuario['nombre2'],
                $datosUsuario['apellido1'],
                $datosUsuario['apellido2'],
                $datosUsuario['sexo'],
                $datosUsuario['fecha_nac'],
                $datosUsuario['tipo_doc'],
                $datosUsuario['num_doc'],
                $datosUsuario['telefono'],
                $datosUsuario['pregunta_s1'],
                $datosUsuario['respuesta_1'],
                $datosUsuario['pregunta_s2'],
                $datosUsuario['respuesta_2'],
                'activo' // Status activo por defecto
            ])) {
                throw new \Exception("Error al insertar los datos del usuario: " . implode(", ", $queryUsuario->errorInfo()));
            }
            echo "Datos del usuario insertados correctamente.\n";

            // Obtener el ID del usuario recién insertado
            $idUsuario = $this->conn->lastInsertId();

            // Insertar o actualizar datos en la tabla `direccion`
            $queryDireccion = $this->conn->prepare(
                "INSERT INTO direccion (id_estado, id_ciudad, id_municipio, id_parroquia, descripcion) 
            VALUES (?, ?, ?, ?, ?)"
            );
            if (!$queryDireccion->execute([
                $datosPaciente['id_estado'],
                $datosPaciente['id_ciudad'],
                $datosPaciente['id_municipio'],
                $datosPaciente['id_parroquia'],
                $datosPaciente['otro']
            ])) {
                throw new \Exception("Error al insertar los datos de la dirección: " . implode(", ", $queryDireccion->errorInfo()));
            }
            echo "Datos de la dirección insertados correctamente.\n";

            // Obtener el ID de la dirección recién insertada
            $idDireccion = $this->conn->lastInsertId();

            // Insertar datos del paciente
            $queryPaciente = $this->conn->prepare(
                "INSERT INTO paciente (id_usuario, id_direccion, num_hijos, discapacitado, descrip_disca) 
            VALUES (?, ?, ?, ?, ?)"
            );
            if (!$queryPaciente->execute([
                $idUsuario,
                $idDireccion,
                $datosPaciente['num_hijos'],
                $datosPaciente['discapacitado'],
                $datosPaciente['descrip_disca']
            ])) {
                throw new \Exception("Error al insertar los datos del paciente: " . implode(", ", $queryPaciente->errorInfo()));
            }
            echo "Datos del paciente insertados correctamente.\n";

            // Confirmar la transacción
            $this->conn->commit();
            echo "Transacción completada correctamente.\n";
        } catch (\Exception $e) {
            // Si ocurre un error, revertir la transacción
            $this->conn->rollBack();
            echo "Error al registrar el usuario: " . $e->getMessage() . "\n";
        }
    }


    // Método para listar las ciudades

}
