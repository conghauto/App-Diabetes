<?php
    header("Content-type: application/json; charset=utf-8");
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
    header('Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization, X-Request-With');
    header('Access-Control-Allow-Credentials: true');
    header("Access-Control-Allow-Methods: PUT, GET, POST, OPTIONS, DELETE");
    include("../config.php");

    $query="SELECT * FROM users";
    
    $data= mysqli_query($con,$query);

    $result=array();

    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new User(
            $row['id'],
            $row['fullname'],
            $row['email'],
            $row['phone'],
            $row['signUpDate'],
            $row['avatar']
        ));
    }

    echo json_encode(['data'=>$result]);

    class User{
        public function User($id,$fullname,$email, $phone, $signUpDate, $avatar){
            $this->id=$id;
            $this->fullname=$fullname;
            $this->email=$email;
            $this->phone=$phone;
            $this->signUpDate=$signUpDate;
            $this->avatar=$avatar;
        }
    }
?>