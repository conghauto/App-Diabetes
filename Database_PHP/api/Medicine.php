<?php
    class Medicine{

        public function __construct($con)
        {
            $this->con=$con;
        }

        public function insertMedicine($name,$typeInsulin, $amount, $userID, $measureTime,$unit, $note){

            $result=mysqli_query($this->con, "INSERT INTO medicine VALUES ('','$name','$typeInsulin','$amount','$userID','$measureTime','$unit','$note')");
            return $result;
        }

        public function updateMedicine($id,$name,$typeInsulin, $amount, $measureTime,$unit, $note){
            $query = "UPDATE medicine SET name='$name', typeInsulin='$typeInsulin', amount='$amount', measureTime='$measureTime', unit='$unit', note='$note'  WHERE id='$id'";
            $result=mysqli_query($this->con, $query);
            return $result;
        }
    }
?>