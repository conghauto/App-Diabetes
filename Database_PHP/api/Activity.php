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

        
        public function updateActivity($id,$nameActivity,$indexMET,$timeActivity,$tags,$note,$activityTime,$kCal){
            $query = "UPDATE activities SET nameActivity='$nameActivity', indexMET='$indexMET', timeActivity='$timeActivity', tags='$tags', note='$note', activityTime='$activityTime', activityTime='$activityTime', kCal='$kCal'  WHERE id='$id'";
            $result=mysqli_query($this->con, $query);
            return $result;
        }
    }
?>