<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>
<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    Modificar Datos del Local
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
                                <label for="Descripcion" class="form-label">Titulo</label>
                                <input type="text" class="form-control" id="DescripcionLocal" name="Descripcion" required value="<?= $fila['descripcion'] ?>">
                            </div>
                        </div>
                        <div class="row g-3">
                            <div class="col-12">
                                <br>
                                <label for="logo">Logo en pantalla</label>
                                <input type="hidden" name="logo_act" value="f">
                                <input type="checkbox" id="logo" name="logo_act" <?= $fila['logo_act'] == 't' ? 'checked' : '' ?> data-toggle="toggle" data-size="xs">
                            </div>
                        </div>

                        <input type="hidden" name="id_datos_local" value="<?= $fila['id_datos_local'] ?>">
                        <br>
                        <button type="submit" class="btn btn-outline-primary" onclick="return confirm('¿Estás seguro de que deseas modificar los datos del local?');">Guardar <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-save" viewBox="0 0 16 16">
                                <path d="M2 1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H9.5a1 1 0 0 0-1 1v7.293l2.646-2.647a.5.5 0 0 1 .708.708l-3.5 3.5a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L7.5 9.293V2a2 2 0 0 1 2-2H14a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h2.5a.5.5 0 0 1 0 1z" />
                            </svg></button>
                    </form>
                    <form action=" <?php echo site_url('ControladorPersonalizacion/ActualizarImagenLocal'); ?> " method="post" enctype="multipart/form-data">
                        <?php if ($fila['logo_act'] == 't') : ?>
                            <input type="hidden" name="id_datos_local2" value="<?= $fila['id_datos_local'] ?>">
                            <?php if ($fila['logo_act'] == 't' && isset($imagen)) : ?>
                                <div class="row g-3">
                                    <div class="col-12">
                                        <label for="imagen_actual">Imagen Actual</label>
                                        <img src="<?php echo base_url('uploads/DatosLocal/' . $imagen->nombre); ?>" alt="Imagen actual" class="img-fluid">
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
                                            <path d="M2 1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H9.5a1 1 0 0 0-1 1v7.293l2.646-2.647a.5.5 0 0 1 .708.708l-3.5 3.5a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L7.5 9.293V2a2 2 0 0 1 2-2H14a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h2.5a.5.5 0 0 1 0 1z" />
                                        </svg></button>
                                </div>
                            </div>
                        <?php endif; ?>
                    </form>
                    <?php if ($fila['logo_act'] == 't' && isset($imagen)) : ?>
                        <form method="post" action="<?php echo base_url() ?>ControladorPersonalizacion/EliminarImagenLogo/<?php echo $imagen->id; ?>">
                            <button type="submit" class="btn btn-danger">Eliminar Logo</button>
                        </form>
                    <?php endif; ?>
                    <a href="<?php echo base_url() ?>ControladorPersonalizacion/CargarImagenesFondo/<?php echo $fila['id_datos_local'] ?>"><button class="btn btn-outline-success">Seleccionar Imagenes de Fondo</button></a>
                </div>
            </div>
        </div>
    </div>
</div>
<?php require_once "application/views/footer/Footer.php"; ?>
