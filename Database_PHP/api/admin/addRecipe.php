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
      $ingredient = mysqli_real_escape_string($con, trim($request->data->ingredient));
      $recipe = mysqli_real_escape_string($con, trim($request->data->recipe));
      $benefit = mysqli_real_escape_string($con, trim($request->data->benefit));
      $groupID = mysqli_real_escape_string($con, trim($request->data->groupID));
      if ($name != '' && $groupID != '') {
    
      // Store.
      $sql = "INSERT INTO `recipes`(`id`, `name`, `ingredient`, `recipe`, `benefit`, `groupID`) VALUES (null,'{$name}','{$ingredient}','{$recipe}','{$benefit}','{$groupID}')";
    
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