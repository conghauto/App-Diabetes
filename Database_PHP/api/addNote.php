<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Note.php");

    $note = new Note($con);

    $title = $_POST['title'];
    $description = $_POST['description'];
    $eventStartDate = $_POST['eventStartDate'];
    $eventEndDate = $_POST['eventEndDate'];


    $query = $note->insertNote($title,$description,$eventStartDate,$eventEndDate);

    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Fail");
    }
?>