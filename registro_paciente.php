<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Registro de Paciente</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>

<body>
    <div class="container mt-5">
        <h2 class="text-center">Registro de Paciente</h2>
        <form action="procesar_registro_paciente.php" method="POST" class="mt-4">
            <div class="form-group">
                <label for="usuario">Usuario</label>
                <input type="text" name="usuario" id="usuario" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="contraseña">Contraseña</label>
                <input type="password" name="contraseña" id="contraseña" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="correo">Correo Electrónico</label>
                <input type="email" name="correo" id="correo" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="nombre1">Primer Nombre</label>
                <input type="text" name="nombre1" id="nombre1" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="apellido1">Primer Apellido</label>
                <input type="text" name="apellido1" id="apellido1" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="num_doc">Número de Documento</label>
                <input type="text" name="num_doc" id="num_doc" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="telefono">Teléfono</label>
                <input type="text" name="telefono" id="telefono" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Registrar Paciente</button>
        </form>
    </div>
</body>

</html>