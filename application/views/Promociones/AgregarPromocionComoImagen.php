<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>

<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    Formulario de registro de Promociones por imagen.
                </div>
                <div class="card-body">
                    <form id="formularioAgregarPromocion" action="<?php echo base_url() ?>ControladorPromocion/GuardarPromocionPorImagen" method="POST" enctype="multipart/form-data">
                        <div class="row">
                            <div class="form-group">
                                <label for="imagenes" class="form-label">Seleccionar Imagen</label>
                                <input type="file" class="form-control" id="imagenes" name="imagenes" multiple accept="image/*" required>
                            </div>
                            <div class="row g-3">
                                <div class="col-12">
                                    <img src="<?php echo base_url(); ?>" id="imagen_actual" alt="Imagen actual" class="img-fluid" style="display:none">
                                </div>
                            </div>
                            <div class="form-group mt-3">
                                <label for="fecha_inicio">Fecha de inicio:</label>
                                <div class="input-group date" id="fecha_inicio">
                                    <input type="date" class="form-control" name="fecha_inicio" min="<?php echo date('Y-m-d'); ?>" required />
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="fecha_termino">Fecha de término:</label>
                                <div class="input-group date" id="fecha_termino">
                                    <input type="date" class="form-control" name="fecha_termino" min="<?php echo date('Y-m-d'); ?>" required />
                                </div>
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
                            <div class="row">
                                <div class="col-6">
                                    <button type="submit" class="btn btn-outline-primary">Guardar <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-save" viewBox="0 0 16 16">
                                            <path d="M2 1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H9.5a1 1 0 0 0-1 1v7.293l2.646-2.647a.5.5 0 0 1 .708.708l-3.5 3.5a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L7.5 9.293V2a2 2 0 0 1 2-2H14a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h2.5a.5.5 0 0 1 0 1z" />
                                        </svg></button>
                                </div>
                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>
<?php require_once "application/views/footer/Footer.php"; ?>

<script>
    $(document).ready(function() {
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function(e) {
                    $('#imagen_actual').attr('src', e.target.result);
                }

                reader.readAsDataURL(input.files[0]);
            }
        }
        $('#imagenes').change(function() {
            previewImage(this);
            $('#imagen_actual').css("display", "block");
        });

        $("#fecha_inicio").on("change", function() {
            $('#fecha_termino input').attr('min', $(this).val());
        });

        $("#fecha_termino").on("change", function() {
            $('#fecha_inicio input').attr('max', $(this).val());
        });
    });
</script>