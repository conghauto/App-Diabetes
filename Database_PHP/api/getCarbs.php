<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");

    $userID = $_GET['userID'];
    $query="SELECT *FROM carbs WHERE userID='".$userID."'";
    
    $data= mysqli_query($con,$query);

    $result=array();

    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new Carb(
            $row['id'],
            $row['carb'],
            $row['fat'],
            $row['protein'],
            $row['calo'],
            $row['tags'],
            $row['note'],
            $row['userID'],
            $row['measureTime'])
        );
    }

    echo json_encode($result);

    class Carb{
        public function Carb($id,$carb,$fat,$protein,$calo,$tags,$note,$userID,$measureTime){
            $this->id=$id;
            $this->carb=$carb;
            $this->fat=$fat;
            $this->protein=$protein;
            $this->calo=$calo;
            $this->tags=$tags;
            $this->note=$note;
            $this->userID=$userID;
            $this->measureTime=$measureTime;
        }
    }
?>