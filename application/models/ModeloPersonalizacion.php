<?php

class ModeloPersonalizacion extends CI_Model {

    public function guardarCambios($id_datos_local, $nombre, $descripcion, $logo, $permitirSesion) {
        $data = array(
            'nombre_local' => $nombre,
            'descripcion' => $descripcion,
            'logo_act' => $logo,
            'permitir_sesion' =>  $permitirSesion
        );

        $this->db->where('id_datos_local', $id_datos_local);
        $this->db->update('datos_local', $data);

        return ($this->db->affected_rows() > 0) ? true : false;
    }
    

    public function selectPersonalizacion($id_usuario) {
        $querySelect = $this->db->query("SELECT datos_local.* 
            FROM datos_local INNER JOIN usuario
            ON datos_local.id_datos_local = usuario.id_datos_local 
            WHERE usuario.id_usuario ='$id_usuario'");
        return $querySelect->row_array();
    }

public function obtenerImagenLocal($id_datos_local) {
    $this->db->where('id_datos_local', $id_datos_local);
    $this->db->where('tipo_img_id', 2);
    $query = $this->db->get('images');
    
    return $query->row();
}

    public function guardarImagen($id_datos_local, $nombre_imagen, $imagen_data,$img_tipo) {
       
        if (!empty($nombre_imagen) && !empty($imagen_data)) {
            $data = array(
                'nombre' => $nombre_imagen,
                'image_data' => pg_escape_bytea($imagen_data),
                'id_datos_local' => $id_datos_local,
                'tipo_img_id' => $img_tipo
            );

            $this->db->insert('images', $data);

            return ($this->db->affected_rows() > 0) ? true : false;
        } else {
            return false;
        }
    }
     public function updateImagenDatosLocal($id_datos_local, $nombre_imagen, $imagen_data,$img_tipo,$id) {
      
        if (!empty($nombre_imagen) && !empty($imagen_data)) {
            $imagen_existente = $this->obtenerImagenLocal($id_datos_local);

            if ($imagen_existente) {
                
                $data = array(
                    'nombre' => $nombre_imagen,
                    'image_data' => pg_escape_bytea($imagen_data),
                    'tipo_img_id' => $img_tipo,
                    'id' => $id
                );

                $this->db->where('id_datos_local', $id_datos_local);
                $this->db->where('tipo_img_id', $img_tipo);
                $this->db->where('id', $id);
                $this->db->update('images', $data);
            } else {
                
                $data = array(
                    'nombre' => $nombre_imagen,
                    'image_data' => pg_escape_bytea($imagen_data),
                    'id_datos_local' => $id_datos_local
                );

                $this->db->insert('images', $data);
            }

            return ($this->db->affected_rows() > 0) ? true : false;
        } else {
            return false;
        }
    }
    
public function obtenerImagenesFondo($id_datos_local) {
    $querySelect = $this->db->query("SELECT * FROM images WHERE id_datos_local = '$id_datos_local' and tipo_img_id = 1");
    return $querySelect->result();

}

public function deletePersonalizacion($id_images) {
    $querySelect = $this->db->query("DELETE FROM images WHERE id = '$id_images' and tipo_img_id = 2");
    return $querySelect;
}


public function deletePersonalizacionFondo($id_images) {
    $querySelect = $this->db->query("DELETE FROM images WHERE id = '$id_images' and tipo_img_id = 1");
    return $querySelect;

}
public function selectidlocal($id_images) {
    $query = $this->db->query("SELECT id_datos_local FROM images WHERE id = '$id_images'");
    if ($query->num_rows() > 0) {
        return $query->row()->id_datos_local;
    } else {
        return null;
    }
}




public function deletePersonalizacionLogo($id_images) {
    $querySelect = $this->db->query("DELETE FROM images WHERE id = '$id_images' and tipo_img_id = 2");
    return $querySelect;

}
}

