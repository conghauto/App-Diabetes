<?php
    include("config.php");

    $id = $_POST['id'];
    $title = $_POST['title'];
    $description = $_POST['description'];
    $eventStartDate = $_POST['eventStartDate'];
    $eventEndDate = $_POST['eventEndDate'];

    $query = "UPDATE notes SET title='$title', description='$description', eventStartDate='$eventStartDate', eventEndDate='$eventEndDate' WHERE id='$id'";
    $data= mysqli_query($con,$query);

    if ($data!=null) {
        echo json_encode("Success");
    } else 
    {
        echo "Error deleting record: " . $con->error;
    }
      
    $con->close();
?>