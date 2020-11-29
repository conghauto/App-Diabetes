<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Note.php");

    $note = new Note($con);

    $title = $_POST['title'];
    $description = $_POST['description'];
    $eventStartDate = $_POST['eventStartDate'];
    $eventEndDate = $_POST['eventEndDate'];
    $userID = $_POST['userID'];


    $query = $note->insertNote($title,$description,$eventStartDate,$eventEndDate,$userID);
    $id = $con->insert_id;

    if($query){
        echo json_encode($id);
    }else{
        echo json_encode("Fail");
    }
?>