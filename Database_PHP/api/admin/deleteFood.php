<?php
    header("Content-type: application/json; charset=utf-8");
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
    header('Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization, X-Request-With');
    header('Access-Control-Allow-Credentials: true');
    header("Access-Control-Allow-Methods: PUT, GET, POST, OPTIONS, DELETE");
    // header("Access-Control-Allow-Methods PUT, GET, POST, DELETE, OPTIONS");
    include("../config.php");

    $id = ($_GET['id'] !== null && (int)$_GET['id'] > 0)? mysqli_real_escape_string($con, (int)$_GET['id']) : false;

    if(!$id)
    {
      return http_response_code(400);
    }
    
    // Delete food
    $sqlfood = "DELETE FROM `foods` WHERE `id` ='{$id}' ";
    
    if(mysqli_query($con, $sqlfood))
    {
        $sqlrecipe = "DELETE FROM `recipes` WHERE `groupID` ='{$id}' ";
        if (mysqli_query($con, $sqlrecipe)){
            http_response_code(200);
        } else {
            return http_response_code(422);
        }
    }
    else
    {
      return http_response_code(422);
    }
?>