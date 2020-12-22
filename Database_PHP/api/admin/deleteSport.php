<?php
    header("Content-type: application/json; charset=utf-8");
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
    header('Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization, X-Request-With');
    header('Access-Control-Allow-Credentials: true');
    header("Access-Control-Allow-Methods: PUT, GET, POST, OPTIONS, DELETE");
    include("../config.php");

    $id = ($_GET['id'] !== null && (int)$_GET['id'] > 0)? mysqli_real_escape_string($con, (int)$_GET['id']) : false;

    if(!$id)
    {
      return http_response_code(400);
    }
    
    // Delete food
    $sql = "DELETE FROM `sports` WHERE `id` ='{$id}' ";
    
    if(mysqli_query($con, $sql))
    {
        http_response_code(200);
        echo json_encode("Delete thanh cong");
    }
    else
    {
      return http_response_code(422);
    }
?>