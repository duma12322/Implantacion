<?php
// Conexión a la base de datos
require_once 'conexion.php';

// Recibir datos del formulario
$entrevistador=$_POST['entrevistador'] ?? null;
$fecha_nac=$_POST['fecha_nac'];
$instruccion=$_POST['instruccion'];
$edo_civil=$_POST['edo_civil'];
$estudio_trabajo=$_POST['estudios_trabajos']?? null;
$lugar_resi=$_POST['lugar_resi'];
$procedencia=$_POST['procedencia'];
$fecha_p_cita=$_POST['fecja_p_cita']??null;
$edad=$_POST['edad'];
$lugar_nacimient=$_POST['lugar_nacimient'];
$ocupacion=$_POST['ocupacion'];
$religion=$_POST['religion'];
$grado_ciclo=$_POST['grado_ciclo'];
$ti_resi=$_POST['ti_resi'];
$informante=$_POST['informante'];
$motivo = $_POST['motivo'];  // Usar null si no se envía
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
$estatura_al_nacer = $_POST['estatura_al_nacer'] ?? null;
$peso = $_POST['peso'] ?? null;
$perimetro_cefalico = $_POST['perimetro_cefalico'] ?? null;
$taraxico = $_POST['taraxico'] ?? null;
$llorro = $_POST['llorro'] ?? null;
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
$caracter_y_comportamiento = $_POST['caracter_y_comportamiento'] ?? null;
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
$grado_autonomia_deliberacion_accion = $_POST['grado_autonomía_deliberación_acción'] ?? null; // Asegúrate de que el nombre sea correcto
$persistencia_esfuerzo = $_POST['persistencia_esfuerzo'] ?? null;
$jerarvalores_estilovida_sexaceina = $_POST['jerarvalores_estilovida_sexaceina'] ?? null;
$norma_nivel_familiar = $_POST['norma_nivel_familiar'] ?? null;
$prefe_smo = $_POST['prefe_smo'] ?? null;
$habitos_intereses = $_POST['habitos_intereses'] ?? null;
$enfermedad_accidente = $_POST['enfermedad_accidente'] ?? null;
$eleccion_profesion = $_POST['eleccion_profesion'] ?? null;
$vivienda = $_POST['vivienda'] ?? null;
$economia = $_POST['economia'] ?? null;
$r_jefe_super_compa_subal = $_POST['r_jefe_super_compa_subal'] ?? null;
$crecimiento_psicosocial = $_POST['crecimiento_psicosocial'] ?? null;
$ambiciones_laboral = $_POST['ambiciones_laboral'] ?? null;
$cambio_profesion = $_POST['cambio_profesion'] ?? null;
$cuadro_familiar = $_POST['cuadro_familiar'] ?? null;
$relaciones_interperso = $_POST['relaciones_interperso'] ?? null;
$religion = $_POST['religion'] ?? null;
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

// Insertar datos en la tablas
$query = $conn->prepare("INSERT INTO historial_medico ( entrevistador,instruccion,edo_civil,estudio_trabajo,lugar_resi,procedencia,fecha_p_cita,edad,lugar_nacimient,ocupacion,religion,grado_ciclo,ti_resi,informante) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,?, ?)");

$query->execute([
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
    $informante
]);

$query = $conn->prepare("INSERT INTO historial (motivo, inicio_curso, tiempo_proble, suceso_dia, dia_anterior, que_hizo, como_se_calmo, hablo_alguien_del_problema, factores_desenca_del_proble, ultimo_trata_fisi_psico, autodescrpi_perso, filosofia_vida) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
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

$query = $conn->prepare("INSERT INTO historia_perso_social (edad_madre_nacer,parto,tipo_atencion_parto,descrip_tipo_atencion,termino,postnatalidad,`estatura al nacer`,`peso`,`perimetro cefalico`, `taraxico`, llorró, reflejos,lenguaje,juego,edad_camino,encopresis,edad_control_enco,enuresis,edad_control_enu,motroci_fina,motrici_gruesa,movimi_pinza, alimentacion_infancia,crianza,`juego infantil`,`caracter y comportamiento primeros años`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
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
    $llorro,
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
    $caracter_y_comportamiento]);

    
$query = $conn->prepare("INSERT INTO relacion_social_niñez ( r_s_padres, r_s_hermanos, r_s_otros_familiares, r_s_conocidos, r_s_extraños_m_edad_d_edad, grado_integracion_a_ellos) VALUES (?, ?, ?, ?, ?, ?)");
$query->execute([
    $r_s_padres,
    $r_s_hermanos,
    $r_s_otros_familiares,
    $r_s_conocidos,
    $r_s_extraños_m_edad_d_edad,
    $grado_integracion_a_ellos
]);

$query = $conn->prepare("INSERT INTO escolaridad (adaptacion_ingreso_escu,integracion_condiscipulos,comportamiento_salon_clase,comor_recreo,relacion_demas,aislamiento,descrip_aislamiento,experiencia_estudio_primarios,experiencia_estudio_segundario,experiencia_estudio_superior) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
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

$query = $conn->prepare("INSERT INTO conducta (problema_afectivo_conducta_niñez,problema_afectivo_pubertad,particularidades_adole,problema_afectivo_adole,grado_armonia_madurez_bio_psico,desarrollo_voluntad,grado_autonomia_deliberacion_accion,persistencia_esfuerzo,jerarvalores_estilovida_sexaceina,norma_nivel_familiar,prefe_smo,habitos_intereses,enfermedad_accidente) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

$query->execute([
    $proble_afectivo_conducta_niñez,
    $proble_afectivo_pubertad,
    $particularidades_adole,
    $proble_afectivo_adole,
    $grado_armonia_madurez_bio_psico,
    $desarrollo_voluntad,
    $grado_autonomia_deliberacion_accion,
    $persistencia_esfuerzo,
    $jerarvalores_estilovida_sexaceina,
    $norma_nivel_familiar,
    $prefe_smo,
    $habitos_intereses,
    $enfermedad_accidente
]);

$query = $conn->prepare("INSERT INTO traba_social (eleccion_profesion,vivienda,economia,r_jefe_super_compa_subal,crecimiento_psicosocial,ambiciones_laboral,cambio_profesion,cuadro_familiar,relaciones_interperso,religion,recreacion) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
$query->execute([
    $eleccion_profesion,
    $vivienda,
    $economia,
    $r_jefe_super_compa_subal,
    $crecimiento_psicosocial,
    $ambiciones_laboral,
    $cambio_profesion,
    $cuadro_familiar,
    $relaciones_interperso,
    $religion,
    $recreacion
]);

$query = $conn->prepare("INSERT INTO conducta_pareja (
    conducta_sexual,
    elegir_pareja,
    fiel_exigente,
    noviazgo,
    matrimonio,
    opinion_matrimonio,
    particularidades_dia_boda,
    vida_matrimonial,
    separacion,
    divorcio,
    problema_peri_criti_particu_climaterio_menopausia_edadcriti
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
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
$query = $conn->prepare("INSERT INTO antecedentes_familiares (
    abuelo_p,
    abuela_p,
    padre,
    tios_p,
    abuelo_m,
    abuela_m,
    madre,
    tios_m,
    hermanos,
    esposo_a,
    hijos,
    colaterales
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
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

$query = $conn->prepare("INSERT INTO diag_resul_trata_evo (
    signos_sintoma,
    patologia_sindrome,
    trastorno,
    nivel_afectacion,
    conclusion_diag,
    exa_conductual_facultades_psiquicas,
    eva_psico,
    programa_trata_propuesto,
    evolucion
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
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
?>