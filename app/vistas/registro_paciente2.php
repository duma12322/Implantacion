<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="CSS/registro_paciente2.css">
</head>

<body>
    <div class="container">
        <header>Parte 2: Registro</header>
        <form action="../../config/procesar_registro2.php" method="POST">
            <div class="form first">
                <div class="details personal">
                    <span class="title">Datos Personales</span>

                    <div class="fields">
                        <div class="input-field">
                            <label>Primer Nombre</label>
                            <input type="text" name="nombre1" placeholder="Ingrese su primer nombre" required>
                        </div>

                        <div class="input-field">
                            <label>Tipo de Documento</label>
                            <select name="tipo_doc" required>
                                <option disabled selected>Seleccione su tipo de documento</option>
                                <option>V</option>
                                <option>E</option>
                                <option>J</option>
                                <option>P</option>
                            </select>
                        </div>

                        <div class="input-field">
                            <label>Estado</label>
                            <select name="id_estado" id="estado" required>
                                <option enable selected>Seleccione su estado</option>
                                <!-- Estados serán cargados dinámicamente -->
                            </select>
                        </div>

                        <div class="input-field">
                            <label>Segundo Nombre</label>
                            <input type="text" name="nombre2" placeholder="Ingrese su segundo apellido">
                        </div>

                        <div class="input-field">
                            <label>Numero de Documento</label>
                            <input type="text" name="num_doc" placeholder="Ingrese su numero de documento" required>
                        </div>

                        <div class="input-field">
                            <label>Ciudad</label>
                            <select name="id_ciudad" id="ciudad" required>
                                <option disabled selected>Seleccione su ciudad</option>
                                <!-- Ciudades serán cargadas dinámicamente -->
                            </select>
                        </div>

                        <div class="input-field">
                            <label>Primer Apellido</label>
                            <input type="text" name="apellido1" placeholder="Ingrese su primer apellido" required>
                        </div>

                        <div class="input-field">
                            <label>Fecha de Nacimiento</label>
                            <input type="date" name="fecha_nac" placeholder="Ingrese su fecha de nacimiento" required>
                        </div>

                        <div class="input-field">
                            <label>Municipio</label>
                            <select name="id_municipio" id="municipio" required>
                                <option disabled selected>Seleccione su municipio</option>
                                <!-- Municipios serán cargados dinámicamente -->
                            </select>
                        </div>

                        <div class="input-field">
                            <label>Segundo Apellido</label>
                            <input type="text" name="apellido2" placeholder="Ingrese su segundo apellido">
                        </div>

                        <div class="input-field">
                            <label>Sexo</label>
                            <select name="sexo" required>
                                <option disabled selected>Seleccione su sexo</option>
                                <option value="Masculino">Masculino</option>
                                <option value="Femenino">Femenino</option>
                            </select>
                        </div>

                        <div class="input-field">
                            <label>Parroquia</label>
                            <select name="id_parroquia" id="parroquia" required>
                                <option disabled selected>Seleccione su parroquia</option>
                                <!-- Parroquias serán cargadas dinámicamente -->
                            </select>
                        </div>

                        <div class="input-field">
                            <label for="telefono">Teléfono</label>
                            <input type="text" id="telefono" name="telefono" placeholder="Ingrese su teléfono">
                        </div>

                        <div class="input-field">
                            <label>Otro</label>
                            <input type="text" name="otro" placeholder="Ingrese detalles de su ubicacion">
                        </div>


                    </div>
                </div>

                <div class="Detalles ID">
                    <span class="title">Preguntas de seguridad</span>

                    <div class="fields2">
                        <div class="input-field">
                            <label>Preguntas de seguridad 1</label>
                            <select name="pregunta_s1" required>
                                <option disabled selected>Seleccione la primera pregunta de seguridad</option>
                                <option>NOMBRE DE MI MADRE</option>
                                <option>NOMBRE DE MI MASCOTA</option>
                                <option>NOMBRE DE MI PRIMER COLEGIO</option>
                                <option>NOMBRE DE MI PRIMER TRABAJO</option>
                                <option>NOMBRE DE MI PADRE</option>
                            </select>
                        </div>

                        <div class="input-field">
                            <label>Respuesta 1</label>
                            <input type="text" name="respuesta_1" placeholder="Ingrese la respuesta de la pregunta 1" required>
                        </div>

                        <div class="input-field">
                            <label>Preguntas de seguridad 2</label>
                            <select name="pregunta_s2" required>
                                <option disabled selected>Seleccione la segunda pregunta de seguridad</option>
                                <option>NOMBRE DE MI HERMANO MAYOR</option>
                                <option>DONDE NACIO SU MADRE</option>
                                <option>NOMBRE DE MEJOR AMIGO DE LA INFANCIA</option>
                                <option>PELICULA FAVORITA</option>
                                <option>SEGUNDO APELLIDO DE MI MADRE</option>
                            </select>
                        </div>

                        <div class="input-field">
                            <label>Respuesta 2</label>
                            <input type="text" name="respuesta_2" placeholder="Ingrese la respuesta de la pregunta 2" required>
                        </div>

                        <button class="backBtn">
                            <span class="btnText">Atras</span>
                            <i class="uil uil-navigator"></i>
                        </button>

                        <button class="nextBtn">
                            <span class="btnText">Finalizar</span>
                            <i class="uil uil-navigator"></i>
                        </button>

                    </div>
                </div>
            </div>


        </form>
    </div>

    <script src="script/registro_paciente2.js"></script>
    <script src="script/registro.js"></script>
</body>

</html>