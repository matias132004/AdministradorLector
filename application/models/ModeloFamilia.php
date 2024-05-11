<?php

class ModeloFamilia extends CI_Model {

    public function selectFamilia() {
        $querySelect = $this->db->query("SELECT familia.*, estado.nombre_estado AS nombre_estado FROM familia LEFT JOIN estado ON familia.id_estado = estado.id_estado WHERE  familia.id_estado = 1");
        return $querySelect->result_array();
    }

    public function comprobar($idfamilia) {
        $querySelect = $this->db->query("SELECT COUNT(*) AS cantidad_productos
                                      FROM producto
                                      WHERE id_familia = '$idfamilia'");
        $result = $querySelect->row_array();
        return $result['cantidad_productos'];
    }
    
    public function insertFamilia($nombre_familia, $id_estado) {
        $this->db->query("INSERT INTO familia(nombre_familia, id_estado) VALUES (UPPER('$nombre_familia'), '$id_estado')");
    }

    public function deleteFamilia($id_familia) {
        $querySelect = $this->db->query("DELETE FROM familia WHERE id_familia='$id_familia'");
    }

    public function deshabilitarFamilia($id_familia) {
        $queryUpdate = $this->db->query("UPDATE familia SET id_estado = 2 WHERE id_familia = '$id_familia'");
    }

    public function selectFamiliaId($id_familia) {
        $querySelect = $this->db->query("SELECT * FROM familia WHERE id_familia='$id_familia'");
        return $querySelect;
    }

    public function updateFamilia($id_familia, $nombre_familia, $id_estado) {
        $this->db->query("UPDATE familia SET nombre_familia=UPPER('$nombre_familia'),id_estado='$id_estado' WHERE id_familia = '$id_familia' ");
    }

    public function obtenerEstado() {
        $this->db->select('id_estado,nombre_estado');
        $query = $this->db->get('estado');
        return $query->result();
    }
}
