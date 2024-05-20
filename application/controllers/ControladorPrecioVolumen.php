<?php

class ControladorPrecioVolumen extends CI_Controller
{

    public function index()
    {
        $this->load->view('base.php');
    }

    public function AgregarPrecioVolumen()
    {
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloPrecioVolumen');
            $resultado = $this->ModeloPrecioVolumen->selectProducto();
            $data['datos'] = $resultado;
            $this->load->view('PrecioVolumen/CrearPrecioVolumen', $data);
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function GuardarPrecioVolumen()
    {
        if ($this->session->userdata('id_usuario')) {

            $id_producto = $this->input->post('CampoIdProducto');
            $desde = $this->input->post('CampoDesde');
            $hasta = $this->input->post('CampoHasta');
            $precio = $this->input->post('CampoPrecio');

            $this->load->model('ModeloPrecioVolumen');
            $this->ModeloPrecioVolumen->insertPrecioVolumen($id_producto, $desde, $hasta, $precio);

            redirect('ControladorPrecioVolumen/MostrarPrecioVolumen');
        } else {
            redirect('ControladorLogin');
        }
    }

    public function MostrarPrecioVolumen()
    {
        if ($this->session->userdata('id_usuario')) {

            $this->load->model('ModeloPrecioVolumen');

            $data['datos'] = $this->ModeloPrecioVolumen->selectPrecioVolumen();
            $this->load->view('PrecioVolumen/MostrarPrecioVolumen', $data);
        } else {
            redirect('ControladorLogin');
        }
    }

    public function eliminarPrecioVolumen()
    {
        if ($this->session->userdata('id_usuario')) {
            $idDelete = $this->uri->segment(3);

            $this->load->model('ModeloPrecioVolumen');
            $this->ModeloPrecioVolumen->deletePrecioVolumen($idDelete);
            redirect('ControladorPrecioVolumen/MostrarPrecioVolumen');
        } else {
            redirect('ControladorLogin');
        }
    }

    public function deshabilitarPrecioVolumen()
    {
        if ($this->session->userdata('id_usuario')) {
            $idDelete = $this->uri->segment(3);
            $this->load->model('ModeloPrecioVolumen');
            $this->ModeloPrecioVolumen->deshabilitarPrecioVolumen($idDelete);

            redirect('ControladorPrecioVolumen/MostrarPrecioVolumen');
        } else {
            redirect('ControladorLogin');
        }
    }

    public function cargarEditarPrecioVolumen()
    {
        if ($this->session->userdata('id_usuario')) {

            $idUpdate = $this->uri->segment(3);

            $this->load->model('ModeloPrecioVolumen');
            $resultado = $this->ModeloPrecioVolumen->selectPrecioVolumenId($idUpdate);

            $data["datoPrecioVolumen"] = $resultado;

            $this->load->view('PrecioVolumen/ModificarPrecioVolumen', $data);
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function editarPrecioVolumen()
    {
        if ($this->session->userdata('id_usuario')) {

            $id_precio_volumen = $this->input->post('CampoHidden');
            $id_estado = $this->input->post('CampoEstado');
            $desde = $this->input->post('CampoDesde');
            $hasta = $this->input->post('CampoHasta');
            $precio = $this->input->post('CampoPrecio');

            $this->load->model('ModeloPrecioVolumen');
            $this->ModeloPrecioVolumen->updatePrecioVolumen($id_precio_volumen, $desde, $hasta, $precio, $id_estado);

            redirect('ControladorPrecioVolumen/MostrarPrecioVolumen');
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function cargarEstado()
    {
        if ($this->session->userdata('id_usuario')) {

            $this->load->model('ModeloPrecioVolumen');
            $estado = $this->ModeloPrecioVolumen->obtenerEstado();
            echo json_encode($estado);
        } else {
            redirect('ControladorLogin');
        }
    }

    public function deleteTodo()
    {
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloPrecioVolumen');
            $this->load->model('ModeloUsuarios');

            $contrasena = $this->input->post('contrasena');
            $usuario_actual = $this->session->userdata('id_usuario');
            $usuario = $this->ModeloUsuarios->selectUsuarioId($usuario_actual);
            $contrasena_bd = $usuario->row()->contrasena;

            if (password_verify($contrasena, $contrasena_bd)) {
                if ($this->ModeloPrecioVolumen->deleteTodo()) {
                    redirect('ControladorPrecioVolumen/MostrarPrecioVolumen');
                } else {
                    echo "<script>
                        alert('Ocurrió un error al eliminar todos los registros de Precio Volumen.');
                        window.location.href = '" . base_url('ControladorPrecioVolumen/MostrarPrecioVolumen') . "';
                    </script>";
                }
            } else {
                echo "<script>
                    alert('La contraseña es incorrecta.');
                    window.location.href = '" . base_url('ControladorPrecioVolumen/MostrarPrecioVolumen') . "';
                </script>";
            }
        } else {
            redirect('ControladorLogin');
        }
    }
}
