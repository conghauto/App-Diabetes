<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Glycemic.php");

    $glycemic = new Glycemic($con);

    $indexG = $_POST['indexG'];
    $tags = $_POST['tags'];
    $note = $_POST['note'];
    $measureTime = $_POST['measureTime'];
    $userID = $_POST['userID'];
    // $indexG = 1.1;
    // $tags = "aaa";
    // $note = "aaa";
    // $measureTime = $_POST['measureTime'];
    // $userID = $_POST['userID'];


    $query = $glycemic->insertGlycemic($indexG,$tags,$note,$measureTime,$userID);

    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
?>