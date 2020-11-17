<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Weight.php");

    $glycemic = new Weight($con);

    $weight = $_POST['weight'];
    $tags = $_POST['tags'];
    $note = $_POST['note'];
    $measureTime = $_POST['measureTime'];
    $userID = $_POST['userID'];

    $query = $glycemic->insertWeight($weight,$tags,$note,$measureTime,$userID);

    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
?>