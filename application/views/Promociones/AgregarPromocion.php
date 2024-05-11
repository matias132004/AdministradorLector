<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>

<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    Formulario de registro de Promociones.
                </div>
                <div class="card-body">
                    <form id="formularioAgregarPromocion" action="<?php echo base_url() ?>ControladorPromocion/GuardarPromocion" method="POST" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-md-6">
                                <label for="id_producto">ID Producto:</label>
                                <input type="number" class="form-control" id="id_producto" name="id_producto" min="0" required>
                            </div>
                            <div class="col-md-6">
                                <label for="nombre_producto">Nombre Producto:</label>
                                <select class="form-control" id="nombre_producto" name="nombre_producto" disabled>
                                    <option value="">No hay Productos Seleccionados</option>
                                    <?php foreach ($datos as $dato) : ?>
                                        <option value="<?= $dato['nombre_producto'] ?>" data-id="<?= $dato['id_producto'] ?>"><?= $dato['nombre_producto'] ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                        </div>
                        <div class="form-group mt-3">
                            <button id="AbrirModal" type="button" class="btn btn-outline-success mt-3">Seleccionar Producto</button>
                        </div>
                        <div class="form-group mt-3">
                            <label for="fecha_inicio">Fecha de inicio:</label>
                            <div class="input-group date" id="fecha_inicio">
                                <input type="date" class="form-control" name="fecha_inicio" min="<?php echo date('Y-m-d'); ?>" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="fecha_termino">Fecha de término:</label>
                            <div class="input-group date" id="fecha_termino">
                                <input type="date" class="form-control"  name="fecha_termino" min="<?php echo date('Y-m-d'); ?>" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="descripcion">Descripción:</label>
                            <textarea id="descripcion" name="descripcion" rows="5" class="form-control"></textarea>
                        </div>
                        <div class="card card-secondary">
                            <div class="card-header">
                                <h3 class="card-title">Seleccionar días donde Aplica</h3>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-4">
                                        <label for="lunes">Lunes:</label>
                                        <input type="checkbox" name="lunes" checked data-toggle="toggle" data-size="xs">
                                    </div>
                                    <div class="col-4">
                                        <label for="martes">Martes:</label>
                                        <input type="checkbox" name="martes" checked data-toggle="toggle" data-size="xs">
                                    </div>
                                    <div class="col-4">
                                        <label for="miercoles">Miércoles:</label>
                                        <input type="checkbox" name="miercoles" checked data-toggle="toggle" data-size="xs">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4">
                                        <label for="jueves">Jueves:</label>
                                        <input type="checkbox" name="jueves" checked data-toggle="toggle" data-size="xs">
                                    </div>
                                    <div class="col-4">
                                        <label for="viernes">Viernes:</label>
                                        <input type="checkbox" name="viernes" checked data-toggle="toggle" data-size="xs">
                                    </div>
                                    <div class="col-4">
                                        <label for="sabado">Sábado:</label>
                                        <input type="checkbox" name="sabado" checked data-toggle="toggle" data-size="xs">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4">
                                        <label for="domingo">Domingo:</label>
                                        <input type="checkbox" name="domingo" checked data-toggle="toggle" data-size="xs">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-outline-primary">Guardar <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-save" viewBox="0 0 16 16">
                            <path d="M2 1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H9.5a1 1 0 0 0-1 1v7.293l2.646-2.647a.5.5 0 0 1 .708.708l-3.5 3.5a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L7.5 9.293V2a2 2 0 0 1 2-2H14a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h2.5a.5.5 0 0 1 0 1z"/>
                            </svg></button>
                    </form> 
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="container">
            <div class="row">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Seleccionar Productos</h5>
                        <button type="button" class="btn-close" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="table-responsive">
                            <table id="idTabla" class="table table-bordered-lg">
                                <thead>
                                    <tr>
                                        <th scope="col">Id Producto</th>
                                        <th scope="col">Nombre Producto</th>
                                        <th scope="col">código de barras</th>
                                        <th scope="col">Precio Antiguo</th>
                                        <th scope="col">Precio</th>
                                        <th scope="col">Acción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($datos as $dato) : ?>
                                        <tr>
                                            <td><?= $dato['id_producto'] ?></td>
                                            <td><?= $dato['nombre_producto'] ?></td>
                                            <td><?= $dato['cbarra'] ?></td>
                                            <td>$<?= $dato['precio_old'] ?></td>
                                            <td>$<?= $dato['total'] ?></td>
                                            <td>
                                                <button type="button" class="btn btn-success agregar-producto" data-id="<?= $dato['id_producto'] ?>" data-nombre="<?= $dato['nombre_producto'] ?>">Agregar</button>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php require_once "application/views/footer/Footer.php"; ?>

<script>
    $(document).ready(function () {

        $("#idTabla").DataTable({
            responsive: true,
            language: {
                "decimal": "",
                "emptyTable": "No hay información",
                "info": "Mostrando _START_ a _END_ de _TOTAL_ Entradas",
                "infoEmpty": "Mostrando 0 a 0 de 0 Entradas",
                "infoFiltered": "(Filtrado de _MAX_ total entradas)",
                "infoPostFix": "",
                "thousands": ",",
                "lengthMenu": "Mostrar _MENU_ Entradas",
                "loadingRecords": "Cargando...",
                "processing": "Procesando...",
                "search": "Buscar:",
                "zeroRecords": "Sin resultados encontrados",
                "paginate": {
                    "first": "Primero",
                    "last": "Último",
                    "next": "Siguiente",
                    "previous": "Anterior"
                }
            },
            dom: 'Bfrtip',

        });

        $("#id_producto").on("input", function () {
            var id_producto = $(this).val();
            var nombre_producto = $("#nombre_producto option[data-id='" + id_producto + "']").val();
            $("#nombre_producto").val(nombre_producto);
        });

        $("#AbrirModal").click(function () {
            $('#myModal').modal('show');
        });

        $('.modal .btn-close').on('click', function () {
            $('#myModal').modal('hide');
        });

        $(document).on('click', '.agregar-producto', function () {
            var id_producto = $(this).data('id');
            var nombre_producto = $(this).data('nombre');
            $("#id_producto").val(id_producto);
            $("#nombre_producto").val(nombre_producto);
            $('#myModal').modal('hide');
        });

        $("#fecha_inicio").on("change", function () {
            var selectedDate = new Date($(this).val());
            var currentDate = new Date();
            if (selectedDate < currentDate) {
                alert("La fecha de inicio no puede ser menor que la fecha actual.");
                $(this).val("");
            }
        });
        $("#fecha_termino").on("change", function () {
            var selectedDate = new Date($(this).val());
            var currentDate = new Date();
            if (selectedDate < currentDate) {
                alert("La fecha de inicio no puede ser menor que la fecha actual.");
                $(this).val("");
            }
        });

    });
</script>
