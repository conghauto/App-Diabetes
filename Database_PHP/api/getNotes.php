<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    // include("Note.php");


    $userID = $_GET['userID'];
    $query="SELECT *FROM notes WHERE userID='".$userID."'";
    
    $data= mysqli_query($con,$query);

    $result=array();

    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new Note(
            $row['id'],
            $row['title'],
            $row['description'],
            $row['eventStartDate'],
            $row['eventEndDate'],
            $row['userID']
        ));
    }

    echo json_encode($result);

    class Note{
        function Note($id,$title,$description,$eventStartDate,$eventEndDate,$userID){
            $this->id=$id;
            $this->title=$title;
            $this->description=$description;
            $this->eventStartDate=$eventStartDate;
            $this->eventEndDate=$eventEndDate;
            $this->userID=$userID;
        }
    }
?>