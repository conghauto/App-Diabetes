<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Weight.php");

    $weights = new Weight($con);

    $id = $_POST['id'];
    $weight = $_POST['weight'];
    $tags = $_POST['tags'];
    $note = $_POST['note'];
    $measureTime = $_POST['measureTime'];

    $query = $weights->updateWeight($id, $weight,$tags,$note,$measureTime);

    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
?>