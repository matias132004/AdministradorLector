<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>
<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-12">
            <div class="card card-danger">
                <div class="card-header">
                    <h3 class="card-title">Promociones Por Imágenes</h3>
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
                    <div class="d-flex justify-content-end py-1 m-3">
                        <a href="<?php echo base_url() ?>ControladorPromocion/AgregarPromocionComoImagen">
                            <button class="btn btn-outline-success">Agregar Promocion por Imagen<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-file-earmark-plus-fill" viewBox="0 0 16 16">
                                    <path d="M9.293 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.707A1 1 0 0 0 13.707 4L10 .293A1 1 0 0 0 9.293 0M9.5 3.5v-2l3 3h-2a1 1 0 0 1-1-1M8.5 7v1.5H10a.5.5 0 0 1 0 1H8.5V11a.5.5 0 0 1-1 0V9.5H6a.5.5 0 0 1 0-1h1.5V7a.5.5 0 0 1 1 0" />
                                </svg></button>
                        </a>
                    </div>
                    <?php if (empty($promociones)) : ?>
                        <p>No se encuentran Promociones disponibles</p>
                    <?php else : ?>
                        <div class="table-responsive">
                            <table id="idTabla" class="table table-bordered-lg">
                                <thead>
                                    <tr>
                                        <th scope="col">Id Promoción</th>
                                        <th scope="col">Fecha de Inicio</th>
                                        <th scope="col">Fecha de Fin</th>
                                        <th scope="col">Días Aplicables</th>
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Imagen</th>
                                        <th scope="col">Editar</th>
                                        <th scope="col">Eliminar</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($promociones as $promocion) : ?>
                                        <tr>
                                            <td><?= $promocion->id_promocion_imagen ?></td>
                                            <td><?= $promocion->fecha_inicio ?></td>
                                            <td><?= $promocion->fecha_fin ?></td>
                                            <td>
                                                <?php
                                                $dias_aplicables = [];
                                                if ($promocion->lunes === 't') {
                                                    array_push($dias_aplicables, 'Lunes');
                                                }
                                                if ($promocion->martes === 't') {
                                                    array_push($dias_aplicables, 'Martes');
                                                }
                                                if ($promocion->miercoles === 't') {
                                                    array_push($dias_aplicables, 'Miércoles');
                                                }
                                                if ($promocion->jueves === 't') {
                                                    array_push($dias_aplicables, 'Jueves');
                                                }
                                                if ($promocion->viernes === 't') {
                                                    array_push($dias_aplicables, 'Viernes');
                                                }
                                                if ($promocion->sabado === 't') {
                                                    array_push($dias_aplicables, 'Sábado');
                                                }
                                                if ($promocion->domingo === 't') {
                                                    array_push($dias_aplicables, 'Domingo');
                                                }

                                                if (empty($dias_aplicables)) {
                                                    array_push($dias_aplicables, 'No aplica');
                                                }
                                                echo implode(', ', $dias_aplicables);
                                                ?>
                                            </td>
                                            <td><?= isset($promocion->nombre) ? $promocion->nombre : 'Nombre no disponible' ?></td>
                                            <td>
                                                <?php if (isset($promocion->nombre)) : ?>
                                                    <div>
                                                        <img src="<?= base_url('uploads/Promocion/' . $promocion->nombre) ?>" alt="Imagen de Fondo" width="200px" height="200px" class="img-fluid">
                                                    </div>
                                                <?php else : ?>
                                                    <span>No disponible</span>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <a href="<?= base_url('ControladorPromocion/cargarEditarPromocionImagen/' . $promocion->id_promocion_imagen) ?>"><button class="btn btn-outline-warning"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pen" viewBox="0 0 16 16">
                                                            <path d="m13.498.795.149-.149a1.207 1.207 0 1 1 1.707 1.708l-.149.148a1.5 1.5 0 0 1-.059 2.059L4.854 14.854a.5.5 0 0 1-.233.131l-4 1a.5.5 0 0 1-.606-.606l1-4a.5.5 0 0 1 .131-.232l9.642-9.642a.5.5 0 0 0-.642.056L6.854 4.854a.5.5 0 1 1-.708-.708L9.44.854A1.5 1.5 0 0 1 11.5.796a1.5 1.5 0 0 1 1.998-.001m-.644.766a.5.5 0 0 0-.707 0L1.95 11.756l-.764 3.057 3.057-.764L14.44 3.854a.5.5 0 0 0 0-.708z" />
                                                        </svg></button>
                                                </a>
                                            </td>
                                            <td>
                                                <a href="<?= base_url('ControladorPromocion/EliminarPromocionPorImagen/' . $promocion->id_promocion_imagen) ?>" class="btn btn-outline-danger">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z" />
                                                        <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z" />
                                                    </svg>
                                                </a>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</div>
<?php require_once "application/views/footer/Footer.php"; ?>
<script>
    $(document).ready(function() {
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
            buttons: [{
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