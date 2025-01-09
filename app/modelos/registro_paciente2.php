<?php 
require_once 'config/conexion.php';


class registro_paciente2 extends principalModelo{

    private $nombre1;
    private $nombre2;
    private $apellido1;
    private $apellido2;
    private $tipo_doc;
    private $num_doc;
    private $fecha_nac;
    private $sexo;
    
    private $pregunta_s1;
    private $respuesta_1;
    private $pregunta_s2;
    private $respuesta_2;
    
    
    function __construct(){
        $this->usuario=array();
			parent::__construct();
     }

    function getNombre1() {
        return $this->nombre1;
    }

   function setNombre1($nombre1) {
        $this->nombre1 = $nombre1;
    }

   function getNombre2() {
        return $this->nombre2;
    }

   function setNombre2($nombre2) {
        $this->nombre2 = $nombre2;
    }

    function getApellido1() {
        return $this->apellido1;
    }

   function setApellido1($apellido1) {
        $this->apellido1 = $apellido1;
    }

    function getApellido2() {
        return $this->apellido2;
    }

    function setApellido2($apellido2) {
        $this->apellido2 = $apellido2;
    }

    function getTipoDoc() {
        return $this->tipo_doc;
    }

   function setTipoDoc($tipo_doc) {
        $this->tipo_doc = $tipo_doc;
    }

    function getNumDoc() {
        return $this->num_doc;
    }

    function setNumDoc($num_doc) {
        $this->num_doc = $num_doc;
    }

    function getFechaNac() {
        return $this->fecha_nac;
    }

    function setFechaNac($fecha_nac) {
        $this->fecha_nac = $fecha_nac;
    }

    function getSexo() {
        return $this->sexo;
    }

    function setSexo($sexo) {
        $this->sexo = $sexo;
    }

    function getPreguntaS1() {
        return $this->pregunta_s1;
    }

    function setPreguntaS1($pregunta_s1) {
        $this->pregunta_s1 = $pregunta_s1;
    }

    function getRespuesta1() {
        return $this->respuesta_1;
    }

    function setRespuesta1($respuesta_1) {
        $this->respuesta_1 = $respuesta_1;
    }

    function getPreguntaS2() {
        return $this->pregunta_s2;
    }

    function setPreguntaS2($pregunta_s2) {
        $this->pregunta_s2 = $pregunta_s2;
    }

    function getRespuesta2() {
        return $this->respuesta_2;
    }

    function setRespuesta2($respuesta_2) {
        $this->respuesta_2 = $respuesta_2;
    }

    function guardarDatos(){

        $datos = [
    
        [
                "campo_nombre" => "nombre1", 
                "campo_marcador" => ":nombre1",
                "campo_valor" => $nombre1
        ],

        [
                "campo_nombre" => "nombre2", 
                "campo_marcador" => ":nombre2", 
                "campo_valor" => $nombre2
        ],

        [
                "campo_nombre" => "apellido1", 
                "campo_marcador" => ":apellido1", 
                "campo_valor" => $apellido1
        ],

        [
                "campo_nombre" => "apellido2", 
                "campo_marcador" => ":apellido2", 
                "campo_valor" => $apellido2
        ],

        [
            "campo_nombre" => "tipo_doc", 
            "campo_marcador" => ":tipo_doc", 
            "campo_valor" => $tipo_doc
        ],

        [
                "campo_nombre" => "num_doc", 
                "campo_marcador" => ":num_doc", 
                "campo_valor" => $num_doc
        ],

        [
                "campo_nombre" => "fecha_nac",
                "campo_marcador" => ":fecha_nac", 
                "campo_valor" => $fecha_nac
        ],

        [
                "campo_nombre" => "sexo",
                "campo_marcador" => ":sexo",
                "campo_valor" => $sexo
        ],
            
        [
            "campo_nombre" => "pregunta_s1", 
            "campo_marcador" => ":pregunta_s1",
            "campo_valor" => $pregunta_s1
        ],

                
        [
            "campo_nombre" => "respuesta_1", 
            "campo_marcador" => ":respuesta_1", 
            "campo_valor" => $respuesta_1
        ],

        [
            "campo_nombre" => "pregunta_s2",
            "campo_marcador" => ":pregunta_s2",
            "campo_valor" => $pregunta_s2
        ],

        [
            "campo_nombre" => "respuesta_2", 
            "campo_marcador" => ":respuesta_2",
            "campo_valor" => $respuesta_2
        ]

        ]
        
        return $this->guardarDatos("usuario", $datos);
    }
}
