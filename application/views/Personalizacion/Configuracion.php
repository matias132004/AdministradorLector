<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>

<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-md-8"> <!-- Colocando el formulario en una columna de tamaño medio -->
        <div class="card card-danger">
                <div class="card-header">
                    <h3 class="card-title">Configuraciones del Lector</h3>
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
                    <form method="post" action="<?php echo base_url() ?>ControladorConfiguracion/ModificarConfiguracion" method="POST">
                        <div class="row">
                            <input type="hidden" name="id_configuracion" value="<?php echo $configuraciones['id_configuracion']; ?>">
                               <div class="col-6">
                                    <label for="venta_volumen">Venta Volumen:</label>
                                    <input type="checkbox" name="venta_volumen" <?php echo ($configuraciones['venta_volumen'] == 't') ? 'checked' : ''; ?> data-toggle="toggle" data-size="xs">
                                </div>   
                                <div class="col-6">
                                    <label for="dictado_precios">Dictado de Precios:</label>
                                    <input type="checkbox" name="dictado_precios" <?php echo ($configuraciones['dictado_precios'] == 't') ? 'checked' : ''; ?> data-toggle="toggle" data-size="xs">
                                </div>
                                <div class="col-6">
                                    <label for="imagen_act">Imagen Activada:</label>
                                    <input type="checkbox" name="imagen_act" <?php echo ($configuraciones['imagen_act'] == 't') ? 'checked' : ''; ?> data-toggle="toggle" data-size="xs">
                                </div>
                                  <div class="col-6">
                                    <label for="precio_old_act">Mostrar Precio Antiguo:</label>
                                    <input type="checkbox" name="precio_old_act" <?php echo ($configuraciones['precio_old_act'] == 't') ? 'checked' : ''; ?> data-toggle="toggle" data-size="xs">
                                </div>
                        </div>
                        <button type="submit" class="btn btn-outline-primary">Guardar Configuración <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-save" viewBox="0 0 16 16">
                                <path d="M2 1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H9.5a1 1 0 0 0-1 1v7.293l2.646-2.647a.5.5 0 0 1 .708.708l-3.5 3.5a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L7.5 9.293V2a2 2 0 0 1 2-2H14a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h2.5a.5.5 0 0 1 0 1z"/>
                            </svg></button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<?php require_once "application/views/footer/Footer.php"; ?>
