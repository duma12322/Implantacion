<?php
session_start();
// Conexión a la base de datos
require_once '../../config/conexion.php';
include '../controladores/log.php';

// Verifica si la sesión está activa 
if (!isset($_SESSION['usuario'])) {
    header("Location: login_paciente.php");
    exit;
}


// Verifica si se hizo clic en el botón de cerrar sesión 
if (isset($_POST['cerrar_sesion'])) {
    session_unset();
    session_destroy();
    header("Location: login_paciente.php");
    exit;
}

// Verificar si el ID de usuario a modificar está presente en la URL
if (!isset($_GET['id_usuario']) || empty($_GET['id_usuario'])) {
    echo "ID de usuario no válido.";
    exit;
}

$id_usuario_modificar = htmlspecialchars($_GET['id_usuario']);

// Guarda el id_usuario en la sesión
$_SESSION['id_usuario_modificar'] = $id_usuario_modificar;

//echo "ID del usuario a modificar: " . $id_usuario_modificar . "<br>";

// Obtener los datos del usuario a modificar
$query_result = "
    SELECT 
        u.*, 
        p.*, 
        pr.*
    FROM 
        usuario u
    JOIN 
        paciente p ON u.id_usuario = p.id_usuario
    LEFT JOIN 
        paciente_relacion pr ON p.id_paciente = pr.id_paciente
    WHERE 
        u.id_usuario = :id_usuario";

$stmt_result = $conn->prepare($query_result);
$stmt_result->bindParam(':id_usuario', $id_usuario_modificar, PDO::PARAM_INT);
$stmt_result->execute();
$result = $stmt_result->fetch(PDO::FETCH_ASSOC);

if (!$result) {
    echo "Usuario no encontrado.";
    exit;
}

//echo "Datos básicos del usuario obtenidos.<br>";

// Obtener los datos combinados de historial médico, historial, historia_perso_social, relacion_social_niñez, escolaridad, conducta, traba_social y antecedentes_familiares
$query_combined_test = "
    SELECT 
        h.ID_HistorialM, h.id_administrativo, h.fecha_p_cita, h.edad, h.id_usuario, h.lugar_nacimient, h.instruccion, h.ocupacion, 
        h.edo_civil, h.religion, h.id_paciente_relacion, h.id_historial, h.id_historia_perso_social, h.id_relacion_social_niñez, 
        h.id_escolaridad, h.id_conducta, h.id_traba_social, h.id_conductas_pareja, h.id_antecedentes_familiares, h.id_diag_resul_trata_evo,
        h.estudio_trabajo, h.procedencia, h.lugar_resi, h.grado_ciclo, h.ti_resi, h.informante, h.entrevistador,
        u.id_usuario, u.usuario, u.nombre1 AS usuario_nombre, u.apellido1 AS usuario_apellido, u.correo AS usuario_correo,
        hi.motivo, hi.inicio_curso, hi.tiempo_proble, hi.suceso_dia, hi.dia_anterior, hi.que_hizo, hi.como_se_calmo, 
        hi.hablo_alguien_del_problema, hi.factores_desenca_del_proble, hi.ultimo_trata_fisi_psico, hi.autodescrpi_perso, hi.filosofia_vida,
        hp.edad_madre_nacer, hp.parto, hp.tipo_atencion_parto, hp.descrip_tipo_atencion, hp.termino, hp.postnatalidad, 
        hp.estatura_al_nacer, hp.peso, hp.perimetro_cefalico, hp.taraxico, hp.lloro, hp.reflejos, hp.lenguaje, hp.juego, 
        hp.edad_camino, hp.encopresis, hp.edad_control_enco, hp.enuresis, hp.edad_control_enu, hp.motroci_fina, hp.motrici_gruesa, 
        hp.movimi_pinza, hp.alimentacion_infancia, hp.crianza, hp.juego_infantil, hp.caracter_y_comportamiento_primero_años,
        rsn.r_s_padres, rsn.r_s_hermanos, rsn.r_s_otros_familiares, rsn.r_s_conocidos, rsn.r_s_extraños_m_edad_d_edad, rsn.grado_integracion_a_ellos,
        es.adaptacion_ingreso_escu, es.integracion_condiscipulos, es.comportamiento_salon_clase, es.compor_recreo, 
        es.relacion_demas, es.aislamiento, es.descrip_aislamiento, es.experiencia_estudio_primarios, es.experiencia_estudio_segundario, 
        es.experiencia_estudio_superior,
        c.proble_afectivo_conducta_niñez, c.proble_afectivo_pubertad, c.particularidades_adole, c.proble_afectivo_adole, 
        c.grado_armonia_madurez_bio_psico, c.desarrollo_voluntad, c.grado_autonomía_deliberación_acción, c.persistencia_esfuerzo, 
        c.jerarvalores_estilovida_sexaceina, c.norma_nivel_familiar, c.prefe_smo, c.habitos_intereses, c.enfermedad_accidente,
        ts.eleccion_profesion, ts.vivienda, ts.economía, ts.r_jefe_super_compa_subal, ts.crecimiento_psicosocial, ts.ambiciones_laboral, 
        ts.cambio_profesion, ts.cuadro_familiar, ts.relaciones_interperso, ts.religion, ts.recreacion,
        af.abuelo_p, af.abuela_p, af.padre, af.tios_p, af.abuelo_m, af.abuela_m, af.madre, af.tios_m, af.hermanos, af.esposo_a, af.hijos, af.colaterales,
        cp.conducta_sexual, cp.elegir_pareja, cp.fiel_exigente, cp.noviazgo, cp.matrimonio, cp.opinion_matrimonio,
        cp.particularidades_dia_boda, cp.vida_matrimonial, cp.separacion, cp.divorcio,
        cp.proble_peri_criti_particu_climaterio_menopausia_edadcriti,
        dt.signos_sintoma, dt.patologia_sindrome, dt.trastorno, dt.nivel_afectacion, dt.conclusion_diag, 
        dt.exa_conductual_facultades_psiquicas, dt.eva_psico, dt.programa_trata_propuesto, dt.evolucion
    FROM 
        historial_medico h 
    LEFT JOIN 
        usuario u ON h.id_usuario = u.id_usuario
    LEFT JOIN 
        paciente p ON u.id_usuario = p.id_usuario
    LEFT JOIN 
        historial hi ON h.id_historial = hi.id_historial
    LEFT JOIN 
        historia_perso_social hp ON h.id_historia_perso_social = hp.id_historia_perso_social
    LEFT JOIN 
        relacion_social_niñez rsn ON h.id_relacion_social_niñez = rsn.id_relacion_social_niñez
    LEFT JOIN 
        escolaridad es ON h.id_escolaridad = es.id_escolaridad
    LEFT JOIN 
        conducta c ON h.id_conducta = c.id_conducta
    LEFT JOIN 
        traba_social ts ON h.id_traba_social = ts.id_traba_social
    LEFT JOIN 
        antecedentes_familiares af ON h.id_antecedentes_familiares = af.id_antecedentes_familiares
    LEFT JOIN 
        conductas_pareja cp ON h.id_conductas_pareja = cp.id_conductas_pareja
    LEFT JOIN 
        diag_resul_trata_evo dt ON h.id_diag_resul_trata_evo = dt.id_diag_resul_trata_evo
    WHERE 
        h.id_usuario = :id_usuario";

$stmt_combined_test = $conn->prepare($query_combined_test);
$stmt_combined_test->bindParam(':id_usuario', $id_usuario_modificar, PDO::PARAM_INT);
$stmt_combined_test->execute();
$result_test = $stmt_combined_test->fetch(PDO::FETCH_ASSOC);

registrar_log($_SESSION['usuario'], "Modificó al usuario con el nombre: {$result['nombre1']} {$result['apellido1']}");

if (!$result_test) {
    echo "
    <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.0.17/dist/sweetalert2.all.min.js'></script>
    <script>
      window.onload = function() {
        Swal.fire({
          icon: 'warning',
          title: 'No se ha creado el historial medico de este paciente',
          showConfirmButton: true,
          confirmButtonText: 'OK',
          timer: 3000,
          willClose: () => { window.location.href = '../vistas/listado_pacientes.php'; }
        });
      }
    </script>";
    exit;
}
?>


<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Modificar historial medico</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/perfil_usuario.css">
    <link rel="stylesheet" href="css/modificar.css">
</head>

<body>
    <div class="container">
        <form action="../controladores/actualizar_historial.php" method="POST">
            <div class="card mb-4">
                <div class="card-header">Historial Clínico</div>
                <div class="card-body">
                    <?php if (isset($error)): ?>
                        <div class="alert alert-danger"><?= $error ?></div>
                    <?php endif; ?>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="entrevistador" class="form-label">Entrevistador</label>
                                <input type="text" class="form-control" id="entrevistador" name="entrevistador" value="<?= htmlspecialchars($result_test['entrevistador'] ?? '') ?>" required>
                            </div>
                            <h4>I. DATOS DE FILIACIÓN</h4>
                            <div class="mb-3">
                                <label for="nombre1" class="form-label">Nombres Completos</label>
                                <input type="text" class="form-control" id="nombre1" name="nombre1" value="<?= htmlspecialchars($result['apellido1'] . ' ' . $result['apellido2'] . ' ' . $result['nombre1'] . ' ' . $result['nombre2']) ?>" required>
                            </div>
                            <div class="mb-3">
                                <label for="fecha_nac" class="form-label">Fecha de Nacimiento</label>
                                <input type="date" class="form-control" id="fecha_nac" name="fecha_nac" value="<?= htmlspecialchars($result['fecha_nac']) ?>" required>
                            </div>
                            <div class="mb-3">
                                <label for="instruccion" class="form-label">Instrucción</label>
                                <input type="text" class="form-control" id="instruccion" name="instruccion" value="<?= htmlspecialchars($result_test['instruccion'] ?? '') ?>">
                            </div>
                            <div class="mb-3">
                                <label for="edo_civil" class="form-label">Estado Civil</label>
                                <input type="text" class="form-control" id="edo_civil" name="edo_civil" value="<?= htmlspecialchars($result_test['edo_civil'] ?? '') ?>">
                            </div>
                            <div class="mb-3">
                                <label for="relacion_nombre1" class="form-label">Nombre del Cónyuge</label>
                                <input type="text" class="form-control" id="relacion_nombre1" name="relacion_nombre1" value="<?= htmlspecialchars($result['relacion_nombre1']) ?>">
                            </div>
                            <div class="mb-3">
                                <label for="num_hijos" class="form-label">Número de Hijos</label>
                                <input type="text" class="form-control" id="num_hijos" name="num_hijos" value="<?= htmlspecialchars($result['num_hijos']) ?>">
                            </div>
                            <div class="mb-3">
                                <label for="estudio_trabajo" class="form-label">Centro de Estudios y/o Trabajo</label>
                                <input type="text" class="form-control" id="estudio_trabajo" name="estudio_trabajo" value="<?= htmlspecialchars($result_test['estudio_trabajo'] ?? '') ?>">
                            </div>
                            <div class="mb-3">
                                <label for="lugar_resi" class="form-label">Lugar de Residencia</label>
                                <input type="text" class="form-control" id="lugar_resi" name="lugar_resi" value="<?= htmlspecialchars($result_test['lugar_resi'] ?? '') ?>">
                            </div>
                            <div class="mb-3">
                                <label for="procedencia" class="form-label">Procedencia</label>
                                <input type="text" class="form-control" id="procedencia" name="procedencia" value="<?= htmlspecialchars($result_test['procedencia'] ?? '') ?>">
                            </div>
                            <div class="mb-3">
                                <label for="correo" class="form-label">Email</label>
                                <input type="email" class="form-control" id="correo" name="correo" value="<?= $result['correo'] ?>">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="fecha_p_cita" class="form-label">Fecha Primera Cita</label>
                                <input type="date" class="form-control" id="fecha_p_cita" name="fecha_p_cita" value="<?= htmlspecialchars($result_test['fecha_p_cita'] ?? '') ?>">
                            </div>
                            <div class="mb-3">
                                <label for="edad" class="form-label">Edad</label>
                                <input type="number" class="form-control" id="edad" name="edad" value="<?= htmlspecialchars($result_test['edad'] ?? '') ?>">
                            </div>
                            <div class="mb-3">
                                <label for="lugar_nacimient" class="form-label">Lugar de Nacimiento</label>
                                <input type="text" class="form-control" id="lugar_nacimient" name="lugar_nacimient" value="<?= htmlspecialchars($result_test['lugar_nacimient'] ?? '') ?>">
                            </div>
                            <div class="mb-3">
                                <label for="ocupacion" class="form-label">Ocupacion</label>
                                <input type="text" class="form-control" id="ocupacion" name="ocupacion" value="<?= htmlspecialchars($result_test['ocupacion'] ?? '') ?>">
                            </div>
                            <div class="mb-3">
                                <label for="religion" class="form-label">Religion</label>
                                <input type="text" class="form-control" id="religion" name="religion" value="<?= htmlspecialchars($result_test['religion'] ?? '') ?>">
                            </div>
                            <div class="mb-3">
                                <label for="edades_hijos" class="form-label">Edades de los Hijos</label>
                                <input type=" text" class="form-control" id="edades_hijos" name="edades_hijos" value="<?= $result['edades_hijos'] ?>">
                            </div>
                            <div class="mb-3">
                                <label for="grado_ciclo" class="form-label">Grado/Ciclo</label>
                                <input type="text" class="form-control" id="grado_ciclo" name="grado_ciclo" value="<?= htmlspecialchars($result_test['grado_ciclo'] ?? '') ?>">
                            </div>
                            <div class="mb-3">
                                <label for="ti_resi" class="form-label">Tiempo de Residencia</label>
                                <input type="text" class="form-control" id="ti_resi" name="ti_resi" value="<?= htmlspecialchars($result_test['ti_resi'] ?? '') ?>">
                            </div>
                            <div class="mb-3">
                                <label for="telefono" class="form-label">Teléfonos</label>
                                <input type="text" class="form-control" id="telefono" name="telefono" value="<?= $result['telefono'] ?>">
                            </div>
                            <div class="mb-3">
                                <label for="informante" class="form-label">Informante</label>
                                <input type="text" class="form-control" id="informante" name="informante" value="<?= htmlspecialchars($result_test['informante'] ?? '') ?>">
                            </div>
                        </div>
                    </div>
                    <h4>II.PROBLEMA ACTUAL</h4>
                    <div class="mb-3">
                        <label for="motivo" class="form-label">1. Motivo De consulta - Problema actual:</label>
                        <textarea type="text" class="form-control" id="motivo" name="motivo" required><?= htmlspecialchars($result_test['motivo'] ?? '') ?></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="inicio_curso" class="form-label">2. Inicio y Curso (síntomas):</label>
                        <textarea class="form-control" id="inicio_curso" name="inicio_curso" required><?= htmlspecialchars($result_test['inicio_curso'] ?? '') ?></textarea>
                    </div>
                    <h5>3. Episodios previos (inicio y curso – síntomas):</h5>
                    <div class="mb-3">
                        <label for="tiempo_proble" class="form-label">Tiempo del Problema:</label>
                        <textarea class="form-control" id="tiempo_proble" name="tiempo_proble" required><?= htmlspecialchars($result_test['tiempo_proble'] ?? '') ?></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="suceso_dia" class="form-label">Que le sucedió ese día:</label>
                        <textarea class="form-control" id="suceso_dia" name="suceso_dia" required><?= htmlspecialchars($result_test['suceso_dia'] ?? '') ?></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="dia_anterior" class="form-label">El día anterior:</label>
                        <textarea class="form-control" id="dia_anterior" name="dia_anterior" required><?= htmlspecialchars($result_test['dia_anterior'] ?? '') ?></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="que_hizo" class="form-label">¿Qué Hizo?</label>
                        <textarea class="form-control" id="que_hizo" name="que_hizo" required><?= htmlspecialchars($result_test['que_hizo'] ?? '') ?></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="como_se_calmo" class="form-label">¿Cómo se Calmó?</label>
                        <textarea class="form-control" id="como_se_calmo" name="como_se_calmo" required><?= htmlspecialchars($result_test['como_se_calmo'] ?? '') ?></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="hablo_alguien_del_problema" class="form-label">¿Habló Alguien del Problema?</label>
                        <textarea class="form-control" id="hablo_alguien_del_problema" name="hablo_alguien_del_problema" required><?= htmlspecialchars($result_test['hablo_alguien_del_problema'] ?? '') ?></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="factores_desenca_del_proble" class="form-label">4. Factores desencadenantes del problema Actual (agravantes y repercusión en su vida social, riesgos para sí o los demás):</label>
                        <textarea class="form-control" id="factores_desenca_del_proble" name="factores_desenca_del_proble" required><?= htmlspecialchars($result_test['factores_desenca_del_proble'] ?? '') ?></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="ultimo_trata_fisi_psico" class="form-label">5. Últimos Tratamientos Recibidos (físicos y psicológicos):</label>
                        <textarea class="form-control" id="ultimo_trata_fisi_psico" name="ultimo_trata_fisi_psico" required><?= htmlspecialchars($result_test['ultimo_trata_fisi_psico'] ?? '') ?></textarea>
                    </div>
                    <h5>6. Auto descripción de la Personalidad:</h5>
                    <div class="mb-3">
                        <label for="autodescrpi_perso" class="form-label">¿Cómo podría describir su personalidad?</label>
                        <textarea class="form-control" id="autodescrpi_perso" name="autodescrpi_perso" required><?= htmlspecialchars($result_test['autodescrpi_perso'] ?? '') ?></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="filosofia_vida" class="form-label">¿Cuál es su filosofía de vida?</label>
                        <textarea class="form-control" id="filosofia_vida" name="filosofia_vida" required><?= htmlspecialchars($result_test['filosofia_vida'] ?? '') ?></textarea>
                    </div>

                    <h4>III. HISTORIA PERSONAL Y SOCIAL</h4>
                    <h5>1. Gestación (pre – natalidad):</h5>
                    <div class="mb-3">
                        <label for="edad_madre_nacer" class="form-label">Edad de la Madre al Nacer</label>
                        <input type="number" class="form-control" id="edad_madre_nacer" name="edad_madre_nacer" value="<?= htmlspecialchars($result_test['edad_madre_nacer'] ?? '') ?>">
                    </div>
                    <div class="mb-3">
                        <label for="parto" class="form-label">2. Parto:</label>
                        <textarea class="form-control" id="parto" name="parto" required><?= htmlspecialchars($result_test['parto'] ?? '') ?></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="tipo_atencion_parto" class="form-label">Tipo de atención:</label>
                        <select id="tipo_atencion_parto" name="tipo_atencion_parto" required>
                            <option value="eutocico" <?= ($result_test['tipo_atencion_parto'] == 'eutocico') ? 'selected' : '' ?>>Eutócico</option>
                            <option value="distocico" <?= ($result_test['tipo_atencion_parto'] == 'distocico') ? 'selected' : '' ?>>Distócico</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="descrip_tipo_atencion" class="form-label">¿Por qué?:</label>
                        <textarea class="form-control" id="descrip_tipo_atencion" name="descrip_tipo_atencion" required><?= htmlspecialchars($result_test['descrip_tipo_atencion'] ?? '') ?></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="termino" class="form-label">¿Fue a término? </label>
                        <select id="termino" name="termino" required>
                            <option value="Si" <?= ($result_test['termino'] == 'Si') ? 'selected' : '' ?>>Sí</option>
                            <option value="No" <?= ($result_test['termino'] == 'No') ? 'selected' : '' ?>>No</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="postnatalidad" class="form-label">Postnatalidad</label>
                        <textarea class="form-control" id="postnatalidad" name="postnatalidad" required><?= htmlspecialchars($result_test['postnatalidad']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="estatura_al_nacer" class="form-label">Estatura al Nacer</label>
                        <input type="number" class="form-control" id="estatura_al_nacer" name="estatura_al_nacer" value="<?= htmlspecialchars($result_test['estatura_al_nacer']) ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="peso" class="form-label">Peso</label>
                        <input type="number" class="form-control" id="peso" name="peso" value="<?= $result_test['peso'] ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="perimetro_cefalico" class="form-label">Perímetro Cefálico</label>
                        <input type="number" class="form-control" id="perimetro_cefalico" name="perimetro_cefalico" value="<?= $result_test['perimetro_cefalico'] ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="taraxico" class="form-label">Taraxico</label>
                        <input type="number" class="form-control" id="taraxico" name="taraxico" value="<?= $result_test['taraxico'] ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="lloro" class="form-label">¿Lloró?</label>
                        <select class="form-control" id="lloro" name="lloro" required>
                            <option value="si" <?= ($result_test['lloro'] == 'si') ? 'selected' : '' ?>>Sí</option>
                            <option value="no" <?= ($result_test['lloro'] == 'no') ? 'selected' : '' ?>>No</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="reflejos" class="form-label">Reflejos</label>
                        <textarea class="form-control" id="reflejos" name="reflejos" required><?= htmlspecialchars($result_test['reflejos']) ?></textarea>
                    </div>
                    <h5>3. Desarrollo Psicomotor: </h5>
                    <div class="mb-3">
                        <label for="lenguaje" class="form-label">Lenguaje</label>
                        <textarea class="form-control" id="lenguaje" name="lenguaje" required><?= htmlspecialchars($result_test['lenguaje']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="juego" class="form-label">Juego</label>
                        <textarea class="form-control" id="juego" name="juego" required><?= htmlspecialchars($result_test['juego']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="edad_camino" class="form-label">A QUE EDAD Caminó:</label>
                        <input type="number" class="form-control" id="edad_camino" name="edad_camino" value="<?= $result_test['edad_camino'] ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="encopresis" class="form-label">¿Encopresis?</label>
                        <select class="form-control" id="encopresis" name="encopresis" required>
                            <option value="0" <?= ($result_test['encopresis'] == 0) ? 'selected' : '' ?>>No</option>
                            <option value="1" <?= ($result_test['encopresis'] == 1) ? 'selected' : '' ?>>Sí</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="edad_control_enco" class="form-label">Edad de Control de Encopresis</label>
                        <input type="number" class="form-control" id="edad_control_enco" name="edad_control_enco" value="<?= $result_test['edad_control_enco'] ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="enuresis" class="form-label">¿Enuresis?</label>
                        <select class="form-control" id="enuresis" name="enuresis" required>
                            <option value="0" <?= ($result_test['enuresis'] == 0) ? 'selected' : '' ?>>No</option>
                            <option value="1" <?= ($result_test['enuresis'] == 1) ? 'selected' : '' ?>>Sí</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="edad_control_enu" class="form-label">Edad de Control de Enuresis</label>
                        <input type="number" class="form-control" id="edad_control_enu" name="edad_control_enu" value="<?= $result_test['edad_control_enu'] ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="motrici_fina" class="form-label">Motricidad Fina</label>
                        <textarea class="form-control" id="motrici_fina" name="motrici_fina" required><?= htmlspecialchars($result_test['motroci_fina']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="motrici_gruesa" class="form-label">Motricidad Gruesa</label>
                        <textarea class="form-control" id="motrici_gruesa" name="motrici_gruesa" required><?= htmlspecialchars($result_test['motrici_gruesa']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="movimi_pinza" class="form-label">Movimiento de Pinza</label>
                        <textarea class="form-control" id="movimi_pinza" name="movimi_pinza" required><?= htmlspecialchars($result_test['movimi_pinza']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="alimentacion_infancia" class="form-label">4. Alimentación infancia:</label>
                        <textarea class="form-control" id="alimentacion_infancia" name="alimentacion_infancia" required><?= htmlspecialchars($result_test['alimentacion_infancia']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="crianza" class="form-label">5. Crianza por parte de los padres: </label>
                        <select id="crianza" name="crianza" required>
                            <option value="Madre y Padre" <?= ($result_test['crianza'] == 'Madre y Padre') ? 'selected' : '' ?>>Madre y Padre</option>
                            <option value="Madre" <?= ($result_test['crianza'] == 'Madre') ? 'selected' : '' ?>>Madre</option>
                            <option value="Padre" <?= ($result_test['crianza'] == 'Padre') ? 'selected' : '' ?>>Padre</option>
                            <option value="Otros" <?= ($result_test['crianza'] == 'Otros') ? 'selected' : '' ?>>Otros</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="juego_infantil" class="form-label">6. Juego infantil:</label>
                        <textarea class="form-control" id="juego_infantil" name="juego_infantil" required><?= htmlspecialchars($result_test['juego_infantil']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="caracter_y_comportamiento" class="form-label">7. Carácter y Comportamiento en los Primeros Años</label>
                        <textarea class="form-control" id="caracter_y_comportamiento" name="caracter_y_comportamiento" required><?= htmlspecialchars($result_test['caracter_y_comportamiento_primero_años']) ?></textarea>
                    </div>
                    <h5> 8. Relación social (niñez):</h5>
                    <div class="mb-3">
                        <label for="r_s_padres" class="form-label">Con los Padres</label>
                        <textarea class="form-control" id="r_s_padres" name="r_s_padres" required><?= htmlspecialchars($result_test['r_s_padres']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="r_s_hermanos" class="form-label">Con los Hermanos</label>
                        <textarea class="form-control" id="r_s_hermanos" name="r_s_hermanos" required><?= htmlspecialchars($result_test['r_s_hermanos']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="r_s_otros_familiares" class="form-label"> Otros familiares</label>
                        <textarea class="form-control" id="r_s_otros_familiares" name="r_s_otros_familiares" required><?= htmlspecialchars($result_test['r_s_otros_familiares']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="r_s_conocidos" class="form-label">Conocidos</label>
                        <textarea class="form-control" id="r_s_conocidos" name="r_s_conocidos" required><?= htmlspecialchars($result_test['r_s_conocidos']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="r_s_extraños_m_edad_d_edad" class="form-label">Extraños (Mismo Edad y Diferente Edad)</label>
                        <textarea class="form-control" id="r_s_extraños_m_edad_d_edad" name="r_s_extraños_m_edad_d_edad" required><?= htmlspecialchars($result_test['r_s_extraños_m_edad_d_edad']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="grado_integracion_a_ellos" class="form-label">Grado de Integración a Ellos</label>
                        <textarea class="form-control" id="grado_integracion_a_ellos" name="grado_integracion_a_ellos" required><?= htmlspecialchars($result_test['grado_integracion_a_ellos']) ?></textarea>
                    </div>

                    <h5> 9. Escolaridad</h5>
                    <div class="mb-3">
                        <label for="adaptacion_ingreso_escu" class="form-label">Ingreso a la escuela (¿se adaptó?):</label>
                        <textarea class="form-control" id="adaptacion_ingreso_escu" name="adaptacion_ingreso_escu" required><?= htmlspecialchars($result_test['adaptacion_ingreso_escu']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="integracion_condiscipulos" class="form-label">Integración con los condiscípulos:</label>
                        <textarea class="form-control" id="integracion_condiscipulos" name="integracion_condiscipulos" required><?= htmlspecialchars($result_test['integracion_condiscipulos']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="comportamiento_salon_clase" class="form-label">Comportamiento en el salón de clases:</label>
                        <textarea class="form-control" id="comportamiento_salon_clase" name="comportamiento_salon_clase" required><?= htmlspecialchars($result_test['comportamiento_salon_clase']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="compor_recreo" class="form-label">En las horas de esparcimiento: (recreo):</label>
                        <textarea class="form-control" id="compor_recreo" name="compor_recreo" required><?= htmlspecialchars($result_test['compor_recreo']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="relacion_demas" class="form-label">RRelación con los demás:</label>
                        <textarea class="form-control" id="relacion_demas" name="relacion_demas" required><?= htmlspecialchars($result_test['relacion_demas']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="aislamiento" class="form-label">Aislamiento: Explique:</label>
                        <textarea class="form-control" id="aislamiento" name="aislamiento" required><?= htmlspecialchars($result_test['aislamiento']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="experiencia_estudio_primarios" class="form-label">10. Experiencias durante los estudios primarios (recurso y apoyo, problemas de conducta, indisciplina): Dificultades académicas (cómo enfrentaba los exámenes):</label>
                        <textarea class="form-control" id="experiencia_estudio_primarios" name="experiencia_estudio_primarios" required><?= htmlspecialchars($result_test['experiencia_estudio_primarios']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="experiencia_estudio_segundario" class="form-label">11. Experiencias durante la secundaria: (recurso y apoyo, problemas conducta indisciplina): Dificultades académicas (cómo enfrentaba los exámenes):</label>
                        <textarea class="form-control" id="experiencia_estudio_segundario" name="experiencia_estudio_segundario" required><?= htmlspecialchars($result_test['experiencia_estudio_segundario']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="experiencia_estudio_superior" class="form-label">12. Experiencias durante los estudios superiores (recurso y apoyo, problemas de conducta, indisciplina): Dificultades académicas:</label>
                        <textarea class="form-control" id="experiencia_estudio_superior" name="experiencia_estudio_superior" required><?= htmlspecialchars($result_test['experiencia_estudio_superior']) ?></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="proble_afectivo_conducta_niñez" class="form-label">13. Problemas afectivos o conducta durante su niñez:</label>
                        <textarea class="form-control" id="proble_afectivo_conducta_niñez" name="proble_afectivo_conducta_niñez"><?= htmlspecialchars($result_test['proble_afectivo_conducta_niñez']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="proble_afectivo_pubertad" class="form-label">14. Problemas afectivos en la Pubertad, desde la pubescencia cuando se dan los cambios fisiológicos y aumento del Ritmo Maduracional (características Sexuales Primarias y Secundarias otras particularidades):</label>
                        <textarea class="form-control" id="proble_afectivo_pubertad" name="proble_afectivo_pubertad"><?= htmlspecialchars($result_test['proble_afectivo_pubertad']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="particularidades_adole" class="form-label">15. Particularidades de la adolescencia:</label>
                        <textarea class="form-control" id="particularidades_adole" name="particularidades_adole"><?= htmlspecialchars($result_test['particularidades_adole']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="proble_afectivo_adole" class="form-label">16. Problemas afectivos o de conducta en la Adolescencia:</label>
                        <textarea class="form-control" id="proble_afectivo_adole" name="proble_afectivo_adole"><?= htmlspecialchars($result_test['proble_afectivo_adole']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="grado_armonia_madurez_bio_psico" class="form-label">17. Grado de armonía entre la Madurez Biológica y Psicológica:</label>
                        <textarea class="form-control" id="grado_armonia_madurez_bio_psico" name="grado_armonia_madurez_bio_psico"><?= htmlspecialchars($result_test['grado_armonia_madurez_bio_psico']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="desarrollo_voluntad" class="form-label">18. Desarrollo de la Voluntad (rapidez, decisión y ejecución):</label>
                        <textarea class="form-control" id="desarrollo_voluntad" name="desarrollo_voluntad"><?= htmlspecialchars($result_test['desarrollo_voluntad']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="grado_autonomia_deliberacion_accion" class="form-label">19. Grado de autonomía en la deliberación y la acción:</label>
                        <textarea class="form-control" id="grado_autonomia_deliberacion_accion" name="grado_autonomia_deliberacion_accion"><?= htmlspecialchars($result_test['grado_autonomía_deliberación_acción']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="persistencia_esfuerzo" class="form-label">20. Persistencia y Esfuerzo</label>
                        <textarea class="form-control" id="persistencia_esfuerzo" name="persistencia_esfuerzo"><?= htmlspecialchars($result_test['persistencia_esfuerzo']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="jerarvalores_estilovida_sexaceina" class="form-label">21. Jerarquía de valores (concepción de la vida y el mundo): Estilo de vida: Sexualidad activa e inactiva:</label>
                        <textarea class="form-control" id="jerarvalores_estilovida_sexaceina" name="jerarvalores_estilovida_sexaceina"><?= htmlspecialchars($result_test['jerarvalores_estilovida_sexaceina']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="norma_nivel_familiar" class="form-label">22. Problemas legales: Norma a nivel familiar:</label>
                        <textarea class="form-control" id="norma_nivel_familiar" name="norma_nivel_familiar"><?= htmlspecialchars($result_test['norma_nivel_familiar']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="prefe_smo" class="form-label">23. Servicio Militar Obligatorio: Preferencias en el SMO:</label>
                        <textarea class="form-control" id="prefe_smo" name="prefe_smo"><?= htmlspecialchars($result_test['prefe_smo']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="habitos_intereses" class="form-label">24. Hábitos e intereses (consumo de alcohol, drogas, etc.):</label>
                        <textarea class="form-control" id="habitos_intereses" name="habitos_intereses"><?= htmlspecialchars($result_test['habitos_intereses']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="enfermedad_accidente" class="form-label">25. Enfermedad y accidentes (desde la niñez hasta la actualidad):</label>
                        <textarea class="form-control" id="enfermedad_accidente" name="enfermedad_accidente"><?= htmlspecialchars($result_test['enfermedad_accidente']) ?></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="eleccion_profesion" class="form-label">26. Elección de profesión u Oficio (libre, influenciado o forzado):</label>
                        <textarea class="form-control" id="eleccion_profesion" name="eleccion_profesion"><?= htmlspecialchars($result_test['eleccion_profesion']) ?></textarea>
                    </div>
                    <h5>27. Ambiente social Actual Trabajo (actual y anteriores):</h5>
                    <div class="mb-3">
                        <label for="vivienda" class="form-label">Vivienda:</label>
                        <textarea class="form-control" id="vivienda" name="vivienda"><?= htmlspecialchars($result_test['vivienda']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="economia" class="form-label">Economía:</label>
                        <textarea class="form-control" id="economia" name="economia"><?= htmlspecialchars($result_test['economía']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="r_jefe_super_compa_subal" class="form-label">Relación con Jefe, Superior, Compañeros, Subalternos:</label>
                        <textarea class="form-control" id="r_jefe_super_compa_subal" name="r_jefe_super_compa_subal"><?= htmlspecialchars($result_test['r_jefe_super_compa_subal']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="crecimiento_psicosocial" class="form-label">Crecimiento Psicosocial:</label>
                        <textarea class="form-control" id="crecimiento_psicosocial" name="crecimiento_psicosocial"><?= htmlspecialchars($result_test['crecimiento_psicosocial']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="ambiciones_laboral" class="form-label">Ambiciones Laborales:</label>
                        <textarea class="form-control" id="ambiciones_laboral" name="ambiciones_laboral"><?= htmlspecialchars($result_test['ambiciones_laboral']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="cambio_profesion" class="form-label">Cambios de profesión, oficios o trabajo (frecuentes, circunstanciales y sus causas):</label>
                        <textarea class="form-control" id="cambio_profesion" name="cambio_profesion"><?= htmlspecialchars($result_test['cambio_profesion']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="cuadro_familiar" class="form-label">Cuadro Familiar:</label>
                        <textarea class="form-control" id="cuadro_familiar" name="cuadro_familiar"><?= htmlspecialchars($result_test['cuadro_familiar']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="relaciones_interperso" class="form-label">Relaciones Interpersonales:</label>
                        <textarea class="form-control" id="relaciones_interperso" name="relaciones_interperso"><?= htmlspecialchars($result_test['relaciones_interperso']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="religion" class="form-label">Religión:</label>
                        <textarea class="form-control" id="religion" name="religion"><?= htmlspecialchars($result_test['religion']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="recreacion" class="form-label">Recreación:</label>
                        <textarea class="form-control" id="recreacion" name="recreacion"><?= htmlspecialchars($result_test['recreacion']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="abuelo_p" class="form-label">Abuelo Paterno</label>
                        <input type="text" class="form-control" id="abuelo_p" name="abuelo_p" maxlength="70" value="<?= htmlspecialchars($result_test['abuelo_p']) ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="conducta_sexual" class="form-label">28. Conducta sexual (inicio y vida sexual, desde los juegos infantiles a la actualidad) Relación con las personas del mismo sexo y del sexo opuesto:</label>
                        <textarea class="form-control" id="conducta_sexual" name="conducta_sexual"><?= htmlspecialchars($result_test['conducta_sexual']) ?></textarea>
                    </div>
                    <h5>29. Elección de la pareja:</h5>
                    <div class="mb-3">
                        <label for="elegir_pareja" class="form-label">¿Le cuesta trabajo elegir pareja?:</label>
                        <textarea class="form-control" id="elegir_pareja" name="elegir_pareja"><?= htmlspecialchars($result_test['elegir_pareja']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="fiel_exigente" class="form-label">¿Fiel y exigente?:</label>
                        <textarea class="form-control" id="fiel_exigente" name="fiel_exigente"><?= htmlspecialchars($result_test['fiel_exigente']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="noviazgo" class="form-label">Noviazgo (número y duración de ellos)</label>
                        <textarea class="form-control" id="noviazgo" name="noviazgo"><?= htmlspecialchars($result_test['noviazgo']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="matrimonio" class="form-label">Matrimonio (edad del paciente y la pareja)</label>
                        <textarea class="form-control" id="matrimonio" name="matrimonio"><?= htmlspecialchars($result_test['matrimonio']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="opinion_matrimonio" class="form-label">¿Qué opina del matrimonio?:</label>
                        <textarea class="form-control" id="opinion_matrimonio" name="opinion_matrimonio"><?= htmlspecialchars($result_test['opinion_matrimonio']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="particularidades_dia_boda" class="form-label">Particularidades del día de la boda:</label>
                        <textarea class="form-control" id="particularidades_dia_boda" name="particularidades_dia_boda"><?= htmlspecialchars($result_test['particularidades_dia_boda']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="vida_matrimonial" class="form-label">Vida Matrimonial (armonía o desarmonía conyugal):</label>
                        <textarea class="form-control" id="vida_matrimonial" name="vida_matrimonial"><?= htmlspecialchars($result_test['vida_matrimonial']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="separacion" class="form-label">Separación:</label>
                        <textarea class="form-control" id="separacion" name="separacion"><?= htmlspecialchars($result_test['separacion']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="divorcio" class="form-label">Divorcio (causas)</label>
                        <textarea class="form-control" id="divorcio" name="divorcio"><?= htmlspecialchars($result_test['divorcio']) ?></textarea>
                    </div>
                    <h5>30. Problemas y periodos críticos particularidades del climaterio, menopausia y edad crítica:</h5>
                    <div class="mb-3">
                        <label for="proble_peri_criti_particu_climaterio_menopausia_edadcriti" class="form-label">Síntesis de lo encontrado:</label>
                        <textarea class="form-control" id="proble_peri_criti_particu_climaterio_menopausia_edadcriti" name="proble_peri_criti_particu_climaterio_menopausia_edadcriti"><?= htmlspecialchars($result_test['proble_peri_criti_particu_climaterio_menopausia_edadcriti']) ?></textarea>
                    </div>
                    <h4>IV. ANTECEDENTES FAMILIARES</h4>
                    <h5>(Se señalan los datos correspondientes a la filiación de toda la parentela del paciente, relaciones familiares, carácter y personalidad, antecedentes clínicos Psicológicos y afines)</h5>
                    <h6>1. Rama Paterna:</h6>
                    <div class="mb-3">
                        <label for="abuela_p" class="form-label">Abuelo</label>
                        <input type="text" class="form-control" id="abuela_p" name="abuela_p" maxlength="70" value="<?= htmlspecialchars($result_test['abuelo_p']) ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="abuela_p" class="form-label">Abuela</label>
                        <input type="text" class="form-control" id="abuela_p" name="abuela_p" maxlength="70" value="<?= htmlspecialchars($result_test['abuela_p']) ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="padre" class="form-label">Padre</label>
                        <input type="text" class="form-control" id="padre" name="padre" maxlength="70" value="<?= htmlspecialchars($result_test['padre']) ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="tios_p" class="form-label">Tíos</label>
                        <textarea class="form-control" id="tios_p" name="tios_p"><?= htmlspecialchars($result_test['tios_p']) ?></textarea>
                    </div>

                    <h6>1. Rama Paterna:</h6>

                    <div class="mb-3">
                        <label for="abuelo_m" class="form-label">Abuelo Materno</label>
                        <input type="text" class="form-control" id="abuelo_m" name="abuelo_m" maxlength="70" value="<?= htmlspecialchars($result_test['abuelo_m']) ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="abuela_m" class="form-label">Abuela Materna</label>
                        <input type="text" class="form-control" id="abuela_m" name="abuela_m" maxlength="70" value="<?= htmlspecialchars($result_test['abuela_m']) ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="madre" class="form-label">Madre</label>
                        <input type="text" class="form-control" id="madre" name="madre" maxlength="70" value="<?= htmlspecialchars($result_test['madre']) ?>" required>
                    </div>

                    <div class="mb-3">
                        <label for="tios_m" class="form-label">Tíos Maternos</label>
                        <textarea class="form-control" id="tios_m" name="tios_m"><?= htmlspecialchars($result_test['tios_m']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="hermanos" class="form-label">3. Hermanos (as):</label>
                        <textarea class="form-control" id="hermanos" name="hermanos"><?= htmlspecialchars($result_test['hermanos']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="esposo_a" class="form-label">4. Esposo (a):</label>
                        <textarea class="form-control" id="esposo_a" name="esposo_a"><?= htmlspecialchars($result_test['esposo_a']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="hijos" class="form-label">5. Hijos:</label>
                        <textarea class="form-control" id="hijos" name="hijos"><?= htmlspecialchars($result_test['hijos']) ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="colaterales" class="form-label">6. Colaterales (de manera general los datos de algún pariente colateral que haya sufrido trastornos mentales u orgánicos, conducta delictiva, etc.)</label>
                        <textarea class="form-control" id="colaterales" name="colaterales"><?= htmlspecialchars($result_test['colaterales']) ?></textarea>
                    </div>
                    <h4>V. SUMARIO DIAGNÓSTICO – RESULTADOS DE EXAMEN – TRATAMIENTO Y EVOLUCIÓN</h4>
                    <h5> 1. SUMARIO DIAGNÓSTICO</h5>

                    <div class="mb-3">
                        <label for="signos_sintoma" class="form-label">SIGNOS Y SINTOMAS</label>
                        <textarea class="form-control" id="signos_sintoma" name="signos_sintoma"><?= htmlspecialchars($result_test['signos_sintoma'] ?? '') ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="patologia_sindrome" class="form-label">PATOLOGIAS, SINDROMES</label>
                        <textarea class="form-control" id="patologia_sindrome" name="patologia_sindrome"><?= htmlspecialchars($result_test['patologia_sindrome'] ?? '') ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="trastorno" class="form-label">TRASTORNOS</label>
                        <textarea class="form-control" id="trastorno" name="trastorno"><?= htmlspecialchars($result_test['trastorno'] ?? '') ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="nivel_afectacion" class="form-label">NIVEL DE AFECTACIÓN (LEVE, MODERADO,GRAVE)</label>
                        <textarea class="form-control" id="nivel_afectacion" name="nivel_afectacion"><?= htmlspecialchars($result_test['nivel_afectacion'] ?? '') ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="conclusion_diag" class="form-label">Conclusión Diagnóstica</label>
                        <textarea class="form-control" id="conclusion_diag" name="conclusion_diag"><?= htmlspecialchars($result_test['conclusion_diag'] ?? '') ?></textarea>
                    </div>
                    <h5>2. EXAMEN CONDUCTUAL Y DE LAS FACULTADES PSÍQUICAS</h5>
                    <div class="mb-3">
                        <label for="exa_conductual_facultades_psiquicas" class="form-label">Síntesis de lo encontrado:</label>
                        <textarea class="form-control" id="exa_conductual_facultades_psiquicas" name="exa_conductual_facultades_psiquicas"><?= htmlspecialchars($result_test['exa_conductual_facultades_psiquicas'] ?? '') ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="eva_psico" class="form-label">3. EVALUACIÓN PSICOLÓGICA:</label>
                        <textarea class="form-control" id="eva_psico" name="eva_psico"><?= htmlspecialchars($result_test['eva_psico'] ?? '') ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="programa_trata_propuesto" class="form-label">4. PROGRAMA DE TRATAMIENTO PROPUESTO:</label>
                        <textarea class="form-control" id="programa_trata_propuesto" name="programa_trata_propuesto"><?= htmlspecialchars($result_test['programa_trata_propuesto'] ?? '') ?></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="evolucion" class="form-label">5. EVOLUCIÓN:</label>
                        <textarea class="form-control" id="evolucion" name="evolucion"><?= htmlspecialchars($result_test['evolucion'] ?? '') ?></textarea>
                    </div>

                </div>
            </div>
            <button type="submit" class="btn btn-primary">Guardar Historial Medico</button>
        </form>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>