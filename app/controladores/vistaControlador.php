<?php

	namespace app\controladores;
	use app\modelos\vistaModelo;

	class vistaControlador extends vistaModelo{

		/*---------- Controlador obtener vistas ----------*/
		public function obtenerVistasControlador($vista){
			if($vista!=""){
				$respuesta=$this->obtenerVistasModelo($vista);
			}else{
				$respuesta="inicio";
			}
			return $respuesta;
		}
	}