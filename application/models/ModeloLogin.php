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

    public function verificarSesionActivaPorEquipo($nombre_equipo) {
        $query = $this->db->query("SELECT * FROM sesion WHERE nombre_equipo = ? AND termino = 'f' AND fecha_termino IS NULL", array($nombre_equipo));
        return $query->row();
    }

    public function verificarSesionActiva($id_usuario) {
        $query = $this->db->query("SELECT * FROM sesion WHERE id_usuario = ? AND termino = 'f'", array($id_usuario));
        return $query->row();
    }

    public function registrarSesion($id_usuario, $nombre_equipo) {
        $data = array(
            'id_usuario' => $id_usuario,
            'nombre_equipo' => $nombre_equipo,
            'fecha_sesion' => date('Y-m-d H:i:s'),
            'termino' => 'f'
        );
        $this->db->insert('sesion', $data);
        return $this->db->insert_id(); 
    }

    public function cerrarSesion($id_sesion) {
        $fecha_termino = date('Y-m-d H:i:s'); 
        $this->db->set('termino', 't');
        $this->db->set('fecha_termino', $fecha_termino);
        $this->db->where('id_sesion', $id_sesion);
        $this->db->update('sesion');
    }
    
    public function obtenerSesionPorId($id_sesion) {
        $query = $this->db->query("SELECT * FROM sesion WHERE id_sesion = ?", array($id_sesion));
        return $query->row();
    }

    public function verificarContrasena($password, $hash) {
        return password_verify($password, $hash);
    }
}
?>
