<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");

    $userID = $_GET['userID'];
    $query="SELECT *FROM activities WHERE userID='".$userID."'";
    
    $data= mysqli_query($con,$query);

    $result=array();

    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new Activity(
            $row['id'],
            $row['nameActivity'],
            $row['indexMET'],
            $row['timeActivity'],
            $row['tags'],
            $row['note'],
            $row['measureTime'],
            $row['calo'],
            $row['userID'])
        );
    }

    echo json_encode($result);

    class Activity{
        public function Activity($id,$nameActivity,$indexMET,$timeActivity,$tags,$note,$measureTime,$calo,$userID){
            $this->id=$id;
            $this->nameActivity=$nameActivity;
            $this->indexMET=$indexMET;
            $this->timeActivity=$timeActivity;
            $this->tags=$tags;
            $this->note=$note;
            $this->measureTime=$measureTime;
            $this->calo=$calo;
            $this->userID=$userID;
        }
    }
?>