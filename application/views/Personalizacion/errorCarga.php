<?php require_once "application/views/header/Header.php"; ?>
<?php require_once "application/views/nav/base.php"; ?>


<div class="container">
    <div class="row py-5 justify-content-center">
        <div class="col-12">
            <div class="card">
                <h1>Error de carga:</h1>
                <p><?php echo $error; ?></p>
            </div>
        </div>
    </div>
</div>



<?php require_once "application/views/footer/Footer.php"; ?>