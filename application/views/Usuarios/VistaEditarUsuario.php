<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    Editar Usuario
                </div>
                <div class="card-body">
                    <?php $fila = $datoUsuario->row_array(); ?>
                    <form action="<?= base_url() ?>ControladorUsuarios/editarUsuario" method="post">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="Rut" class="form-label">Rut</label>
                                <input type="text" class="form-control" id="Rut" name="Rut" required value="<?= $fila['rut'] ?>">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="nombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required value="<?= $fila['nombre_usuario'] ?>">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="apellido1" class="form-label">Apellido 1</label>
                                <input type="text" class="form-control" id="apellido1" name="apellido1" required value="<?= $fila['apellido1'] ?>">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="apellido2" class="form-label">Apellido 2</label>
                                <input type="text" class="form-control" id="apellido2" name="apellido2" required value="<?= $fila['apellido2'] ?>">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="correo" class="form-label">Correo Electrónico</label>
                                <input type="email" class="form-control" id="correo" name="correo" required value="<?= $fila['correo'] ?>">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="telefono" class="form-label">Teléfono</label>
                                <input type="num" class="form-control" id="telefono" name="telefono"   minlength="9" maxlength="9"  required value="<?= $fila['telefono'] ?>">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="tipo_usuario" class="form-label">Tipo de Usuario</label>
                                <select class="form-select" id="tipo_usuario" name="id_tipo_usuario" required>
                                    <?php foreach ($tipos_usuario as $tipo_usuario) { ?>
                                        <option value="<?= $tipo_usuario['id_tipo_usuario'] ?>" <?php echo ($fila['id_tipo_usuario'] == $tipo_usuario['id_tipo_usuario']) ? 'selected' : ''; ?>>
                                            <?= $tipo_usuario['nombre_tipo_usuario'] ?></option>
                                    <?php } ?>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="genero" class="form-label">Género</label>
                                <select class="form-select" id="genero" name="id_genero" required>
                                    <?php foreach ($generos as $genero) : ?>
                                        <option value="<?= $genero['id_genero'] ?>" <?= ($fila['id_genero'] == $genero['id_genero']) ? 'selected' : '' ?>>
                                            <?= $genero['nombre_genero'] ?>
                                        </option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                        </div>
                        <input type="hidden" name="id_usuario" value="<?= $fila['id_usuario'] ?>">
                        <button type="submit" class="btn btn-primary" onclick="return confirm('¿Estás seguro de que deseas modificar los datos del usuario?');">Editar Usuario</button>
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