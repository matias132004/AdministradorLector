<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>
<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    Imágenes de Fondo
                </div>
                <div class="card-body">
                    <?php if (empty($imagenes_fondo)): ?>
                        <p>No se encuentran imágenes disponibles</p>
                    <?php else: ?>
                        <div class="table-responsive">
                            <table id="idTabla" class="table table-bordered-lg">
                                <thead>
                                    <tr>
                                        <th>Nombre</th>
                                        <th>Imagen</th>
                                        <th>Eliminar</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($imagenes_fondo as $imagen): ?>
                                        <tr>
                                            <td><?= isset($imagen->nombre) ? $imagen->nombre : 'Nombre no disponible' ?></td>
                                            <td>
                                                <?php if (isset($imagen->nombre)): ?>
                                                    <div>
                                                        <img src="<?= base_url('uploads/DatosLocal/' . $imagen->nombre) ?>" alt="Imagen de Fondo" width="200px" height="200px" class="img-fluid">
                                                    </div>
                                                <?php else: ?>
                                                    <span>No disponible</span>
                                                <?php endif; ?>
                                            </td>
                                            <td><a href="<?= base_url('ControladorPersonalizacion/EliminarImagenFondo/' . $imagen->id) ?>" class="btn btn-outline-danger"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
                                                        <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
                                                    </svg></a></td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>



        <div class="row py-5 justify-content-center">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-dark text-white">
                        Agregar Nuevas Imágenes de Fondo
                    </div>
                    <div class="card-body">
                        <form action="<?= base_url('ControladorPersonalizacion/actualizarImagenesFondo') ?>" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <input type="hidden" name="id_datos_local" value="<?= $datos_local ?>">
                                    <label for="imagenes" class="form-label">Seleccionar Imágenes</label>
                                    <input type="file" class="form-control" id="imagenes" name="imagenes" multiple accept="image/*" required>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Cargar Imágenes</button>
                                        </form>
                                        </div>
                                        </div>
                                        </div>
                                        </div>
                                        </div>

                                        <?php require_once "application/views/footer/Footer.php"; ?>

                                        <script>
                                            $(document).ready(function () {
                                                $("#idTabla").DataTable({
                                                    responsive: true,
                                                    language: {
                                                        "decimal": "",
                                                        "emptyTable": "No hay información",
                                                        "info": "Mostrando _START_ a _END_ de _TOTAL_ Entradas",
                                                        "infoEmpty": "Mostrando 0 a 0 de 0 Entradas",
                                                        "infoFiltered": "(Filtrado de _MAX_ total entradas)",
                                                        "infoPostFix": "",
                                                        "thousands": ",",
                                                        "lengthMenu": "Mostrar _MENU_ Entradas",
                                                        "loadingRecords": "Cargando...",
                                                        "processing": "Procesando...",
                                                        "search": "Buscar:",
                                                        "zeroRecords": "Sin resultados encontrados",
                                                        "paginate": {
                                                            "first": "Primero",
                                                            "last": "Último",
                                                            "next": "Siguiente",
                                                            "previous": "Anterior"
                                                        }
                                                    },
                                                    dom: 'Bfrtip',
                                                    buttons: [
                                                        {
                                                            extend: 'copy',
                                                            text: 'Copiar',
                                                            exportOptions: {
                                                                columns: ':visible:not(:nth-last-child(2), :last-child)' // Excluir las últimas dos columnas
                                                            }
                                                        },
                                                        {
                                                            extend: 'csv',
                                                            text: 'CSV',
                                                            exportOptions: {
                                                                columns: ':visible:not(:nth-last-child(2), :last-child)' // Excluir las últimas dos columnas
                                                            }
                                                        },
                                                        {
                                                            extend: 'excel',
                                                            text: 'Excel',
                                                            exportOptions: {
                                                                columns: ':visible:not(:nth-last-child(2), :last-child)' // Excluir las últimas dos columnas
                                                            }
                                                        },
                                                        {
                                                            extend: 'pdf',
                                                            text: 'PDF',
                                                            exportOptions: {
                                                                columns: ':visible:not(:nth-last-child(2), :last-child)' // Excluir las últimas dos columnas
                                                            }
                                                        },
                                                        {
                                                            extend: 'print',
                                                            text: 'Imprimir',
                                                            exportOptions: {
                                                                columns: ':visible:not(:nth-last-child(2), :last-child)' // Excluir las últimas dos columnas
                                                            }
                                                        }
                                                    ]
                                                });

                                            });
                                        </script>

