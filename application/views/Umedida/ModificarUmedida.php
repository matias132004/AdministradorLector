<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>
<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    Formulario de Edición de Unidades de Medida.
                </div>
                <div class="card-body">
                    <?php
                    $fila = $datoUmedida->row_array();
                    ?>
                    <form action="<?php echo base_url() ?>ControladorUmedida/editarUmedida" method="POST">
                        <input type="hidden" name="CampoHidden" value="<?php echo $fila['id_umedida'] ?>">
                        <div class="row g-3">
                            <div class="col">
                                <label for="idNombreUmedida" class="form-label">Nombre de la Unidad de Medida</label>
                                <input type="text" name="CampoNombreUmedida" id="idNombreUmedida" class="form-control" required autofocus value="<?php echo $fila['nombre_umedida'] ?>">
                            </div>
                            <div class="col">
                                <label for="idNombreCorto" class="form-label">Nombre Corto</label>
                                <input type="text" name="CampoNombreCorto" id="idNombreCorto" class="form-control" required value="<?php echo $fila['nombre_corto'] ?>">
                            </div>
                            <div class="col">
                                <label for="idEstado" class="form-label">Estado</label>
                                <select name="CampoEstado" id="idEstado" class="form-control" required>
                                    <option value="">Seleccione el estado de la Unidad de Medida</option>
                                    <!-- Los datos de los estados se cargarán dinámicamente con JavaScript -->
                                </select>
                            </div>
                        </div>
                        <br>
                        <br>
                        <input type="submit" value="Guardar" class="btn btn-primary" onclick="return confirm('¿Estás seguro de que deseas modificar los datos de la Unidad de Medida?');">
                    </form>

                    <?php require_once "application/views/footer/Footer.php"; ?>
                    <script>
                        $(document).ready(function () {
                            // Realiza una solicitud AJAX para obtener los datos en formato JSON
                            $.ajax({
                                url: '<?php echo base_url() ?>ControladorUmedida/cargarEstado',
                                type: 'GET',
                                dataType: 'json',
                                success: function (data) {
                                    var dropdown = $('#idEstado');
                                    $.each(data, function (key, value) {
                                        dropdown.append($('<option>').text(value.nombre_estado).val(value.id_estado));
                                    });
                                    // Establece el valor seleccionado en el campo select
                                    dropdown.val(<?php echo $fila['id_estado'] ?>);
                                }
                            });
                        });
                    </script>


                </div>
            </div>
        </div>
    </div>
</div>

