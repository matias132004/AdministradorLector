<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>

<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-12">
            <div class="card">
                <?php if (isset($error)): ?>
                    <p><?php echo $error; ?></p>
                <?php else: ?>
                    <h3>Cambiar Imagen:</h3>
                    <img src="<?php echo base_url('uploads/Promocion/' . $imagen->nombre); ?>" alt="Imagen actual" class="img-fluid">

                    <form action="<?php echo site_url('ControladorImagen/ActualizarImagenPromocion'); ?>" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="id_promocion" value="<?php echo $imagen->id_promocion; ?>">
                        <label for="imagenes" class="form-label">Seleccionar Imagen</label>
                        <input type="file" class="form-control" id="imagenes" name="image" multiple accept="image/*" required>
                        <br>
                        <br>
                        <button type="submit" class="btn btn-outline-primary">Cargar Nueva Imagen</button>
                    </form>
                    <br>
                    <a href="<?php echo base_url() ?>ControladorImagen/EliminarImagenPromocion/<?php echo $imagen->id_promocion; ?>">
                        <button class="btn btn-outline-danger">Eliminar imagen</button>
                    </a>

                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<?php require_once "application/views/footer/Footer.php"; ?>
