<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>
<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    Formulario de Edición de Precio por Volumen.
                </div>
                <div class="card-body">
                    <?php
                    if ($datoPrecioVolumen) {
                    ?>
                    <form action="<?php echo base_url() ?>ControladorPrecioVolumen/editarPrecioVolumen" method="POST">
                        <input type="hidden" name="CampoHidden" value="<?php echo $datoPrecioVolumen['id_precio_volumen'] ?>">
                        <div class="row g-3">
                            <div class="col">
                                <label for="desde" class="form-label">Desde</label>
                                <input type="number" name="CampoDesde" id="desde" class="form-control" min="1" required value="<?php echo $datoPrecioVolumen['desde'] ?>">
                            </div>
                            <div class="col">
                                <label for="hasta" class="form-label">Hasta</label>
                                <input type="number" name="CampoHasta" id="hasta" class="form-control" min="1" required value="<?php echo $datoPrecioVolumen['hasta'] ?>">
                            </div>
                            <div class="col">
                                <label for="precio" class="form-label">Precio</label>
                                <input type="number" name="CampoPrecio" id="precio" class="form-control" required value="<?php echo $datoPrecioVolumen['precio'] ?>">
                            </div>
                            <div class="col">
                                <label for="idEstado" class="form-label">Estado</label>
                                <select name="CampoEstado" id="idEstado" class="form-control" required>
                                    <option value="">Seleccione el estado</option>
                                    <!-- Los datos de los estados se cargarán dinámicamente con JavaScript -->
                                </select>
                            </div>
                        </div>
                        <br>
                        <br>
                        <input type="submit" value="Guardar" class="btn btn-primary" onclick="return confirm('¿Estás seguro de que deseas modificar este registro de Precio por Volumen?');">
                    </form>
                    <?php
                    } else {
                        echo "<p>No se encontraron datos para editar.</p>";
                    }
                    ?>
                </div>
            </div>
        </div>
    </div>
</div>
<?php require_once "application/views/footer/Footer.php"; ?>
<script>
    $(document).ready(function() {
        // Realiza una solicitud AJAX para obtener los datos en formato JSON
        $.ajax({
            url: '<?php echo base_url() ?>ControladorPrecioVolumen/cargarEstado',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                var dropdown = $('#idEstado');
                $.each(data, function(key, value) {
                    dropdown.append($('<option>').text(value.nombre_estado).val(value.id_estado));
                });
                // Establece el valor seleccionado en el campo select
                dropdown.val(<?php echo $datoPrecioVolumen['id_estado'] ?>);
            },
            error: function() {
                console.log('Error al cargar los estados.');
            }
        });
    });
</script>
