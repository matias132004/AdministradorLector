<?php

class ControladorConfiguracionPromocion extends CI_Controller {

    public function index() {
        if ($this->session->userdata('id_usuario')) {
            $this->load->view('base.php');
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function CargarPromocionConfiguracion() {
        if ($this->session->userdata('id_usuario')) {
            $idUsuario = $this->session->userdata('id_usuario');
            $this->load->model('ModeloConfiguracionPromocion');
            $configuraciones = $this->ModeloConfiguracionPromocion->selectConfiguracionPromocion($idUsuario);
            $opciones_fuente = $this->ModeloConfiguracionPromocion->selectFontFamilyOptions();
            $destacados = $this->ModeloConfiguracionPromocion->selectDestacados();
            // Pasa los datos de configuración a la vista
            $data['configuraciones'] = $configuraciones;
            $data['fuentes'] = $opciones_fuente;
            $data['destacados'] = $destacados;
    
            $this->load->view('Promociones/ConfiguracionPromocion.php', $data);
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }
    
    

    public function ModificarConfiguracion() {
        if ($this->session->userdata('id_usuario')) {
            // Obtener los datos del formulario
            $idUsuario = $this->session->userdata('id_usuario');
            $camponombre = $this->input->post('camponombre');
            $colorPrincipal = $this->input->post('colorPrincipal');
            $colorPrincipal = $this->input->post('colorPrincipal');
            $colorSecundario = $this->input->post('colorSecundario');
            $colorFuentePrincipal = $this->input->post('colorFuentePrincipal');
            $colorFuenteSecundario = $this->input->post('colorFuenteSecundario');
            $tiempoesperaMs = $this->input->post('tiempoespera');
            $fontFamily = $this->input->post('fontFamily');
            $iddestacado = $this->input->post('destacado');
            $tiempoespera = $tiempoesperaMs * 1000;
            $this->load->model('ModeloConfiguracionPromocion');
            $id_datos_local = $this->ModeloConfiguracionPromocion->selectIdlocal($idUsuario);
            
            // Actualizar los datos en la base de datos
            $this->ModeloConfiguracionPromocion->updateConfiguracion($id_datos_local,$camponombre, $colorPrincipal, $colorSecundario, $colorFuentePrincipal, $colorFuenteSecundario, $fontFamily,$tiempoespera,$iddestacado);

            // Redireccionar o mostrar un mensaje de éxito
            redirect('ControladorConfiguracionPromocion/CargarPromocionConfiguracion');
        } else {
            redirect('ControladorLogin');
        }
    }
    
    
}
