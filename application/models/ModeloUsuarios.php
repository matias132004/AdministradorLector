<?php

class ModeloUsuarios extends CI_Model {

    public function selectUsuario() {
        $querySelect = $this->db->query("
            SELECT u.*, tu.nombre_tipo_usuario, g.nombre_genero
            FROM usuario u
            INNER JOIN tipo_usuario tu ON u.id_tipo_usuario = tu.id_tipo_usuario
            INNER JOIN genero g ON u.id_genero = g.id_genero
            WHERE u.id_estado = 1 and u.rut NOT LIKE '77.115.675-4' 
        ");

        if ($querySelect->num_rows() > 0) {
            return $querySelect->result_array();
        } else {
            return null;
        }
    }


    public function obtenerGeneros() {
        $querySelect = $this->db->query("SELECT * FROM genero");
            $this->db->order_by('nombre_genero', 'ASC');
        return $querySelect->result_array();
    }

    public function obtenerTiposUsuario() {
        $querySelect = $this->db->query("SELECT * FROM tipo_usuario");
            $this->db->order_by('nombre_tipo_usuario', 'ASC');
        return $querySelect->result_array();
    }

    public function insertUsuario($rut, $nombre, $apellidoP, $apellidoM, $id_tipo_usuario, $mail, $phone, $password, $id_genero, $estado) {
        $sql = "INSERT INTO usuario (rut, nombre_usuario, apellido1, apellido2, id_tipo_usuario, correo, telefono, contrasena, id_genero, id_estado,id_datos_local) VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $this->db->query($sql, array($rut, $nombre, $apellidoP, $apellidoM, $id_tipo_usuario, $mail, $phone, $password, $id_genero, $estado,1));
    }

    public function deleteUsuario($id) {
        $querySelect = $this->db->query("DELETE FROM usuario WHERE id_usuario='$id'");
        return $querySelect;
    }
    public function selectUsuarioId($id) {
        $querySelect = $this->db->query("SELECT * FROM usuario WHERE id_usuario = '$id'");
        return $querySelect;
    }
        public function selectUsuarioRut($rut) {
        $querySelect = $this->db->query("SELECT * FROM usuario WHERE rut LIKE '$rut'");
        return $querySelect;
    }

    public function updateUsuario($id, $rut, $nombre, $apellidoP, $apellidoM, $id_tipo_usuario, $mail, $phone, $genero) {
        $sql = "UPDATE usuario 
            SET rut = ?, 
                nombre_usuario = ?, 
                apellido1 = ?, 
                apellido2 = ?, 
                id_tipo_usuario = ?, 
                correo = ?, 
                telefono = ?, 
                id_genero = ? 
            WHERE id_usuario = ?";

        // Preparar la consulta
        $query = $this->db->query($sql, array(
            $rut,
            $nombre,
            $apellidoP,
            $apellidoM,
            $id_tipo_usuario,
            $mail,
            $phone,
            $genero,
            $id
        ));

        // Verificar si la consulta se ejecutó correctamente
        if ($query) {
            // Éxito
            return true;
        } else {
            // Error
            return false;
        }
    }
    
    
        public function cambiarContrasena($id_usuario, $contrasena_nueva) {
        $hashed_password = password_hash($contrasena_nueva, PASSWORD_DEFAULT);
        $this->db->where('id_usuario', $id_usuario);
        $this->db->update('usuario', array('contrasena' => $hashed_password));
    }

    
}

?>
