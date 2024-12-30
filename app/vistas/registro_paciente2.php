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
                            <label>Segundo Apellido</label>
                            <input type="text" placeholder="Ingrese su segundo apellido">
                        </div>

                        <div class="input-field">
                            <label>Telefono</label>
                            <input type="text" placeholder="Ingrese su numero de telefono" required>
                        </div>

                        <div class="input-field">
                            <label>Segundo Nombre</label>
                            <input type="text" placeholder="Ingrese su segundo apellido">
                        </div>

                        <div class="input-field">
                            <label>Fecha de Nacimiento</label>
                            <input type="date" placeholder="Ingrese su fecha de nacimiento" required>
                        </div>

                        <div class="input-field">
                            <label>Estado</label>
                            <input type="text" placeholder="Ingrese su estado (ubicacion)" required>
                        </div>

                        <div class="input-field">
                            <label>Primer Apellido</label>
                            <input type="number" placeholder="Ingrese su primer apellido" required>
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
                            <label>Ciudad</label>
                            <input type="text" placeholder="Ingrese su cuidad (ubicacion)" required>
                        </div>

                        <div class="input-field">
                            <label>Parroquia</label>
                            <input type="text" placeholder="Ingrese su parroquia (ubicacion)" required>
                        </div>

                        <div class="input-field">
                            <label>Municipio</label>
                            <input type="text" placeholder="Ingrese su municipio (ubicacion)" required>
                        </div>

                        <div class="input-field">
                            <label>Otro</label>
                            <input type="text" placeholder="Ingrese detalles de su ubicacion">
                        </div>
                    </div>
                </div>

                <div class="Detalles ID">
                    <span class="title">Detalles de identidad</span>

                    <div class="fields">
                        <div class="input-field">
                            <label>Tipo de Documento</label>
                            <select required>
                                <option disabled selected>Seleccione el tipo de documento</option>
                                <option>V</option>
                                <option>E</option>
                                <option>J</option>
                                <option>P</option>
                            </select>
                        </div>

                        <div class="input-field">
                            <label>Numero de Documento</label>
                            <input type="text" placeholder="Ingrese el numero del documento" required>
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