<?php

class ModeloConfiguracionPromocion extends CI_Model {

public function selectConfiguracionPromocion($id_usuario) {
    $querySelect = $this->db->query("SELECT configuracionesPromocion.* 
        FROM configuracionesPromocion  
        INNER JOIN usuario ON usuario.id_datos_local = configuracionesPromocion.id_datos_local
        WHERE usuario.id_usuario = '$id_usuario'");
    return $querySelect->row(); // Devuelve un solo objeto en lugar de un array de objetos
}


    public function selectIdlocal($id_usuario) {
        $querySelect = $this->db->query("SELECT configuracionesPromocion.id_datos_local
            FROM configuracionesPromocion  
            INNER JOIN usuario ON usuario.id_datos_local = configuracionesPromocion.id_datos_local
            WHERE usuario.id_usuario = '$id_usuario'");
        return $querySelect->row()->id_datos_local; // Solo devuelve el ID
    }
    public function selectFontFamilyOptions() {
        $query = $this->db->query('Select id_fuente, nombre_fuente FROM fuente');
        return $query->result_array();
    }
    
    public function selectDestacados() {
        $query = $this->db->query('Select id_destacado, nombre_destacado FROM destacado');
        return $query->result_array();
    }
    
    

    public function updateConfiguracion($idlocal,$camponombre, $colorPrincipal, $colorSecundario, $colorFuentePrincipal, $colorFuenteSecundario, $fontFamily,$iddestacado) {
        $query = "UPDATE configuracionesPromocion SET 
                  nombre = '$camponombre',
                  colorprincipal = '$colorPrincipal', 
                  colorsecundario = '$colorSecundario', 
                  colorfuentePrincipal = '$colorFuentePrincipal', 
                  colorfuenteSecundario = '$colorFuenteSecundario', 
                  id_fuente = '$fontFamily',
                  id_destacado = '$iddestacado'
                  WHERE id_datos_local = '$idlocal'";
                  
        $this->db->query($query);
    }
    
}
