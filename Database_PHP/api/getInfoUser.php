<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    // include("Note.php");

    $userID = $_POST['userID'];

    $query="SELECT * FROM personalinfos WHERE userID = '".$userID."'";
    
    $data= mysqli_query($con,$query);

    $result=array();

    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new InfoUser(
            $row['id'],
            $row['birthday'],
            $row['gender'],
            $row['height'],
            $row['weight'],
            $row['typeDiabete'],
            $row['emailRelative']
        ));
    }

    echo json_encode($result);

    class InfoUser{
        function InfoUser($id,$birthday,$gender, $height,$weight,$typeDiabete,$emailRelative){
            $this->id=$id;
            $this->birthday=$birthday;
            $this->gender=$gender;
            $this->height=$height;
            $this->weight=$weight;
            $this->typeDiabete=$typeDiabete;
            $this->emailRelative=$emailRelative;
        }
    }
?>