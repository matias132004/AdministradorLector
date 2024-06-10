<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>

<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    Editar Promoción
                </div>
                <div class="card-body">
                    <?php $fila = $promocion; ?>

                    <form method="post" action="<?php echo base_url() ?>ControladorPromocion/actualizar_promocion_por_imagen">
                        <input type="hidden" name="id_promocion" value="<?php echo $fila['id_promocion_imagen']; ?>">
                        <div class="form-group">
                            <label for="fecha_inicio">Fecha de Inicio:</label>
                            <input type="date" class="form-control" id="fecha_inicio" name="fecha_inicio" required value="<?php echo $fila['fecha_inicio']; ?>">
                        </div>
                        <div class="form-group">
                            <label for="fecha_termino">Fecha de Término:</label>
                            <input type="date" class="form-control" id="fecha_termino" name="fecha_termino" required value="<?php echo $fila['fecha_fin']; ?>">
                        </div>        
                        <div class="mt-3">
                            <h5>Días donde aplica la promoción</h5>
                            <div class="row g-3">
                                <?php $diasSemana = array('lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo'); ?>
                                <?php foreach ($diasSemana as $dia) : ?>
                                    <div class="col-6">
                                        <label for="<?php echo $dia; ?>" class="form-check-label"><?php echo ucfirst($dia); ?></label>
                                        <input type="hidden" name="<?php echo $dia; ?>" value="false"> <!-- Hidden input para enviar false si el checkbox no está marcado -->
                                        <input type="checkbox" name="<?php echo $dia; ?>" id="<?php echo $dia; ?>" class="form-check-input" data-toggle="toggle" data-size="xs" <?php echo ($fila[$dia] == 't') ? 'checked' : ''; ?>>
                                    </div>
                                <?php endforeach; ?>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary mt-3">Guardar Cambios</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<?php require_once "application/views/footer/Footer.php"; ?>
