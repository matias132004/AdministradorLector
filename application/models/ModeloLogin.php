<?php

class ModeloLogin extends CI_Model {

    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function iniciarSesion($rut) {
        $this->db->select('*');
        $this->db->from('usuario');
        $this->db->where('rut', $rut);
        $this->db->where('id_estado', 1);
        $this->db->where('id_tipo_usuario !=', 3); 

        $query = $this->db->get();

        if ($query->num_rows() == 1) {
            return $query->row();
        } else {
            return false;
        }
    }

    public function verificarContrasena($password, $hash) {
        return password_verify($password, $hash);
    }
}

?>
