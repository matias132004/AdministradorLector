<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ControladorEstadisticas extends CI_Controller {

    public function __construct() {
        parent::__construct();
        // Cargar el modelo
        $this->load->model('ModeloEstadisticas');
    }

    public function index() {
        // Obtener datos de estadísticas desde el modelo
        $data['resultados'] = $this->ModeloEstadisticas->obtener_datos_estadisticas();
        $data['resultados_pie'] = $this->ModeloEstadisticas->obtener_productos_meses();
        // Cargar la vista
        $this->load->view('Estadisticas/Estadisticas', $data);
    }
}
