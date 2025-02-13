<?php
session_start();

// Verifica si la sesión está activa
if (!isset($_SESSION['id_usuario'])) {
    header("Location: login_paciente.php");
    exit;
}

$id_usuario = (int)$_SESSION['id_usuario'];

include_once('../../config/conexion.php');

$query_paciente = "
    SELECT 
        u.id_usuario, u.nombre1, u.nombre2, u.apellido1, u.apellido2, p.id_paciente 
    FROM usuario u 
    JOIN paciente p ON u.id_usuario = p.id_usuario
    WHERE u.id_usuario = :id_usuario
";
$stmt_paciente = $conn->prepare($query_paciente);
$stmt_paciente->bindParam(':id_usuario', $id_usuario, PDO::PARAM_INT);
$stmt_paciente->execute();
$paciente = $stmt_paciente->fetch(PDO::FETCH_ASSOC);

if (!$paciente) {
    echo "No se encontró información para el paciente.";
    exit;
}

$query_psicologos = "
    SELECT 
        p.id_psicologo, 
        a.Nombre1, 
        a.Apellido1
    FROM psicologo p
    JOIN administrativo a ON p.id_administrativo = a.id_administrativo
";
$stmt_psicologos = $conn->prepare($query_psicologos);
$stmt_psicologos->execute();
$result_psicologos = $stmt_psicologos->fetchAll(PDO::FETCH_ASSOC);

$query_agenda = "SELECT * FROM agenda WHERE status = 'Pendiente'";
$stmt_agenda = $conn->prepare($query_agenda);
$stmt_agenda->execute();
$result_agenda = $stmt_agenda->fetchAll(PDO::FETCH_ASSOC);

// Obtener el número de hijos del paciente desde la base de datos
$stmt_paciente = $conn->prepare("SELECT num_hijos FROM paciente WHERE id_paciente = :id_paciente");
$stmt_paciente->execute([':id_paciente' => $paciente['id_paciente']]);
$info_paciente = $stmt_paciente->fetch(PDO::FETCH_ASSOC);

$stmt_usuario = $conn->prepare("SELECT tipo_doc FROM usuario WHERE id_usuario = :id_usuario");
$stmt_usuario->execute([':id_usuario' => $id_usuario]);
$info_usuario = $stmt_usuario->fetch(PDO::FETCH_ASSOC);

$tipo_doc = isset($info_usuario['tipo_doc']) ? htmlspecialchars($info_usuario['tipo_doc']) : '';

if ($info_paciente && $info_paciente['num_hijos'] !== NULL) {
    $num_hijos = $info_paciente['num_hijos'];

    // Obtener el número de documento del usuario desde la base de datos
    $stmt_usuario = $conn->prepare("SELECT num_doc FROM usuario WHERE id_usuario = :id_usuario");
    $stmt_usuario->execute([':id_usuario' => $id_usuario]);
    $info_usuario = $stmt_usuario->fetch(PDO::FETCH_ASSOC);

    if ($info_usuario && $info_usuario['num_doc'] !== NULL) {
        $num_doc = $info_usuario['num_doc'];

        // Crear el número de documento combinando el num_hijos y el num_doc con un guion
        $relacion_numero_doc = $num_hijos . "-" . $num_doc;
        echo "Número de Documento Generado: " . $relacion_numero_doc;
        // Almacenar el valor en una variable de sesión
        $_SESSION['relacion_numero_doc'] = $relacion_numero_doc;
    } else {
        echo "No se encontró un número de documento válido para el usuario.";
        $relacion_numero_doc = "";
    }
} else {
    echo "No se encontró un número de hijos válido para el paciente.";
    $relacion_numero_doc = "";
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agendar Cita Infantil Presencial</title>
    <link rel="stylesheet" href="css/bootstrap-4.5.2/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-icons/bootstrap-icons.min.css">
</head>

<body>
    <div class="container">
        <nav class="nav nav-borders">
            <a class="nav-link" href="agendar_cita.php">Volver al listado</a>
        </nav>
        <h2 class="my-4">Agendar Cita Infantil Presencial</h2>
        <form action="../controladores/procesar_agendar_cita_infantil.php" method="POST">
            <div class="form-group">
                <label for="id_psicologo">Psicólogo</label>
                <select name="id_psicologo" id="id_psicologo" class="form-control" required>
                    <option value="">Seleccione un psicólogo</option>
                    <?php foreach ($result_psicologos as $row_psicologo): ?>
                        <option value="<?= $row_psicologo['id_psicologo']; ?>">
                            <?= $row_psicologo['Nombre1'] . ' ' . $row_psicologo['Apellido1']; ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-group">
                <label for="paciente_nombre">Paciente</label>
                <input type="text" id="paciente_nombre" class="form-control" value="<?= $paciente['nombre1'] . ' ' . $paciente['nombre2'] . ' ' . $paciente['apellido1'] . ' ' . $paciente['apellido2']; ?>" readonly>
                <input type="hidden" name="id_paciente" id="id_paciente" value="<?= $paciente['id_paciente']; ?>">
            </div>

            <div class="form-group">
                <label for="discapacitado">¿Es discapacitado?</label>
                <select name="discapacitado" id="discapacitado" class="form-control" required>
                    <option value="">Seleccione</option>
                    <option value="1">Sí</option>
                    <option value="0">No</option>
                </select>
            </div>

            <div class="form-group" id="descrip_disca_group" style="display: none;">
                <label for="descrip_disca">Descripción de la discapacidad</label>
                <textarea type="text" name="descrip_disca" id="descrip_disca" class="form-control"></textarea>
            </div>

            <h3 class="mt-4">Datos del Paciente Infantil</h3>
            <div class="form-group">
                <label for="relacion_familiar">Tipo de Relación</label>
                <select name="relacion_familiar" id="relacion_familiar" class="form-control">
                    <option value="Hijo">Hijo</option>
                    <option value="Sobrino">Sobrino</option>
                    <option value="Ahijado">Ahijado</option>
                    <option value="Otro">Otro</option>
                </select>
            </div>

            <div class="form-group">
                <label for="relacion_nombre1">Primer Nombre</label>
                <input type="text" name="relacion_nombre1" id="relacion_nombre1" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="relacion_nombre2">Segundo Nombre</label>
                <input type="text" name="relacion_nombre2" id="relacion_nombre2" class="form-control">
            </div>
            <div class="form-group">
                <label for="relacion_apellido1">Primer Apellido</label>
                <input type="text" name="relacion_apellido1" id="relacion_apellido1" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="relacion_apellido2">Segundo Apellido</label>
                <input type="text" name="relacion_apellido2" id="relacion_apellido2" class="form-control">
            </div>

            <div class="form-group">
                <label for="relacion_fecha_nac">Fecha de Nacimiento</label>
                <input type="date" name="relacion_fecha_nac" id="relacion_fecha_nac" class="form-control" required>
                <span id="age-warning" style="color: red; display: none;">Debe ser menor de edad.</span>
                <span id="age-warning-12" style="color: red; display: none;">No puede ser mayor de 12 años.</span>
            </div>

            <div class="form-group">
                <label for="relacion_tipo_doc">Tipo de Documento</label>
                <input type="text" name="relacion_tipo_doc" id="relacion_tipo_doc" class="form-control" value="<?= $tipo_doc ?>" readonly>
            </div>

            <div class="form-group">
                <label for="relacion_numero_doc">Número de Documento</label>
                <input type="text" name="relacion_numero_doc" id="relacion_numero_doc" class="form-control" required readonly value="<?php echo htmlspecialchars($_SESSION['relacion_numero_doc'] ?? '', ENT_QUOTES, 'UTF-8'); ?>">
            </div>

            <div class="form-group">
                <label for="relacion_discapacitado">¿Es discapacitado?</label>
                <select name="relacion_discapacitado" id="relacion_discapacitado" class="form-control" required onchange="toggleDescriptionField()">
                    <option value="">Seleccione</option>
                    <option value="1">Sí</option>
                    <option value="0">No</option>
                </select>
            </div>

            <div class="form-group" id="descriptionField" style="display:none;">
                <label for="relacion_descrip_disca">Descripción de la discapacidad</label>
                <textarea type="text" name="relacion_descrip_disca" id="relacion_descrip_disca" class="form-control"></textarea>
            </div>

            <h3 class="mt-4">Datos de la Cita</h3>
            <div class="form-group">
                <label for="fecha">Fecha de la Cita</label>
                <input type="date" name="fecha" id="fecha" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="hora">Hora de inicio</label>
                <div class="row">
                    <div class="col">
                        <input type="number" name="hora" id="hora" class="form-control" placeholder="Hora (1-12)" min="1" max="12" required>
                    </div>
                    <div class="col">
                        <input type="number" name="minutos" id="minutos" class="form-control" placeholder="Minutos (00-59)" min="0" max="59" required>
                    </div>
                    <div class="col">
                        <select name="am_pm" id="am_pm" class="form-control" required>
                            <option value="">Seleccione</option>
                            <option value="AM">AM</option>
                            <option value="PM">PM</option>
                        </select>
                    </div>
                </div>
                <!-- Aquí se mostrará el mensaje de advertencia -->
                <div id="advertencia" style="color: red; margin-top: 10px;"></div>
            </div>

            <div class="form-group">
                <label for="motivo">Motivo</label>
                <textarea name="motivo" id="motivo" class="form-control" rows="3" required></textarea>
            </div>

            <h4 class="mt-4">Pago</h4>
            <div class="form-group">
                <label for="tipo_pago">Tipo de Pago</label>
                <select name="tipo_pago" id="tipo_pago" class="form-control" required onchange="toggleReferencia()">
                    <option value="">Seleccione un tipo de pago</option>
                    <option value="TRANSFERENCIA BANCARIA">TRANSFERENCIA BANCARIA</option>
                    <option value="PAGO MOVIL">PAGO MOVIL</option>
                    <option value="EFECTIVO $">EFECTIVO $</option>
                </select>
            </div>
            <div class="form-group">
                <label for="monto">Monto</label>
                <input type="number" name="monto" id="monto" class="form-control" value="30" readonly required>
            </div>
            <div class="form-group" id="referencia-group">
                <label for="referencia_bancaria">Referencia Bancaria</label>
                <input type="text" name="referencia_bancaria" id="referencia_bancaria" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-success">Agendar Cita</button>
        </form>
    </div>
    <script src="script/jquery.min.js"></script>
    <script src="script/popper.min.js"></script>
    <script src="script/bootstrap.min.js/bootstrap.min.js"></script>
    <script src="script/fecha.js"></script>
    <script src="script/menorEdad.js "></script>
    <script src="script/discapacitado.js"></script>
    <script src="script/relacion_discapacitado.js"></script>
    <script src="script/validarHora.js"></script>
    <script>
        function toggleReferencia() {
            let tipoPago = document.getElementById('tipo_pago').value;
            let referenciaInput = document.getElementById('referencia_bancaria');

            if (tipoPago === 'EFECTIVO $') {
                referenciaInput.value = '0000'; // Asignar valor
                referenciaInput.disabled = true; // Deshabilitar
            } else {
                referenciaInput.value = ''; // Limpiar valor
                referenciaInput.disabled = false; // Habilitar
            }
        }

        // Ejecutar la función una vez al cargar la página
        document.addEventListener('DOMContentLoaded', function() {
            toggleReferencia(); // Inicializa el estado del campo al cargar la página
        });
    </script>

    <script>
        const numHijos = <?php echo json_encode($num_hijos ?? null); ?>;
        const numDoc = <?php echo json_encode($num_doc ?? null); ?>;
        const relacionNumeroDoc = numHijos + numDoc;

        document.addEventListener('DOMContentLoaded', function() {
            const numeroDocField = document.getElementById('relacion_numero_doc');
            if (numeroDocField) {
                numeroDocField.value = relacionNumeroDoc;
            } else {
                console.error("Campo 'relacion_numero_doc' no encontrado.");
            }
        });
    </script>
</body>

</html>