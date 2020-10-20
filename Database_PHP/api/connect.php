<?php
    $host = "localhost";
    $username = "root";
    $password = "";
    $database = "db_diabete";

    $conn = mysqli_connect($host,$username,$password,$database);
    mysqli_query($conn,"SET NAMES 'utf8'");

    if($conn){
        echo "Dang nhap thanh cong";
    }else{
        echo "That bat";
    }

?>