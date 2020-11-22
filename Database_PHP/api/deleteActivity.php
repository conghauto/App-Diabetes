<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Activity.php");

    $activity = new Activity($con);

    $id = $_POST['id'];

    $query = $activity->deleteActivity($id);

    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
?>