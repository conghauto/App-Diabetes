<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("PersonalInfo.php");

    $info = new PersonalInfo($con);

    $birthday = $_POST['birthday'];
    $gender = $_POST['gender'];
    $height = $_POST['height'];
    $weight = $_POST['weight'];
    $typeDiabete = $_POST['typeDiabete'];
    $userID= $_POST['userID'];
    $emailRelative= $_POST['emailRelative'];

    $query = $info->updateInfoUser($userID,$birthday,$gender,$height,$weight,$typeDiabete,$emailRelative);

    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Fail");
    }
?>