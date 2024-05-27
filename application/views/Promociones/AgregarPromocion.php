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
                    <form id="formularioAgregarPromocion" action="<?php echo base_url() ?>ControladorPromocion/GuardarPromocion" method="POST">
                        <div class="row">
                            <div class="col-md-6">
                                <label for="id_producto">ID Producto:</label>
                                <input type="number" class="form-control" id="id_producto" name="id_producto" min="0" required>
                            </div>
                            <div class="col-md-6">
                                <label for="nombre_producto">Nombre Producto:</label>
                                <select class="form-control" id="nombre_producto" name="nombre_producto" disabled>
                                    <option value="">No hay Productos Seleccionados</option>
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
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Seleccionar Productos</h5>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
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
                        <tbody id="productos-container">
                            <!-- Data will be filled by DataTable -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<?php require_once "application/views/footer/Footer.php"; ?>

<script>
   $(document).ready(function() {
    var table = $('#idTabla').DataTable({
        "processing": true,
        "serverSide": true,
        "ajax": {
            "url": "<?= base_url('ControladorPromocion/MostrarProductoAjax') ?>",
            "type": "GET"
        },
        "columns": [
            { "data": "id_producto" },
            { "data": "nombre_producto" },
            { "data": "cbarra" },
            { "data": "precio_old" },
            { "data": "total" },
            {
                "data": null,
                "render": function(data, type, row) {
                    return '<button id="btn-select" class="btn btn-outline-primary" data-id="' + row.id_producto + '">Seleccionar</button>';
                }
            }
        ],
                    "language": {
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
            }
    });

    // Open modal and load products
    $("#AbrirModal").click(function () {
        $('#myModal').modal('show');
        table.ajax.reload(); // Reload the DataTable to fetch new data
    });

    // Close modal
    $('.modal .btn-close').on('click', function () {
        $('#myModal').modal('hide');
    });

    // Assign selected product to the form
    $(document).on('click', '#btn-select', function () {
        var id_producto = $(this).data('id');
        var row = table.row($(this).parents('tr')).data();
        var nombre_producto = row.nombre_producto;
        $("#id_producto").val(id_producto);
        $("#nombre_producto").html(`<option value="${nombre_producto}">${nombre_producto}</option>`);
        $('#myModal').modal('hide');
    });

    // Adjust min/max dates
    $("#fecha_inicio").on("change", function () {
        $('#fecha_termino input').attr('min', $(this).val());
    });

    $("#fecha_termino").on("change", function () {
        $('#fecha_inicio input').attr('max', $(this).val());
    });
});

</script>
