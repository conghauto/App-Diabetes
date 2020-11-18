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
    }
?>