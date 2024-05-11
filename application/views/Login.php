</html>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Administrador Lector</title>

        <!-- Google Font: Source Sans Pro -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="<?php echo base_url() ?>/plugins/fontawesome-free/css/all.min.css">
        <!-- icheck bootstrap -->
        <link rel="stylesheet" href="<?php echo base_url() ?>/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="<?php echo base_url() ?>/dist/css/adminlte.min.css">
        <link rel="shortcut icon" type="image/png" href="<?php echo base_url() ?>/assets/images/logos/favicon.png" />
        <link rel="stylesheet" href="<?php echo base_url() ?>/assets/css/styles.min.css" />
    </head>

    <body class="hold-transition login-page">
        <div class="login-box">
            <div class="card card-outline card-primary">
                <div class="card-header text-center">
                    <b class="h1">Administrador Lector</b>
                </div>
                <div class="card-body">
                    <p class="login-box-msg">Ingrese sus datos para iniciar Sesión</p>
                    <?php if (isset($error)): ?>
                        <div class="alert alert-danger" role="alert">
                            <?php echo $error; ?>
                        </div>
                    <?php endif; ?>
                   <form id="loginForm" action="<?php echo base_url('ControladorLogin/Login'); ?>" method="post">
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" placeholder="RUT" id="camporut" name="rut" maxlength="12">
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-user"></span>
                                </div>
                            </div>
                        </div>
                        <div class="input-group mb-3">
                            <input type="password" class="form-control" placeholder="Password" id="Contrasena" name="password" maxlength="28">
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-lock"></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <div class="icheck-primary">
                                    <input type="checkbox" id="Recuerdame" name="remember">
                                    <label for="Recuerdame">
                                        Recuerdame
                                    </label>
                                </div>
                            </div>

                            <div class="col-12">
                                <button type="submit" class="btn btn-primary btn-block">Iniciar Sesion</button>
                            </div>

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <!-- jQuery -->
    <script src="<?php echo base_url() ?>/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="<?php echo base_url() ?>/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="<?php echo base_url() ?>/dist/js/adminlte.min.js"></script>


    <script>
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
        document.getElementById('camporut').addEventListener('input', function (event) {
            var rutInput = event.target;
            if (rutInput.value.length <= 12) {
                var formattedRut = formatRut(rutInput.value);
                rutInput.value = formattedRut;
            } else {
                rutInput.value = rutInput.value.slice(0, 12);
            }
        });

        function getCookie(camporut) {
            const value = "; " + document.cookie;
            const parts = value.split("; " + camporut + "=");
            if (parts.length === 2)
                return parts.pop().split(";").shift();
        }

        function setCookie(camporut, value, days) {
            const date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            const expires = "expires=" + date.toUTCString();
            document.cookie = camporut + "=" + value + ";" + expires + ";path=/";
        }

        const rutInput = document.getElementById("camporut");
        const rememberedRut = getCookie("rememberedRut");
        if (rememberedRut) {
            rutInput.value = rememberedRut;
            document.getElementById("Recuerdame").checked = true;
        }

        document.querySelector("form").addEventListener("submit", function (event) {
            if (document.getElementById("Recuerdame").checked) {
                const rutValue = rutInput.value;
                setCookie("rememberedRut", rutValue, 30);
            } else {
                document.cookie = "rememberedRut=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
            }
        });
    </script>
</body>

</html>
