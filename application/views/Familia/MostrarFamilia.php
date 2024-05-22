<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-lg-12">
        <div class="card card-danger">
                <div class="card-header">
                    <h3 class="card-title">Listado de Familias</h3>
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
                        <a href="<?php echo base_url() ?>ControladorFamilia/AgregarFamilia">
                            <button class="btn btn-outline-success">Agregar Familia<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-file-earmark-plus-fill" viewBox="0 0 16 16">
                                    <path d="M9.293 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.707A1 1 0 0 0 13.707 4L10 .293A1 1 0 0 0 9.293 0M9.5 3.5v-2l3 3h-2a1 1 0 0 1-1-1M8.5 7v1.5H10a.5.5 0 0 1 0 1H8.5V11a.5.5 0 0 1-1 0V9.5H6a.5.5 0 0 1 0-1h1.5V7a.5.5 0 0 1 1 0"/>
                                </svg></button>
                        </a>
                        <button id="btnEliminar" class="btn btn-outline-danger">
                            Eliminar Todo
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z" />
                                <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z" />
                            </svg>
                            </button> 
                    </div>
                    <?php if (!empty($datos)) : ?>
                        <div class="table-responsive">
                            <table id="idTabla" class="table table-bordered-lg">
                                <thead>
                                    <tr>
                                        <th scope="col">Id Familia </th>
                                        <th scope="col">Nombre Familia</th>
                                        <th scope="col">Estado</th>
                                        <th scope="col">Editar</th>
                                        <th scope="col">Eliminar</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($datos as $dato) : ?>
                                        <tr>
                                            <td><?= $dato['id_familia'] ?></td>
                                            <td><?= $dato['nombre_familia'] ?></td>
                                            <td><?= $dato['nombre_estado'] ?></td>
                                            <td>
                                                <a href="<?php echo base_url() ?>ControladorFamilia/CargarEditarFamilia/<?php echo $dato['id_familia'] ?>"><button class="btn btn-outline-warning"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pen" viewBox="0 0 16 16">
                                                            <path d="m13.498.795.149-.149a1.207 1.207 0 1 1 1.707 1.708l-.149.148a1.5 1.5 0 0 1-.059 2.059L4.854 14.854a.5.5 0 0 1-.233.131l-4 1a.5.5 0 0 1-.606-.606l1-4a.5.5 0 0 1 .131-.232l9.642-9.642a.5.5 0 0 0-.642.056L6.854 4.854a.5.5 0 1 1-.708-.708L9.44.854A1.5 1.5 0 0 1 11.5.796a1.5 1.5 0 0 1 1.998-.001m-.644.766a.5.5 0 0 0-.707 0L1.95 11.756l-.764 3.057 3.057-.764L14.44 3.854a.5.5 0 0 0 0-.708z"/>
                                                        </svg></button></a>
                                            </td>
                                            <td>
                                                <button class="btn btn-outline-danger btn-eliminar" data-id="<?= $dato['id_familia'] ?>"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
                                                        <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
                                                    </svg></button>
                                            </td>  
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        <?php else : ?>
                            <p>No se encontraron datos.</p>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="confirmarEliminarModal" tabindex="-1" role="dialog" aria-labelledby="confirmarEliminarModalLabel"  aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmarEliminarModalLabel">Confirmar Eliminación</h5>
                <button type="button" class="close" data-dismiss="modal" id="Close" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                ¿Está seguro de que desea eliminar este elemento permanentemente?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" id= "Cancelar" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-danger" id="eliminarPermanentemente">Eliminar Permanentemente</button>
                <button type="button" class="btn btn-warning" id="desactivar">Desactivar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="confirmDeleteModal" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmDeleteModalLabel">Confirmar eliminación</h5>
                <button type="button" class="close" id="btnCancelar2" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="eliminarConfirmarForm" action="<?php echo base_url() ?>ControladorFamilia/deleteTodo" method="post">
                <div class="modal-body">
                    <p>Por favor, ingresa tu contraseña para confirmar la eliminación:</p>
                    <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Contraseña">
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-danger" id="confirmDeleteBtn">Eliminar</button>
            </form>
            <button type="button" id="btnCancelar" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>

        </div>
        </form>
    </div>
</div>
</div>


<?php require_once "application/views/footer/Footer.php"; ?>

<script>
    $(document).ready(function() {
        $("#btnEliminar").click(function() {
        $('#confirmDeleteModal').modal('show');
    });


        $('#btnCancelar').on('click', function() {
            $('#confirmDeleteModal').modal('hide');
        });

        $('#btnCancelar2').on('click', function() {
            $('#confirmDeleteModal').modal('hide');
        });

        $(".btn-eliminar").click(function () {
            // Obtener el ID del elemento a eliminar
            var idEliminar = $(this).data('id');
            // Guardar el ID en un atributo data del botón de confirmación del modal
            $("#eliminarPermanentemente").data('id-eliminar', idEliminar);
            // Guardar el ID también en el botón de desactivar
            $("#desactivar").data('id-eliminar', idEliminar);
            // Mostrar el modal
            $("#confirmarEliminarModal").modal('show');
        });

        $("#eliminarPermanentemente").click(function () {
            var idEliminar = $(this).data('id-eliminar');
            window.location.href = "<?php echo base_url() ?>ControladorFamilia/EliminarFamilia/" + idEliminar;
        });
        $("#Cancelar,#Close").click(function () {
            $('#confirmarEliminarModal').modal('hide');
        });
        $("#desactivar").click(function () {
            var idEliminar = $(this).data('id-eliminar');
            window.location.href = "<?php echo base_url() ?>ControladorFamilia/deshabilitarFamilia/" + idEliminar;
        });


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
