<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    // include("Note.php");

    $userID = $_GET['userID'];

    $query="ELECT users.id, fullname, phoneRelative FROM users, personalinfos WHERE users.id = personalinfos.userID AND id='".$userID."' GROUP BY users.id";
    
    $data= mysqli_query($con,$query);

    $result=array();

    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new InfoUser(
            $row['id'],
            $row['fullname'],
            $row['phoneRelative'],
        ));
    }

    echo json_encode($result);

    class InfoUser{
        function InfoUser($id,$fullname,$phoneRelative){
            $this->id=$id;
            $this->fullname=$fullname;
            $this->phoneRelative=$phoneRelative;
        }
    }
?>