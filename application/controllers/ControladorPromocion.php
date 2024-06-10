<?php

class ControladorPromocion extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();
        // Cargar librería de sesión
        $this->load->library('session');
        $this->load->model('ModeloPromocion');
        $this->load->helper(array('form', 'url'));
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

    public function MostrarPromocionPorImagen()
    {
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloPromocion');
            $data['promociones'] = $this->ModeloPromocion->obtenerPromocionesPorImagenes();
            $this->load->view('Promociones/MostrarPromocionPorImagen', $data);
        } else {
            redirect('ControladorLogin');
        }
    }
    public function AgregarPromocion()
    {
        if ($this->session->userdata('id_usuario')) {

            $this->load->model('ModeloPromocion');

            $this->load->view('Promociones/AgregarPromocion');
        } else {
            redirect('ControladorLogin');
        }
    }

    public function AgregarPromocionComoImagen()
    {
        if ($this->session->userdata('id_usuario')) {

            $this->load->model('ModeloPromocion');

            $this->load->view('Promociones/AgregarPromocionComoImagen');
        } else {
            redirect('ControladorLogin');
        }
    }

    public function GuardarPromocionPorImagen()
    {
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloPromocion');
    
            $fecha_inicio = $this->input->post('fecha_inicio');
            $fecha_termino = $this->input->post('fecha_termino');
            $lunes = boolval($this->input->post('lunes'));
            $martes = boolval($this->input->post('martes'));
            $miercoles = boolval($this->input->post('miercoles'));
            $jueves = boolval($this->input->post('jueves'));
            $viernes = boolval($this->input->post('viernes'));
            $sabado = boolval($this->input->post('sabado'));
            $domingo = boolval($this->input->post('domingo'));
            $id_estado = 1;
            $idUsuario = $this->session->userdata('id_usuario');
            $id_datos_local = $this->ModeloPromocion->selectIdlocal($idUsuario);
    
            $config['upload_path'] = './uploads/Promocion';
            $config['allowed_types'] = 'gif|jpg|png';
            $config['max_size'] = 700000;
            $config['max_width'] = 700000;
            $config['max_height'] = 700000;
    
            $this->load->library('upload');
            $this->upload->initialize($config);
    
            if (empty($_FILES['imagenes']['name'])) {
                $error = array('error' => 'No file selected');
                $this->load->view('Promociones/errorCarga', $error);
                return;
            }
    
            if (!$this->upload->do_upload('imagenes')) {
                $error = array('error' => $this->upload->display_errors());
                $this->load->view('Promociones/errorCarga', $error);
            } else {
                $upload_data = $this->upload->data();
                $nombre = $upload_data['file_name'];
                $datos = file_get_contents($upload_data['full_path']);
    
                // Convertir los datos a UTF-8 directamente
                $datos_utf8 = mb_convert_encoding($datos, 'UTF-8');
    
                $this->ModeloPromocion->guardarPromocionPorImagen($nombre, $datos_utf8, $id_datos_local, $fecha_inicio, $fecha_termino, $lunes, $martes, $miercoles, $jueves, $viernes, $sabado, $domingo, $id_estado);
                redirect('ControladorPromocion/MostrarPromocionPorImagen');
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
    public function cargarEditarPromocionImagen()
    {
        // Verificar si el usuario está autenticado
        if ($this->session->userdata('id_usuario')) {
            $idUpdate = $this->uri->segment(3);

            $this->load->model('ModeloPromocion');
            $resultado = $this->ModeloPromocion->selectPromocionImagenId($idUpdate);

            $resultado['fecha_inicio'] = date('Y-m-d', strtotime($resultado['fecha_inicio']));
            $resultado['fecha_fin'] = date('Y-m-d', strtotime($resultado['fecha_fin']));

            $data["promocion"] = $resultado;

            $this->load->view('Promociones/ModificarPromocionPorImagen', $data);
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
    public function actualizar_promocion_por_imagen()
    {
        $id_promocion = $this->input->post('id_promocion');
        $datos_promocion = array(
            'fecha_inicio' => $this->input->post('fecha_inicio'),
            'fecha_fin' => $this->input->post('fecha_termino'),
            'lunes' => $this->input->post('lunes') == 'on' ? 't' : 'f',   
            'martes' => $this->input->post('martes') == 'on' ? 't' : 'f',
            'miercoles' => $this->input->post('miercoles') == 'on' ? 't' : 'f',
            'jueves' => $this->input->post('jueves') == 'on' ? 't' : 'f',
            'viernes' => $this->input->post('viernes') == 'on' ? 't' : 'f',
            'sabado' => $this->input->post('sabado') == 'on' ? 't' : 'f',
            'domingo' => $this->input->post('domingo') == 'on' ? 't' : 'f'
        );
        $resultado = $this->ModeloPromocion->actualizar_promocion_por_imagen($id_promocion, $datos_promocion);
        if ($resultado) {
            redirect('ControladorPromocion/MostrarPromocionPorImagen');
        } else {
            redirect('pagina_de_error');
        }
    }

    public function eliminarPromocion()
    {
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
    
    public function EliminarPromocionPorImagen()
    {
        if ($this->session->userdata('id_usuario')) {
            $idDelete = $this->uri->segment(3);

            $this->load->model('ModeloPromocion');
            $this->ModeloPromocion->deleteImagenPromocionPorImagen($idDelete);
            redirect('ControladorPromocion/MostrarPromocionPorImagen');
        } else {
            redirect('ControladorLogin');
        }
    }

    public function deleteTodo()
    {
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

    public function MostrarProductoAjax()
    {
        if ($this->session->userdata('id_usuario')) {
            $this->load->model('ModeloPromocion');

            $draw = intval($this->input->get("draw"));
            $start = intval($this->input->get("start"));
            $length = intval($this->input->get("length"));
            $search = $this->input->get("search")["value"]; // Obtener el término de búsqueda

            $productos = $this->ModeloPromocion->selectProducto2($length, $start, $search);
            $totalProductos = $this->ModeloPromocion->countProductos($search);

            $data = array(
                "draw" => $draw,
                "recordsTotal" => $totalProductos,
                "recordsFiltered" => $totalProductos,
                "data" => $productos
            );

            echo json_encode($data);
        } else {
            echo json_encode(['error' => 'No autenticado']);
        }
    }
}
