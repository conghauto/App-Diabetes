<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");

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
            $row['note'])
        );
    }

    echo json_encode($result);

    class Sport{
        public function Sport($id, $name,$image, $technique, $benefit, $note){
            $this->id=$id;
            $this->name=$name;
            $this->image=$image;
            $this->technique=$technique;
            $this->benefit=$benefit;
            $this->note=$note;
        }
    }
?>