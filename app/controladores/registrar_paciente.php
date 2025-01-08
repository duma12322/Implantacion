<?php


require_once 'modelos/registrar_paciente.php';
$p = new registrar_paciente();

if (isset($_POST['enviar'])) {

	$p->set_id_usuario($_POST['id_usuario']);
	$p->set_usuario($_POST['usuario']);
	$p->set_correo($_POST['correo']);
	$p->set_contraseña($_POST['contraseña']);
}


require_once "vista/registro_paciente.php";
