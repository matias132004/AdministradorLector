<?php

class ModeloProducto extends CI_Model
{

    public function selectProducto($limit, $offset, $search = '')
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
    
    public function countProductos()
    {
        $query = $this->db->query("SELECT COUNT(*) as count FROM producto WHERE id_estado = 1");
        return $query->row()->count;
    }
    
    public function insertProducto($nombre_producto, $id_familia, $cbarra, $id_umedida, $total, $id_estado)
    {
        $precio_old = 0;
        $this->db->query("INSERT INTO producto(nombre_producto, id_familia, cbarra, id_umedida, total, id_estado,precio_old) VALUES (UPPER('$nombre_producto'), '$id_familia', '$cbarra', '$id_umedida', '$total', '$id_estado', '$precio_old')");
    }

    public function comprobarCbarra($cbarra)
    {
        $query = $this->db->query("SELECT count(*) as count from producto where cbarra = '$cbarra'");
        $row = $query->row();
        $count = $row->count;

        if ($count == 0) {
            return false;
        } else {
            return true;
        }
    }

    public function deleteProductoPromocion($id_producto)
    {
        $querySelect = $this->db->query("DELETE FROM producto_promocion WHERE id_producto='$id_producto'");
        return $querySelect;
    }

    public function deleteProducto($id_producto)
    {
        $querySelect = $this->db->query("DELETE FROM producto WHERE id_producto='$id_producto'");
        return $querySelect;
    }

    public function selectProductoId($id_producto)
    {
        $querySelect = $this->db->query("SELECT * FROM producto WHERE id_producto=' $id_producto'");
        return $querySelect;
    }

    public function updateProducto($id_producto, $nombre_producto, $id_familia, $cbarra, $id_umedida, $total, $id_estado)
    {
        // Obtener el valor actual de total antes de la actualización
        $query = $this->db->query("SELECT total FROM producto WHERE id_producto = '$id_producto'");
        $row = $query->row();
        $precio_old = $row->total;

        $this->db->query("UPDATE producto SET precio_old = '$precio_old' WHERE id_producto = '$id_producto'");

        $this->db->query("UPDATE producto SET nombre_producto=UPPER('$nombre_producto'), id_familia='$id_familia',cbarra='$cbarra',id_umedida='$id_umedida',total='$total',id_estado='$id_estado' WHERE id_producto = '$id_producto'");
    }

    public function obtenerEstado()
    {
        $this->db->select('id_estado, nombre_estado');
        $this->db->order_by('nombre_estado', 'ASC');
        $query = $this->db->get('estado');
        return $query->result_array();
    }

    public function obtenerUmedida()
    {
        $this->db->select('id_umedida, nombre_umedida');
        $this->db->order_by('nombre_umedida', 'ASC');
        $query = $this->db->get('umedida');
        return $query->result_array();
    }

    public function obtenerFamilia()
    {
        $this->db->select('id_familia, nombre_familia');
        $this->db->order_by('nombre_familia', 'ASC');
        $query = $this->db->get('familia');
        return $query->result_array();
    }

    public function deleteTodo()
    {
        return $this->db->query("DELETE FROM producto");
    }
    public function comprobarPromocionAsociados()
    {
        $querySelect = $this->db->query("SELECT COUNT(*) AS cantidad_promociones FROM promocion");
        $result = $querySelect->row_array();
        return ($result['cantidad_promociones'] > 0);
    }
}
