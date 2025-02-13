<?php
session_start();
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro Completo</title>
    <link href="css/sweetalert2.min.css" rel="stylesheet">
    <script src="script/sweetalert2.all11.7.7.min.js"></script>
</head>

<body>
    <?php if (isset($_SESSION['mensaje']) && isset($_SESSION['mensaje_tipo'])): ?>
        <script>
            Swal.fire({
                icon: '<?php echo $_SESSION['mensaje_tipo']; ?>', // 'success' o 'error'
                title: '<?php echo $_SESSION['mensaje']; ?>',
                showConfirmButton: true,
                confirmButtonText: 'OK',
                timer: 3000
            }).then(() => {
                window.location.href = 'login_paciente.php'; // Cambiar a la página deseada
            });
        </script>
        <?php
        // Limpiar los mensajes después de mostrarlos
        unset($_SESSION['mensaje']);
        unset($_SESSION['mensaje_tipo']);
        ?>
    <?php else: ?>
        <!-- Mensaje predeterminado si no hay sesión -->
        <p>No hay mensajes para mostrar.</p>
    <?php endif; ?>
</body>

</html>