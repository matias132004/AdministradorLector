<?php

class ControladorProducto extends CI_Controller {

    public function index() {
        
        if ($this->session->userdata('id_usuario')) {
            $this->load->view('base.php');
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function AgregarProducto() {
        // Verificar si el usuario está autenticado
        if ($this->session->userdata('id_usuario')) {
            $this->load->view('Productos/CrearProducto');
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

public function GuardarProducto() {
    // Verificar si el usuario está autenticado
    if ($this->session->userdata('id_usuario')) {
        $nombre_producto = $this->input->post('CampoNombreProducto');
        $id_familia = $this->input->post('CampoNombreFamilia');
        $cbarra = $this->input->post('CampoCodBarra');
        $id_umedida = $this->input->post('CampoTmedida');
        $total = $this->input->post('CampoPrecio');
        $id_estado = $this->input->post('CampoEstado');

        // Verificar si el código de barras ya existe
        $this->load->model('ModeloProducto');
        if ($this->ModeloProducto->comprobarCbarra($cbarra)) {
            // Set alert message
            $alert_message = "No se puede guardar el producto porque el código de barras ya existe.";
        } else {
            $this->ModeloProducto->insertProducto($nombre_producto, $id_familia, $cbarra, $id_umedida, $total, $id_estado);
            // Set success message or any other logic after successful insertion
            $alert_message = "El producto se ha guardado correctamente.";
        }

        // Pass the alert message to the view
        $data['alert_message'] = $alert_message;
        
        // Load the view with the alert message
        $this->load->view('Productos/CrearProducto', $data);
    } else {
        redirect('ControladorLogin'); 
    }
}


public function MostrarProducto() {
    if ($this->session->userdata('id_usuario')) {
        $this->load->view('Productos/MostrarProducto');
    } else {
        redirect('ControladorLogin');
    }
}
public function MostrarProductoAjax() {
    if ($this->session->userdata('id_usuario')) {
        $this->load->model('ModeloProducto');
        $productos = $this->ModeloProducto->selectProducto();
        
        // Devolver los datos en formato JSON
        echo json_encode($productos);
    } else {
        // Si no está autenticado, devolver un mensaje de error
        echo json_encode(['error' => 'No autenticado']);
    }
}


    public function eliminarProducto() {
      
        if ($this->session->userdata('id_usuario')) {
            $idDelete = $this->uri->segment(3);

            $this->load->model('ModeloProducto');
            $this->ModeloProducto->deleteproducto($idDelete);

            redirect('ControladorProducto/MostrarProducto');
        } else {
            redirect('ControladorLogin');
        }
    }

    public function cargarEditarProducto() {

        if ($this->session->userdata('id_usuario')) {
            $idUpdate = $this->uri->segment(3);

            $this->load->model('ModeloProducto');
            $resultado = $this->ModeloProducto->selectProductoId($idUpdate)->row_array();
            $data['Umedidas'] = $this->ModeloProducto->obtenerUmedida();
            $data['familias'] = $this->ModeloProducto->obtenerFamilia();
            $data['Estados'] = $this->ModeloProducto->obtenerEstado();
            $data["datos"] = $resultado;

            $this->load->view('Productos/ModificarProducto', $data);
        } else {
            redirect('ControladorLogin');
        }
    }

    public function editarProducto() {
        if ($this->session->userdata('id_usuario')) {
            $id_producto = $this->input->post('CampoHidden');
            $nombre_producto = $this->input->post('CampoNombreProducto');
            $id_familia = $this->input->post('CampoNombreFamilia');
            $cbarra = $this->input->post('CampoCodBarra');
            $id_umedida = $this->input->post('CampoUmedida');
            $total = $this->input->post('CampoPrecio');
            $id_estado = $this->input->post('CampoEstado');

            $this->load->model('ModeloProducto');
            $this->ModeloProducto->updateProducto($id_producto, $nombre_producto, $id_familia, $cbarra, $id_umedida, $total, $id_estado);

            redirect('ControladorProducto/mostrarProducto');
        } else {
            redirect('ControladorLogin'); 
        }
    }

    public function cargarEstado() {
     
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloProducto');
            $estado = $this->ModeloProducto->obtenerEstado();
            echo json_encode($estado);
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function cargarUmedida() {
        // Verificar si el usuario está autenticado
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloProducto');
            $id_umedida = $this->ModeloProducto->obtenerUmedida();
            echo json_encode($id_umedida);
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }

    public function cargarFamilia() {
        // Verificar si el usuario está autenticado
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloProducto');
            $id_familia = $this->ModeloProducto->obtenerFamilia();
            echo json_encode($id_familia);
        } else {
            redirect('ControladorLogin'); // Redireccionar al controlador de login si no está autenticado
        }
    }
    public function deleteTodo()
    {
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloProducto');
    
            if (!$this->ModeloProducto->comprobarPromocionAsociados()) {
                  if ($this->ModeloProducto->deleteTodo()) {
                    // Éxito en la eliminación
                    redirect('ControladorProducto/MostrarProducto');
                } else {
                    // Error en la eliminación
                    echo "<script>
                        alert('Ocurrió un error al eliminar todos los productos.');
                        window.location.href = '" . base_url('ControladorProducto/MostrarProducto') . "';
                    </script>";
                }
            } else {
                // Hay productos asociados, mostrar mensaje de advertencia
                echo "<script>
                    if (confirm('No puede realizar la eliminación permanente de los Productos ya que tiene promociones asociados.')) {
                        window.location.href = '" . base_url('ControladorProducto/MostrarProducto') . "';
                    } else {
                        window.location.href = '" . base_url('ControladorProducto/MostrarProducto') . "';
                    }
                </script>";
            }
        } else {
            redirect('ControladorLogin');
        }
    }
}


