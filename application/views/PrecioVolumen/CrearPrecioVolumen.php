<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>
<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    Formulario de registro de Precio por Volumen.
                </div>
                <div class="card-body">
                    <form action="<?php echo base_url() ?>ControladorPrecioVolumen/GuardarPrecioVolumen" method="POST">
                        <div class="row g-3">
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="id_producto">ID Producto:</label>
                                    <input type="number" class="form-control" id="id_producto" name="CampoIdProducto" min="0" required>
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
                            <div class="col-6">
                                <label for="desde" class="form-label">Desde</label>
                                <input type="number" name="CampoDesde" id="desde" class="form-control" min="1" required>
                            </div>
                            <div class="col-6">
                                <label for="hasta" class="form-label">Hasta</label>
                                <input type="number" name="CampoHasta" id="hasta" class="form-control" min="1" required>
                            </div>
                            <div class="col-6">
                                <label for="precio" class="form-label">Precio</label>
                                <input type="number" name="CampoPrecio" id="precio" class="form-control" required>
                            </div>
                        </div>
                        <br>
                        <input type="submit" value="Guardar" class="btn btn-primary">
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
    $(document).ready(function() {

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

        $("#id_producto").on("input", function() {
            var id_producto = $(this).val();
            var nombre_producto = $("#nombre_producto option[data-id='" + id_producto + "']").val();
            $("#nombre_producto").val(nombre_producto);
        });

        $("#AbrirModal").click(function() {
            $('#myModal').modal('show');
        });

        $('.modal .btn-close').on('click', function() {
            $('#myModal').modal('hide');
        });

        $(document).on('click', '.agregar-producto', function() {
            var id_producto = $(this).data('id');
            var nombre_producto = $(this).data('nombre');
            $("#id_producto").val(id_producto);
            $("#nombre_producto").val(nombre_producto);
            $('#myModal').modal('hide');
        });
        $("form").submit(function(event) {
            var desde = parseInt($("#desde").val());
            var hasta = parseInt($("#hasta").val());         
            if (hasta < desde) {
                alert("El valor de 'hasta' no puede ser menor que el de 'desde'");
                event.preventDefault();
            }
        });
    });
</script>