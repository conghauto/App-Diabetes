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
        
    
      // Validate.
    //   if(trim($request->data->name) === '' || (int)$request->data->id < 1)
    //   {
    //     return http_response_code(400);
    //   }

        
      // Sanitize.
      $id = mysqli_real_escape_string($con, trim($request->data->id));
      $name = mysqli_real_escape_string($con, trim($request->data->name));
      $amount = mysqli_real_escape_string($con, (int)$request->data->amount);
      $unit = mysqli_real_escape_string($con, trim($request->data->unit));
      $calo = mysqli_real_escape_string($con, (int)$request->data->calo);
      $protein = mysqli_real_escape_string($con, trim($request->data->protein));
      $lipid = mysqli_real_escape_string($con, (int)$request->data->lipid);
      $carb = mysqli_real_escape_string($con, trim($request->data->carb));
      $cellulose = mysqli_real_escape_string($con, (int)$request->data->cellulose);
      $meal = mysqli_real_escape_string($con, trim($request->data->meal));
      $stateBG = mysqli_real_escape_string($con, trim($request->data->stateBG));
      $image = mysqli_real_escape_string($con, trim($request->data->image));
        
    
      // Store.
      $sql = "UPDATE foods SET name = '$name', amount = '$amount', unit = '$unit', `calo` = '$calo', `protein` = '$protein', `lipid` = '$lipid', `carb` = '$carb', `cellulose` = '$cellulose', `meal` = '$meal', `stateBG` = '$stateBG', `image` = '$image' WHERE id = '$id'";
    
      if(mysqli_query($con,$sql))
      {
        http_response_code(200);
        echo json_encode("Update food thanh cong");
      }
      else
      {
        http_response_code(422);
      }
    }
?>