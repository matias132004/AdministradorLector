<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>

<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    Configuraciones del Lector.
                </div>
                <div class="card-body">
                    <?php $fila = $configuraciones; ?>
                    <form id="configuracionForm" method="post" action="<?php echo base_url() ?>ControladorConfiguracionPromocion/ModificarConfiguracion">
                        <div class="row">
                            <div class="col-4">
                                <label for="colorPrincipal">Color Principal:</label>
                                <input type="color" id="colorPrincipal" name="colorPrincipal" value="<?php echo $fila->colorprincipal; ?>" />
                            </div>
                            <div class="col-4">
                                <label for="colorSecundario">Color Secundario:</label>
                                <input type="color" id="colorSecundario" name="colorSecundario" value="<?php echo $fila->colorsecundario; ?>" />
                            </div>
                            <div class="col-4">
                                <label for="colorFuentePrincipal">Color de la fuente Principal:</label>
                                <input type="color" id="colorFuentePrincipal" name="colorFuentePrincipal" value="<?php echo $fila->colorfuenteprincipal; ?>" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-4">
                                <label for="colorFuenteSecundario">Color de la fuente Secundaria:</label>
                                <input type="color" id="colorFuenteSecundario" name="colorFuenteSecundario" value="<?php echo $fila->colorfuentesecundario; ?>" />
                            </div>
                            <div class="col-4">
                                <label for="fontFamily">Fuente de Letras:</label>
                                <select id="fontFamily" name="fontFamily" class="form-control">
                                    <?php foreach ($fuentes as $fuente) { ?>
                                        <option value="<?= $fuente['id_fuente'] ?>" <?php echo ($fuente['id_fuente'] == $fila->id_fuente) ? 'selected' : ''; ?>>
                                            <?= $fuente['nombre_fuente'] ?>
                                        </option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-outline-primary" id="guardarConfiguracionBtn">Guardar Configuración
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-save" viewBox="0 0 16 16">
                                <path d="M2 1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H9.5a1 1 0 0 0-1 1v7.293l2.646-2.647a.5.5 0 0 1 .708.708l-3.5 3.5a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L7.5 9.293V2a2 2 0 0 1 2-2H14a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h2.5a.5.5 0 0 1 0 1z" />
                            </svg>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div> 

<?php require_once "application/views/footer/Footer.php"; ?>
<script>
</script>
