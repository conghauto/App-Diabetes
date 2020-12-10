<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    $groupID = $_POST['groupID'];
    $query="SELECT * FROM recipes WHERE groupID = '".$groupID."'";
    $data= mysqli_query($con,$query);

    $result=array();

    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new Food(
            $row['id'],
            $row['name'],
            $row['ingredient'],
            $row['recipe'],
            $row['benefit'],
            $row['groupID'])
        );
    }

    echo json_encode($result);

    class Food{
        public function Food($id,$name, $ingredient, $recipe, $benefit,$groupID){
            $this->id=$id;
            $this->name=$name;
            $this->ingredient=$ingredient;
            $this->recipe=$recipe;
            $this->benefit=$benefit;
            $this->groupID=$groupID;
        }
    }
?>