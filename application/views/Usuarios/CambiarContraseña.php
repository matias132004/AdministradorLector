<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    Cambiar Contraseña
                </div>
                <div class="card-body">
                    <form id="cambiarContrasenaForm" action="<?php echo base_url() ?>ControladorUsuarios/CambiarContrasena" method="post">
                        <div class="row">
                            <div class="col-md-6">
                                <label for="contrasena_antigua" class="form-label">Contraseña Antigua</label>
                                <input type="password" class="form-control" id="contrasena_antigua" name="contrasena_antigua" minlength="6" maxlength="30" required placeholder="Ejemplo: Contraseña123">
                            </div>
                            <div class="col-md-6">
                                <label for="nueva_contrasena" class="form-label">Nueva Contraseña</label>
                                <input type="password" class="form-control" id="nueva_contrasena" name="nueva_contrasena" minlength="6" maxlength="12" required placeholder="Ejemplo: Contraseña123">
                                <br>  
                            </div>
                        </div>
                        <button type="button" class="btn btn-primary" onclick="confirmarCambioContrasena()">Cambiar Contraseña</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<?php require_once "application/views/footer/Footer.php"; ?>

<script>
function confirmarCambioContrasena() {
    if (confirm("¿Estás seguro de que deseas cambiar la contraseña?")) {
        document.getElementById("cambiarContrasenaForm").submit();
    }
}
</script>
