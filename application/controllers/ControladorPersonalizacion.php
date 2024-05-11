<?php

class ControladorPersonalizacion extends CI_Controller {

    public function __construct() {
        parent::__construct();
        // Cargar librería de sesión
        $this->load->library('session');
        $this->load->model('ModeloPersonalizacion');
        $this->load->helper(array('form', 'url'));
    }

    public function cargarEditarLocal() {
        if ($this->session->userdata('id_usuario')) {
            $idUpdate = $this->session->userdata('id_usuario');

            $datosLocal = $this->ModeloPersonalizacion->selectPersonalizacion($idUpdate);
            $id_datos_local = $datosLocal['id_datos_local'];

            $imagen = $this->ModeloPersonalizacion->obtenerImagenLocal($id_datos_local);

            $data["datosLocal"] = $datosLocal;
            $data["imagen"] = $imagen;

            // Cargar la vista con los datos
            $this->load->view('Personalizacion/ModificarDatos', $data);
        } else {
            // Si el usuario no está autenticado, redirigir al inicio de sesión
            redirect('ControladorLogin');
        }
    }


    public function guardarCambios() {
        $id_datos_local = $this->input->post('id_datos_local');
        $nombre = $this->input->post('nombre');
        $descripcion = $this->input->post('Descripcion');
        $logo = $this->input->post('logo_act') == 'on' ? 't' : 'f';

        if ($this->ModeloPersonalizacion->guardarCambios($id_datos_local, $nombre, $descripcion, $logo)) {
            redirect('ControladorMenu/index');
        } else {
            $this->load->view('Personalizacion/errorCarga');
        }
    }

    public function ActualizarImagenLocal() {
        if ($this->session->userdata('id_usuario')) {
            $id_datos_local = $this->input->post('id_datos_local2');
            $id = $this->input->post('id');

            $config['upload_path'] = './uploads/DatosLocal';
            $config['allowed_types'] = 'gif|jpg|png';
            $config['max_size'] = 700000;
            $config['max_width'] = 700000;
            $config['max_height'] = 700000;

            $this->load->library('upload');
            $this->upload->initialize($config);

            if (empty($_FILES['imagenes']['name'])) {

                $error = 'No se seleccionó ningún archivo para cargar.';
                $this->load->view('Personalizacion/errorCarga', array('error' => $error));
            } else {
                if ($this->upload->do_upload('imagenes')) {
                    // La imagen se ha cargado correctamente
                    $upload_data = $this->upload->data();
                    $nombre = $upload_data['file_name'];
                    $imagen_data = file_get_contents($upload_data['full_path']);
                    $img_tipo = 2;

                    $imagen = $this->ModeloPersonalizacion->obtenerImagenLocal($id_datos_local);

                    if (!isset($imagen)) {
                        $this->load->model('ModeloPersonalizacion');
                        $this->ModeloPersonalizacion->guardarImagen($id_datos_local, $nombre, $imagen_data, $img_tipo);
                        // Redirigir a la página de edición del local
                        redirect('ControladorPersonalizacion/cargarEditarLocal');
                    } else {
                        $this->load->model('ModeloPersonalizacion');
                        $this->ModeloPersonalizacion->updateImagenDatosLocal($id_datos_local, $nombre, $imagen_data, $img_tipo,$id);
                        // Redirigir a la página de edición del local
                        redirect('ControladorPersonalizacion/cargarEditarLocal');
                    }
                } else {
                    // La carga de la imagen falló, muestra un mensaje de error
                    $error = array('error' => $this->upload->display_errors());
                    $this->load->view('Personalizacion/errorCarga', $error);
                }
            }
        } else {

            redirect('ControladorLogin');
        }
    }

    public function CargarImagenesFondo() {
        if ($this->session->userdata('id_usuario')) {
            $id_datos_local = $this->uri->segment(3);

            $imagenes_fondo = $this->ModeloPersonalizacion->obtenerImagenesFondo($id_datos_local);

            $data['imagenes_fondo'] = $imagenes_fondo;
            $data['datos_local'] = $id_datos_local;

            $this->load->view('Personalizacion/ImagenesFondo', $data);
        } else {
            redirect('ControladorLogin');
        }
    }

    public function actualizarImagenesFondo() {
        if ($this->session->userdata('id_usuario')) {
            $id_datos_local = $this->input->post('id_datos_local');

            $config['upload_path'] = './uploads/DatosLocal';
            $config['allowed_types'] = 'gif|jpg|png';
            $config['max_size'] = 700000;
            $config['max_width'] = 700000;
            $config['max_height'] = 700000;

            $this->load->library('upload');
            $this->upload->initialize($config);

            if (empty($_FILES['imagenes']['name'])) {
                // No se seleccionó ningún archivo, muestra un mensaje de error
                $error = 'No se seleccionó ningún archivo para cargar.';
                $this->load->view('Personalizacion/errorCarga', array('error' => $error));
            } else {
                if ($this->upload->do_upload('imagenes')) {

                    $upload_data = $this->upload->data();
                    $nombre = $upload_data['file_name'];
                    $imagen_data = file_get_contents($upload_data['full_path']);
                    $img_tipo = 1;

                    $this->load->model('ModeloPersonalizacion');
                    $this->ModeloPersonalizacion->guardarImagen($id_datos_local, $nombre, $imagen_data, $img_tipo);
                    // Redirigir a la página de edición del local
                    redirect('ControladorPersonalizacion/cargarEditarLocal');
                } else {
                    // La carga de la imagen falló, muestra un mensaje de error
                    $error = array('error' => $this->upload->display_errors());
                    $this->load->view('Personalizacion/errorCarga', $error);
                }
            }
        } else {
            redirect('ControladorLogin');
        }
    }
    
    
    
    
        public function EliminarImagenFondo() {

        if ($this->session->userdata('id_usuario')) {
            $id_images = $this->uri->segment(3);

            $this->load->model('ModeloPromocion');
            $this->ModeloPersonalizacion->deletePersonalizacionFondo($id_images);

            redirect('ControladorMenu/index');
        } else {
            redirect('ControladorLogin');
        }
    }
}
