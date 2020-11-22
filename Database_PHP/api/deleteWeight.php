<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Weight.php");

    $weights = new Weight($con);

    $id = $_POST['id'];

    $query = $weights->deleteWeight($id);

    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
?>