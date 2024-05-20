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
          <h3 class="card-title">Productos más Escaneados de los Últimos 6 Meses</h3>
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
          <canvas id="barChart" style="min-height: 400px; height: 400px; max-height: 400px; max-width: 100%;"></canvas>
        </div>
        <!-- /.card-body -->
      </div>
    </div>
  </div>
</div>

<?php require_once "application/views/footer/Footer.php"; ?>

<script>
  $(function() {
    // Obtener datos de PHP y convertirlos en formato JavaScript
    var resultadosPie = <?php echo json_encode($resultados_pie); ?>;
    var resultados = <?php echo json_encode($resultados); ?>;

    // Procesar datos para el gráfico de pie
    var labelsPie = [];
    var dataPie = [];
    resultadosPie.forEach(function(item) {
      labelsPie.push(item.nombre_producto);
      dataPie.push(item.num_escaneos);
    });

    // Procesar datos para el gráfico de barras
    var labelsBar = [];
    var dataBar = [];
    resultados.forEach(function(item) {
      labelsBar.push(item.mes);
      dataBar.push(item.num_escaneos);
    });

    // Configuración del gráfico de pie
    var pieChartCanvas = $('#pieChart').get(0).getContext('2d');
    var pieOptions = {
      maintainAspectRatio: false,
      responsive: true,
    };

    // Configuración del gráfico de barras
    var barChartCanvas = $('#barChart').get(0).getContext('2d');
    var barOptions = {
      maintainAspectRatio: false,
      responsive: true,
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: true
          }
        }]
      }
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

    // Crear el gráfico de barras
    new Chart(barChartCanvas, {
      type: 'bar',
      data: {
        labels: labelsBar,
        datasets: [{
          label: 'Productos Escaneados',
          backgroundColor: 'rgba(60,141,188,0.9)',
          borderColor: 'rgba(60,141,188,0.8)',
          borderWidth: 2,
          data: dataBar
        }]
      },
      options: barOptions
    });
  });
</script>
