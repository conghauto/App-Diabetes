<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    // include("Note.php");


    $query="SELECT *FROM notes";
    
    $data= mysqli_query($con,$query);

    $result=array();

    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new Note(
            $row['id'],
            $row['title'],
            $row['description'],
            $row['eventStartDate'],
            $row['eventEndDate']
        ));
    }

    echo json_encode($result);

    class Note{
        function Note($id,$title,$description,$eventStartDate,$eventEndDate){
            $this->id=$id;
            $this->title=$title;
            $this->description=$description;
            $this->eventStartDate=$eventStartDate;
            $this->eventEndDate=$eventEndDate;
        }
    }
?>