<?php
    class Food{

        public function __construct($con)
        {
            $this->con=$con;
        }

        public function insertFood($name,$image, $ingredient, $recipe, $benefit,$groupID){

            $result=mysqli_query($this->con, "INSERT INTO foods VALUES ('','$carb','$fat','$protein','$calo','$tags','$note','$userID','$measureTime')");
            return $result;
        }

        public function updateFood($id, $name,$image, $ingredient, $recipe, $benefit,$groupID){
            $query = "UPDATE foods SET name='$name', image='$image', ingredient='$ingredient', recipe='$recipe', benefit='$benefit', groupID='$groupID' WHERE id='$id'";
            $result=mysqli_query($this->con, $query);
            return $result;
        }

        public function deleteFood($id){
            $query = "DELETE FROM foods WHERE id='$id'";
            $result=mysqli_query($this->con, $query);
            return $result;
        }
    }
?>