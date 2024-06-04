<?php

class ModeloPrecioVolumen extends CI_Model {

    public function selectPrecioVolumen() {
        $querySelect = $this->db->query("SELECT precio_volumen.*, producto.nombre_producto AS nombre_producto, producto.total AS total, estado.nombre_estado AS nombre_estado
                                         FROM precio_volumen 
                                         LEFT JOIN producto ON precio_volumen.id_producto = producto.id_producto
                                         LEFT JOIN estado ON precio_volumen.id_estado = estado.id_estado
                                         
                                         ");
        return $querySelect->result_array();
    }

    public function insertPrecioVolumen($id_producto, $desde, $hasta, $precio) {
        $query = $this->db->query("SELECT COALESCE(MAX(id_precio_volumen), 0) + 1 AS max_id FROM precio_volumen");
        $row = $query->row();
        $ultimo_id = $row->max_id;

        $this->db->query("INSERT INTO precio_volumen (id_precio_volumen, id_producto, desde, hasta, precio,id_estado)  
                          VALUES ('$ultimo_id', '$id_producto', '$desde', '$hasta', '$precio',1)");
    }

    public function deletePrecioVolumen($idPrecioVolumen) {
        $this->db->query("DELETE FROM precio_volumen WHERE id_precio_volumen='$idPrecioVolumen'");
    }

    public function deshabilitarPrecioVolumen($id_precio_volumen) {
        $queryUpdate = $this->db->query("UPDATE precio_volumen SET id_estado = 2 WHERE id_precio_volumen = '$id_precio_volumen'");
    }

    public function selectPrecioVolumenId($id_precio_volumen) {
        $querySelect = $this->db->query("SELECT * FROM precio_volumen WHERE id_precio_volumen='$id_precio_volumen'");
        return $querySelect->row_array();
    }

    public function updatePrecioVolumen($id_precio_volumen, $desde, $hasta, $precio,$id_estado) {
        $this->db->query("UPDATE precio_volumen 
                          SET id_estado='$id_estado',desde='$desde', hasta='$hasta', precio='$precio' 
                          WHERE id_precio_volumen='$id_precio_volumen'");
    }

    public function obtenerEstado() {
        $this->db->select('id_estado, nombre_estado');
        $query = $this->db->get('estado');
        return $query->result();
    }

    public function deleteTodo() {
        return $this->db->query("DELETE FROM precio_volumen");
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
