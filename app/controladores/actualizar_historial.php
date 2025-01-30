<?php
include_once('../../config/conexion.php');

session_start(); // Asegúrate de iniciar la sesión
if (!isset($_SESSION['usuario'])) {
    header("Location: login_psicologo_admin.php");
    exit;
}

// Obtener id_usuario desde la URL
$id_usuario_modificar = $_GET['id_usuario'] ?? $_SESSION['id_usuario_creacion'] ?? null;

// Verificar que id_usuario no sea nulo
if (empty($id_usuario_modificar)) {
    die("ID de usuario no válido.");
}

// Obtener los datos del formulario para la actualización
$datos_historial_medico = [
    'fecha_p_cita' => $_POST['fecha_p_cita'],
    'edad' => $_POST['edad'],
    'lugar_nacimient' => $_POST['lugar_nacimient'],
    'instruccion' => $_POST['instruccion'],
    'ocupacion' => $_POST['ocupacion'],
    'edo_civil' => $_POST['edo_civil'],
    'religion' => $_POST['religion'],
    'id_paciente_relacion' => isset($_POST['id_paciente_relacion']) ? $_POST['id_paciente_relacion'] : null,
    'estudio_trabajo' => $_POST['estudio_trabajo'],
    'procedencia' => $_POST['procedencia'],
    'lugar_resi' => $_POST['lugar_resi'],
    'grado_ciclo' => $_POST['grado_ciclo'],
    'ti_resi' => $_POST['ti_resi'],
    'informante' => $_POST['informante'],
    'entrevistador' => $_POST['entrevistador']
];

$datos_historial = [
    'motivo' => $_POST['motivo'],
    'inicio_curso' => $_POST['inicio_curso'],
    'tiempo_proble' => $_POST['tiempo_proble'],
    'suceso_dia' => $_POST['suceso_dia'],
    'dia_anterior' => $_POST['dia_anterior'],
    'que_hizo' => $_POST['que_hizo'],
    'como_se_calmo' => $_POST['como_se_calmo'],
    'hablo_alguien_del_problema' => $_POST['hablo_alguien_del_problema'],
    'factores_desenca_del_proble' => $_POST['factores_desenca_del_proble'],
    'ultimo_trata_fisi_psico' => $_POST['ultimo_trata_fisi_psico'],
    'autodescrpi_perso' => $_POST['autodescrpi_perso'],
    'filosofia_vida' => $_POST['filosofia_vida']
];

$datos_historia_perso_social = [
    'edad_madre_nacer' => $_POST['edad_madre_nacer'],
    'parto' => $_POST['parto'],
    'tipo_atencion_parto' => $_POST['tipo_atencion_parto'],
    'descrip_tipo_atencion' => $_POST['descrip_tipo_atencion'],
    'termino' => $_POST['termino'],
    'postnatalidad' => $_POST['postnatalidad'],
    'estatura_al_nacer' => $_POST['estatura_al_nacer'],
    'peso' => $_POST['peso'],
    'perimetro_cefalico' => $_POST['perimetro_cefalico'],
    'taraxico' => $_POST['taraxico'],
    'lloro' => $_POST['lloro'],
    'reflejos' => $_POST['reflejos'],
    'lenguaje' => $_POST['lenguaje'],
    'juego' => $_POST['juego'],
    'edad_camino' => $_POST['edad_camino'],
    'encopresis' => $_POST['encopresis'],
    'edad_control_enco' => $_POST['edad_control_enco'],
    'enuresis' => $_POST['enuresis'],
    'edad_control_enu' => $_POST['edad_control_enu'],
    'motroci_fina' => isset($_POST['motroci_fina']) ? $_POST['motroci_fina'] : null,
    'motrici_gruesa' => $_POST['motrici_gruesa'],
    'movimi_pinza' => $_POST['movimi_pinza'],
    'alimentacion_infancia' => $_POST['alimentacion_infancia'],
    'crianza' => $_POST['crianza'],
    'juego_infantil' => $_POST['juego_infantil'],
    'caracter_y_comportamiento_primero_años' => isset($_POST['caracter_y_comportamiento_primero_años']) ? $_POST['caracter_y_comportamiento_primero_años'] : null,
];

$datos_relacion_social_niñez = [
    'r_s_padres' => $_POST['r_s_padres'],
    'r_s_hermanos' => $_POST['r_s_hermanos'],
    'r_s_otros_familiares' => $_POST['r_s_otros_familiares'],
    'r_s_conocidos' => $_POST['r_s_conocidos'],
    'r_s_extraños_m_edad_d_edad' => $_POST['r_s_extraños_m_edad_d_edad'],
    'grado_integracion_a_ellos' => $_POST['grado_integracion_a_ellos']
];

$datos_escolaridad = [
    'adaptacion_ingreso_escu' => $_POST['adaptacion_ingreso_escu'],
    'integracion_condiscipulos' => $_POST['integracion_condiscipulos'],
    'comportamiento_salon_clase' => $_POST['comportamiento_salon_clase'],
    'compor_recreo' => $_POST['compor_recreo'],
    'relacion_demas' => $_POST['relacion_demas'],
    'aislamiento' => $_POST['aislamiento'],
    'descrip_aislamiento' => isset($_POST['descrip_aislamiento']) ? $_POST['descrip_aislamiento'] : null,
    'experiencia_estudio_primarios' => $_POST['experiencia_estudio_primarios'],
    'experiencia_estudio_segundario' => $_POST['experiencia_estudio_segundario'],
    'experiencia_estudio_superior' => $_POST['experiencia_estudio_superior']
];

$datos_conducta = [
    'proble_afectivo_conducta_niñez' => $_POST['proble_afectivo_conducta_niñez'],
    'proble_afectivo_pubertad' => $_POST['proble_afectivo_pubertad'],
    'particularidades_adole' => $_POST['particularidades_adole'],
    'proble_afectivo_adole' => $_POST['proble_afectivo_adole'],
    'grado_armonia_madurez_bio_psico' => $_POST['grado_armonia_madurez_bio_psico'],
    'desarrollo_voluntad' => $_POST['desarrollo_voluntad'],
    'grado_autonomía_deliberación_acción' => isset($_POST['grado_autonomía_deliberación_acción']) ? $_POST['grado_autonomía_deliberación_acción'] : null,
    'persistencia_esfuerzo' => $_POST['persistencia_esfuerzo'],
    'jerarvalores_estilovida_sexaceina' => $_POST['jerarvalores_estilovida_sexaceina'],
    'norma_nivel_familiar' => $_POST['norma_nivel_familiar'],
    'prefe_smo' => $_POST['prefe_smo'],
    'habitos_intereses' => $_POST['habitos_intereses'],
    'enfermedad_accidente' => $_POST['enfermedad_accidente']
];

$datos_traba_social = [
    'eleccion_profesion' => $_POST['eleccion_profesion'],
    'vivienda' => $_POST['vivienda'],
    'economía' => isset($_POST['economía']) ? $_POST['economía'] : null,
    'r_jefe_super_compa_subal' => $_POST['r_jefe_super_compa_subal'],
    'crecimiento_psicosocial' => $_POST['crecimiento_psicosocial'],
    'ambiciones_laboral' => $_POST['ambiciones_laboral'],
    'cambio_profesion' => $_POST['cambio_profesion'],
    'cuadro_familiar' => $_POST['cuadro_familiar'],
    'relaciones_interperso' => $_POST['relaciones_interperso'],
    'religion' => $_POST['religion'],
    'recreacion' => $_POST['recreacion']
];

$datos_antecedentes_familiares = [
    'abuelo_p' => $_POST['abuelo_p'],
    'abuela_p' => $_POST['abuela_p'],
    'padre' => $_POST['padre'],
    'tios_p' => $_POST['tios_p'],
    'abuelo_m' => $_POST['abuelo_m'],
    'abuela_m' => $_POST['abuela_m'],
    'madre' => $_POST['madre'],
    'tios_m' => $_POST['tios_m']
];

// Unir todos los arrays de datos en uno solo
$datos_completos = array_merge(
    $datos_historial_medico,
    $datos_historial,
    $datos_historia_perso_social,
    $datos_relacion_social_niñez,
    $datos_escolaridad,
    $datos_conducta,
    $datos_traba_social,
    $datos_antecedentes_familiares
);

try {
    // Ejecutar los UPDATE para cada conjunto de datos
    $query_historial_medico = "UPDATE historial_medico SET 
        fecha_p_cita = ?, edad = ?, lugar_nacimient = ?, instruccion = ?, ocupacion = ?, edo_civil = ?, 
        religion = ?, id_paciente_relacion = ?, estudio_trabajo = ?, procedencia = ?, lugar_resi = ?, 
        grado_ciclo = ?, ti_resi = ?, informante = ?, entrevistador = ? WHERE id_usuario = ?";
    $stmt = $conn->prepare($query_historial_medico);
    $stmt->execute(array_merge(array_values($datos_historial_medico), [$id_usuario_modificar]));

    $query_historial = "UPDATE historial SET 
        motivo = ?, inicio_curso = ?, tiempo_proble = ?, suceso_dia = ?, dia_anterior = ?, que_hizo = ?, 
        como_se_calmo = ?, hablo_alguien_del_problema = ?, factores_desenca_del_proble = ?, 
        ultimo_trata_fisi_psico = ?, autodescrpi_perso = ?, filosofia_vida = ? WHERE id_usuario = ?";
    $stmt = $conn->prepare($query_historial);
    $stmt->execute(array_merge(array_values($datos_historial), [$id_usuario_modificar]));

    $query_historia_perso_social = "UPDATE historia_perso_social SET 
        edad_madre_nacer = ?, parto = ?, tipo_atencion_parto = ?, descrip_tipo_atencion = ?, termino = ?, 
        postnatalidad = ?, estatura_al_nacer = ?, peso = ?, perimetro_cefalico = ?, taraxico = ?, 
        lloro = ?, reflejos = ?, lenguaje = ?, juego = ?, edad_camino = ?, encopresis = ?, 
        edad_control_enco = ?, enuresis = ?, edad_control_enu = ?, motroci_fina = ?, 
        motrici_gruesa = ?, movimi_pinza = ?, alimentacion_infancia = ?, crianza = ?, juego_infantil = ?, 
        caracter_y_comportamiento_primero_años = ? WHERE id_usuario = ?";
    $stmt = $conn->prepare($query_historia_perso_social);
    $stmt->execute(array_merge(array_values($datos_historia_perso_social), [$id_usuario_modificar]));

    $query_relacion_social_niñez = "UPDATE relacion_social_niñez SET 
        r_s_padres = ?, r_s_hermanos = ?, r_s_otros_familiares = ?, r_s_conocidos = ?, 
        r_s_extraños_m_edad_d_edad = ?, grado_integracion_a_ellos = ? WHERE id_usuario = ?";
    $stmt = $conn->prepare($query_relacion_social_niñez);
    $stmt->execute(array_merge(array_values($datos_relacion_social_niñez), [$id_usuario_modificar]));

    $query_escolaridad = "UPDATE escolaridad SET 
        adaptacion_ingreso_escu = ?, integracion_condiscipulos = ?, comportamiento_salon_clase = ?, 
        compor_recreo = ?, relacion_demas = ?, aislamiento = ?, descrip_aislamiento = ?, 
        experiencia_estudio_primarios = ?, experiencia_estudio_segundario = ?, experiencia_estudio_superior = ? WHERE id_usuario = ?";
    $stmt = $conn->prepare($query_escolaridad);
    $stmt->execute(array_merge(array_values($datos_escolaridad), [$id_usuario_modificar]));

    $query_conducta = "UPDATE conducta SET 
        proble_afectivo_conducta_niñez = ?, proble_afectivo_pubertad = ?, particularidades_adole = ?, 
        proble_afectivo_adole = ?, grado_armonia_madurez_bio_psico = ?, desarrollo_voluntad = ?, 
        grado_autonomía_deliberación_acción = ?, persistencia_esfuerzo = ?, jerarvalores_estilovida_sexaceina = ?, 
        norma_nivel_familiar = ?, prefe_smo = ?, habitos_intereses = ?, enfermedad_accidente = ? WHERE id_usuario = ?";
    $stmt = $conn->prepare($query_conducta);
    $stmt->execute(array_merge(array_values($datos_conducta), [$id_usuario_modificar]));

    $query_traba_social = "UPDATE traba_social SET 
        eleccion_profesion = ?, vivienda = ?, economía = ?, r_jefe_super_compa_subal = ?, 
        crecimiento_psicosocial = ?, ambiciones_laboral = ?, cambio_profesion = ?, cuadro_familiar = ?, 
        relaciones_interperso = ?, religion = ?, recreacion = ? WHERE id_usuario = ?";
    $stmt = $conn->prepare($query_traba_social);
    $stmt->execute(array_merge(array_values($datos_traba_social), [$id_usuario_modificar]));

    $query_antecedentes_familiares = "UPDATE antecedentes_familiares SET 
        abuelo_p = ?, abuela_p = ?, padre = ?, tios_p = ?, abuelo_m = ?, abuela_m = ?, madre = ?, 
        tios_m = ? WHERE id_usuario = ?";
    $stmt = $conn->prepare($query_antecedentes_familiares);
    $stmt->execute(array_merge(array_values($datos_antecedentes_familiares), [$id_usuario_modificar]));

    echo "
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.17/dist/sweetalert2.all.min.js'></script>
<script>
  window.onload = function() {
    Swal.fire({
      icon: 'success',
      title: 'Datos actualizados correctammente',
      showConfirmButton: true,
      confirmButtonText: 'OK',
      timer: 3000,
      willClose: () => { window.location.href = '../vistas/listado_pacientes.php'; }
    });
  }
</script>";
} catch (PDOException $e) {
    echo "
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.17/dist/sweetalert2.all.min.js'></script>
<script>
  window.onload = function() {
    Swal.fire({
      icon: 'error',
      title: 'No se pudo enviar el mensaje',
      text: 'Error al actualizar datos: {$e->getMessage()}',
      showConfirmButton: true,
      confirmButtonText: 'OK',
      timer: 5000,
      willClose: () => { window.location.href = '../vistas/Modificar_historial_medico.php'; }
    });
  }
</script>";
}
