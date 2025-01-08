<!DOCTYPE html>
<!-- Coding By CodingNepal - codingnepalweb.com -->
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

        <form action="#">
            <div class="form first">
                <div class="details personal">
                    <span class="title">Datos Personales</span>

                    <div class="fields">
                        <div class="input-field">
                            <label>Primer Nombre</label>
                            <input type="text" placeholder="Ingrese su primer nombre" required>
                        </div>

                        <div class="input-field">
                            <label>Tipo de Documento</label>
                            <select required>
                                <option disabled selected>Seleccione su tipo de documento</option>
                                <option>V</option>
                                <option>E</option>
                                <option>J</option>
                                <option>P</option>
                            </select>
                        </div>

                        <div class="input-field">
                            <label>Estado</label>
                            <input type="text" placeholder="Ingrese su estado (ubicacion)" required>
                        </div>


                        <div class="input-field">
                            <label>Segundo Nombre</label>
                            <input type="text" placeholder="Ingrese su segundo apellido">
                        </div>

                        <div class="input-field">
                            <label>Numero de Documento</label>
                            <input type="text" placeholder="Ingrese su numero de documento" required>
                        </div>

                        <div class="input-field">
                            <label>Ciudad</label>
                            <input type="text" placeholder="Ingrese su cuidad (ubicacion)" required>
                        </div>

                        <div class="input-field">
                            <label>Primer Apellido</label>
                            <input type="number" placeholder="Ingrese su primer apellido" required>
                        </div>

                        <div class="input-field">
                            <label>Fecha de Nacimiento</label>
                            <input type="date" placeholder="Ingrese su fecha de nacimiento" required>
                        </div>

                        <div class="input-field">
                            <label>Parroquia</label>
                            <input type="text" placeholder="Ingrese su parroquia (ubicacion)" required>
                        </div>

                        <div class="input-field">
                            <label>Segundo Apellido</label>
                            <input type="text" placeholder="Ingrese su segundo apellido">
                        </div>

                        <div class="input-field">
                            <label>Sexo</label>
                            <select required>
                                <option disabled selected>Seleccione su sexo</option>
                                <option>Masculino</option>
                                <option>Femenino</option>
                            </select>
                        </div>

                        <div class="input-field">
                            <label>Municipio</label>
                            <input type="text" placeholder="Ingrese su municipio (ubicacion)" required>
                        </div>

                        <div class="input-field-other">
                            <label>Otro</label>
                            <input type="text" placeholder="Ingrese detalles de su ubicacion">
                        </div>


                    </div>
                </div>

                <div class="Detalles ID">
                    <span class="title">Preguntas de seguridad</span>

                    <div class="fields2">
                        <div class="input-field">
                            <label>Preguntas de seguridad 1</label>
                            <select required>
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
                            <input type="text" placeholder="Ingrese la respuesta de la pregunta 1" required>
                        </div>

                        <div class="input-field">
                            <label>Preguntas de seguridad 2</label>
                            <select required>
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
                            <input type="text" placeholder="Ingrese la respuesta de la pregunta 2" required>
                        </div>

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
</body>

</html>