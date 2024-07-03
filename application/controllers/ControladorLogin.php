<?php
class ControladorLogin extends CI_Controller {
    public function index() {

        $this->load->model('ModeloLogin');
        

        $nombre_equipo = gethostname();

        $sesion_activa = $this->ModeloLogin->verificarSesionActivaPorEquipo($nombre_equipo);

        if ($sesion_activa) {

            if ($sesion_activa->termino == 'f' && empty($sesion_activa->fecha_termino) && $sesion_activa->nombre_equipo == $nombre_equipo) {
 
                $session_data = array(
                    'id_usuario' => $sesion_activa->id_usuario,
                    'rut' => $sesion_activa->rut,
                    'id_sesion' => $sesion_activa->id_sesion
                );
                $this->session->set_userdata($session_data);
                redirect('ControladorMenu/index'); 
            }
        }

        $this->load->view('Login.php');
    }

    public function login() {
        $rut = $this->input->post('rut');
        $password = $this->input->post('password');
    
        $this->load->model('ModeloLogin');
    
        $user = $this->ModeloLogin->iniciarSesion($rut);
    
        if ($user === '1') {
            $data['error'] = 'Sistema Bloqueado por no pago.';
            $this->load->view('Login.php', $data);
            return; 
        }
        
        if ($user !== false && property_exists($user, 'contrasena') && password_verify($password, $user->contrasena)) {

            $sesion_activa = $this->ModeloLogin->verificarSesionActiva($user->id_usuario);

            if (!$sesion_activa) {

                $nombre_equipo = gethostname();
                $id_sesion = $this->ModeloLogin->registrarSesion($user->id_usuario, $nombre_equipo);

                if ($id_sesion) {
                    $session_data = array(
                        'id_usuario' => $user->id_usuario,
                        'rut' => $user->rut,
                        'id_sesion' => $id_sesion
                    );
                    $this->session->set_userdata($session_data);
                    redirect('ControladorMenu/index');
                } else {
                    $data['error'] = 'Error al crear sesión.';
                    $this->load->view('Login.php', $data);
                }
            } else {
                $session_data = array(
                    'id_usuario' => $user->id_usuario,
                    'rut' => $user->rut,
                    'id_sesion' => $sesion_activa->id_sesion
                );
                $this->session->set_userdata($session_data);
                redirect('ControladorMenu/index');
            }
        } else {
            $data['error'] = 'Usuario o contraseña incorrectos.';
            $this->load->view('Login.php', $data);
        }
    }
    
    public function logout() {
        $id_sesion = $this->session->userdata('id_sesion');
        
        if ($id_sesion) {
            $this->load->model('ModeloLogin');
            $this->ModeloLogin->cerrarSesion($id_sesion);
        }

        $this->session->unset_userdata('id_usuario');
        $this->session->unset_userdata('id_sesion');
        $this->session->sess_destroy();
        redirect('ControladorLogin/index');
    }
}
?>
