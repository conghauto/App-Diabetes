<?php
    ob_start();

    $timezone = date_default_timezone_set("Asia/Ho_Chi_Minh");
    
    $host = "localhost";
    $username = "root";
    $password = "";
    $database = "db_diabete";

    $con = mysqli_connect($host,$username,$password,$database);
    mysqli_query($con,"SET NAMES 'utf8'");

    if(mysqli_connect_errno()){
        echo "Failed to connect: ".mysqli_connect_errno();
        // echo json_encode(("Error"));
    }

?>