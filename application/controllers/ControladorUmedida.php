<?php

class ControladorUmedida extends CI_Controller
{

    public function index()
    {
        $this->load->view('base.php');
    }

    public function AgregarUmedida()
    {
        if ($this->session->userdata('id_usuario')) {
            $this->load->view('Umedida/CrearUmedida');
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function GuardarUmedida()
    {
        if ($this->session->userdata('id_usuario')) {

            $nombre_umedida = $this->input->post('CampoNombreUmedida');
            $nombre_corto = $this->input->post('CampoNombreCorto');
            $id_estado = 1;

            $this->load->model('ModeloUmedida');
            $this->ModeloUmedida->insertUmedida($nombre_umedida, $nombre_corto, $id_estado);

            redirect('ControladorUmedida/MostrarUmedida');
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function MostrarUmedida()
    {
        if ($this->session->userdata('id_usuario')) {

            $this->load->model('ModeloUmedida');

            $data['datos'] = $this->ModeloUmedida->selectUmedida();
            $this->load->view('Umedida/MostrarUmedida', $data);
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function eliminarUmedida()
    {
        if ($this->session->userdata('id_usuario')) {
            $idDelete = $this->uri->segment(3);
    
            $this->load->model('ModeloUmedida');
            $existe = $this->ModeloUmedida->comprobar($idDelete);
    
            if (isset($existe) && $existe == 0) {
                $this->ModeloUmedida->deleteUmedida($idDelete);
                redirect('ControladorUmedida/MostrarUmedida');
            } else {
                echo "<script>
                    if (confirm('No puede realizar la eliminación permanente de la unidad de medida ya que tiene productos asociados.')) {
                        window.location.href = '" . base_url('ControladorUmedida/MostrarUmedida') . "';
                    } else {
                        window.location.href = '" . base_url('ControladorUmedida/MostrarUmedida') . "';
                    }
                </script>";
            }
        } else {
            redirect('ControladorLogin');
        }
    }
    

    public function deshabilitarUmedida()
    {
        if ($this->session->userdata('id_usuario')) {
            $idDelete = $this->uri->segment(3);
            $this->load->model('ModeloUmedida');
            $this->ModeloUmedida->deshabilitarUmedida($idDelete);

            redirect('ControladorUmedida/MostrarUmedida');
        } else {
            redirect('ControladorLogin');
        }
    }

    public function cargarEditarUmedida()
    {
        if ($this->session->userdata('id_usuario')) {

            $idUpdate = $this->uri->segment(3);

            $this->load->model('ModeloUmedida');
            $resultado = $this->ModeloUmedida->selectUmedidaId($idUpdate);

            $data["datoUmedida"] = $resultado;

            $this->load->view('Umedida/ModificarUmedida', $data);
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function editarUmedida()
    {
        if ($this->session->userdata('id_usuario')) {


            $id_umedida = $this->input->post('CampoHidden');
            $nombre_umedida = $this->input->post('CampoNombreUmedida');
            $nombre_corto = $this->input->post('CampoNombreCorto');
            $id_estado = $this->input->post('CampoEstado');

            $this->load->model('ModeloUmedida');
            $this->ModeloUmedida->updateUmedida($id_umedida, $nombre_umedida, $nombre_corto, $id_estado);

            redirect('ControladorUmedida/MostrarUmedida');
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function cargarEstado()
    {
        if ($this->session->userdata('id_usuario')) {

            $this->load->model('ModeloUmedida');
            $estado = $this->ModeloUmedida->obtenerEstado();
            echo json_encode($estado);
        } else {
            redirect('ControladorLogin');
        }
    }

    public function deleteTodo()
    {
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloUmedida');
            $this->load->model('ModeloUsuarios');
            $contrasena = $this->input->post('contrasena');
            $usuario_actual = $this->session->userdata('id_usuario');
            $usuario = $this->ModeloUsuarios->selectUsuarioId($usuario_actual);
            $contrasena_bd = $usuario->row()->contrasena;
    
            // Verificar si la contraseña proporcionada coincide con la contraseña del usuario actual
            if (password_verify($contrasena, $contrasena_bd)) {
                // Verificar si hay productos asociados a las unidades de medida
                if (!$this->ModeloUmedida->comprobarProductosAsociados()) {
                    // Eliminar todas las unidades de medida
                    if ($this->ModeloUmedida->deleteTodo()) {
                        redirect('ControladorUmedida/MostrarUmedida');
                    } else {
                        // Error en la eliminación
                        echo "<script>
                            alert('Ocurrió un error al eliminar todas las unidades de medida.');
                            window.location.href = '" . base_url('ControladorUmedida/MostrarUmedida') . "';
                        </script>";
                    }
                } else {
                    // Hay productos asociados, mostrar mensaje de advertencia
                    echo "<script>
                        if (confirm('No puede realizar la eliminación permanente de la unidad de medida ya que tiene productos asociados.')) {
                            window.location.href = '" . base_url('ControladorUmedida/MostrarUmedida') . "';
                        } else {
                            window.location.href = '" . base_url('ControladorUmedida/MostrarUmedida') . "';
                        }
                    </script>";
                }
            } else {
                // Contraseña incorrecta
                echo "<script>
                alert('La contraseña es incorrecta.');
                window.location.href = '" . base_url('ControladorUmedida/MostrarUmedida') . "';
            </script>";
            }
        } else {
            redirect('ControladorLogin');
        }
    }
    
    
}
