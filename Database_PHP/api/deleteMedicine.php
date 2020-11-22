<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Medicine.php");

    $medicine = new Medicine($con);

    $id = $_POST['id'];

    $query = $medicine->deleteMedicine($id);

    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
?>