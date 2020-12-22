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
      $id = mysqli_real_escape_string($con, (int)$request->data->id);
      $name = mysqli_real_escape_string($con, trim($request->data->name));
      $technique = mysqli_real_escape_string($con, trim($request->data->technique));
      $benefit = mysqli_real_escape_string($con, trim($request->data->benefit));
      $note = mysqli_real_escape_string($con, trim($request->data->note));
      $image = mysqli_real_escape_string($con, trim($request->data->image));
    
      // Store.
        $sql = "UPDATE sports SET name = '$name', technique = '$technique', benefit = '$benefit', `note` = '$note', `image` = '$image' WHERE id = '$id'";
      if(mysqli_query($con,$sql))
      {
        http_response_code(200);
        echo json_encode("update thanh cong");
      }
      else
      {
        http_response_code(422);
      }
    }
?>