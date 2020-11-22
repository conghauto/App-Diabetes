<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Carbs.php");

    $carbs = new Carbs($con);
    $id = $_POST['id'];

    $query = $carbs->deleteCarbs($id);

    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
?>