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

    public function obtener_productos_meses() {
        // Ejecutar la consulta SQL para obtener los productos más escaneados de cada mes
        $query = $this->db->query("SELECT e.id_producto, e.nombre_producto, COUNT(e.cbarra) AS num_escaneos, EXTRACT(MONTH FROM e.fecha_escaneado) AS mes
            FROM escaneados e
            LEFT JOIN producto p ON e.id_producto = p.id_producto
            WHERE e.fecha_escaneado >= CURRENT_DATE - INTERVAL '6 months'
                AND e.cbarra = p.cbarra
                AND e.id_producto = p.id_producto
                AND e.nombre_producto = p.nombre_producto
            GROUP BY e.id_producto, e.nombre_producto, EXTRACT(MONTH FROM e.fecha_escaneado)
            ORDER BY EXTRACT(MONTH FROM e.fecha_escaneado), num_escaneos DESC");

        // Devolver los resultados
        return $query->result_array();
    }
}
