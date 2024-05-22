<?php
class ModeloEstadisticas extends CI_Model {
    
    public function obtener_datos_estadisticas() {
        // Ejecutar la consulta SQL para obtener los datos
        $query = $this->db->query("SELECT COUNT(e.cbarra) AS num_escaneos, e.id_producto, e.nombre_producto, e.cbarra, p.total
            FROM escaneados e
            LEFT JOIN producto p ON e.id_producto = p.id_producto
            WHERE e.fecha_escaneado >= CURRENT_DATE - INTERVAL '30 days'
                AND e.cbarra = p.cbarra
                AND e.id_producto = p.id_producto
                AND e.nombre_producto = p.nombre_producto
            GROUP BY e.id_producto, e.nombre_producto, e.cbarra, p.total
            ORDER BY num_escaneos DESC
            LIMIT 10");

        // Devolver los resultados
        return $query->result_array();
    }

    public function obtenerEscaneosPorCodigoBarras($codigoBarras) {
        $this->db->select('COUNT(e.cbarra) AS num_escaneos, e.id_producto, e.nombre_producto, e.cbarra, p.total');
        $this->db->from('escaneados e');
        $this->db->join('producto p', 'e.id_producto = p.id_producto', 'left');
        $this->db->where('e.fecha_escaneado >= CURRENT_DATE - INTERVAL \'30 days\'');
        $this->db->where('e.cbarra', $codigoBarras);
        $this->db->where('e.cbarra = p.cbarra');
        $this->db->where('e.id_producto = p.id_producto');
        $this->db->where('e.nombre_producto = p.nombre_producto');
        $this->db->group_by('e.id_producto, e.nombre_producto, e.cbarra, p.total');
        $this->db->order_by('num_escaneos', 'DESC');
        $this->db->limit(1);
        $query = $this->db->get();
        return $query->result();
    }

    
}
