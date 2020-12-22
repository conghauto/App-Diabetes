<?php
    header("Content-type: application/json; charset=utf-8");
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
    header('Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization, X-Request-With');
    header('Access-Control-Allow-Credentials: true');
    header("Access-Control-Allow-Methods: PUT, GET, POST, OPTIONS, DELETE");
    include("../config.php");

    $query="SELECT * FROM sports";
    
    $data= mysqli_query($con,$query);

    $result=array();

    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new Sport(
            $row['id'],
            $row['name'],
            $row['image'],
            $row['technique'],
            $row['benefit'],
            $row['note']
        ));
    }

    echo json_encode(['data'=>$result]);

    class Sport{
        public function Sport($id,$name,$image, $technique, $benefit, $note){
            $this->id=$id;
            $this->name=$name;
            $this->image=$image;
            $this->technique=$technique;
            $this->benefit=$benefit;
            $this->note=$note;
        }
    }
?>