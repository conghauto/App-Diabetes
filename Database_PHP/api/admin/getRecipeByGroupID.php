<?php
    header("Content-type: application/json; charset=utf-8");
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
    header('Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization, X-Request-With');
    header('Access-Control-Allow-Credentials: true');
    header("Access-Control-Allow-Methods: PUT, GET, POST, OPTIONS, DELETE");
    include("../config.php");
    $id = ($_GET['id'] !== null && (int)$_GET['id'] > 0)? mysqli_real_escape_string($con, (int)$_GET['id']) : false;

    $query="SELECT * FROM recipes WHERE  `groupID` ='{$id}'";
    
    $data= mysqli_query($con,$query);

    $result=array();

    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new Recipe(
            $row['id'],
            $row['name'],
            $row['ingredient'],
            $row['recipe'],
            $row['benefit']
        ));
    }

    echo json_encode(['data'=>$result]);

    class Recipe{
        public function Recipe($id,$name,$ingredient, $recipe, $benefit){
            $this->id=$id;
            $this->name=$name;
            $this->ingredient=$ingredient;
            $this->recipe=$recipe;
            $this->benefit=$benefit;
        }
    }
?>