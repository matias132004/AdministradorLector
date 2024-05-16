<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>
<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    Formulario de edición de Productos.
                </div>
                <div class="card-body">
                    <form action="<?php echo base_url() ?>ControladorProducto/EditarProducto" method="POST">
                        <input type="hidden" name="CampoHidden" id="idCampoHidden" class="form-control" required autofocus value="<?php echo $datos['id_producto'] ?>">
                        <div class="row g-3">
                            <div class="col">
                                <label for="idNombreProducto" class="form-label">Nombre del Producto</label>
                                <input type="text" name="CampoNombreProducto" id="idNombreProducto" class="form-control" required autofocus value="<?php echo $datos['nombre_producto'] ?>">
                            </div>
                            <div class="col-6">
                                <label for="idNombreFamilia" class="form-label">Familia</label>
                                <select type="text" name="CampoNombreFamilia" id="idNombreFamilia" class="form-control" required autofocus>
                                    <?php foreach ($familias as $familia) { ?>
                                        <option value="<?= $familia['id_familia'] ?>" <?php echo ($familia['id_familia'] == $familia['id_familia']) ? 'selected' : ''; ?>>
                                            <?= $familia['nombre_familia'] ?></option>
                                    <?php } ?>
                                </select>
                            </div>

                            <div class="col-6">
                                <label for="idCodBarra" class="form-label">Codigo de Barra</label>
                                <input type="text" name="CampoCodBarra" id="idCodBarra" class="form-control" required autofocus value="<?php echo $datos['cbarra'] ?>">
                            </div>
                            <div class="col-6">
                                <label for="idTmedida" class="form-label">unidad de Medida</label>
                                <select type="text" name="CampoUmedida" id="idUmedida" class="form-control" required autofocus value="<?php echo $datos['$id_umedida'] ?>">
                                    <?php foreach ($Umedidas as $Umedida) { ?>
                                        <option value="<?= $Umedida['id_umedida'] ?>" <?php echo ($Umedida['id_umedida'] == $datos['id_umedida']) ? 'selected' : ''; ?>>
                                            <?= $Umedida['nombre_umedida'] ?></option>
                                    <?php } ?>
                                </select>
                            </div>
                            <div class="col-6">
                                <label for="idPrecio" class="form-label">Precio</label>
                                <input type="text" name="CampoPrecio" id="idPrecio" class="form-control" required autofocus value="<?php echo $datos['total'] ?>">
                            </div>
                            <div class="col-6">
                                <label for="idPrecio" class="form-label">Precio Antiguo</label>
                                <br>
                                <button id="btnModificar" class="btn btn-success" type="button">Modificar precio antiguo</button>
                            </div>

                            <div class="col-6">
                                <label for="idEstado" class="form-label">Estado</label>
                                <select name="CampoEstado" id="idEstado" class="form-control" required>
                                    <?php foreach ($Estados as $Estados) { ?>
                                        <option value="<?= $Estados['id_estado'] ?>" <?php echo ($Estados['id_estado'] == $datos['id_estado']) ? 'selected' : ''; ?>>
                                            <?= $Estados['nombre_estado'] ?></option>
                                    <?php } ?>
                                </select>
                            </div>
                            <div class="col">
                                <label for="idDescripcionProducto" class="form-label">Descripcion del Producto</label>
                                <input type="text" name="CampoDescripcionProducto" id="idDescripcionProducto" class="form-control"  autofocus value="<?php echo $datos['descripcion'] ?>">
                            </div>
                        </div>
                        <br>
                        <br>
                        <input type="submit" value="Guardar" class="btn btn-primary" onclick="return confirm('¿Estás seguro de que deseas modificar los datos del producto?');">
                    </form>
                    
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="editarModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="editarModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editarModalLabel">Modificar Precio Antiguo</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Modifique el Precio Antiguo:</p>
                <input type="hidden" name="CampoHidden" id="idCampoHidden" class="form-control" required autofocus value="<?php echo $datos['id_producto'] ?>">
                <input type="text" name="CampoPrecioOld" id="idPrecioAntiguo" class="form-control" required autofocus value="<?php echo $datos['precio_old'] ?>">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-success" id="btnGuardarPrecio">Guardar</button>
                <button type="button" class="btn btn-secondary" id="btnCancelar" data-dismiss="modal">Cancelar</button>
            </div>
        </div>
    </div>
</div>

<?php require_once "application/views/footer/Footer.php"; ?>

<script>
    $(document).ready(function() {
        $("#btnModificar").click(function() {
            $('#editarModal').modal('show');
        });
        $("#btnCancelar").click(function() {
            $('#editarModal').modal('hide');
        });

        $('#btnGuardarPrecio').on('click', function() {
            var id_producto = $("#idCampoHidden").val();
            var nuevo_precio = $("#idPrecioAntiguo").val();

            $.ajax({
                url: "<?php echo base_url() ?>ControladorProducto/modificarPrecioAntiguo",
                type: "POST",
                data: {
                    id_producto: id_producto,
                    nuevo_precio: nuevo_precio
                },
                success: function(response) {
                    alert("Precio antiguo modificado correctamente.");
                    $('#editarModal').modal('hide');
                },
                error: function(xhr, status, error) {
                    alert("Error al modificar el precio antiguo: " + error);
                }
            });
        });
    });
</script>