<?php
require 'vendor/autoload.php';

// Tu código aquí, por ejemplo:
$pdf = new TCPDF();
$pdf->AddPage();
$pdf->SetFont('helvetica', '', 12);
$pdf->Cell(0, 10, '¡Hola, TCPDF!', 0, 1, 'C');
$pdf->Output('ejemplo.pdf', 'I');
