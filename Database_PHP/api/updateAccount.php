<?php
    include("config.php");

    $id = $_POST['id'];
    $fullname = $_POST['fullname'];
    $username = $_POST['username'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $avatar = $_POST['avatar'];

    $sql = "SELECT *FROM users WHERE email = '".$email."'";
    $result = mysqli_query($con,$sql);
    $count = mysqli_num_rows($result);
    if ($count >= 1){
        echo json_encode("Email đã tồn tại");
    } else {
        $query = "UPDATE users SET fullname='$fullname', username='$username', email='$email', phone='$phone', avatar='$avatar'  WHERE id='$id'";
        $data= mysqli_query($con,$query);
    
        if ($data!=null) {
            echo json_encode("Success");
        } else 
        {
            echo "Error updating record: " . $con->error;
        }
    }


      
    $con->close();
?>