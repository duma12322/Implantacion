<?php
// Conexión a la base de datos
require_once 'conexion.php';

session_start(); // Asegúrate de iniciar la sesión
if (!isset($_SESSION['usuario'])) {
    header("Location: login_psicologo_admin.php");
    exit;
}

// Obtener id_usuario desde la URL
if (isset($_GET['id_usuario'])) {
    $id_usuario = $_GET['id_usuario'];
} else {
    $id_usuario = $_SESSION['id_usuario_creacion'] ?? null;
}

// Verificar que id_usuario no sea nulo
if (empty($id_usuario)) {
    die("ID de usuario no válido.");
}
//echo "ID de usuario utilizado para la creación: " . $id_usuario; // Mensaje de depuración

// Recibir datos del formulario
// Recibir datos del formulario
$entrevistador = $_POST['entrevistador'] ?? null;
$id_administrativo = $_POST['id_administrativo'] ?? null;
$fecha_nac = $_POST['fecha_nac'] ?? null;
$instruccion = $_POST['instruccion'] ?? null;
$edo_civil = $_POST['edo_civil'] ?? null;
$estudio_trabajo = $_POST['estudios_trabajos'] ?? null;
$lugar_resi = $_POST['lugar_resi'] ?? null;
$procedencia = $_POST['procedencia'] ?? null;
$fecha_p_cita = $_POST['fecha_p_cita'] ?? null;
$edad = $_POST['edad'] ?? null;
$lugar_nacimient = $_POST['lugar_nacimient'] ?? null;
$ocupacion = $_POST['ocupacion'] ?? null;
$religion = $_POST['religion'] ?? null;
$grado_ciclo = $_POST['grado_ciclo'] ?? null;
$ti_resi = $_POST['ti_resi'] ?? null;
$informante = $_POST['informante'] ?? null;
$motivo = $_POST['motivo'] ?? null;  // Usar null si no se envía
$inicio_curso = $_POST['inicio_curso'] ?? null;
$tiempo_proble = $_POST['tiempo_proble'] ?? null;
$suceso_dia = $_POST['suceso_dia'] ?? null;
$dia_anterior = $_POST['dia_anterior'] ?? null;
$que_hizo = $_POST['que_hizo'] ?? null;
$como_se_calmo = $_POST['como_se_calmo'] ?? null;
$hablo_alguien_del_problema = $_POST['hablo_alguien_del_problema'] ?? null;
$factores_desenca_del_proble = $_POST['factores_desenca_del_proble'] ?? null;
$ultimo_trata_fisi_psico = $_POST['ultimo_trata_fisi_psico'] ?? null;
$autodescrpi_perso = $_POST['autodescrpi_perso'] ?? null; // Corregido
$filosofia_vida = $_POST['filosofia_vida'] ?? null;
$edad_madre_nacer = $_POST['edad_madre_nacer'] ?? null;
$parto = $_POST['parto'] ?? null;
$tipo_atencion_parto = $_POST['tipo_atencion_parto'] ?? null;
$descrip_tipo_atencion = $_POST['descrip_tipo_atencion'] ?? null;
$termino = $_POST['termino'] ?? null;
$postnatalidad = $_POST['postnatalidad'] ?? null;
$estatura_al_nacer = $_POST['estatura_al_nacer'] ?? null; // Asegúrate de que esta variable esté definida
$peso = $_POST['peso'] ?? null;
$perimetro_cefalico = $_POST['perimetro_cefalico'] ?? null;
$taraxico = $_POST['taraxico'] ?? null;
$lloro = $_POST['lloro'] ?? null;
$reflejos = $_POST['reflejos'] ?? null;
$lenguaje = $_POST['lenguaje'] ?? null;
$juego = $_POST['juego'] ?? null;
$edad_camino = $_POST['edad_camino'] ?? null;
$encopresis = $_POST['encopresis'] ?? null;
$edad_control_enco = $_POST['edad_control_enco'] ?? null;
$enuresis = $_POST['enuresis'] ?? null;
$edad_control_enu = $_POST['edad_control_enu'] ?? null;
$motroci_fina = $_POST['motroci_fina'] ?? null;
$motrici_gruesa = $_POST['motrici_gruesa'] ?? null;
$movimi_pinza = $_POST['movimi_pinza'] ?? null;
$alimentacion_infancia = $_POST['alimentacion_infancia'] ?? null;
$crianza = $_POST['crianza'] ?? null;
$juego_infantil = $_POST['juego_infantil'] ?? null;
$caracter_y_comportamiento_primero_años = $_POST['caracter_y_comportamiento_primero_años'] ?? null;
$r_s_padres = $_POST['r_s_padres'] ?? null;
$r_s_hermanos = $_POST['r_s_hermanos'] ?? null;
$r_s_otros_familiares = $_POST['r_s_otros_familiares'] ?? null;
$r_s_conocidos = $_POST['r_s_conocidos'] ?? null;
$r_s_extraños_m_edad_d_edad = $_POST['r_s_extraños_m_edad_d_edad'] ?? null;
$grado_integracion_a_ellos = $_POST['grado_integracion_a_ellos'] ?? null;
$adaptacion_ingreso_escu = $_POST['adaptacion_ingreso_escu'] ?? null;
$integracion_condiscipulos = $_POST['integracion_condiscipulos'] ?? null;
$comportamiento_salon_clase = $_POST['comportamiento_salon_clase'] ?? null;
$compor_recreo = $_POST['compor_recreo'] ?? null;
$relacion_demas = $_POST['relacion_demas'] ?? null;
$aislamiento = $_POST['aislamiento'] ?? null;
$descrip_aislamiento = $_POST['descrip_aislamiento'] ?? null;
$experiencia_estudio_primarios = $_POST['experiencia_estudio_primarios'] ?? null;
$experiencia_estudio_segundario = $_POST['experiencia_estudio_segundario'] ?? null;
$experiencia_estudio_superior = $_POST['experiencia_estudio_superior'] ?? null;
$proble_afectivo_conducta_niñez = $_POST['proble_afectivo_conducta_niñez'] ?? null;
$proble_afectivo_pubertad = $_POST['proble_afectivo_pubertad'] ?? null;
$particularidades_adole = $_POST['particularidades_adole'] ?? null;
$proble_afectivo_adole = $_POST['proble_afectivo_adole'] ?? null;
$grado_armonia_madurez_bio_psico = $_POST['grado_armonia_madurez_bio_psico'] ?? null;
$desarrollo_voluntad = $_POST['desarrollo_voluntad'] ?? null;
$economia = $_POST['economia'] ?? null;
$grado_autonomía_deliberación_acción  = $_POST['grado_autonomía_deliberación_acción '] ?? null;
$persistencia_esfuerzo = $_POST['persistencia_esfuerzo'] ?? null;
$jerarvalores_estilovida_sexaceina = $_POST['jerarvalores_estilovida_sexaceina'] ?? null;
$norma_nivel_familiar = $_POST['norma_nivel_familiar'] ?? null;
$prefe_smo = $_POST['prefe_smo'] ?? null;
$habitos_intereses = $_POST['habitos_intereses'] ?? null;
$enfermedad_accidente = $_POST['enfermedad_accidente'] ?? null;
$eleccion_profesion = $_POST['eleccion_profesion'] ?? null;
$vivienda = $_POST['vivienda'] ?? null;
$economía = $_POST['economía'] ?? null;
$r_jefe_super_compa_subal = $_POST['r_jefe_super_compa_subal'] ?? null;
$crecimiento_psicosocial = $_POST['crecimiento_psicosocial'] ?? null;
$ambiciones_laboral = $_POST['ambiciones_laboral'] ?? null;
$cambio_profesion = $_POST['cambio_profesion'] ?? null;
$cuadro_familiar = $_POST['cuadro_familiar'] ?? null;
$relaciones_interperso = $_POST['relaciones_interperso'] ?? null;
$recreacion = $_POST['recreacion'] ?? null;
$conducta_sexual = $_POST['conducta_sexual'] ?? null;
$elegir_pareja = $_POST['elegir_pareja'] ?? null;
$fiel_exigente = $_POST['fiel_exigente'] ?? null;
$noviazgo = $_POST['noviazgo'] ?? null;
$matrimonio = $_POST['matrimonio'] ?? null;
$opinion_matrimonio = $_POST['opinion_matrimonio'] ?? null;
$particularidades_dia_boda = $_POST['particularidades_dia_boda'] ?? null;
$vida_matrimonial = $_POST['vida_matrimonial'] ?? null;
$separacion = $_POST['separacion'] ?? null;
$divorcio = $_POST['divorcio'] ?? null;
$proble_peri_criti_particu_climaterio_menopausia_edadcriti = $_POST['proble_peri_criti_particu_climaterio_menopausia_edadcriti'] ?? null;
$abuelo_p = $_POST['abuelo_p'] ?? null;
$abuela_p = $_POST['abuela_p'] ?? null;
$padre = $_POST['padre'] ?? null;
$tios_p = $_POST['tios_p'] ?? null;
$abuelo_m = $_POST['abuelo_m'] ?? null;
$abuela_m = $_POST['abuela_m'] ?? null;
$madre = $_POST['madre'] ?? null;
$tios_m = $_POST['tios_m'] ?? null;
$hermanos = $_POST['hermanos'] ?? null;
$esposo_a = $_POST['esposo_a'] ?? null; // Asegúrate de que el nombre sea correcto
$hijos = $_POST['hijos'] ?? null;
$colaterales = $_POST['colaterales'] ?? null;
$signos_sintoma = $_POST['signos_sintoma'] ?? null;
$patologia_sindrome = $_POST['patologia_sindrome'] ?? null;
$trastorno = $_POST['trastorno'] ?? null;
$nivel_afectacion = $_POST['nivel_afectacion'] ?? null;
$conclusion_diag = $_POST['conclusion_diag'] ?? null;
$exa_conductual_facultades_psiquicas = $_POST['exa_conductual_facultades_psiquicas'] ?? null;
$eva_psico = $_POST['eva_psico'] ?? null;
$programa_trata_propuesto = $_POST['programa_trata_propuesto'] ?? null;
$evolucion = $_POST['evolucion'] ?? null;

// Validar que el campo 'motivo' no sea nulo
if (empty($motivo)) {
    die("El campo 'motivo' es obligatorio y no puede estar vacío.");
}

// Definir las variables de ID inicialmente
$id_paciente_relacion = null;
$id_historial = null;
$id_historia_perso_social = null;
$id_relacion_social_niñez = null;
$id_escolaridad = null;
$id_conducta = null;
$id_traba_social = null;
$id_conductas_pareja = null;
$id_antecedentes_familiares = null;
$id_diag_resul_trata_evo = null;

// Obtener id_paciente_relacion desde la tabla paciente_relacion
// Obtener id_paciente desde la tabla paciente
$query_paciente = "
    SELECT id_paciente 
    FROM paciente 
    WHERE id_usuario = :id_usuario";

$stmt_paciente = $conn->prepare($query_paciente);
$stmt_paciente->bindParam(':id_usuario', $id_usuario, PDO::PARAM_INT);
$stmt_paciente->execute();
$result_paciente = $stmt_paciente->fetch(PDO::FETCH_ASSOC);

if (!$result_paciente) {
    echo "No se encontró el paciente.";
    exit;
}

$id_paciente = $result_paciente['id_paciente'];

// Obtener id_paciente_relacion desde la tabla paciente_relacion
$query_paciente_relacion = "
    SELECT id_paciente_relacion 
    FROM paciente_relacion 
    WHERE id_paciente = :id_paciente";

$stmt_paciente_relacion = $conn->prepare($query_paciente_relacion);
$stmt_paciente_relacion->bindParam(':id_paciente', $id_paciente, PDO::PARAM_INT);
$stmt_paciente_relacion->execute();
$result_paciente_relacion = $stmt_paciente_relacion->fetch(PDO::FETCH_ASSOC);

if (!$result_paciente_relacion) {
    echo "No se encontró la relación de paciente.";
    exit;
}

$id_paciente_relacion = $result_paciente_relacion['id_paciente_relacion'];

$query = $conn->prepare("INSERT INTO historial
(motivo, inicio_curso, tiempo_proble, suceso_dia, dia_anterior, que_hizo, como_se_calmo, hablo_alguien_del_problema, factores_desenca_del_proble, ultimo_trata_fisi_psico, autodescrpi_perso, filosofia_vida)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
$query->execute([
    $motivo,
    $inicio_curso,
    $tiempo_proble,
    $suceso_dia,
    $dia_anterior,
    $que_hizo,
    $como_se_calmo,
    $hablo_alguien_del_problema,
    $factores_desenca_del_proble,
    $ultimo_trata_fisi_psico,
    $autodescrpi_perso,
    $filosofia_vida
]);
$id_historial = $conn->lastInsertId();

$query = $conn->prepare("INSERT INTO relacion_social_niñez (r_s_padres, r_s_hermanos, r_s_otros_familiares, r_s_conocidos, r_s_extraños_m_edad_d_edad, grado_integracion_a_ellos) VALUES (?, ?, ?, ?, ?, ?)");
$query->execute([
    $r_s_padres,
    $r_s_hermanos,
    $r_s_otros_familiares,
    $r_s_conocidos,
    $r_s_extraños_m_edad_d_edad,
    $grado_integracion_a_ellos
]);
$id_relacion_social_niñez = $conn->lastInsertId();

$query = $conn->prepare("INSERT INTO escolaridad (adaptacion_ingreso_escu, integracion_condiscipulos, comportamiento_salon_clase, compor_recreo, relacion_demas, aislamiento, descrip_aislamiento, experiencia_estudio_primarios, experiencia_estudio_segundario, experiencia_estudio_superior) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
$query->execute([
    $adaptacion_ingreso_escu,
    $integracion_condiscipulos,
    $comportamiento_salon_clase,
    $compor_recreo,
    $relacion_demas,
    $aislamiento,
    $descrip_aislamiento,
    $experiencia_estudio_primarios,
    $experiencia_estudio_segundario,
    $experiencia_estudio_superior
]);
$id_escolaridad = $conn->lastInsertId();

$query = $conn->prepare("INSERT INTO conducta (proble_afectivo_conducta_niñez, proble_afectivo_pubertad, particularidades_adole, proble_afectivo_adole, grado_armonia_madurez_bio_psico, desarrollo_voluntad, grado_autonomía_deliberación_acción, persistencia_esfuerzo, jerarvalores_estilovida_sexaceina, norma_nivel_familiar, prefe_smo, habitos_intereses, enfermedad_accidente) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
$query->execute([
    $proble_afectivo_conducta_niñez,
    $proble_afectivo_pubertad,
    $particularidades_adole,
    $proble_afectivo_adole,
    $grado_armonia_madurez_bio_psico,
    $desarrollo_voluntad,
    $grado_autonomía_deliberación_acción,
    $persistencia_esfuerzo,
    $jerarvalores_estilovida_sexaceina,
    $norma_nivel_familiar,
    $prefe_smo,
    $habitos_intereses,
    $enfermedad_accidente
]);
$id_conducta = $conn->lastInsertId();

$query = $conn->prepare("INSERT INTO traba_social (eleccion_profesion, vivienda, economía, r_jefe_super_compa_subal, crecimiento_psicosocial, ambiciones_laboral, cambio_profesion, cuadro_familiar, relaciones_interperso, religion, recreacion) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
$query->execute([
    $eleccion_profesion,
    $vivienda,
    $economía,
    $r_jefe_super_compa_subal,
    $crecimiento_psicosocial,
    $ambiciones_laboral,
    $cambio_profesion,
    $cuadro_familiar,
    $relaciones_interperso,
    $religion,
    $recreacion
]);
$id_traba_social = $conn->lastInsertId();

$query = $conn->prepare("INSERT INTO conductas_pareja (conducta_sexual, elegir_pareja, fiel_exigente, noviazgo, matrimonio, opinion_matrimonio, particularidades_dia_boda, vida_matrimonial, separacion, divorcio, proble_peri_criti_particu_climaterio_menopausia_edadcriti ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
$query->execute([
    $conducta_sexual,
    $elegir_pareja,
    $fiel_exigente,
    $noviazgo,
    $matrimonio,
    $opinion_matrimonio,
    $particularidades_dia_boda,
    $vida_matrimonial,
    $separacion,
    $divorcio,
    $proble_peri_criti_particu_climaterio_menopausia_edadcriti
]);
$id_conductas_pareja = $conn->lastInsertId();

$query = $conn->prepare("INSERT INTO antecedentes_familiares (abuelo_p, abuela_p, padre, tios_p, abuelo_m, abuela_m, madre, tios_m, hermanos, esposo_a, hijos, colaterales) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
$query->execute([
    $abuelo_p,
    $abuela_p,
    $padre,
    $tios_p,
    $abuelo_m,
    $abuela_m,
    $madre,
    $tios_m,
    $hermanos,
    $esposo_a,
    $hijos,
    $colaterales
]);
$id_antecedentes_familiares = $conn->lastInsertId();

$query = $conn->prepare("INSERT INTO diag_resul_trata_evo (signos_sintoma, patologia_sindrome, trastorno, nivel_afectacion, conclusion_diag, exa_conductual_facultades_psiquicas, eva_psico, programa_trata_propuesto, evolucion) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
$query->execute([
    $signos_sintoma,
    $patologia_sindrome,
    $trastorno,
    $nivel_afectacion,
    $conclusion_diag,
    $exa_conductual_facultades_psiquicas,
    $eva_psico,
    $programa_trata_propuesto,
    $evolucion
]);
$id_diag_resul_trata_evo = $conn->lastInsertId();

$query = $conn->prepare("INSERT INTO historia_perso_social (edad_madre_nacer, parto, tipo_atencion_parto, descrip_tipo_atencion, termino, postnatalidad, estatura_al_nacer, peso, perimetro_cefalico, taraxico, lloro, reflejos, lenguaje, juego, edad_camino, encopresis, edad_control_enco, enuresis, edad_control_enu, motroci_fina, motrici_gruesa, movimi_pinza, alimentacion_infancia, crianza, juego_infantil, caracter_y_comportamiento_primero_años) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
$query->execute([
    $edad_madre_nacer,
    $parto,
    $tipo_atencion_parto,
    $descrip_tipo_atencion,
    $termino,
    $postnatalidad,
    $estatura_al_nacer,
    $peso,
    $perimetro_cefalico,
    $taraxico,
    $lloro,
    $reflejos,
    $lenguaje,
    $juego,
    $edad_camino,
    $encopresis,
    $edad_control_enco,
    $enuresis,
    $edad_control_enu,
    $motroci_fina,
    $motrici_gruesa,
    $movimi_pinza,
    $alimentacion_infancia,
    $crianza,
    $juego_infantil,
    $caracter_y_comportamiento_primero_años
]);
$id_historia_perso_social = $conn->lastInsertId();

// Preparar y ejecutar la consulta
$query = $conn->prepare("
    INSERT INTO historial_medico (
        id_usuario, id_paciente_relacion, id_historial, id_historia_perso_social, 
        id_relacion_social_niñez, id_escolaridad, id_conducta, id_traba_social, 
        id_conductas_pareja, id_antecedentes_familiares, id_diag_resul_trata_evo, 
        entrevistador, instruccion, edo_civil, estudio_trabajo, lugar_resi, procedencia, 
        fecha_p_cita, edad, lugar_nacimient, ocupacion, religion, grado_ciclo, ti_resi, informante,
        id_administrativo
    ) VALUES (
        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
    )
");

$query->execute([
    $id_usuario,
    $id_paciente_relacion,
    $id_historial,
    $id_historia_perso_social,
    $id_relacion_social_niñez,
    $id_escolaridad,
    $id_conducta,
    $id_traba_social,
    $id_conductas_pareja,
    $id_antecedentes_familiares,
    $id_diag_resul_trata_evo,
    $entrevistador,
    $instruccion,
    $edo_civil,
    $estudio_trabajo,
    $lugar_resi,
    $procedencia,
    $fecha_p_cita,
    $edad,
    $lugar_nacimient,
    $ocupacion,
    $religion,
    $grado_ciclo,
    $ti_resi,
    $informante,
    $id_administrativo
]);

// Ahora, asegurándote de que el `id_administrativo` está en `entrevistador`
$query_update = $conn->prepare("UPDATE entrevistador SET id_administrativo = ? WHERE id = ?");
$query_update->execute([$id_administrativo, $entrevistador]);


// Verifica si se insertó correctamente
if ($query->rowCount()) {
    echo "Datos insertados correctamente.";
} else {
    echo "Error al insertar los datos.";
}
header("Location: ../app/vistas/listado_pacientes.php");
exit;
