<?php

class ControladorPromocion extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();
        // Cargar librería de sesión
        $this->load->library('session');
        $this->load->model('ModeloPromocion');
    }

    public function index()
    {
        if ($this->session->userdata('id_usuario')) {
            $this->load->view('Promocion/MostrarPromocion.php');
        } else {
            redirect('ControladorLogin');
        }
    }

    public function MostrarPromocion()
    {
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloPromocion');
            $data['promociones'] = $this->ModeloPromocion->obtenerPromociones();
            $this->load->view('Promociones/MostrarPromocion', $data);
        } else {
            redirect('ControladorLogin');
        }
    }




    public function AgregarPromocion()
    {
        if ($this->session->userdata('id_usuario')) {

            $this->load->model('ModeloProducto');

            $resultado = $this->ModeloProducto->selectProducto();
            $data['datos'] = $resultado;
            $this->load->view('Promociones/AgregarPromocion', $data);
        } else {
            redirect('ControladorLogin');
        }
    }

    public function GuardarPromocion()
    {
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloPromocion');

            // Obtener los datos del formulario
            $id_producto = $this->input->post('id_producto');
            $fecha_inicio = $this->input->post('fecha_inicio');
            $fecha_termino = $this->input->post('fecha_termino');
            $lunes = boolval($this->input->post('lunes'));
            $martes = boolval($this->input->post('martes'));
            $miercoles = boolval($this->input->post('miercoles'));
            $jueves = boolval($this->input->post('jueves'));
            $viernes = boolval($this->input->post('viernes'));
            $sabado = boolval($this->input->post('sabado'));
            $domingo = boolval($this->input->post('domingo'));
            $descripcion = $this->input->post('descripcion');

            $existePromocion = $this->ModeloPromocion->existePromocion($id_producto);
            if ($existePromocion) {
                echo "<script>
            if (confirm('No puede realizar la creación de la promoción ya que existe una promoción con el producto asociado.')) {
                window.location.href = '" . base_url('ControladorPromocion/AgregarPromocion') . "';
            } else {
                window.location.href = '" . base_url('ControladorPromocion/AgregarPromocion') . "';
            }
          </script>";
            } else {
                $this->ModeloPromocion->guardarPromocion($id_producto, $fecha_inicio, $fecha_termino, $lunes, $martes, $miercoles, $jueves, $viernes, $sabado, $domingo, $descripcion);
                redirect('ControladorPromocion/MostrarPromocion');
            }
        } else {
            redirect('ControladorLogin');
        }
    }

    public function cargarEditarPromocion()
    {
        // Verificar si el usuario está autenticado
        if ($this->session->userdata('id_usuario')) {
            $idUpdate = $this->uri->segment(3);

            $this->load->model('ModeloPromocion');
            $resultado = $this->ModeloPromocion->selectPromocionId($idUpdate);

            $resultado['fecha_inicio'] = date('Y-m-d', strtotime($resultado['fecha_inicio']));
            $resultado['fecha_fin'] = date('Y-m-d', strtotime($resultado['fecha_fin']));

            $data["promocion"] = $resultado;

            $this->load->view('Promociones/ModificarPromocion', $data);
        } else {
            redirect('ControladorLogin');
        }
    }

    public function actualizar_promocion()
    {
        $id_promocion = $this->input->post('id_promocion');
        $datos_promocion = array(
            'fecha_inicio' => $this->input->post('fecha_inicio'),
            'fecha_fin' => $this->input->post('fecha_termino'),
            'descripcion' => $this->input->post('descripcion'),
            'lunes' => $this->input->post('lunes') == 'on' ? 't' : 'f',
            'martes' => $this->input->post('martes') == 'on' ? 't' : 'f',
            'miercoles' => $this->input->post('miercoles') == 'on' ? 't' : 'f',
            'jueves' => $this->input->post('jueves') == 'on' ? 't' : 'f',
            'viernes' => $this->input->post('viernes') == 'on' ? 't' : 'f',
            'sabado' => $this->input->post('sabado') == 'on' ? 't' : 'f',
            'domingo' => $this->input->post('domingo') == 'on' ? 't' : 'f'
        );
        $resultado = $this->ModeloPromocion->actualizar_promocion($id_promocion, $datos_promocion);
        if ($resultado) {
            redirect('ControladorPromocion/MostrarPromocion');
        } else {
            redirect('pagina_de_error');
        }
    }

    public function eliminarPromocion() {
        if ($this->session->userdata('id_usuario')) {
            $idDelete = $this->uri->segment(3);

            $this->load->model('ModeloPromocion');
            $this->ModeloPromocion->deleteImagenPromocion($idDelete);
            $this->ModeloPromocion->deletePromocion($idDelete);

            redirect('ControladorPromocion/MostrarPromocion');
        } else {
            redirect('ControladorLogin');
        }
    }



    public function deleteTodo(){
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloPromocion');
            $this->load->model('ModeloUsuarios');


            $contrasena = $this->input->post('contrasena');
            $usuario_actual = $this->session->userdata('id_usuario');
            $usuario = $this->ModeloUsuarios->selectUsuarioId($usuario_actual);
            $contrasena_bd = $usuario->row()->contrasena;
    
            // Verificar si la contraseña proporcionada coincide con la contraseña del usuario actual
            if (password_verify($contrasena, $contrasena_bd)) {
                $this->ModeloPromocion->deleteTodo();
            redirect('ControladorPromocion/MostrarPromocion');
            
        } else {
            // Contraseña incorrecta
            echo "<script>
            alert('La contraseña es incorrecta.');
            window.location.href = '" . base_url('ControladorPromocion/MostrarPromocion') . "';
        </script>";
        }
    } else {
            redirect('ControladorLogin');
        }
    }
}
