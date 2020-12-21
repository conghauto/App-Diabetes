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
      $ingredient = mysqli_real_escape_string($con, trim($request->data->ingredient));
      $recipe = mysqli_real_escape_string($con, trim($request->data->recipe));
      $benefit = mysqli_real_escape_string($con, trim($request->data->benefit));
    
      // Store.
        $sql = "UPDATE recipes SET name = '$name', ingredient = '$ingredient', recipe = '$recipe', `benefit` = '$benefit' WHERE id = '$id'";
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