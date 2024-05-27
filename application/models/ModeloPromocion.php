<?php

class ModeloPromocion extends CI_Model {

    public function __construct() {
        parent::__construct();
        // Cargar base de datos
        $this->load->database();
    }

    public function guardarPromocion($id_producto, $fecha_inicio, $fecha_termino, $lunes, $martes, $miercoles, $jueves, $viernes, $sabado, $domingo, $descripcion) {
        $ultimo_id_result = $this->db->query("SELECT COALESCE(MAX(id_promocion), 0) + 1 AS max_id FROM promocion");
        $row = $ultimo_id_result->row();
        $max_id = $row->max_id; 
        
        $data = array(
            'id_promocion' => $max_id,
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
        $query = $this->db->query("SELECT pr.total AS total ,p.id_promocion, p.id_producto, pr.nombre_producto, pr.cbarra, p.fecha_inicio,p.fecha_fin, p.lunes, p.martes, p.miercoles, p.jueves, p.viernes, p.sabado, p.domingo
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


    public function comprobarProductosAsociados()
    {
        $querySelect = $this->db->query("SELECT COUNT(*) AS cantidad_productos FROM producto");
        $result = $querySelect->row_array();
        return ($result['cantidad_productos'] > 0);
    }
    public function deleteTodo()
    {
        $this->db->query("DELETE FROM images_promocion");
        return $this->db->query("DELETE FROM promocion");
    }
    public function selectProducto()
    {
        $querySelect = $this->db->query("SELECT p.*, u.nombre_umedida, e.nombre_estado, f.nombre_familia
            FROM producto p
            INNER JOIN familia f ON p.id_familia = f.id_familia
            INNER JOIN umedida u ON p.id_umedida = u.id_umedida
            INNER JOIN estado e ON p.id_estado = e.id_estado
            WHERE p.id_estado = 1
            ORDER BY id_producto");
    
        return $querySelect->result_array();
    }

    public function selectProducto2($limit, $offset, $search = '')
    {
        $searchQuery = "";
        if (!empty($search)) {
            $search = strtoupper($search); // Convertir el término de búsqueda a mayúsculas
            $searchQuery = "AND (UPPER(p.nombre_producto) LIKE '%$search%' OR UPPER(f.nombre_familia) LIKE '%$search%' OR UPPER(p.cbarra) LIKE '%$search%' OR UPPER(u.nombre_umedida) LIKE '%$search%' OR UPPER(e.nombre_estado) LIKE '%$search%')";
        }
    
        $querySelect = $this->db->query("SELECT p.*, u.nombre_umedida, e.nombre_estado, f.nombre_familia
            FROM producto p
            INNER JOIN familia f ON p.id_familia = f.id_familia
            INNER JOIN umedida u ON p.id_umedida = u.id_umedida
            INNER JOIN estado e ON p.id_estado = e.id_estado
            WHERE p.id_estado = 1
            $searchQuery
            ORDER BY id_producto
            LIMIT $limit OFFSET $offset");
    
        return $querySelect->result_array();
    }
    
    public function countProductos($search = '')
    {
        $searchQuery = "";
        if (!empty($search)) {
            $search = strtoupper($search); // Convertir el término de búsqueda a mayúsculas
            $searchQuery = "AND (UPPER(p.nombre_producto) LIKE '%$search%' OR UPPER(f.nombre_familia) LIKE '%$search%' OR UPPER(p.cbarra) LIKE '%$search%' OR UPPER(u.nombre_umedida) LIKE '%$search%' OR UPPER(e.nombre_estado) LIKE '%$search%')";
        }
    
        $query = $this->db->query("SELECT COUNT(*) as total
            FROM producto p
            INNER JOIN familia f ON p.id_familia = f.id_familia
            INNER JOIN umedida u ON p.id_umedida = u.id_umedida
            INNER JOIN estado e ON p.id_estado = e.id_estado
            WHERE p.id_estado = 1
            $searchQuery");
    
        $result = $query->row_array();
        return $result['total'];
    }
    
}
