<?php
namespace app\modelos;
require_once __DIR__ . '/principalModelo.php';


use app\modelos\principalModelo;

class listado_PacienteModelo extends principalModelo {
    public function listarUsuarios() {
        $sql = $this->conectar()->prepare("SELECT * FROM usuario");
        $sql->execute();
        return $sql->fetchAll(\PDO::FETCH_ASSOC);
    }
}