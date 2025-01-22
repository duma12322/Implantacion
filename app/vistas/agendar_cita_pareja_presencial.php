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
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agendar Cita Individual Presencial</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>

<body>
    <div class="container">
        <h2 class="my-4">Agendar Cita Individual Presencial</h2>
        <form action="../controladores/procesar_agendar_cita_pareja.php" method="POST">
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

            <h3 class="mt-4">Datos de la Pareja</h3>
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
            </div>
            <div class="form-group">
                <label for="relacion_tipo_doc">Tipo de Documento</label>
                <select name="relacion_tipo_doc" id="relacion_tipo_doc" class="form-control">
                    <option value="">Seleccione un tipo de documento</option>
                    <option value="V">V</option>
                    <option value="E">E</option>
                    <option value="J">J</option>
                    <option value="P">P</option>
                </select>
            </div>
            <div class="form-group">
                <label for="relacion_numero_doc">Número de Documento</label>
                <input type="text" name="relacion_numero_doc" id="relacion_numero_doc" class="form-control" required>
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
            </div>

            <div class="form-group">
                <label for="motivo">Motivo</label>
                <textarea name="motivo" id="motivo" class="form-control" rows="3" required></textarea>
            </div>

            <h4 class="mt-4">Pago</h4>
            <div class="form-group">
                <label for="tipo_pago">Tipo de Pago</label>
                <select name="tipo_pago" id="tipo_pago" class="form-control" required>
                    <option value="">Seleccione un tipo de pago</option>
                    <option value="TRANSFERENCIA BANCARIA">TRANSFERENCIA BANCARIA</option>
                    <option value="PAGO MOVIL">PAGO MOVIL</option>
                    <option value="EFECTIVO $">EFECTIVO $</option>
                </select>
            </div>
            <div class="form-group">
                <label for="monto">Monto</label>
                <input type="number" name="monto" id="monto" class="form-control" value="35" readonly required>
            </div>
            <div class="form-group">
                <label for="referencia_bancaria">Referencia Bancaria</label>
                <input type="text" name="referencia_bancaria" id="referencia_bancaria" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-success">Agendar Cita</button>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="script/fecha.js"></script>
    <script src="script/discapacitado.js"></script>

</body>

</html>