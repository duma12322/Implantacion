<?php
	
	namespace app\modelos;

	class vistaModelo{

		/*---------- Modelo obtener vista ----------*/
		protected function obtenerVistasModelo($vista){

			$listaBlanca=[
				"inicio",
				"login-paciente",
				"inicio-paciente",
				"inicio-psicologo-admin",
				"registro-paciente",
				"cerrar-sesion",
			];

			if(in_array($vista, $listaBlanca)){
				if(is_file("./app/vistas/contenido/".$vista."-view.php")){
					$contenido="./app/vistas/contenido/".$vista."-view.php";
				}else{
					$contenido="404";
				}
			}elseif($vista=="inicio" || $vista=="index"){
				$contenido="inicio";
			}else{
				$contenido="404";
			}
			return $contenido;
		}

	}