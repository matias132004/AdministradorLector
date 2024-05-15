<?php

class ControladorFamilia extends CI_Controller {

    public function index() {
        $this->load->view('base.php');
    }

    public function AgregarFamilia() {
        if ($this->session->userdata('id_usuario')) {
            $this->load->view('Familia/CrearFamilia');
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function GuardarFamilia() {
        if ($this->session->userdata('id_usuario')) {

            $nombre_familia = $this->input->post('CampoNombreFamilia');
            $id_estado = 1; // Este debe ser el ID del estado seleccionado

            $this->load->model('ModeloFamilia');
            $this->ModeloFamilia->insertFamilia($nombre_familia, $id_estado);

            redirect('ControladorFamilia/MostrarFamilia');
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function MostrarFamilia() {
        if ($this->session->userdata('id_usuario')) {

            $this->load->model('ModeloFamilia');

            $data['datos'] = $this->ModeloFamilia->selectFamilia();
            $this->load->view('Familia/MostrarFamilia', $data);
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function eliminarFamilia()
    {
        if ($this->session->userdata('id_usuario')) {
            $idDelete = $this->uri->segment(3);
                         
            $this->load->model('ModeloFamilia');
            $existe = $this->ModeloFamilia->comprobar($idDelete);
            
            if (isset($existe) && $existe == 0) {
                $this->ModeloFamilia->deleteFamilia($idDelete);
                redirect('ControladorFamilia/MostrarFamilia');
            } else if (isset($existe) && $existe > 0) {
                echo "<script>
                    if (confirm('No puede realizar la eliminación permanente de la familia ya que tiene productos asociados.')) {
                        window.location.href = '".base_url('ControladorFamilia/MostrarFamilia')."';
                    } else {
                        window.location.href = '".base_url('ControladorFamilia/MostrarFamilia')."';
                    }
                </script>";
            }
        } else {
            redirect('ControladorLogin'); 
        }
    }

    public function deshabilitarFamilia() {
        if ($this->session->userdata('id_usuario')) {
            $idDelete = $this->uri->segment(3);
            $this->load->model('ModeloFamilia');
            $this->ModeloFamilia->deshabilitarFamilia($idDelete);

            redirect('ControladorFamilia/MostrarFamilia');
        } else {
            redirect('ControladorLogin');
        }
    }

    public function cargarEditarFamilia() {
        if ($this->session->userdata('id_usuario')) {

            $idUpdate = $this->uri->segment(3);

            $this->load->model('ModeloFamilia');
            $resultado = $this->ModeloFamilia->selectFamiliaId($idUpdate);

            $data["datoFamilia"] = $resultado;

            $this->load->view('Familia/ModificarFamilia', $data);
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function editarFamilia() {
        if ($this->session->userdata('id_usuario')) {
            
        
        $id_familia = $this->input->post('CampoHidden');
        $nombre_familia = $this->input->post('CampoNombreFamilia');
        $id_estado = $this->input->post('CampoEstado');

        $this->load->model('ModeloFamilia');
        $this->ModeloFamilia->updateFamilia($id_familia, $nombre_familia, $id_estado);

        redirect('ControladorFamilia/MostrarFamilia');
        
         } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }

    }

    public function cargarEstado() {
        if ($this->session->userdata('id_usuario')) {
            
        $this->load->model('ModeloFamilia');
        $estado = $this->ModeloFamilia->obtenerEstado();
        echo json_encode($estado);
        
         } else {
            redirect('ControladorLogin');
        }
    }


    public function deleteTodo()
    {
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloFamilia');
            $this->load->model('ModeloUsuarios');

            $contrasena = $this->input->post('contrasena');
            $usuario_actual = $this->session->userdata('id_usuario');
            $usuario = $this->ModeloUsuarios->selectUsuarioId($usuario_actual);
            $contrasena_bd = $usuario->row()->contrasena;

       if (password_verify($contrasena, $contrasena_bd)) {
            if (!$this->ModeloFamilia->comprobarProductosAsociados()) {
               
                if ($this->ModeloFamilia->deleteTodo()) {
                    
                    redirect('ControladorFamilia/MostrarFamilia');
                } else {
                   
                    echo "<script>
                        alert('Ocurrió un error al eliminar todas las Familia.');
                        window.location.href = '" . base_url('ControladorFamilia/MostrarFamilia') . "';
                    </script>";
                }
            } else {
                
                echo "<script>
                    if (confirm('No puede realizar la eliminación permanente de las Familias ya que tienen productos asociados.')) {
                        window.location.href = '" . base_url('ControladorFamilia/MostrarFamilia') . "';
                    } else {
                        window.location.href = '" . base_url('ControladorFamilia/MostrarFamilia') . "';
                    }
                </script>";
            }
        }else {
                // Contraseña incorrecta
                echo "<script>
                alert('La contraseña es incorrecta.');
                window.location.href = '" . base_url('ControladorFamilia/MostrarFamilia') . "';
            </script>";
            }
        } else {
            redirect('ControladorLogin');
        }
    }

    
}
