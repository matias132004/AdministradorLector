<?php

class ModeloPromocion extends CI_Model {

    public function __construct() {
        parent::__construct();
        // Cargar base de datos
        $this->load->database();
    }

    public function guardarPromocion($id_producto, $fecha_inicio, $fecha_termino, $lunes, $martes, $miercoles, $jueves, $viernes, $sabado, $domingo, $descripcion) {

        $data = array(
            'id_producto' => $id_producto,
            'fecha_inicio' => $fecha_inicio,
            'fecha_fin' => $fecha_termino,
            'id_estado' => 1,
            'lunes' => $lunes,
            'martes' => $martes,
            'miercoles' => $miercoles,
            'jueves' => $jueves,
            'viernes' => $viernes,
            'sabado' => $sabado,
            'domingo' => $domingo,
            'descripcion' => $descripcion
        );

        $this->db->insert('promocion', $data);
    }

    public function obtenerPromociones() {
        $query = $this->db->query("SELECT p.id_promocion, p.id_producto, pr.nombre_producto, pr.cbarra, p.fecha_inicio,p.fecha_fin, p.lunes, p.martes, p.miercoles, p.jueves, p.viernes, p.sabado, p.domingo
FROM promocion p
INNER JOIN producto pr ON p.id_producto = pr.id_producto
");
        return $query->result_array();
    }

    public function selectPromocionId($id_Promocion) {
        $querySelect = $this->db->query("SELECT *  FROM Promocion WHERE id_Promocion='$id_Promocion'");
        return $querySelect->row_array();
    }

    public function actualizar_promocion($id_promocion, $datos_promocion) {
        $this->db->where('id_promocion', $id_promocion);
        $this->db->update('promocion', $datos_promocion);
        return $this->db->affected_rows() > 0;
    }

    public function deletePromocion($id_promocion) {
        $querySelect = $this->db->query("DELETE FROM promocion WHERE id_promocion='$id_promocion'");
        return $querySelect;
    }

    public function existePromocion($id_producto) {
        $querySelect = $this->db->query("SELECT id_promocion FROM Promocion WHERE id_producto='$id_producto'");
        return $querySelect->num_rows() > 0;
    }

    public function deleteImagenPromocion($id_promocion) {
        $querySelect = $this->db->query("DELETE FROM images_promocion WHERE id_promocion='$id_promocion'");
        return $querySelect;
    }

}
