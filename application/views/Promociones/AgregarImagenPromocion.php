<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>

<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-12">
            <div class="card shadow border-0">
                <form action="<?php echo site_url('ControladorImagen/upload'); ?>" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id_promocion" value="<?php echo $idPromocion; ?>">

                    <div class="form-group">
                        <label for="image" class="form-label">Seleccionar Imagen</label>
                        <input type="file" class="form-control" id="image" name="image" multiple accept="image/*" required>
                    </div>

                    <button type="submit" class="btn btn-outline-primary">Cargar Imagen</button>
                </form>
            </div>
        </div>
    </div>
</div>

<?php require_once "application/views/footer/Footer.php"; ?>
