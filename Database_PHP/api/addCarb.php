<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Carbs.php");

    $carbs = new Carbs($con);

    $carb = $_POST['carb'];
    $fat = $_POST['fat'];
    $protein = $_POST['protein'];
    $calo = $_POST['calo'];
    $tags = $_POST['tags'];
    $note = $_POST['note'];
    $measureTime = $_POST['measureTime'];
    $userID = $_POST['userID'];

    $query = $carbs->insertCarbs($carb,$fat, $protein, $calo, $tags,$note, $measureTime,$userID);

    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
?>