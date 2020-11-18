<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Medicine.php");

    $medicine = new Medicine($con);

    $name = $_POST['name'];
    $typeInsulin = $_POST['typeInsulin'];
    $amount = $_POST['amount'];
    $userID = $_POST['userID'];
    $measureTime = $_POST['measureTime'];
    $unit = $_POST['unit'];
    $note = $_POST['note'];

    $query = $medicine->insertMedicine($name,$typeInsulin, $amount, $userID, $measureTime,$unit, $note);

    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
?>