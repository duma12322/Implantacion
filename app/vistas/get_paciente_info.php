<?php
include_once('../../config/conexion.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['id_paciente'])) {
    $id_paciente = (int)$_POST['id_paciente'];

    // Consulta para obtener el id_usuario y num_hijos a partir de id_paciente
    $stmt_paciente = $conn->prepare("SELECT id_usuario, num_hijos FROM paciente WHERE id_paciente = :id_paciente");
    $stmt_paciente->bindParam(':id_paciente', $id_paciente, PDO::PARAM_INT);
    $stmt_paciente->execute();
    $paciente = $stmt_paciente->fetch(PDO::FETCH_ASSOC);

    if ($paciente) {
        $id_usuario = $paciente['id_usuario'];
        $num_hijos = $paciente['num_hijos'];

        // Consulta para obtener num_doc y tipo_doc de la tabla usuario
        $stmt_usuario = $conn->prepare("SELECT num_doc, tipo_doc FROM usuario WHERE id_usuario = :id_usuario");
        $stmt_usuario->bindParam(':id_usuario', $id_usuario, PDO::PARAM_INT);
        $stmt_usuario->execute();
        $usuario = $stmt_usuario->fetch(PDO::FETCH_ASSOC);

        if ($usuario) {
            $num_doc = $usuario['num_doc'];
            $tipo_doc = $usuario['tipo_doc'];

            // Combinación de num_hijos y num_doc
            $relacion_numero_doc = $num_hijos . '-' . $num_doc;

            echo json_encode(['success' => true, 'tipo_doc' => $tipo_doc, 'num_doc' => $relacion_numero_doc]);
        } else {
            echo json_encode(['success' => false, 'message' => 'No se encontraron datos para el usuario.']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'No se encontraron datos para el paciente.']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Solicitud no válida.']);
}
