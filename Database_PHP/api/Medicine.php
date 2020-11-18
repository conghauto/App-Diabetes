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
    }
?>