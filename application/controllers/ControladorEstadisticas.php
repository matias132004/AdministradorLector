<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class ControladorEstadisticas extends CI_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('ModeloEstadisticas');
    }

    public function index() {
        $data['resultados_pie'] = $this->ModeloEstadisticas->obtener_datos_estadisticas();
        $data['resultados_bar'] = $this->ModeloEstadisticas->obtener_productos_meses();
        $this->load->view('Estadisticas/Estadisticas', $data);
    }
    

    public function obtenerEscaneosPorCodigoBarras() {
        $codigoBarras = $this->input->post('searchTerm');
        $escaneos = $this->ModeloEstadisticas->obtenerEscaneosPorCodigoBarras($codigoBarras);
        echo json_encode($escaneos);
    }
}
?>
