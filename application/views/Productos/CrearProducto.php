<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>

<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    Formulario de registro de Productos.
                </div>
                <div class="card-body">

                    <form action="<?php echo base_url() ?>ControladorProducto/GuardarProducto" method="POST">
                        <div class="row g-3">
                            <div class="col-6">
                                <label for="idNombreProducto" class="form-label">Nombre del Producto</label>
                                <input type="text" name="CampoNombreProducto" id="idNombreProducto" class="form-control" required autofocus>
                            </div>
                            <div class="col-6">
                                <label for="idNombreFamilia" class="form-label">Familia</label>
                                <select type="text" name="CampoNombreFamilia" id="idNombreFamilia" class="form-control" required autofocus>
                                    <option> Seleccione la familia del producto</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <label for="idCodBarra" class="form-label">Codigo de Barra</label>
                                <input type="text" name="CampoCodBarra" id="idCodBarra" class="form-control" required autofocus>
                            </div>
                            <div class="col-6">
                                <label for="idTmedida" class="form-label">Tipo de Medida</label>

                                <select type="text" name="CampoTmedida" id="idTmedida" class="form-control " required autofocus>
                                    <option> Seleccione el tipo de medida del producto</option>
                                </select>

                            </div>
                            <div class="col-6">
                                <label for="idPrecio" class="form-label">Precio</label>
                                <input type="text" name="CampoPrecio" id="idPrecio" class="form-control" required autofocus>
                            </div>
                            <div class="col-6">
                                <label for="idPrecioAntiguo" class="form-label">Precio Antiguo</label>
                                <input type="text" name="CampoPrecioOld" id="idPrecioAntiguo" value="0" class="form-control" required autofocus>
                            </div>
                            <div class="col-6">
                                <label for="idEstado" class="form-label">Estado</label>
                                <select name="CampoEstado" id="idEstado" class="form-control" required>
                                    <option value="">Seleccione el estado del producto</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <label for="idDescripcionProducto" class="form-label">Descripcion del Producto</label>
                                <input type="text" name="CampoDescripcionProducto" id="idDescripcionProducto" class="form-control" required autofocus>
                            </div>
                            <div class="col-6">
                                <label for="descripcionvisible">descripcion visible en el lector:</label>
                                <input type="checkbox" name="descripcionvisible" checked data-toggle="toggle" data-size="xs">
                            </div>
                        </div>
                        <br>
                        <br>
                        <input type="submit" value="Guardar" class="btn btn-primary">
                    </form>

                    <?php require_once "application/views/footer/Footer.php"; ?>
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script>
                        $(document).ready(function() {
                            // Realiza una solicitud AJAX para obtener los datos en formato JSON
                            $.ajax({
                                url: '<?php echo base_url() ?>ControladorProducto/cargarEstado',
                                type: 'GET',
                                dataType: 'json',
                                success: function(data) {
                                    var dropdown = $('#idEstado');
                                    $.each(data, function(key, value) {
                                        dropdown.append($('<option>').text(value.nombre_estado).val(value.id_estado));
                                    });
                                }
                            });
                        });
                    </script>
                    <script>
                        $(document).ready(function() {
                            // Realiza una solicitud AJAX para obtener los datos en formato JSON
                            $.ajax({
                                url: '<?php echo base_url() ?>ControladorProducto/cargarUmedida',
                                type: 'GET',
                                dataType: 'json',
                                success: function(data) {
                                    var dropdown = $('#idTmedida');
                                    $.each(data, function(key, value) {
                                        dropdown.append($('<option>').text(value.nombre_umedida).val(value.id_umedida));
                                    });
                                }
                            });
                        });
                    </script>
                    <script>
                        $(document).ready(function() {
                            // Realiza una solicitud AJAX para obtener los datos en formato JSON
                            $.ajax({
                                url: '<?php echo base_url() ?>ControladorProducto/cargarFamilia',
                                type: 'GET',
                                dataType: 'json',
                                success: function(data) {
                                    var dropdown = $('#idNombreFamilia');
                                    $.each(data, function(key, value) {
                                        dropdown.append($('<option>').text(value.nombre_familia).val(value.id_familia));
                                    });
                                }
                            });
                        });
                    </script>
                    <!-- Check if there's an alert message to display -->
                    <?php if (isset($alert_message)) : ?>
                        <script>
                            // Display alert using JavaScript
                            alert("<?php echo $alert_message; ?>");
                        </script>
                    <?php endif; ?>

                </div>
            </div>
        </div>
    </div>
</div>
<?php
