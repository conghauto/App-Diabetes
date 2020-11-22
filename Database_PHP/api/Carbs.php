<?php
    class Carbs{

        public function __construct($con)
        {
            $this->con=$con;
        }

        public function insertCarbs($carb,$fat, $protein, $calo, $tags,$note, $measureTime,$userID){

            $result=mysqli_query($this->con, "INSERT INTO carbs VALUES ('','$carb','$fat','$protein','$calo','$tags','$note','$userID','$measureTime')");
            return $result;
        }

        public function updateCarbs($id, $carb,$fat, $protein, $calo, $tags,$note, $measureTime){
            $query = "UPDATE carbs SET carb='$carb', fat='$fat', protein='$protein', calo='$calo', tags='$tags', note='$note', measureTime='$measureTime'  WHERE id='$id'";
            $result=mysqli_query($this->con, $query);
            return $result;
        }

        public function deleteCarbs($id){
            $query = "DELETE FROM carbs WHERE id='$id'";
            $result=mysqli_query($this->con, $query);
            return $result;
        }
    }
?>