<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");

    $userID = $_GET['userID'];
    $query="SELECT *FROM medicine WHERE userID='".$userID."'";
    
    $data= mysqli_query($con,$query);

    $result=array();

    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new Medicine(
            $row['id'],
            $row['name'],
            $row['typeInsulin'],
            $row['amount'],
            $row['userID'],
            $row['measureTime'],
            $row['unit'],
            $row['note'])
        );
    }

    echo json_encode($result);

    class Medicine{
        public function Medicine($id,$name,$typeInsulin,$amount,$userID,$measureTime,$unit,$note){
            $this->id=$id;
            $this->name=$name;
            $this->typeInsulin=$typeInsulin;
            $this->amount=$amount;
            $this->userID=$userID;
            $this->measureTime=$measureTime;
            $this->unit=$unit;
            $this->note=$note;
        }
    }
?>