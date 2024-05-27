<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>

<div class="container mt-4">
    <div class="row"> 
        <div class="d-sm-flex d-block align-items-center justify-content-between mb-lg-9">
            <div class="col-lg-12 m-6">
          <div class="card card-danger">
                <div class="card-header">
                    <h3 class="card-title">Opciones de Operabilidad.</h3>
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
                        <button id="btnSincronizar" class="btn btn-outline-success mb-3">Sincronizar Datos con dat@PDV</button>
                        <button id="btnMostrarModal" class="btn btn-outline-primary mb-3">Ver QR</button>
                        <a href="https://www.remove.bg/es" target="_blank" class="btn btn-outline-primary mb-3">Pagina Web para eliminar fondo de imagenes</a>
                        <a href="http://192.168.1.157/Lector_Precios/ControladorLogin/index" target="_blank" class="btn btn-outline-primary mb-3">Acceder a Lector de Precios</a>
                    </div>
                </di>
            </div>
        </div>
    </div>
</div>


<!-- Modal -->
<div id="qrModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="qrModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="qrModalLabel">Código QR</h5>
                <button type="button" id="cerrar2" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="modalContent">
                <!-- Contenido del modal aquí -->
            </div>
            <div class="modal-footer">
                <button id="btnDescargarQR" class="btn btn-primary">Descargar QR</button>
            </div>
        </div>
    </div>
</div>

<?php require_once "application/views/footer/Footer.php"; ?>

<script>
    var qrData = window.location.href;
    var qrSize = '200x200';
    var apiUrl = 'http://api.qrserver.com/v1/create-qr-code/';
    var qrUrl = apiUrl + '?data=' + encodeURIComponent(qrData) + '&size=' + qrSize;

    document.getElementById('btnSincronizar').addEventListener('click', function () {
        if (confirm('¿Estás seguro de sincronizar los datos con el PDV y perder algunos cambios realizados en el sistema?')) {
            window.location.href = "http://192.168.1.157/ApiLector/obtenerFamilias.php";
        }
    });

    document.getElementById('btnMostrarModal').addEventListener('click', function () {
        $('#qrModal').modal('show');
        document.getElementById('modalContent').innerHTML = '<img src="' + qrUrl + '">';
    });

    document.getElementById('cerrar2').addEventListener('click', function () {
        $('#qrModal').modal('hide');
    });

    document.getElementById('btnDescargarQR').addEventListener('click', function () {
        var link = document.createElement('a');
        link.href = qrUrl;
        link.download = 'qr_modal.jpg';
        link.click();
    });
</script>
