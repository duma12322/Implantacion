<?php
session_start();
// Conexión a la base de datos
require_once '../../config/conexion.php';

// Verificar si el ID de usuario está presente
if (!isset($_GET['id_usuario']) || empty($_GET['id_usuario'])) {
    echo "ID de usuario no válido.";
    exit;
}

$id_usuario = htmlspecialchars($_GET['id_usuario']);

// Obtener los datos del usuario
$query_usuario = "
    SELECT  
        u.*,
        p.*,
        pa.*
       
    FROM 
        usuario u 
    JOIN
        paciente p ON u.id_usuario = p.id_usuario
    JOIN 
        paciente_relacion pa ON p.id_paciente = pa.id_paciente
   
    WHERE 
        u.id_usuario = :id_usuario";
$stmt_usuario = $conn->prepare($query_usuario);
$stmt_usuario->bindParam(':id_usuario', $id_usuario, PDO::PARAM_INT);
$stmt_usuario->execute();
$result = $stmt_usuario->fetch(PDO::FETCH_ASSOC);

if (!$result) {
    echo "Usuario no encontrado.";
    exit;
}


?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Registro de Paciente</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/perfil_usuario.css">
    <link rel="stylesheet" href="css/modificar.css">
</head>
<body>
    <div class="container">
        <form action="../../config/guardar_historial.php" method="POST">
            <div class="card mb-4">
                <div class="card-header">Historial Clínico</div>
                <div class="card-body">
                    <?php if (isset($error)): ?>
                        <div class=" alert alert-danger"><?= $error ?></div>
                    <?php endif; ?>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="Nombre1" class="form-label">Entrevistador</label>
                                <input type="text" class="form-control" id="Nombre1" name="Nombre1" >
                            </div>
                            <h4>I.DATOS DE FILIACIÓN</h4>
                            <div class="mb-3">
                                <label for="nombre1" class="form-label">Nombres Completos</label>
                                <input type="text" class="form-control" id="nombre1" name="nombre1" value="<?= $result['apellido1'] . ' ' . $result['apellido2'] . ' ' . $result['nombre1'] . ' ' . $result['nombre2']?>">
                            </div>
                            <div class="mb-3">
                                <label for="fecha_nac" class="form-label">Fecha de Nacimiento</label>
                                <input type="date" class="form-control" id="fecha_nac" name=" fecha_nac" value="<?= $result['fecha_nac'] ?>">
                            </div>
                            <div class="mb-3">
                                <label for="instruccion" class="form-label">Instrucción</label>
                                <input type="text" class="form-control" id="instruccion" name="instruccion" >
                            </div>
                            <div class="mb-3">
                                <label for="edo_civil" class="form-label">Estado Civil</label>
                                <input type="text" class="form-control" id="edo_civil" name="edo_civil" >
                            </div>
                            <div class="mb-3">
                                <label for="relacion_nombre1" class="form-label">Nombre del Cónyuge</label>
                                <input type="text" class="form-control" id="relacion_nombre1" name="relacion_nombre1" value="<?= $result['relacion_nombre1'] ?>">
                            </div>
                            <div class="mb-3">
                                <label for="num_hijos" class="form-label">Número de Hijos</label>
                                <input type="text" class="form-control" id="num_hijos" name="num_hijos" value="<?= $result['num_hijos'] ?>">
                            </div>
                            <div class="mb-3">
                                <label for="estudio_trabajo" class="form-label">Centro de Estudios y/o Trabajo</label>
                                <input type="text" class="form-control" id="estudio_trabajo" name="estudio_trabajo" >
                            </div>
                            <div class="mb-3">
                                <label for="lugar_resi" class="form-label">Lugar de Residencia</label>
                                <input type="text" class="form-control" id="lugar_resi" name="lugar_resi" >
                            </div>
                            <div class="mb-3">
                                <label for="procedencia" class="form-label">Procedencia</label>
                                <input type="text" class="form-control" id="procedencia" name="procedencia" >
                            </div>
                            <div class="mb-3">
                                <label for="correo" class="form-label">Email</label>
                                <input type="email" class="form-control" id="correo" name="correo" value="<?= $result['correo'] ?>">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="fecha_p_cita" class="form-label">Fecha Primera Cita</label>
                                <input type="date" class="form-control" id="fecha_p_cita" name="fecha_p_cita"  >
                            </div>
                            <div class="mb-3">
                                <label for="edad" class="form-label">Edad</label>
                                <input type="number" class="form-control" id="edad" name="edad" >
                            </div>
                            <div class="mb-3">
                                <label for="lugar_nacimient" class="form-label">Lugar de Nacimiento</label>
                                <input type="text" class="form-control" id="lugar_nacimient" name="lugar_nacimient" >
                            </div>
                            <div class="mb-3">
                                <label for="ocupacion" class="form-label">Ocupación</label>
                                <input type="text" class="form-control" id="ocupacion" name="ocupacion" >
                            </div>
                            <div class="mb-3">
                                <label for="religion" class="form-label">Religión</label>
                                <input type="text" class="form-control" id="religion" name="religion" >
                            </div>
                            <div class="mb-3">
                                <label for="relacion_telefono" class="form-label">Teléfono</label>
                                <input type="text" class="form-control" id="relacion_telefono" name="relacion_telefono" value="<?= $result['relacion_telefono'] ?>">
                            </div>
                            <div class="mb-3">
                                <label for="edades_hijos" class="form-label">Edades de los Hijos</label>
                                <input type=" text" class="form-control" id="edades_hijos" name="edades_hijos" value="<?= $result['edades_hijos'] ?>">
                            </div>
                            <div class="mb-3">
                                <label for="grado_ciclo" class="form-label">Grado/Ciclo</label>
                                <input type="text" class="form-control" id="grado_ciclo" name="grado_ciclo" >
                            </div>
                            <div class="mb-3">
                                <label for="ti_resi" class="form-label">Tiempo de Residencia</label>
                                <input type="text" class="form-control" id="ti_resi" name="ti_resi" >
                            </div>
                            <div class="mb-3">
                                <label for="telefono" class="form-label">Teléfonos</label>
                                <input type="text" class="form-control" id="telefono" name="telefono" value="<?= $result['telefono'] ?>">
                            </div>
                            <div class="mb-3">
                                <label for="informante" class="form-label">Informante</label>
                                <input type="text" class="form-control" id="informante" name="informante" >
                            </div>
                        </div>
                    </div>
                    <h4>II.PROBLEMA ACTUAL</h4>
                    <div class="mb-3">
                        <label for="motivo" class="form-label">1. Motivo De consulta - Problema actual:</label>
                        <textarea type="text" class="form-control" id="motivo" name="motivo"  ></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="inicio_curso" class="form-label">2.	Inicio y Curso (síntomas):</label>
                        <textarea class="form-control" id="inicio_curso" name="inicio_curso" ></textarea>
                    </div>
                    <h5>3.	Episodios previos (inicio y curso – síntomas):</h5>
                    <div class="mb-3">
                        <label for="tiempo_proble" class="form-label">Tiempo del Problema:</label>
                        <textarea class="form-control" id="tiempo_proble" name="tiempo_proble" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="suceso_dia" class="form-label">Que le sucedió ese día:</label>
                        <textarea class="form-control" id="suceso_dia" name="suceso_dia" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="dia_anterior" class="form-label">El día anterior:</label>
                        <textarea class="form-control" id="dia_anterior" name="dia_anterior" required></textarea>
                    </div>
                    <div class="mb-3">
                                        <label for="que_hizo" class="form-label">¿Qué Hizo?</label>
                                        <textarea class="form-control" id="que_hizo" name="que_hizo" required></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="como_se_calmo" class="form-label">¿Cómo se Calmó?</label>
                                        <textarea class="form-control" id="como_se_calmo" name="como_se_calmo" required></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="hablo_alguien_del_problema" class="form-label">¿Habló Alguien del Problema?</label>
                                        <textarea class="form-control" id="hablo_alguien_del_problema" name="hablo_alguien_del_problema" required></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="factores_desenca_del_proble" class="form-label">4. Factores desencadenantes del problema Actual (agravantes y repercusión en su vida social, riesgos para sí o los demás):</label>
                                        <textarea class="form-control" id="factores_desenca_del_proble" name="factores_desenca_del_proble" required></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="ultimo_trata_fisi_psico" class="form-label">5. Últimos Tratamientos Recibidos (físicos y psicológicos):</label>
                                        <textarea class="form-control" id="ultimo_trata_fisi_psico" name="ultimo_trata_fisi_psico" required></textarea>
                                    </div>
                                    <h5>6. Auto descripción de la Personalidad:</h5>
                                    <div class="mb-3">
                                        <label for="autodescrpi_perso" class="form-label">¿Cómo podría describir su personalidad?</label>
                                        <textarea class="form-control" id="autodescrpi_perso" name="autodescrpi_perso" required></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="filosofia_vida" class="form-label">¿Cuál es su filosofía de vida?</label>
                                        <textarea class="form-control" id="filosofia_vida" name="filosofia_vida" required></textarea>
                                    </div>
                                    <h4>III. HISTORIA PERSONAL Y SOCIAL</h4>
                                    <h5>1. Gestación (pre – natalidad):</h5>
                                    <div class="mb-3">
                                        <label for="edad_madre_nacer" class="form-label">Edad de la Madre al Nacer</label>
                                        <input type="number" class="form-control" id="edad_madre_nacer" name="edad_madre_nacer" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="parto" class="form-label">2. Parto:</label>
                                        <textarea class="form-control" id="parto" name="parto" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="tipo_atencion_parto" class="form-label">Tipo de atención:</label>
                                        <select id="tipo_atencion_parto" name="tipo_atencion_parto" required>
                                            <option value="eutocico">Eutócico</option>
                                            <option value="distocico">Distócico</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="descrip_tipo_atencion" class="form-label">¿Por qué?:</label>
                                        <textarea class="form-control" id="descrip_tipo_atencion" name="descrip_tipo_atencion" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="termino" class="form-label">¿Fue a término? </label>
                                        <select id="termino" name="termino" required>
                                            <option value="Si">Sí</option>
                                            <option value="No">No</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="postnatalidad" class="form-label">Postnatalidad</label>
                                        <textarea class="form-control" id="postnatalidad" name="postnatalidad" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="estatura_nacer" class="form-label">Estatura al Nacer</label>
                                        <input type="number" class="form-control" id="estatura_nacer" name="estatura_nacer" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="peso" class="form-label">Peso</label>
                                        <input type="number" class="form-control" id="peso" name="peso" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="perimetro_cefalico" class="form-label">Perímetro Cefálico</label>
                                        <input type="number" class="form-control" id="perimetro_cefalico" name="perimetro_cefalico" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="taraxico" class="form-label">Taraxico</label>
                                        <input type="number" class="form-control" id="taraxico" name="taraxico" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="llorro" class="form-label">¿Lloró?</label>
                                        <select class="form-control" id="llorro" name="llorro" required>
                                            <option value="si">Sí</option>
                                            <option value="no">No</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="reflejos" class="form-label">Reflejos</label>
                                        <textarea class="form-control" id="reflejos" name="reflejos" required></textarea>
                                    </div>
                                    <h5>3. Desarrollo Psicomotor: </h5>
                                    <div class="mb-3">
                                        <label for="lenguaje" class="form-label">Lenguaje</label>
                                        <textarea class="form-control" id="lenguaje" name="lenguaje" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="juego" class="form-label">Juego</label>
                                        <textarea class="form-control" id="juego" name="juego" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="edad_camino" class="form-label">A QUE EDAD Caminó:</label>
                                        <input type="number" class="form-control" id="edad_camino" name="edad_camino" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="encopresis" class="form-label">¿Encopresis?</label>
                                        <select class="form-control" id="encopresis" name="encopresis" required>
                                            <option value="0">No</option>
                                            <option value="1">Sí</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="edad_control_enco" class="form-label">Edad de Control de Encopresis</label>
                                        <input type="number" class="form-control" id="edad_control_enco" name="edad_control_enco" >
                                    </div>

                                    <div class="mb-3">
                                        <label for="enuresis" class="form-label">¿Enuresis?</label>
                                        <select class="form-control" id="enuresis" name="enuresis" required>
                                            <option value="0">No</option>
                                            <option value="1">Sí</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="edad_control_enu" class="form-label">Edad de Control de Enuresis</label>
                                        <input type="number" class="form-control" id="edad_control_enu" name="edad_control_enu" >
                                    </div>

                                    <div class="mb-3">
                                        <label for="motrici_fina" class="form-label">Motricidad Fina</label>
                                        <textarea class="form-control" id="motrici_fina" name="motrici_fina" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="motrici_gruesa" class="form-label">Motricidad Gruesa</label>
                                        <textarea class="form-control" id="motrici_gruesa" name="motrici_gruesa" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="movimi_pinza" class="form-label">Movimiento de Pinza</label>
                                        <textarea class="form-control" id="movimi_pinza" name="movimi_pinza" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="alimentacion_infancia" class="form-label">4. Alimentación infancia:</label>
                                        <textarea class="form-control" id="alimentacion_infancia" name="alimentacion_infancia" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="crianza" class="form-label">5. Crianza por parte de los padres: </label>
                                        <select id="crianza" name="crianza" required>
                                            <option value="Madre y Padre">Madre y Padre</option>
                                            <option value="Madre">Madre</option>
                                            <option value="Padre">Padre</option>
                                            <option value="Otros">Otros</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="juego_infantil" class="form-label">6. Juego infantil:</label>
                                        <textarea class="form-control" id="juego_infantil" name="juego_infantil" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="caracter_y_comportamiento" class="form-label">7. Carácter y Comportamiento en los Primeros Años</label>
                                        <textarea class="form-control" id="caracter_y_comportamiento" name="caracter_y_comportamiento" required></textarea>
                                    </div> 
                                    <h5> 8. Relación social (niñez):</h5>
                                    <div class="mb-3">
                                        <label for="r_s_padres" class="form-label">Con los Padres</label>
                                        <textarea class="form-control" id="r_s_padres" name="r_s_padres" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="r_s_hermanos" class="form-label">Con los Hermanos</label>
                                        <textarea class="form-control" id="r_s_hermanos" name="r_s_hermanos" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="r_s_otros_familiares" class="form-label"> Otros familiares</label>
                                        <textarea class="form-control" id="r_s_otros_familiares" name="r_s_otros_familiares" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="r_s_conocidos" class="form-label">Conocidos</label>
                                        <textarea class="form-control" id="r_s_conocidos" name="r_s_conocidos" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="r_s_extraños_m_edad_d_edad" class="form-label">Extraños (Mismo Edad y Diferente Edad)</label>
                                        <textarea class="form-control" id="r_s_extraños_m_edad_d_edad" name="r_s_extraños_m_edad_d_edad" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="grado_integracion_a_ellos" class="form-label">Grado de Integración a Ellos</label>
                                        <textarea class="form-control" id="grado_integracion_a_ellos" name="grado_integracion_a_ellos" required></textarea>
                                    </div>

                                    <h5> 9. Escolaridad</h5>
                                    <div class="mb-3">
                                        <label for="adaptacion_ingreso_escu" class="form-label">Ingreso a la escuela (¿se adaptó?):</label>
                                        <textarea class="form-control" id="adaptacion_ingreso_escu" name="adaptacion_ingreso_escu" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="integracion_condiscipulos" class="form-label">Integración con los condiscípulos:</label>
                                        <textarea class="form-control" id="integracion_condiscipulos" name="integracion_condiscipulos" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="comportamiento_salon_clase" class="form-label">Comportamiento en el salón de clases:</label>
                                        <textarea class="form-control" id="comportamiento_salon_clase" name="comportamiento_salon_clase" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="compor_recreo" class="form-label">En las horas de esparcimiento: (recreo):</label>
                                        <textarea class="form-control" id="compor_recreo" name="compor_recreo" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="relacion_demas" class="form-label">Relación con los demás:</label>
                                        <textarea class="form-control" id="relacion_demas" name="relacion_demas" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="aislamiento" class="form-label">Aislamiento: Explique:</label>
                                        <textarea class="form-control" id="aislamiento" name="aislamiento" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="experiencia_estudio_primarios" class="form-label">10. Experiencias durante los estudios primarios (recurso y apoyo, problemas de conducta, indisciplina): Dificultades académicas (cómo enfrentaba los exámenes):</label>
                                        <textarea class="form-control" id="experiencia_estudio_primarios" name="experiencia_estudio_primarios" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="experiencia_estudio_segundario" class="form-label">11. Experiencias durante la secundaria: (recurso y apoyo, problemas conducta indisciplina): Dificultades académicas (cómo enfrentaba los exámenes):</label>
                                        <textarea class="form-control" id="experiencia_estudio_segundario" name="experiencia_estudio_segundario" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="experiencia_estudio_superior" class="form-label">12. Experiencias durante los estudios superiores (recurso y apoyo, problemas de conducta, indisciplina): Dificultades académicas:</label>
                                        <textarea class="form-control" id="experiencia_estudio_superior" name="experiencia_estudio_superior" required></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="proble_afectivo_conducta_niñez" class="form-label">13. Problemas afectivos o conducta durante su niñez:</label>
                                        <textarea class="form-control" id="proble_afectivo_conducta_niñez" name="proble_afectivo_conducta_niñez"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="proble_afectivo_pubertad" class="form-label">14. Problemas afectivos en la Pubertad, desde la pubescencia cuando se dan los cambios fisiológicos y aumento del Ritmo Maduracional (características Sexuales Primarias y Secundarias otras particularidades):</label>
                                        <textarea class="form-control" id="proble_afectivo_pubertad" name="proble_afectivo_pubertad"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="particularidades_adole" class="form-label">15. Particularidades de la adolescencia:</label>
                                        <textarea class="form-control" id="particularidades_adole" name="particularidades_adole"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="proble_afectivo_adole" class="form-label">16. Problemas afectivos o de conducta en la Adolescencia:</label>
                                        <textarea class="form-control" id="proble_afectivo_adole" name="proble_afectivo_adole"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="grado_armonia_madurez_bio_psico" class="form-label">17. Grado de armonía entre la Madurez Biológica y Psicológica:</label>
                                        <textarea class="form-control" id="grado_armonia_madurez_bio_psico" name="grado_armonia_madurez_bio_psico"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="desarrollo_voluntad" class="form-label">18. Desarrollo de la Voluntad (rapidez, decisión y ejecución):</label>
                                        <textarea class="form-control" id="desarrollo_voluntad" name="desarrollo_voluntad"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="grado_autonomia_deliberacion_accion" class="form-label">19. Grado de autonomía en la deliberación y la acción:</label>
                                        <textarea class="form-control" id="grado_autonomia_deliberacion_accion" name="grado_autonomia_deliberacion_accion"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="persistencia_esfuerzo" class="form-label">20. Persistencia y Esfuerzo</label>
                                        <textarea class="form-control" id="persistencia_esfuerzo" name="persistencia_esfuerzo"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="jerarvalores_estilovida_sexaceina" class="form-label">21. Jerarquía de valores (concepción de la vida y el mundo): Estilo de vida: Sexualidad activa e inactiva:</label>
                                        <textarea class="form-control" id="jerarvalores_estilovida_sexaceina" name="jerarvalores_estilovida_sexaceina"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="norma_nivel_familiar" class="form-label">22. Problemas legales: Norma a nivel familiar:</label>
                                        <textarea class="form-control" id="norma_nivel_familiar" name="norma_nivel_familiar"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="prefe_smo" class="form-label">23. Servicio Militar Obligatorio: Preferencias en el SMO:</label>
                                        <textarea class="form-control" id="prefe_smo" name="prefe_smo"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="habitos_intereses" class="form-label">24. Hábitos e intereses (consumo de alcohol, drogas, etc.):</label>
                                        <textarea class="form-control" id="habitos_intereses" name="habitos_intereses"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="enfermedad_accidente" class="form-label">25. Enfermedad y accidentes (desde la niñez hasta la actualidad):</label>
                                        <textarea class="form-control" id="enfermedad_accidente" name="enfermedad_accidente"></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="eleccion_profesion" class="form-label">26. Elección de profesión u Oficio (libre, influenciado o forzado):</label>
                                        <textarea class="form-control" id="eleccion_profesion" name="eleccion_profesion"></textarea>
                                    </div>
                                    <h5>27. Ambiente social Actual Trabajo (actual y anteriores):</h5>
                                    <div class="mb-3">
                                        <label for="vivienda" class="form-label">Vivienda:</label>
                                        <textarea class="form-control" id="vivienda" name="vivienda"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="economia" class="form-label">Economía:</label>
                                        <textarea class="form-control" id="economia" name="economia"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="r_jefe_super_compa_subal" class="form-label">Relación con Jefe, Superior, Compañeros, Subalternos:</label>
                                        <textarea class="form-control" id="r_jefe_super_compa_subal" name="r_jefe_super_compa_subal"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="crecimiento_psicosocial" class="form-label">Crecimiento Psicosocial:</label>
                                        <textarea class="form-control" id="crecimiento_psicosocial" name="crecimiento_psicosocial"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="ambiciones_laboral" class="form-label">Ambiciones Laborales:</label>
                                        <textarea class="form-control" id="ambiciones_laboral" name="ambiciones_laboral"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="cambio_profesion" class="form-label">Cambios de profesión, oficios o trabajo (frecuentes, circunstanciales y sus causas):</label>
                                        <textarea class="form-control" id="cambio_profesion" name="cambio_profesion"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="cuadro_familiar" class="form-label">Cuadro Familiar:</label>
                                        <textarea class="form-control" id="cuadro_familiar" name="cuadro_familiar"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="relaciones_interperso" class="form-label">Relaciones Interpersonales:</label>
                                        <textarea class="form-control" id="relaciones_interperso" name="relaciones_interperso"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="religion" class="form-label">Religión:</label>
                                        <textarea class="form-control" id="religion" name="religion"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="recreacion" class="form-label">Recreación:</label>
                                        <textarea class="form-control" id="recreacion" name="recreacion"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="abuelo_p" class="form-label">Abuelo Paterno</label>
                                        <input type="text" class="form-control" id="abuelo_p" name="abuelo_p" maxlength="70" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="conducta_sexual" class="form-label">28. Conducta sexual (inicio y vida sexual, desde los juegos infantiles a la actualidad) Relación con las personas del mismo sexo y del sexo opuesto:</label>
                                        <textarea class="form-control" id="conducta_sexual" name="conducta_sexual"></textarea>
                                    </div>
                                    <h5>29. Elección de la pareja:</h5>
                                    <div class="mb-3">
                                        <label for="elegir_pareja" class="form-label">¿Le cuesta trabajo elegir pareja?:</label>
                                        <textarea class="form-control" id="elegir_pareja" name="elegir_pareja"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="fiel_exigente" class="form-label">¿Fiel y exigente?:</label>
                                        <textarea class="form-control" id="fiel_exigente" name="fiel_exigente"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="noviazgo" class="form-label">Noviazgo (número y duración de ellos)</label>
                                        <textarea class="form-control" id="noviazgo" name="noviazgo"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="matrimonio" class="form-label">Matrimonio (edad del paciente y la pareja)</label>
                                        <textarea class="form-control" id="matrimonio" name="matrimonio"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="opinion_matrimonio" class="form-label">¿Qué opina del matrimonio?:</label>
                                        <textarea class="form-control" id="opinion_matrimonio" name="opinion_matrimonio"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="particularidades_dia_boda" class="form-label">Particularidades del día de la boda:</label>
                                        <textarea class="form-control" id="particularidades_dia_boda" name="particularidades_dia_boda"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="vida_matrimonial" class="form-label">Vida Matrimonial (armonía o desarmonía conyugal):</label>
                                        <textarea class="form-control" id="vida_matrimonial" name="vida_matrimonial"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="separacion" class="form-label">Separación:</label>
                                        <textarea class="form-control" id="separacion" name ="separacion"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="divorcio" class="form-label">Divorcio (causas)</label>
                                        <textarea class="form-control" id="divorcio" name="divorcio"></textarea>
                                    </div>
                                    <h5>30. Problemas y periodos críticos particularidades del climaterio, menopausia y edad crítica:</h5>
                                    <div class="mb-3">
                                        <label for="proble_peri_criti_particu_climaterio_menopausia_edadcriti" class="form-label">Síntesis de lo encontrado:</label>
                                        <textarea class="form-control" id="proble_peri_criti_particu_climaterio_menopausia_edadcriti" name="proble_peri_criti_particu_climaterio_menopausia_edadcriti"></textarea>
                                    </div>
                                    <h4>IV. ANTECEDENTES FAMILIARES</h4>
                                    <h5>(Se señalan los datos correspondientes a la filiación de toda la parentela del paciente, relaciones familiares, carácter y personalidad, antecedentes clínicos Psicológicos y afines)</h5>
                                    <h6>1. Rama Paterna:</h6>
                                    <div class="mb-3">
                                        <label for="abuelo_p" class="form-label">Abuelo</label>
                                        <input type="text" class="form-control" id="abuelo_p" name="abuelo_p" maxlength="70" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="abuela_p" class="form-label">Abuela</label>
                                        <input type="text" class="form-control" id="abuela_p" name="abuela_p" maxlength="70" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="padre" class="form-label">Padre</label>
                                        <input type="text" class="form-control" id="padre" name="padre" maxlength="70" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="tios_p" class="form-label">Tíos</label>
                                        <textarea class="form-control" id="tios_p" name="tios_p"></textarea>
                                    </div>

                                    <h6>2. Rama Materna:</h6>

                                    <div class="mb-3">
                                        <label for="abuelo_m" class="form-label">Abuelo Materno</label>
                                        <input type="text" class="form-control" id="abuelo_m" name="abuelo_m" maxlength="70" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="abuela_m" class="form-label">Abuela Materna</label>
                                        <input type="text" class="form-control" id="abuela_m" name="abuela_m" maxlength="70" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="madre" class="form-label">Madre</label>
                                        <input type="text" class="form-control" id="madre" name="madre" maxlength="70" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="tios_m" class="form-label">Tíos Maternos</label>
                                        <textarea class="form-control" id="tios_m" name="tios_m"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="hermanos" class="form-label">3. Hermanos (as):</label>
                                        <textarea class="form-control" id="hermanos" name="hermanos"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="esposo_a" class="form-label">4. Esposo (a):</label>
                                        <textarea class="form-control" id="esposo_a" name="esposo_a"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="hijos" class="form-label">5. Hijos:</label>
                                        <textarea class="form-control" id="hijos" name="hijos"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="colaterales" class="form-label">6. Colaterales (de manera general los datos de algún pariente colateral que haya sufrido trastornos mentales u orgánicos, conducta delictiva, etc.)</label>
                                        <textarea class="form-control" id="colaterales" name="colaterales"></textarea>
                                    </div> 
                                    <h4>V.	SUMARIO	DIAGNÓSTICO	–	RESULTADOS	DE	EXAMEN	– TRATAMIENTO Y EVOLUCIÓN</h4>
                                    <h5> 1. SUMARIO DIAGNÓSTICO</h5>
                        
                        <div class="mb-3">
                            <label for="signos_sintoma" class="form-label">SIGNOS Y SINTOMAS</label>
                            <textarea class="form-control" id="signos_sintoma" name="signos_sintoma"></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="patologia_sindrome" class="form-label">PATOLOGIAS, SINDROMES</label>
                            <textarea class="form-control" id="patologia_sindrome" name="patologia_sindrome"></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="trastorno" class="form-label">TRASTORNOS</label>
                            <textarea class="form-control" id="trastorno" name="trastorno"></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="nivel_afectacion" class="form-label">NIVEL DE AFECTACIÓN (LEVE, MODERADO,GRAVE)</label>
                            <textarea class="form-control" id="nivel_afectacion" name="nivel_afectacion"></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="conclusion_diag" class="form-label">Conclusión Diagnóstica</label>
                            <textarea class="form-control" id="conclusion_diag" name="conclusion_diag"></textarea>
                        </div>
                        <h5>2.	EXAMEN CONDUCTUAL Y DE LAS FACULTADES PSÍQUICAS</h5>
                        <div class="mb-3">
                            <label for="exa_conductual_facultades_psiquicas" class="form-label">Síntesis de lo encontrado:</label>
                            <textarea class="form-control" id="exa_conductual_facultades_psiquicas" name="exa_conductual_facultades_psiquicas"></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="eva_psico" class="form-label">3.	EVALUACIÓN PSICOLÓGICA:</label>
                            <textarea class="form-control" id="eva_psico" name="eva_psico"></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="programa_trata_propuesto" class="form-label">4.	PROGRAMA DE TRATAMIENTO PROPUESTO:</label>
                            <textarea class="form-control" id="programa_trata_propuesto" name="programa_trata_propuesto"></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="evolucion" class="form-label">5.	EVOLUCIÓN:</label>
                            <textarea class="form-control" id="evolucion" name="evolucion"></textarea>
                        </div>
                        </div>

                </div>   
         <button type="submit" class="btn btn-primary">Registrar Historial Medico</button>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>