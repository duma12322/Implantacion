<?php 
require_once 'config/conexion.php';


class registro_paciente extends principalModelo{


		private $id_usuario;
		private $usuario;
		private $correo;
		private $contraseña;

		

		function __construct(){
			$this->usuario=array();
			parent::__construct();
		}



        function set_id_usuario($id_usuario){
			$this->id_usuario = $id_usuario;
		}
		function get_id_usuario(){
			return $this->id_usuario;
		}

        function set_usuario($usuario){
			$this->usuario = $usuario;
		}
		function get_usuario(){
			return $this->usuario;
		}

        function set_correo($correo){
			$this->correo = $correo;
		}
		function get_correo(){
			return $this->correo;
		}
		
		function set_contraseña($contraseña){
			$this->contraseña = $contraseña;
		}
		function get_contraseña(){
			return $this->contraseña;
		}
	


		function guardarDatos(){

			$datos = [
				[
					"campo_nombre" => "id_usuario",
					"campo_marcador" => ":id_usuario",
					"campo_valor" => $this->id_usuario
				],
				[
					"campo_nombre" => "usuario",
					"campo_marcador" => ":usuario",
					"campo_valor" => $this->usuario
				],
				[
					"campo_nombre" => "correo",
					"campo_marcador" => ":correo",
					"campo_valor" => $this->correo
				],
				[
					"campo_nombre" => "contraseña",
					"campo_marcador" => ":contraseña",
					"campo_valor" => $this->contraseña
				]
			];
			return $this->guardarDatos("usuario", $datos);
		 }
		}
