<?php
class ModeloEstadisticas extends CI_Model {

    public function obtener_datos_estadisticas() {
        $query = $this->db->query("SELECT COUNT(e.cbarra) AS num_escaneos, e.id_producto, e.nombre_producto, e.cbarra, p.total
            FROM escaneados e
            LEFT JOIN producto p ON e.id_producto = p.id_producto
            WHERE e.fecha_escaneado >= CURRENT_DATE - INTERVAL '30 days'
                AND e.cbarra = p.cbarra
            GROUP BY e.id_producto, e.nombre_producto, e.cbarra, p.total
            ORDER BY num_escaneos DESC
            LIMIT 10");
        return $query->result_array();
    }

    public function obtenerEscaneosPorCodigoBarras($codigoBarras) {
        $this->db->select('COUNT(e.cbarra) AS num_escaneos, e.id_producto, e.nombre_producto, e.cbarra, p.total');
        $this->db->from('escaneados e');
        $this->db->join('producto p', 'e.id_producto = p.id_producto', 'left');
        $this->db->where('e.cbarra', $codigoBarras);
        $this->db->where('e.cbarra = p.cbarra');
        $this->db->group_by('e.id_producto, e.nombre_producto, e.cbarra, p.total');
        $this->db->order_by('num_escaneos', 'DESC');
        $this->db->limit(1);
        $query = $this->db->get();
        return $query->result();
    }


    public function obtener_productos_meses() {
        $query = $this->db->query("SELECT sub.id_producto, sub.nombre_producto, sub.num_escaneos, sub.mes FROM (
            SELECT e.id_producto, e.nombre_producto, COUNT(e.cbarra) AS num_escaneos, EXTRACT(MONTH FROM e.fecha_escaneado) AS mes,
                   ROW_NUMBER() OVER (PARTITION BY EXTRACT(MONTH FROM e.fecha_escaneado) ORDER BY COUNT(e.cbarra) DESC) AS row_num
            FROM escaneados e
            LEFT JOIN producto p ON e.id_producto = p.id_producto
            WHERE e.fecha_escaneado >= CURRENT_DATE - INTERVAL '6 months'
                AND e.cbarra = p.cbarra
            GROUP BY e.id_producto, e.nombre_producto, EXTRACT(MONTH FROM e.fecha_escaneado)
        ) sub WHERE sub.row_num = 1");
        return $query->result_array();
    }
    
}
?>
