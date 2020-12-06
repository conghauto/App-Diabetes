<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    // include("Note.php");

    $id= $_POST['id'];
    $query="SELECT * FROM users WHERE id='".$id."'";
    
    $data= mysqli_query($con,$query);

    $result = array();

    while($row = mysqli_fetch_assoc($data)){
        array_push($result, new Account(
            $row['id'],
            $row['fullname'],
            $row['email'],
            $row['phone'],
            $row['avatar']
        ));
    }

    echo json_encode($result);

    class Account{
        function Account($id,$fullname,$email,$phone, $avatar){
            $this->id=$id;
            $this->fullname=$fullname;
            $this->email=$email;
            $this->phone=$phone;
            $this->avatar=$avatar;
        }
    }
?>