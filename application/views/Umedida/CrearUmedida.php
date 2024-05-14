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
                            <div class="col-6">
                                <label for="idNombreUmedida" class="form-label">Nombre de la Unidad de Medida</label>
                                <input type="text" name="CampoNombreUmedida" id="idNombreUmedida" class="form-control" required autofocus>
                            </div>
                            <div class="col-6">
                                <label for="idNombreCorto" class="form-label">Nombre Corto</label>
                                <input type="text" name="CampoNombreCorto" id="idNombreCorto" class="form-control" required>
                            </div>
                        </div>
                        <br>
                        <input type="submit" value="Guardar" class="btn btn-primary">

                    </form>

                </div>
            </div>
        </div>
    </div>
</div>
<?php require_once "application/views/footer/Footer.php"; ?>