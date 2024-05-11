<?php

class ModeloImages extends CI_Model {

    public function __construct() {
        parent::__construct();
        // Cargar base de datos
        $this->load->database();
    }

public function obtenerImagenPorPromocion($id_promocion) {
    $this->db->where('id_promocion', $id_promocion);

    $query = $this->db->get('images_promocion');
    return $query->row(); 
}

    public function insertarImagen($nombre, $datos, $id_promocion) {
        $query = "INSERT INTO images_promocion (nombre, image_data, id_promocion) VALUES ($1, $2, $3)";
        $params = array($nombre, $datos, $id_promocion);
        $result = pg_query_params($this->db->conn_id, $query, $params);
        if (!$result) {
            
        }
    }

    public function actualizarImagen($nombre, $datos, $id_promocion) {
        $query = "UPDATE images_promocion SET nombre = $1, image_data = $2 WHERE id_promocion = $3";
        $params = array($nombre, $datos, $id_promocion);
        $result = pg_query_params($this->db->conn_id, $query, $params);
        if (!$result) {
           
        }
    }

    public function eliminarImagen($id_promocion) {
        $this->db->where('id_promocion', $id_promocion);
        $this->db->delete('images_promocion');
    }
}
