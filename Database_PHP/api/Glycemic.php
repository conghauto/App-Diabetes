<?php
    class Glycemic{
        public function __construct($con)
        {
            $this->con=$con;
        }

        public function insertGlycemic($indexG,$tags,$note,$measureTime,$userID){

            $result=mysqli_query($this->con, "INSERT INTO glycemics VALUES ('','$indexG','$tags','$note','$measureTime','$userID')");
            return $result;
        }
    }
?>