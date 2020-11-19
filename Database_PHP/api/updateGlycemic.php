<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Glycemic.php");

    $glycemic = new Glycemic($con);

    $indexG = $_POST['indexG'];
    $tags = $_POST['tags'];
    $note = $_POST['note'];
    $measureTime = $_POST['measureTime'];
    $id = $_POST['id'];


    $query = $glycemic->updateGlycemic($id, $indexG,$tags,$note,$measureTime);

    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
?>