<?php
require_once('../../tcpdf/tcpdf.php');
require_once('../../config/conexion.php'); // Archivo donde conectas tu base de datos

function generarPDF($paciente, $empresa, $relacion)
{
    // Crear nuevo PDF
    $pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);

    // Información del documento
    $pdf->SetCreator(PDF_CREATOR);
    $pdf->SetAuthor('Autor del Informe');
    $pdf->SetTitle('Informe del Paciente');
    $pdf->SetSubject('Informe detallado');

    // Añadir una página
    $pdf->AddPage();

    // Logo de la empresa
    $pdf->Image('files/logo.png', 15, 15, 40, '', '', '', '', false, 300);

    // Separador
    $pdf->SetLineWidth(0.5);
    $pdf->Line(10, 10, 200, 10);

    // Información de la empresa
    $pdf->SetFont('helvetica', '', 10);
    $pdf->SetXY(15, 25);
    $pdf->MultiCell(0, 6, $empresa['razon_social'] . "\n" .
        $empresa['tipo_documento'] . "-" . $empresa['n_documeto'] .
        "\n" . $empresa['dirreccion'] . "\n" . $empresa['correo'] .
        "\n" . $empresa['tlf_local'] . " / " . $empresa['tlf_celular'], 0, 'C', 0);

    // Fecha de reporte
    $pdf->SetFont('helvetica', 'I', 10);
    $pdf->SetXY(150, 15);
    $pdf->MultiCell(50, 6, 'Fecha de Reporte: ' . date('d-m-Y'), 0, 'C', 0);

    // Separador horizontal
    $pdf->Line(10, 60, 200, 60);

    // Título centralizado - debajo de los datos de la empresa
    $pdf->SetFont('helvetica', 'B', 16);
    $pdf->SetXY(90, $pdf->GetY() + 5); // Ajustamos la Y para que esté justo debajo
    $pdf->Cell(40, 85, 'Reporte del Paciente', 0, 1, 'C');

    // Separador horizontal
    $pdf->Line(10, 85, 200, 85);

    // Título y datos de la cita
    $pdf->SetFont('helvetica', 'B', 13);
    $pdf->SetXY(15, 90);
    $pdf->Cell(0, 10, 'Datos de la Cita', 0, 1, 'L');

    // Información de la cita
    $pdf->SetFont('helvetica', '', 12);
    $pdf->SetFillColor(255, 255, 255);
    $pdf->Cell(0, 10, 'Documento: ' . htmlspecialchars($paciente['tipo_documento'] . '-' . $paciente['numero_documento']), 1, 1, 'L', 1);
    $pdf->Cell(0, 10, 'Paciente: ' . htmlspecialchars($paciente['nombre_paciente'] . ' ' . $paciente['apellido_paciente']), 1, 1, 'L', 1);
    $pdf->Cell(0, 10, 'Fecha: ' . date_format(date_create($paciente['fecha_cita']), 'Y-m-d'), 1, 1, 'L', 1);
    $pdf->Cell(0, 10, 'Hora Inicio: ' . htmlspecialchars($paciente['hora_inicio']), 1, 1, 'L', 1);
    $pdf->Cell(0, 10, 'Hora Final: ' . htmlspecialchars($paciente['hora_final']), 1, 1, 'L', 1);
    $pdf->Cell(0, 10, 'Motivo: ' . htmlspecialchars($paciente['motivo']), 1, 1, 'L', 1);
    $pdf->Cell(0, 10, 'Tipo de Cita: ' . htmlspecialchars($paciente['tipo_cita']), 1, 1, 'L', 1);
    $pdf->Cell(0, 10, 'Modalidad: ' . htmlspecialchars($paciente['modalidad']), 1, 1, 'L', 1);
    $pdf->Cell(0, 10, 'Pago: ' . htmlspecialchars($paciente['tipo_pago']) . ' - $' . number_format($paciente['monto'], 2), 1, 1, 'L', 1);
    $pdf->Cell(0, 10, 'Número de Hijos: ' . htmlspecialchars($paciente['num_hijos']), 1, 1, 'L', 1);
    $pdf->Cell(0, 10, 'Discapacidad: ' . htmlspecialchars($paciente['discapacitado'] ? 'Sí' : 'No'), 1, 1, 'L', 1);

    if ($paciente['discapacitado']) {
        $pdf->Cell(0, 10, 'Descripción Discapacidad: ' . htmlspecialchars($paciente['descrip_disca']), 1, 1, 'L', 1);
    }

    // Relación familiar
    if ($relacion) {
        $pdf->Ln(10);
        $pdf->SetFont('helvetica', 'B', 13);
        $pdf->Cell(0, 10, 'Datos de la Relación Familiar', 0, 1, 'L');

        $pdf->SetFont('helvetica', '', 12);
        $pdf->Cell(0, 10, 'Relación Familiar: ' . htmlspecialchars($relacion['relacion_familiar']), 1, 1, 'L', 1);
        $pdf->Cell(0, 10, 'Nombre: ' . htmlspecialchars($relacion['relacion_nombre1'] . ' ' . $relacion['relacion_nombre2']), 1, 1, 'L', 1);
        $pdf->Cell(0, 10, 'Apellido: ' . htmlspecialchars($relacion['relacion_apellido1'] . ' ' . $relacion['relacion_apellido2']), 1, 1, 'L', 1);
        $pdf->Cell(0, 10, 'Fecha de Nacimiento: ' . date_format(date_create($relacion['relacion_fecha_nac']), 'Y-m-d'), 1, 1, 'L', 1);
        $pdf->Cell(0, 10, 'Documento: ' . htmlspecialchars($relacion['relacion_tipo_doc'] . '-' . $relacion['relacion_numero_doc']), 1, 1, 'L', 1);
        $pdf->Cell(0, 10, 'Discapacidad: ' . htmlspecialchars($relacion['relacion_discapacitado'] ? 'Sí' : 'No'), 1, 1, 'L', 1);
        $pdf->Cell(0, 10, 'Descripción Discapacidad: ' . htmlspecialchars($relacion['relacion_descrip_disca']), 1, 1, 'L', 1);
    }

    // Salida del PDF
    $pdf->Output('Reporte' . ' ' . $paciente['nombre_paciente'] . ' ' . $paciente['apellido_paciente'] . '.pdf', 'I');
}

if (isset($_GET['descargar_pdf'])) {
    $cita_id = $_GET['descargar_pdf'];

    // Consulta para obtener los datos del paciente
    $stmt = $conn->prepare("SELECT c.id_cita, c.motivo, c.fecha AS fecha_cita, 
                            u.nombre1 AS nombre_paciente, u.apellido1 AS apellido_paciente, 
                            u.num_doc AS numero_documento, u.tipo_doc AS tipo_documento,
                            adm.nombre1 AS nombre_psicologo, adm.apellido1 AS apellido_psicologo, 
                            a.hora_inicio, a.hora_final, 
                            pc.tipo_pago, pc.monto, 
                            t.tipo_cita, t.modalidad,
                            p.num_hijos, p.discapacitado, p.descrip_disca,
                            c.id_paciente  -- Ensure this is included
                            FROM cita c
                            JOIN agenda a ON c.id_agenda = a.id_agenda 
                            JOIN paciente p ON c.id_paciente = p.id_paciente
                            JOIN usuario u ON p.id_usuario = u.id_usuario
                            JOIN psicologo ps ON c.id_psicologo = ps.id_psicologo 
                            JOIN administrativo adm ON ps.id_administrativo = adm.id_administrativo
                            JOIN pago_cita pc ON c.id_cita = pc.id_cita 
                            JOIN tipo_cita t ON c.id_tipo_cita = t.id_tipo_cita
                            WHERE c.id_cita = :id_cita");
    $stmt->execute([':id_cita' => $cita_id]);
    $paciente = $stmt->fetch(PDO::FETCH_ASSOC);


    // Verificar si el tipo de cita es "individual"
    if ($paciente['tipo_cita'] !== 'individual') {
        // Si el tipo de cita no es "individual", obtener la relación del paciente
        $stmt_relacion = $conn->prepare("SELECT pr.id_paciente_relacion, pr.relacion_familiar, 
                                            pr.relacion_nombre1, pr.relacion_nombre2, 
                                            pr.relacion_apellido1, pr.relacion_apellido2, 
                                            pr.relacion_fecha_nac, pr.relacion_tipo_doc, 
                                            pr.relacion_numero_doc, pr.relacion_discapacitado, 
                                            pr.relacion_descrip_disca
                                            FROM paciente_relacion pr
                                            WHERE pr.id_paciente = :id_paciente");
        $stmt_relacion->execute([':id_paciente' => $paciente['id_paciente']]);
        $relacion = $stmt_relacion->fetch(PDO::FETCH_ASSOC);
    } else {
        // Si es una cita individual, no se obtiene ninguna relación
        $relacion = null;
    }

    // Consulta para obtener los datos de la empresa
    $stmt_empresa = $conn->prepare("SELECT * FROM empresa LIMIT 1");
    $stmt_empresa->execute();
    $empresa = $stmt_empresa->fetch(PDO::FETCH_ASSOC);

    // Verificar si se encontraron resultados y si las claves necesarias existen
    if ($paciente && $empresa) {
        // Asegurarse de que todas las claves necesarias existen en $paciente
        if (isset($paciente['nombre_paciente'], $paciente['apellido_paciente'], $paciente['nombre_psicologo'], $paciente['apellido_psicologo'], $paciente['fecha_cita'], $paciente['hora_inicio'], $paciente['hora_final'], $paciente['motivo'], $paciente['tipo_cita'], $paciente['modalidad'], $paciente['tipo_pago'], $paciente['monto'], $paciente['num_hijos'], $paciente['discapacitado'], $paciente['descrip_disca'])) {
            generarPDF($paciente, $empresa, $relacion);
        } else {
            echo "Faltan datos necesarios en el resultado de la consulta de paciente.";
        }
    } else {
        echo "No se encontró información para el ID de cita proporcionado o faltan datos.";
    }
}
