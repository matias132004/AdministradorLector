<?php

class ControladorConfiguracion extends CI_Controller {

    public function index() {
        if ($this->session->userdata('id_usuario')) {
            $this->load->view('base.php');
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }
    
    public function __construct() {
        parent::__construct();
        // Cargar el modelo de configuración
        $this->load->model('ModeloConfiguracion');
    }

    public function cargarModificarConfiguraciones() {
        if ($this->session->userdata('id_usuario')) {
            $idusuario = $this->session->userdata('id_usuario');
               $this->load->model('ModeloConfiguracion');
            $Configuraciones = $this->ModeloConfiguracion->selectConfiguracion($idusuario);
            $Datosconfiguraciones['configuraciones'] = $Configuraciones;
            $this->load->view('Personalizacion/Configuracion.php',$Datosconfiguraciones);
        } else {

            redirect('ControladorLogin');
        }
}

    public function ModificarConfiguracion() {
        
        
        if ($this->session->userdata('id_usuario')) {
            
            $venta_volumen = $this->input->post('venta_volumen') ? 't' : 'f';
            $dictado_precios = $this->input->post('dictado_precios') ? 't' : 'f';
            $imagen_act = $this->input->post('imagen_act') ? 't' : 'f';
            $precio_old_act = $this->input->post('precio_old_act') ? 't' : 'f';
                $this->load->model('ModeloConfiguracion');
                $tiempoesperaMs = $this->input->post('tiempoespera');
                $tiempoespera = $tiempoesperaMs * 1000;
            $id_configuracion = $this->input->post('id_configuracion');

            $this->ModeloConfiguracion->updateConfiguracion($id_configuracion, $venta_volumen, $dictado_precios, $imagen_act, $tiempoespera , $precio_old_act);

    
            redirect('ControladorConfiguracion/cargarModificarConfiguraciones');
        } else {
           
            redirect('ControladorLogin');
        }
    }

}
