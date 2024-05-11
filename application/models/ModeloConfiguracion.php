<?php

class ModeloConfiguracion extends CI_Model {

public function selectConfiguracion($id_usuario) {
    $querySelect = $this->db->query("SELECT configuraciones.* 
        FROM configuraciones 
        INNER JOIN usuario ON usuario.id_datos_local = configuraciones.id_datos_local
        WHERE usuario.id_usuario = '$id_usuario'");
    return $querySelect->row_array();
}

    public function updateConfiguracion($id_configuracion, $venta_volumen, $dictado_precios, $imagen_act) {
        
        $data = array(
            'venta_volumen' => $venta_volumen,
            'dictado_precios' => $dictado_precios,
            'imagen_act' => $imagen_act
        );
        
        $this->db->where('id_configuracion',$id_configuracion);
        $this->db->update('configuraciones', $data);
    }

}
