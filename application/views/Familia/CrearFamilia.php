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
                    
                    <form action="<?php echo base_url() ?>ControladorFamilia/GuardarFamilia" method="POST">
                        <div class="row g-3">
                            <div class="col">
                                <label for="idNombreFamilia" class="form-label">Nombre de la Familia</label>
                                <input type="text" name="CampoNombreFamilia" id="idNombreFamilia" class="form-control" required autofocus>
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

<?php
