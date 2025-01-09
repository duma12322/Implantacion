<?php

require_once 'modelos/registro_paciente.php';

class registro_pacienteC {

public function procesarFormulario() {
	if (isset($_POST['usuario']) && isset($_POST['correo']) && isset($_POST['contraseña'])) {
		$usuario = $_POST['usuario'];
        $correo = $_POST['correo'];
        $contraseña = $_POST['contraseña'];

		if (empty($usuario) || empty($correo) || empty($contraseña)) {
			echo "Todos los campos son obligatorios.";
			return;

	}
            
$p = new registro_paciente();

	$p->set_id_usuario($_POST['id_usuario']);
	$p->set_usuario($_POST['usuario']);
	$p->set_correo($_POST['correo']);
	$p->set_contraseña($_POST['contraseña']);



if (isset($_POST['id_usuario'])) {
	$p->set_id_usuario($_POST['id_usuario']);
}


$resultado = $registro->guardarDatos();
if ($resultado) {
	header('Location: registro_paciente2.php');
	exit;
} else {
	echo "Hubo un problema al registrar los datos. Intenta nuevamente.";
}

}
else{
	require_once "vista/registro_paciente.php";
}
}

}

?>