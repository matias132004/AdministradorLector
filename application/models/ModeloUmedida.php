<?php

class ModeloUmedida extends CI_Model {

    public function selectUmedida() {
        $querySelect = $this->db->query("SELECT umedida.*, estado.nombre_estado AS nombre_estado FROM umedida LEFT JOIN estado ON umedida.id_estado = estado.id_estado WHERE umedida.id_estado = 1");
        return $querySelect->result_array();
    }

    public function comprobar($id_umedida) {
        $querySelect = $this->db->query("SELECT COUNT(*) AS cantidad_productos
                                      FROM producto
                                      WHERE id_umedida = '$id_umedida'");
        $result = $querySelect->row_array();
        return $result['cantidad_productos'];
    }

    public function insertUmedida($nombre_umedida, $nombre_corto, $id_estado) {
        $this->db->query("INSERT INTO umedida(nombre_umedida, nombre_corto, id_estado) VALUES (UPPER('$nombre_umedida'),UPPER('$nombre_corto'), '$id_estado')");
    }

    public function deleteUmedida($id_umedida) {
        $querySelect = $this->db->query("DELETE FROM umedida WHERE id_umedida='$id_umedida'");
    }

    public function deshabilitarUmedida($id_umedida) {
        $queryUpdate = $this->db->query("UPDATE umedida SET id_estado = 2 WHERE id_umedida = '$id_umedida'");
    }

    public function selectUmedidaId($id_umedida) {
        $querySelect = $this->db->query("SELECT * FROM umedida WHERE id_umedida='$id_umedida'");
        return $querySelect;
    }

    public function updateUmedida($id_umedida, $nombre_umedida, $nombre_corto, $id_estado) {
        $this->db->query("UPDATE umedida SET nombre_umedida=UPPER('$nombre_umedida'), nombre_corto=UPPER('$nombre_corto'), id_estado='$id_estado' WHERE id_umedida = '$id_umedida' ");
    }

    public function obtenerEstado() {
        $this->db->select('id_estado,nombre_estado');
        $query = $this->db->get('estado');
        return $query->result();
    }
}
