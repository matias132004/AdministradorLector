<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>

<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-md-8">
        <div class="card card-danger">
                <div class="card-header">
                    <h3 class="card-title">Configuracion de La promocion</h3>
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
                    <?php $fila = $configuraciones; ?>
                    <form id="configuracionForm" method="post" action="<?php echo base_url() ?>ControladorConfiguracionPromocion/ModificarConfiguracion">
                        <div class="row">
                            <div class="col-6">
                                <label for="camponombre">Nombre:</label>
                                <input type="text" id="camponombre" name="camponombre" class="form-control" value="<?php echo $fila->nombre; ?>" />
                            </div>
                            <div class="col-6">
                                <label for="colorPrincipal">Color Principal:</label>
                                <br>
                                <input type="color" id="colorPrincipal" name="colorPrincipal" value="<?php echo $fila->colorprincipal; ?>" />
                            </div>
                            <div class="col-6">
                                <label for="colorSecundario">Color Secundario:</label>
                                <br>
                                <input type="color" id="colorSecundario" name="colorSecundario" value="<?php echo $fila->colorsecundario; ?>" />
                            </div>
                            <div class="col-6">
                                <label for="colorFuentePrincipal">Color de la fuente Principal:</label>
                                <br>
                                <input type="color" id="colorFuentePrincipal" name="colorFuentePrincipal" value="<?php echo $fila->colorfuenteprincipal; ?>" />
                            </div>
                            <div class="col-6">
                                <label for="colorFuenteSecundario">Color de la fuente Secundaria:</label>
                                <br>
                                <input type="color" id="colorFuenteSecundario" name="colorFuenteSecundario" value="<?php echo $fila->colorfuentesecundario; ?>" />
                            </div>
                            <div class="col-6">
                                <label for="fontFamily">Fuente de Letras:</label>
                                <select id="fontFamily" name="fontFamily" class="form-control">
                                    <?php foreach ($fuentes as $fuente) { ?>
                                        <option value="<?= $fuente['id_fuente'] ?>" <?php echo ($fuente['id_fuente'] == $fila->id_fuente) ? 'selected' : ''; ?>>
                                            <?= $fuente['nombre_fuente'] ?>
                                        </option>
                                    <?php } ?>
                                </select>
                            </div>
                            <div class="col-6">
                                <label for="destacado">Texto Destacado:</label>
                                <select id="destacado" name="destacado" class="form-control">
                                    <?php foreach ($destacados as $destacado) { ?>
                                        <option value="<?= $destacado['id_destacado'] ?>" <?php echo ($destacado['id_destacado'] == $fila->id_destacado) ? 'selected' : ''; ?>>
                                            <?= $destacado['nombre_destacado'] ?>
                                        </option>
                                    <?php } ?>
                                </select>
                            </div>

                        </div>
                        <br>
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