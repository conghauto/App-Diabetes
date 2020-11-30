<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");

    $query="SELECT * FROM foods";
    
    $data= mysqli_query($con,$query);

    $result=array();

    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new Food(
            $row['id'],
            $row['name'],
            $row['image'],
            $row['ingredient'],
            $row['recipe'],
            $row['benefit'],
            $row['groupID'])
        );
    }

    echo json_encode($result);

    class Food{
        public function Food($id,$name,$image, $ingredient, $recipe, $benefit,$groupID){
            $this->id=$id;
            $this->name=$name;
            $this->image=$image;
            $this->ingredient=$ingredient;
            $this->recipe=$recipe;
            $this->benefit=$benefit;
            $this->groupID=$groupID;
        }
    }
?>