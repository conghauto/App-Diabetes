<?php
    header("Content-type: application/json; charset=utf-8");
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
    header('Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization, X-Request-With');
    header('Access-Control-Allow-Credentials: true');
    header("Access-Control-Allow-Methods: PUT, GET, POST, OPTIONS, DELETE");
    include("../config.php");

    $query="SELECT * FROM foods";
    
    $data= mysqli_query($con,$query);

    $result=array();

    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new Food(
            $row['id'],
            $row['name'],
            $row['amount'],
            $row['unit'],
            $row['calo'],
            $row['protein'],
            $row['lipid'],
            $row['carb'],
            $row['cellulose'],
            $row['meal'],
            $row['stateBG'],
            $row['image']
        ));
    }

    echo json_encode(['data'=>$result]);

    class Food{
        public function Food($id,$name,$amount, $unit, $calo, $protein,$lipid,$carb, $cellulose, $meal,$stateBG,$image){
            $this->id=$id;
            $this->name=$name;
            $this->amount=$amount;
            $this->unit=$unit;
            $this->calo=$calo;
            $this->protein=$protein;
            $this->lipid=$lipid;
            $this->carb=$carb;
            $this->cellulose=$cellulose;
            $this->meal=$meal;
            $this->stateBG=$stateBG;
            $this->image=$image;
        }
    }
?>