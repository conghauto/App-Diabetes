<?php
     include("config.php");
     $id = $_POST['id'];
     $password = md5($_POST['password']);
     $newpassword = md5($_POST['newpassword']);

     $sql = "SELECT * FROM users WHERE id='".$id."' AND password='".$password."'";

     $result = mysqli_query($con,$sql);
     $count = mysqli_num_rows(($result));

     if ($count>=1){
        $query = "UPDATE users SET password='$newpassword' WHERE id='$id'";
        $update=mysqli_query($con, $query);
         if ($update != null) {
             echo json_encode("Success");
         } else {
            echo json_encode("Error");
         }
     }else{
         echo json_encode("Error Password");
     }
?>