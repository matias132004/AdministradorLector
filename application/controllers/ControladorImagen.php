<?php

class ControladorImagen extends CI_Controller
{


    public function __construct()
    {
        parent::__construct();
        $this->load->helper(array('form', 'url'));
    }

    public function index()
    {
        $this->load->view('CrearPromocion', array('error' => ' '));
    }

    public function AgregarImagenCargar()
    {
        if ($this->session->userdata('id_usuario')) {
            $idPromocion = $this->uri->segment(3);
            $data['idPromocion'] = $idPromocion;


            $this->load->model('ModeloImages');
            $imagenExistente = $this->ModeloImages->obtenerImagenPorPromocion($idPromocion);


            if (!$imagenExistente) {
                $this->load->view('Promociones/AgregarImagenPromocion', $data);
            } else {

                redirect('ControladorImagen/CargarEditarImagen/' . $idPromocion);
            }
        } else {
            redirect('ControladorLogin');
        }
    }
    public function CargarEditarImagen($id_promocion)
    {
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloImages');
            $imagen = $this->ModeloImages->obtenerImagenPorPromocion($id_promocion);
            if ($imagen) {

                $data['imagen'] = $imagen;
                $this->load->view('Promociones/EditarImagenPromocion', $data);
            } else {
                redirect('ControladorImagen/AgregarImagenCargar/' . $id_promocion);
            }
        } else {
            redirect('ControladorLogin');
        }
    }

    public function ActualizarImagenPromocion()
    {
        if ($this->session->userdata('id_usuario')) {
            $id_promocion = $this->input->post('id_promocion');


            $config['upload_path'] = './uploads/Promocion';
            $config['allowed_types'] = 'gif|jpg|png';
            $config['max_size'] = 700000;
            $config['max_width'] = 700000;
            $config['max_height'] = 700000;

            $this->load->library('upload');
            $this->upload->initialize($config);
            if (!$this->upload->do_upload('image')) {
                // Manejar errores de carga si los hay
                $error = array('error' => $this->upload->display_errors());
                $this->load->view('Promociones/errorCarga', $error);
            } else {
                // Obtener datos de la imagen cargada
                $upload_data = $this->upload->data();
                $nombre = $upload_data['file_name'];
                $datos = file_get_contents($upload_data['full_path']);
                $datos_utf8 = mb_convert_encoding($datos, 'UTF-8');

                $this->load->model('ModeloImages');
                $this->ModeloImages->actualizarImagen($nombre, $datos_utf8, $id_promocion);

                // Redireccionar a la página de visualización de promociones
                redirect('ControladorPromocion/MostrarPromocion');
            }
        } else {
            // Si no hay sesión de usuario, redireccionar al inicio de sesión
            redirect('ControladorLogin');
        }
    }


    public function upload()
    {
        $config['upload_path'] = './uploads/Promocion';
        $config['allowed_types'] = 'gif|jpg|png';
        $config['max_size'] = 700000;
        $config['max_width'] = 700000;
        $config['max_height'] = 700000;

        $this->load->library('upload');
        $this->upload->initialize($config);

        if (!$this->upload->do_upload('image')) {
            $error = array('error' => $this->upload->display_errors());
            $this->load->view('Promociones/errorCarga', $error);
        } else {
            $upload_data = $this->upload->data();
            $nombre = $upload_data['file_name'];
            $datos = file_get_contents($upload_data['full_path']);

            // Convertir los datos a UTF-8 directamente
            $datos_utf8 = mb_convert_encoding($datos, 'UTF-8');

            $this->load->model('ModeloImages');
            $id_promocion = $this->input->post('id_promocion');
            $this->ModeloImages->insertarImagen($nombre, $datos_utf8, $id_promocion);

            redirect('ControladorPromocion/MostrarPromocion');
        }
    }
    public function EliminarImagenPromocion($id_promocion)
    {
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloImages');
            // Obtener la imagen por su ID de promoción
            $imagen = $this->ModeloImages->obtenerImagenPorPromocion($id_promocion);
            if ($imagen) {
                // Eliminar la imagen de la base de datos
                $this->ModeloImages->eliminarImagen($id_promocion);
                // Redirigir a la página de visualización de promociones
                redirect('ControladorPromocion/MostrarPromocion');
            } else {
                // Redirigir si la imagen no existe o no se puede eliminar
                redirect('ControladorPromocion/MostrarPromocion');
            }
        } else {
            // Si no hay sesión de usuario, redireccionar al inicio de sesión
            redirect('ControladorLogin');
        }
    }
}
