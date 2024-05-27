<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>

<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-12">
        <div class="card card-danger">
                <div class="card-header">
                    <h3 class="card-title">Modificar Datos de el Local</h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-tool" data-card-widget="remove">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <?php $fila = $datosLocal ?>
                    <form action="<?= base_url() ?>ControladorPersonalizacion/guardarCambios" method="post">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="nombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required value="<?= $fila['nombre_local'] ?>">
                            </div>
                            <div class="col-md-6">
                                <label for="Descripcion" class="form-label">Descripcion</label>
                                <input type="text" class="form-control" id="DescripcionLocal" name="Descripcion" required value="<?= $fila['descripcion'] ?>">
                            </div>
                        </div>
                        <input type="hidden" name="id_datos_local" value="<?= $fila['id_datos_local'] ?>">
                        <br>
                        <button type="submit" class="btn btn-outline-primary" onclick="return confirm('¿Estás seguro de que deseas modificar los datos del local?');">Guardar <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-save" viewBox="0 0 16 16">
                                <path d="M2 1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H9.5a1 1 0 0 0-1 1v7.293l2.646-2.647a.5.5 0 0 1 .708.708l-3.5 3.5a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L7.5 9.293V2a2 2 0 0 1 2-2H14a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h2.5a.5.5 0 0 1 0 1z" />
                            </svg></button>
                    </form>
                    <br>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#logoModal">
                        Modificar Logo
                    </button>   <br>                    <br>
                    <a href="<?php echo base_url() ?>ControladorPersonalizacion/CargarImagenesFondo/<?php echo $fila['id_datos_local'] ?>"><button class="btn btn-outline-success">Seleccionar Imagenes de Fondo</button></a>

                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="logoModal" tabindex="-1" aria-labelledby="logoModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="logoModalLabel">Logo en pantalla</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="<?php echo site_url('ControladorPersonalizacion/ActualizarImagenLocal'); ?>" method="post" enctype="multipart/form-data">
                    <?php if ($fila['logo_act'] == 't') : ?>
                        <input type="hidden" name="id_datos_local2" value="<?= $fila['id_datos_local'] ?>">
                        <?php if ($fila['logo_act'] == 't' && isset($imagen)) : ?>
                            <div class="row g-3">
                                <div class="col-12">
                                    <label for="imagen_actual">Imagen Actual</label>
                                    <img src="<?php echo base_url('uploads/DatosLocal/' . $imagen->nombre); ?>" id="imagen_actual" alt="Imagen actual" class="img-fluid">
                                </div>
                            </div>
                        <?php endif; ?>
                        <br>
                        <div class="row g-3">
                            <div class="col-12">
                                <label for="imagenes" class="form-label">Seleccionar Imágenes</label>
                                <input type="file" class="form-control" id="imagenes" name="imagenes" multiple accept="image/*" required>
                                <?php if (!empty($imagen)) : ?>
                                    <input type="hidden" name="id" value="<?= $imagen->id ?>">
                                <?php else : ?>
                                    <p>No se encontraron datos.</p>
                                <?php endif; ?>
                            </div>
                            <div class="col-3">
                                <button type="submit" class="btn btn-outline-success" onclick="return confirm('¿Estás seguro de que deseas cambiar el logo del local?');">Cambiar <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-save" viewBox="0 0 16 16">
                                        <path d="M2 1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H9.5a1 1 0 0 0-1 1v7.293l2.646-2.647a.5.5 0 0 1 .708.708l-3.5 3.5a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L7.5 9.293V2a2 2 0 0 1 2-2H14a2 2 
                                        0 0 16 16">
                                            <path d="M2 1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H9.5a1 1 0 0 0-1 1v7.293l2.646-2.647a.5.5 0 0 1 .708.708l-3.5 3.5a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L7.5 9.293V2a2 2 0 0 1 2-2H14a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h2.5a.5.5 0 0 1 0 1z" />
                                    </svg></button>
                            </div>
                            <div class="col-3">
                                <!-- Botón Cancelar -->
                                <button type="button" class="btn btn-outline-secondary" onclick="cancelarCambio()">Cancelar</button>
                            </div>
                        </div>
                    <?php endif; ?>
                </form>
                <?php if ($fila['logo_act'] == 't' && isset($imagen)) : ?>
                    <br>
                    <form method="post" action="<?php echo base_url() ?>ControladorPersonalizacion/EliminarImagenLogo/<?php echo $imagen->id; ?>">
                        <button type="submit" class="btn btn-danger">Eliminar Logo</button>
                    </form>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<?php require_once "application/views/footer/Footer.php"; ?>

<script>
    // Función para cargar la imagen seleccionada en un elemento img
    function previewImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function(e) {
                $('#imagen_actual').attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }

    // Evento change del input file para llamar a la función previewImage
    $('#imagenes').change(function() {
        previewImage(this);
    });

    // Función para cancelar el cambio y mostrar la imagen actual
    function cancelarCambio() {
        $('#imagenes').val('');
        $('#imagen_actual').attr('src', '<?php echo base_url('uploads/DatosLocal/' . $imagen->nombre); ?>');
    }
</script>
