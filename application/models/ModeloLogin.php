<?php

class ModeloLogin extends CI_Model {

    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function iniciarSesion($rut) {
        $querySelect = $this->db->query("SELECT dt.pago FROM usuario u INNER JOIN datos_local dt ON u.id_datos_local = dt.id_datos_local WHERE u.rut = ? AND dt.pago = 't'", array($rut));
    
        if ($querySelect->num_rows() > 0) { 
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
        } else {
            return '1';

        }
    }
    

    public function verificarContrasena($password, $hash) {
        return password_verify($password, $hash);
    }
}

?>
