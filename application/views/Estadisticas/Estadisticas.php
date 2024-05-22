<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>

<div class="container">
  <div class="row py-5 justify-content-center">
    <div class="col-md-6">
      <div class="card card-danger">
        <div class="card-header">
          <h3 class="card-title">Productos más Escaneados del Mes</h3>
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
          <canvas id="pieChart" style="min-height: 400px; height: 400px; max-height: 400px; max-width: 100%;"></canvas>
        </div>
        <!-- /.card-body -->
      </div>
    </div>

    <div class="col-md-6">
      <div class="card card-danger">
        <div class="card-header">
          <h3 class="card-title">buscar cantidad de veces ha sido escaneado</h3>
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
          <input type="text" id="searchInput" class="form-control" placeholder="Ingrese el código de barras">
          <button id="searchButton" class="btn btn-primary mt-2">Buscar</button>
          <div id="searchResult">
            <h4>Resultados de la búsqueda:</h4>
            <h4>Resultados de la búsqueda:</h4>
            <table class="table table-bordered">
              <thead>
                <tr>
                  <th>Código de Barras</th>
                  <th>Nombre del Producto</th>
                  <th>Número de Escaneos</th>
                </tr>
              </thead>
              <tbody>
                <?php foreach ($escaneos as $escaneo) : ?>
                  <tr>
                    <td><?php echo $escaneo->cbarra; ?></td>
                    <td><?php echo $escaneo->nombre_producto; ?></td>
                    <td><?php echo $escaneo->num_escaneos; ?></td>
                  </tr>
                <?php endforeach; ?>
              </tbody>
            </table>

          </div>

        </div>
      </div>
    </div>


  </div>
</div>

</div>

<?php require_once "application/views/footer/Footer.php"; ?>
<script>
  $(document).ready(function() {
    $('#searchButton').click(function() {
      var searchTerm = $('#searchInput').val();
      $.ajax({
        type: 'POST',
        url: '<?php echo base_url("ControladorEscaneados/obtenerEscaneosPorCodigoBarras"); ?>',
        data: {
          searchTerm: searchTerm
        },
        success: function(response) {
          $('#searchResult').html(response);
        }
      });
    });
  });
</script>


<script>
  $(function() {
    // Obtener datos de PHP y convertirlos en formato JavaScript
    var resultadosPie = <?php echo json_encode($resultados_pie); ?>;

    // Procesar datos para el gráfico de pie
    var labelsPie = [];
    var dataPie = [];
    resultadosPie.forEach(function(item) {
      labelsPie.push(item.nombre_producto);
      dataPie.push(item.num_escaneos);
    });

    // Configuración del gráfico de pie
    var pieChartCanvas = $('#pieChart').get(0).getContext('2d');
    var pieOptions = {
      maintainAspectRatio: false,
      responsive: true,
    };

    // Crear el gráfico de pie
    new Chart(pieChartCanvas, {
      type: 'pie',
      data: {
        labels: labelsPie,
        datasets: [{
          data: dataPie,
          backgroundColor: [
            '#f56954', '#00a65a', '#f39c12', '#00c0ef', '#3c8dbc', '#d2d6de',
            '#FF5733', '#C70039', '#FFC300', '#900C3F'
          ]
        }]
      },
      options: pieOptions
    });


  });
</script>