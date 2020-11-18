<?php
    class Activity{

        public function __construct($con)
        {
            $this->con=$con;
        }

        public function insertActivity($nameActivity,$indexMET,$timeActivity,$tags,$note,$activityTime,$kCal,$userID){

            $result=mysqli_query($this->con, "INSERT INTO activities VALUES ('','$nameActivity','$indexMET','$timeActivity','$tags','$note','$activityTime','$kCal','$userID')");
            return $result;
        }
    }
?>