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
        $data['resultados_pie'] = $this->ModeloEstadisticas->obtener_datos_estadisticas();
        // Cargar la vista
        $this->load->view('Estadisticas/Estadisticas', $data);
    }


    
    public function obtenerEscaneosPorCodigoBarras() {
        $codigoBarras = $this->input->post('searchTerm');
        $this->load->model('ModeloEscaneados');
        $escaneos = $this->ModeloEscaneados->obtenerEscaneosPorCodigoBarras($codigoBarras);
        // Procesar los resultados según sea necesario
        // Por ejemplo, pasarlos a la vista
        $data['escaneos'] = $escaneos;
        $this->load->view('Estadisticas/TablaEscaneos', $data);
    }
    
    
    
}
