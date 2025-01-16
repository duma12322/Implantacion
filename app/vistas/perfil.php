<?php
session_start();

//echo '<pre>';
//print_r($_SESSION);
//echo '</pre>';

// Verifica si la sesión está activa
if (!isset($_SESSION['usuario'])) {
    header("Location: login_paciente.php");
    exit;
}


$nombreUsuario = isset($_SESSION['nombre1']) ? $_SESSION['nombre1'] : 'Usuario';
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Perfil</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/sidebarandheader.css">
   
</head>

<body>
 <!-- Header -->
 <?php include 'includes/header.php'; ?>

<!-- Sidebar -->
<?php include 'includes/sidebar.php'; ?>

    <div class="container">

        <div class="row">
            <div class="col-sm-4" style="margin-top: 50px;">
                <div class="text-center">
                    <img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" class="avatar img-circle img-thumbnail"
                        alt="avatar">
                    <h6>Cambiar foto</h6>
                    <input type="file" class="text-center center-block file-upload">
                </div>
                </hr><br>

             

                <ul class="list-group">
                    <li class="list-group-item text-muted">Informacion <i class="fa fa-dashboard fa-1x"></i></li>
                    <li class="list-group-item text-right"><span class="pull-left"><strong>Nombre</strong></span> 
                    </li>
                    <li class="list-group-item text-right"><span class="pull-left"><strong>Apellido</strong></span> </li>
                    <li class="list-group-item text-right"><span class="pull-left"><strong>Ciudad</strong></span> </li>
                    </li>
                </ul>
            </div>

            <div class="col-sm-8" style="margin-top: 50px;">
                <ul class="nav nav-tabs">
                    <li class="active"><a data-toggle="tab" href="#home">Perfil</a></li>
                </ul>


                <div class="tab-content">
                    <div class="tab-pane active" id="home">
                        <hr>
                        <form class="form" action="##" method="post" >
                            <div class="form-group">

                                <div class="col-xs-6">
                                    <label for="nombre">
                                        <h4>Primer Nombre</h4>
                                    </label>
                                    <input type="text" class="form-control" name="nombre1" id="nombre1"
                                        placeholder="introduce tu primer nombre">
                                </div>
                            </div>
                            <div class="col-xs-6">
                                    <label for="nombre">
                                        <h4>Segundo Nombre</h4>
                                    </label>
                                    <input type="text" class="form-control" name="nombre2" id="nombre2"
                                        placeholder="introduce tu segundo nombre">
                                </div>
                            </div>

                            <div class="form-group">

                                <div class="col-xs-6">
                                    <label for="apellido">
                                        <h4>Primer Apellido</h4>
                                    </label>
                                    <input type="text" class="form-control" name="apellido1" id="apellido1"
                                        placeholder="introduce tu primer apellido">
                                </div>
                            </div>
                            <div class="form-group">

                                <div class="col-xs-6">
                                    <label for="apellido">
                                        <h4>Segundo Apellido</h4>
                                    </label>
                                    <input type="text" class="form-control" name="apellido2" id="apellido2"
                                        placeholder="introduce tu segundo apellido">
                                </div>
                            </div>

                            <div class="form-group">

                                <div class="col-xs-6">
                                    <label for="fecha_nac">
                                        <h4>Fecha de Nacimiento</h4>
                                    </label>
                                    <input type="date" class="form-control" name="fecha_nac" id="fecha_nac"
                                        placeholder="introduce tu fecha de nacimiento">
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-xs-6">
                                    <label for="telefono">
                                        <h4>Telefono</h4>
                                    </label>
                                    <input type="text" class="form-control" name="telefono" id="telefono"
                                        placeholder="introduce tu numero de telefono">
                                </div>
                            </div>
                            <div class="form-group">

                                <div class="col-xs-6">
                                    <label for="email">
                                        <h4>Email</h4>
                                    </label>
                                    <input type="email" class="form-control" name="email" id="email"
                                        placeholder="you@email.com">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-xs-6">
                                 <label for="estado">
                                     <h4>Estado</h4>
                                 </label>
                                 <select name="id_estado" id="estado" required>
                                      <option enable selected>Seleccione su estado</option>
                                      <!-- Estados serán cargados dinámicamente -->
                                 </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-xs-6">
                                    <label for= "ciudad">
                                     <h4>Ciudad</h4>
                                    </label>
                                     <select name="id_ciudad" id="ciudad" required>
                                      <option disabled selected>Seleccione su ciudad</option>
                                      <!-- Ciudades serán cargadas dinámicamente -->
                                    </select>
                                </div>
                            </div>


                            <div class="form-group">
                                <div class="col-xs-6">
                                    <label for= "municipio">
                                     <h4>Municipio</h4>
                                    </label>
                                     <select name="id_municipio" id="municipio" required>
                                      <option disabled selected>Seleccione su ciudad</option>
                                      <!-- Ciudades serán cargadas dinámicamente -->
                                    </select>
                                </div>
                            </div>
                        
                            <div class="form-group">
                                <div class="col-xs-6">
                                    <label for= "parroquia">
                                     <h4>Parroquia</h4>
                                    </label>
                                     <select name="id_parroquia" id="parroquia" required>
                                      <option disabled selected>Seleccione su ciudad</option>
                                      <!-- Ciudades serán cargadas dinámicamente -->
                                    </select>
                                </div>
                            </div>

                        

                            <div class="form-group">

                                <div class="col-xs-6">
                                    <label for="password">
                                        <h4>Contraseña</h4>
                                    </label>
                                    <input type="password" class="form-control" name="password" id="password"
                                        placeholder="contraseña">
                                </div>
                            </div>
                            <div class="form-group">

                                <div class="col-xs-6">
                                    <label for="password2">
                                        <h4>Verifica la contraseña</h4>
                                    </label>
                                    <input type="password" class="form-control" name="password2" id="password2"
                                        placeholder="password2">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-xs-12">
                                    <br>
                                    <button class="btn btn-success" type="submit"><i
                                            class="glyphicon glyphicon-ok-sign"></i> Guardar</button>
                                    <button class="btn btn-danger" type="reset"><i
                                            class="glyphicon glyphicon-repeat"></i> Limpiar</button>
                                </div>
                            </div>
                        </form>

                        <hr>

                    </div>
                </div>

            </div>
        </div>

        <script type="text/javascript">
            $(document).ready(function () {
                var readURL = function (input) {
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();

                        reader.onload = function (e) {
                            $('.avatar').attr('src', e.target.result);
                        }

                        reader.readAsDataURL(input.files[0]);
                    }
                }

                $(".file-upload").on('change', function () {
                    readURL(this);
                });
            });
        </script>

        <!-- Vinculamos los scripts de Bootstrap 4 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">

    <!-- Script -->
    <script src="script/sidebarandheader.js"></script>
</body>

</html>