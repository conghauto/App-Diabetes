<?php
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
    header('Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization, X-Request-With');
    header('Access-Control-Allow-Credentials: true');
    header("Access-Control-Allow-Methods: PUT, GET, POST, OPTIONS, DELETE");
    include("../config.php");
    include_once 'libs/php-jwt-master/src/BeforeValidException.php';
    include_once 'libs/php-jwt-master/src/ExpiredException.php';
    include_once 'libs/php-jwt-master/src/SignatureInvalidException.php';
    include_once 'libs/php-jwt-master/src/JWT.php';
    use \Firebase\JWT\JWT;
 

    $postdata = file_get_contents("php://input");

    if(isset($postdata) && !empty($postdata)){
        $request = json_decode($postdata);

        // $username = $_POST['username'];
        // $password = $_POST['password'];

        $username = mysqli_real_escape_string($con, trim($request->data->username));
        $password = mysqli_real_escape_string($con, (int)$request->data->password);
   
        $key = "key";
        $issued_at = time();
        $expiration_time = $issued_at + (60 * 60); // valid for 1 hour
        $issuer = "http://localhost";
   
        $query = "SELECT * FROM admins WHERE username='".$username."' AND password='".$password."'";
   
        $data= mysqli_query($con,$query);
        $result = array();
   
        while($row = mysqli_fetch_assoc($data)){
           array_push($result, new Admin(
               $row['id'],
               $row['username']
           ));
       }
   
       $token = array(
           "iat" => $issued_at,
           "exp" => $expiration_time,
           "iss" => $issuer,
           "data" => array(
               "id" => $result[0]->id,
               "username" => $result[0]->username,
           )
        );
     
        // set response code
        http_response_code(200);
     
        // generate jwt
        $jwt = JWT::encode($token, $key);
        echo json_encode(['token'=>$jwt]);
    }

 
    //  echo json_encode($result);
 
     class Admin{
         function Admin($id,$username){
             $this->id=$id;
             $this->username=$username;
         }
     }
?>