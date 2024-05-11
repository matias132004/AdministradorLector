<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>
<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    Formulario de registro de Unidad de Medida.
                </div>
                <div class="card-body">

                    <form action="<?php echo base_url() ?>ControladorUmedida/GuardarUmedida" method="POST">
                        <div class="row g-3">
                            <div class="col">
                                <label for="idNombreUmedida" class="form-label">Nombre de la Unidad de Medida</label>
                                <input type="text" name="CampoNombreUmedida" id="idNombreUmedida" class="form-control" required autofocus>
                            </div>
                            <div class="col">
                                <label for="idNombreCorto" class="form-label">Nombre Corto</label>
                                <input type="text" name="CampoNombreCorto" id="idNombreCorto" class="form-control" required>
                            </div>
                            <div class="col">
                                <label for="idEstado" class="form-label">Estado</label>
                                <select name="CampoEstado" id="idEstado" class="form-control" required>
                                    <option value="">Seleccione el estado de la Unidad de Medida</option>
                                </select>
                                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                                            }
                                        });
                                    });
                                </script>
                            </div>
                        </div>
                        <br>
                        <br>
                        <input type="submit" value="Guardar" class="btn btn-primary">
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>
<?php require_once "application/views/footer/Footer.php"; ?>
