<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");

    $userID = $_GET['userID'];
    $query="SELECT *FROM weights WHERE userID='".$userID."'";
    
    $data= mysqli_query($con,$query);

    $result=array();

    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new Weight(
            $row['id'],
            $row['userID'],
            $row['tags'],
            $row['note'],
            $row['weight'],
            $row['measureTime'])
        );
    }

    echo json_encode($result);

    class Weight{
        public function Weight($id,$userID,$tags,$note,$weight,$measureTime){
            $this->id=$id;
            $this->userID=$userID;
            $this->tags=$tags;
            $this->note=$note;
            $this->weight=$weight;
            $this->measureTime=$measureTime;
        }
    }
?>