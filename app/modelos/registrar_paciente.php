<?php 
require_once 'config/conexion.php';


class registro_paciente extends BD{


		private $id_usuario;
		private $usuario;
		private $correo;
		private $contraseña;
        private $status = 1;
		private $conex;
		

		function __construct(){
			$this->usuario=array();
			parent::__construct();

			$this->conex = parent::conexion();
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

	


		function registrar(){

			$sql = "INSERT INTO usuario() VALUES(:id_usuario,:usuario,:correo,:contraseña) ";

			$conexion = $this->conex->prepare($sql);

			$conexion->bindParam(':id_usuario',$this->id_usuario);
			$conexion->bindParam(':usuario',$this->usuario);
			$conexion->bindParam(':correo',$this->correo);
			$conexion->bindParam(':contraseña',$this->contraseña);
	

			return $conexion->execute();
		}

		function consultar(){

			$sql = "SELECT * FROM usuario WHERE status = 1 ";

			$conexion = $this->conex->prepare($sql);

			$conexion->execute();

			$registros = $conexion->fetchAll(PDO::FETCH_ASSOC);

			return $registros;

		}
        function actualizar(){

			$sql = "UPDATE usuario SET  usuario  = :usuario, correo = :correo,  
			contraseña = :contraseña WHERE id_usuario = :id_usuario";

			$conexion = $this->conex->prepare($sql);

			$conexion->bindParam(':id_usuario',$this->id_usuario);
			$conexion->bindParam(':usuario',$this->usuario);
			$conexion->bindParam(':correo',$this->correo);
			$conexion->bindParam(':contraseña',$this->contraseña);
		
			

			return $conexion->execute();
		}


		function eliminar_l($id_usuario1){

			$sql = "UPDATE usuario SET status = 0 WHERE id_usuario = $id_usuario1";

			$conexion = $this->conex->prepare($sql);

			return $conexion->execute();
		}



		function eliminar($id_usuario){

			$sql = "DELETE FROM usuario WHERE id_usuario = $id_usuario";

			$conexion = $this->conex->prepare($sql);

			return $conexion->execute();
		}

	

 }
