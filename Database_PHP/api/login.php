<?php
     include("config.php");
 
     $email = $_POST['email'];
     $password = md5($_POST['password']);

     $sql = "SELECT * FROM users WHERE email='".$email."' AND password='".$password."'";

     $result = mysqli_query($con,$sql);
     $count = mysqli_num_rows(($result));

     if ($count>=1){
         echo json_encode("Success");
     }else{
         echo json_encode("Error");
     }
?>