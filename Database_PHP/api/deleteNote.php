<?php
    include("config.php");

    $id = $_POST['id'];

    $query="DELETE FROM notes WHERE id = '".$id."'";
    $data= mysqli_query($con,$query);

    if ($data!=null) {
        echo json_encode("Success");
    } else 
    {
        echo "Error deleting record: " . $con->error;
    }
      
    $con->close();
?>