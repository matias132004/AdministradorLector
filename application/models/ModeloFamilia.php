<?php

class ModeloFamilia extends CI_Model {

    public function selectFamilia() {
        $querySelect = $this->db->query("SELECT familia.*, estado.nombre_estado AS nombre_estado FROM familia LEFT JOIN estado ON familia.id_estado = estado.id_estado WHERE  familia.id_estado = 1");
        return $querySelect->result_array();
    }


    public function insertFamilia($nombre_familia, $id_estado) {
       
        $query = $this->db->query("SELECT MAX(id_familia) AS max_id FROM familia");
        $row = $query->row();
        $ultimo_id = $row->max_id;
    
        $nuevo_id = $ultimo_id + 1;

        $this->db->query("INSERT INTO familia (id_familia, nombre_familia, id_estado) VALUES ('$nuevo_id', UPPER('$nombre_familia'), '$id_estado')");
    }
    public function comprobar($idFamilia){
    $querySelect = $this->db->query("SELECT COUNT(*) AS cantidad_productos
                                  FROM producto
                                  WHERE id_familia = '$idFamilia'");
    $result = $querySelect->row_array();
    return $result['cantidad_productos'];
}

public function deleteFamilia($idFamilia)
{
    $this->db->query("DELETE FROM familia WHERE id_familia='$idFamilia'");
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

    public function comprobarProductosAsociados()
    {
        $querySelect = $this->db->query("SELECT COUNT(*) AS cantidad_productos FROM producto");
        $result = $querySelect->row_array();
        return ($result['cantidad_productos'] > 0);
    }
    
    public function deleteTodo()
    {
        return $this->db->query("DELETE FROM familia");
    }

}
