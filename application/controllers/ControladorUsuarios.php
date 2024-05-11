<?php

class ControladorUsuarios extends CI_Controller {

    public function __construct() {
        parent::__construct();
        // Cargar librería de sesión
        $this->load->library('session');
    }

    public function index() {
        // Verificar si el usuario está autenticado
        if ($this->session->userdata('id_usuario')) {
            $this->load->view('AdmiUsuarios.php');
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function mostrarUsuario() {
        // Verificar si el usuario está autenticado
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloUsuarios');
            $data['Datos'] = $this->ModeloUsuarios->selectUsuario();

            $this->load->view('Usuarios/AdmiUsuarios', $data);
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function error() {
        // Verificar si el usuario está autenticado
        if ($this->session->userdata('id_usuario')) {
            $this->load->view('VistaError.php');
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function crearUsuario() {
        // Verificar si el usuario está autenticado
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloUsuarios');
            $data['generos'] = $this->ModeloUsuarios->obtenerGeneros();
            $data['tipos_usuario'] = $this->ModeloUsuarios->obtenerTiposUsuario();
            $this->load->view('Usuarios/VistaAgregarUsuario', $data);
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function registroUsuario() {
        // Verificar si el usuario está autenticado
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloUsuarios');

            $rut = $this->input->post('Rut');
            $nombre = $this->input->post('nombre');
            $apellidoP = $this->input->post('apellido1');
            $apellidoM = $this->input->post('apellido2');
            $mail = $this->input->post('correo');
            $phone = $this->input->post('telefono');
            $password = $this->input->post('contrasena');
            $hashed_password = password_hash($password, PASSWORD_DEFAULT);

            $id_tipo_usuario = $this->input->post('tipo_usuario');
            $id_genero = $this->input->post('genero');
            $estado = 1;

            $comprobar = $this->ModeloUsuarios->selectUsuarioRut($rut);
            if ($comprobar == null) {

                $this->session->set_flashdata('alerta', 'El rut ya se encuentra registrado en el sistema');
                redirect('ControladorUsuarios/crearUsuario');
            } else {
                // Rut no existe, proceder con la inserción
                $this->ModeloUsuarios->insertUsuario($rut, $nombre, $apellidoP, $apellidoM, $id_tipo_usuario, $mail, $phone, $hashed_password, $id_genero, $estado);
                redirect('ControladorUsuarios/mostrarUsuario');
            }
        } else {
            redirect('ControladorLogin');
        }
    }

    public function eliminarUsuario() {
        // Verificar si el usuario está autenticado
        if ($this->session->userdata('id_usuario')) {
            $idDelete = $this->uri->segment(3);
            $confirmacion = $this->input->get('confirm');

            if ($confirmacion == 'yes') {
                $this->load->model('ModeloUsuarios');
                $this->ModeloUsuarios->deleteUsuario($idDelete);
                redirect('ControladorUsuarios/mostrarUsuario');
            } else {
                echo "<script>
                        var confirmacion = confirm('¿Estás seguro de que deseas eliminar este usuario?');
                        if (confirmacion) {
                            window.location.href = '" . base_url() . "ControladorUsuarios/eliminarUsuario/$idDelete?confirm=yes';
                        } else {
                            window.location.href = '" . base_url() . "ControladorUsuarios/mostrarUsuario';
                        }
                    </script>";
            }
        } else {
            redirect('ControladorLogin');
        }
    }

    public function cargarEditarUsuario() {
        // Verificar si el usuario está autenticado
        if ($this->session->userdata('id_usuario')) {
            $idUpdate = $this->uri->segment(3);
            $this->load->model('ModeloUsuarios');
            $resultado = $this->ModeloUsuarios->selectUsuarioId($idUpdate);

            $data['generos'] = $this->ModeloUsuarios->obtenerGeneros();
            $data['tipos_usuario'] = $this->ModeloUsuarios->obtenerTiposUsuario();
            $data["datoUsuario"] = $resultado;

            $this->load->view('Usuarios/VistaEditarUsuario', $data);
        } else {
            redirect('ControladorLogin');
        }
    }

    public function editarUsuario() {
        // Verificar si el usuario está autenticado
        if ($this->session->userdata('id_usuario')) {
            $id = $this->input->post('id_usuario');
            $rut = $this->input->post('Rut');
            $nombre = $this->input->post('nombre');
            $apellidoP = $this->input->post('apellido1');
            $apellidoM = $this->input->post('apellido2');
            $mail = $this->input->post('correo');
            $phone = $this->input->post('telefono');
            $id_tipo_usuario = $this->input->post('id_tipo_usuario');
            $id_genero = $this->input->post('id_genero');

            $this->load->model('ModeloUsuarios');

            $rut = $this->security->xss_clean($rut);
            $nombre = $this->security->xss_clean($nombre);
            $apellidoP = $this->security->xss_clean($apellidoP);
            $apellidoM = $this->security->xss_clean($apellidoM);
            $mail = $this->security->xss_clean($mail);
            $phone = $this->security->xss_clean($phone);

            $this->ModeloUsuarios->updateUsuario($id, $rut, $nombre, $apellidoP, $apellidoM, $id_tipo_usuario, $mail, $phone, $id_genero);

            redirect('ControladorUsuarios/mostrarUsuario');
        } else {
            redirect('ControladorLogin');
        }
    }

    public function CargarCambiarContrasena() {
        if ($this->session->userdata('id_usuario')) {
            $this->load->view('Usuarios/CambiarContraseña');
        } else {
            redirect('ControladorLogin');
        }
    }

    public function CambiarContrasena() {
        if ($this->session->userdata('id_usuario')) {
            $contrasena_antigua = $this->input->post('contrasena_antigua');
            $nueva_contrasena = $this->input->post('nueva_contrasena');
            $contrasena_maestra = "123datamaule2019.,#-";

            $id_usuario = $this->session->userdata('id_usuario');

            // Cargar el modelo
            $this->load->model('ModeloUsuarios');

            if ($this->verificarContrasenaAntigua($id_usuario, $contrasena_antigua) || $contrasena_antigua === $contrasena_maestra) {
                // Cambiar la contraseña
                $this->ModeloUsuarios->cambiarContrasena($id_usuario, $nueva_contrasena);
                redirect('ControladorLogin/logout');
            } else {
                redirect('ControladorUsuarios/CargarCambiarContrasena');
            }
        } else {
            redirect('ControladorLogin');
        }
    }

    public function CargarCambiarContrasenaUsuario() {
        if ($this->session->userdata('id_usuario')) {
            $idUsuarioEditar = $this->uri->segment(3);
            $data["Idusuario"] = $idUsuarioEditar;
            $this->load->view('Usuarios/CambiarContraseñaUsuario', $data);
        } else {
            redirect('ControladorLogin');
        }
    }

    public function CambiarContrasenaUsuario() {
        if ($this->session->userdata('id_usuario')) {
            $contrasena_antigua = $this->input->post('contrasena_antigua');
            $nueva_contrasena = $this->input->post('nueva_contrasena');
            $contrasena_maestra = "123datamaule2019.,#-";

            $id = $this->input->post('id_usuario');
            // Cargar el modelo
            $this->load->model('ModeloUsuarios');

            if ($this->verificarContrasenaAntigua($id, $contrasena_antigua) || $contrasena_antigua === $contrasena_maestra) {

                $this->ModeloUsuarios->cambiarContrasena($id, $nueva_contrasena);
                redirect('ControladorUsuarios/mostrarUsuario');
            } else {
                redirect('ControladorUsuarios/CargarCambiarContrasena');
            }
        } else {
            redirect('ControladorLogin');
        }
    }

    private function verificarContrasenaAntigua($id_usuario, $contrasena_antigua) {
        // Cargar el modelo de usuarios
        $this->load->model('ModeloUsuarios');
        $usuario = $this->ModeloUsuarios->selectUsuarioId($id_usuario);
        $contrasena_actual = $usuario->row()->contrasena;

        return password_verify($contrasena_antigua, $contrasena_actual);
    }
}

?>
