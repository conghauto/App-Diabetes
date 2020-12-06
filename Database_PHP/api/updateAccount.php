<?php
    include("config.php");

    $id = $_POST['id'];
    $fullname = $_POST['fullname'];
    $phone = $_POST['phone'];
    $avatar = $_POST['avatar'];

    $query = "UPDATE users SET fullname='$fullname', phone='$phone', avatar='$avatar'  WHERE id='$id'";
    $data= mysqli_query($con,$query);
    
    if ($data!=null) {
        echo json_encode("Success");
    } else 
    {
        echo "Error updating record: " . $con->error;
    }

    $con->close();
?>