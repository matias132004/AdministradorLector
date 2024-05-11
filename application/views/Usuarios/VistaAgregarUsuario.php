<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>
<?php if ($this->session->flashdata('alerta')) { ?>
    <script>alert("<?php echo $this->session->flashdata('alerta'); ?>");</script>
<?php } ?>

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-lg-6"> <!-- Dividir en dos columnas -->
            <div class="card">
                <div class="card-header bg-dark text-white">
                    Crear Usuario
                </div>
                <div class="card-body">
                    <form action="<?php echo base_url() ?>ControladorUsuarios/registroUsuario" method="post">
                        <div class="row"> <!-- Dividir en filas -->
                            <div class="col-md-6"> <!-- Dividir en dos columnas en la fila -->
                                <label for="Rut" class="form-label">Rut</label>
                                <input type="text" class="form-control" id="Rut" name="Rut" required placeholder="Ej: 12345678-9">
                            </div>

                            <div class="col-md-6">
                                <label for="nombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required >
                            </div>

                            <div class="col-md-6">
                                <label for="apellido1" class="form-label">Apellido 1</label>
                                <input type="text" class="form-control" id="apellido1" name="apellido1" required >
                            </div>

                            <div class="col-md-6">
                                <label for="apellido2" class="form-label">Apellido 2</label>
                                <input type="text" class="form-control" id="apellido2" name="apellido2" required >
                            </div>

                            <div class="col-md-6">
                                <label for="correo" class="form-label">Correo Electrónico</label>
                                <input type="email" class="form-control" id="correo" name="correo" required placeholder="Ej: usuario@example.com">
                            </div>

                            <div class="col-md-6">
                                <label for="telefono" class="form-label">Teléfono</label>
                                <input type="number" class="form-control" id="telefono" name="telefono" required min="0" minlength="9" maxlength="9" placeholder="Ej: 987654321" >
                            </div>

                            <div class="col-md-6">
                                <label for="contrasena" class="form-label">Contraseña</label>
                                <input type="password" class="form-control" id="contrasena" name="contrasena" minlength="6" maxlength="25" required >
                            </div>

                            <div class="col-md-6">
                                <label for="genero" class="form-label">Género</label>
                                <select class="form-select" id="genero" name="genero" required>
                                    <option value="" selected disabled hidden>Seleccione su género</option>
                                    <?php foreach ($generos as $genero) : ?>
                                        <option value="<?= $genero['id_genero'] ?>"><?= $genero['nombre_genero'] ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label for="tipo_usuario" class="form-label">Tipo de Usuario</label>
                                <select class="form-select" id="tipo_usuario" name="tipo_usuario" required>
                                    <option value="" selected disabled hidden>Seleccione el tipo de usuario</option>
                                    <?php foreach ($tipos_usuario as $tipo_usuario) : ?>
                                        <option value="<?= $tipo_usuario['id_tipo_usuario'] ?>"><?= $tipo_usuario['nombre_tipo_usuario'] ?></option>
                                    <?php endforeach; ?>
                                </select>
                                <br>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-outline-primary">Guardar <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-save" viewBox="0 0 16 16">
                            <path d="M2 1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H9.5a1 1 0 0 0-1 1v7.293l2.646-2.647a.5.5 0 0 1 .708.708l-3.5 3.5a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L7.5 9.293V2a2 2 0 0 1 2-2H14a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h2.5a.5.5 0 0 1 0 1z"/>
                            </svg></button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<?php require_once "application/views/footer/Footer.php"; ?>

<script>

// Event listener para validar el número de teléfono antes de enviar el formulario
    document.querySelector('form').addEventListener('submit', function (e) {
        if (!validarTelefono()) {
            e.preventDefault();
        }
    });

    function formatRut(rut) {
        rut = rut.replace(/[^\dkK.-]/g, ''); // Eliminar caracteres no permitidos
        rut = rut.replace(/-/g, ''); // Eliminar guiones
        var body = rut.slice(0, -1);
        var verifier = rut.slice(-1);
        body = body.replace(/\D/g, ''); // Eliminar caracteres no numéricos
        body = body.replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.'); // Agregar puntos al cuerpo del RUT
        return body + '-' + verifier; // Agregar guión y dígito verificador
    }

    // Evento que se activa al escribir en el campo RUT
    document.getElementById('Rut').addEventListener('input', function (event) {
        var rutInput = event.target;
        if (rutInput.value.length <= 12) {
            var formattedRut = formatRut(rutInput.value);
            rutInput.value = formattedRut;
        } else {
            rutInput.value = rutInput.value.slice(0, 12);
        }
    });
</script>