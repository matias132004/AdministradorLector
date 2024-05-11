<?php
class ControladorMenu extends CI_Controller {

    public function index() {
          if ($this->session->userdata('id_usuario')) {
        $this->load->view('Operabilidad/operabilidad.php');
         } else {
            redirect('ControladorLogin');
        }
    }  

}