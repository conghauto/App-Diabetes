<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Glycemic.php");

    $glycemic = new Glycemic($con);

    $id = $_POST['id'];
    $query = $glycemic->deleteGlycemic($id);

    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
?>