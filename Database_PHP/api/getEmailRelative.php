<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    // include("Note.php");

    $userID= $_POST['userID'];
    $query="SELECT id, emailRelative FROM personalinfos WHERE userID='".$userID."'";
    
    $data= mysqli_query($con,$query);

    $result = array();

    while($row = mysqli_fetch_assoc($data)){
        array_push($result, new PersonalInfo(
            $row['id'],
            $row['emailRelative']
        ));
    }

    echo json_encode($result);

    class PersonalInfo{
        function PersonalInfo($id,$emailRelative){
            $this->id=$id;
            $this->emailRelative=$emailRelative;
        }
    }
?>