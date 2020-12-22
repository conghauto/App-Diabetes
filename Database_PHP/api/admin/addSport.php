<?php
    header("Content-type: application/json; charset=utf-8");
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
    header('Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization, X-Request-With');
    header('Access-Control-Allow-Credentials: true');
    header("Access-Control-Allow-Methods: PUT, GET, POST, OPTIONS, DELETE");
    include("../config.php");

    $postdata = file_get_contents("php://input");

    if(isset($postdata) && !empty($postdata))
    {
      // Extract the data.
      $request = json_decode($postdata);
        
        
      // Sanitize.
      $name = mysqli_real_escape_string($con, trim($request->data->name));
      $image = mysqli_real_escape_string($con, trim($request->data->image));
      $technique = mysqli_real_escape_string($con, trim($request->data->technique));
      $benefit = mysqli_real_escape_string($con, trim($request->data->benefit));
      $note = mysqli_real_escape_string($con, trim($request->data->note));
      if ($name != '' && $benefit != '' && $technique != '') {
    
      // Store.
      $sql = "INSERT INTO `sports`(`id`, `name`, `image`, `technique`, `benefit`, `note`) VALUES (null,'{$name}','{$image}','{$technique}','{$benefit}','{$note}')";
    
      if(mysqli_query($con,$sql))
      {
        http_response_code(200);
        echo json_encode("Them moi cong thuc thanh cong");
      }
      else
      {
        http_response_code(422);
      }
    } else {
        http_response_code(422);
        echo json_encode("Them that bai");
    }
    }
?>