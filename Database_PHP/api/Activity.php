<?php
    class Activity{

        public function __construct($con)
        {
            $this->con=$con;
        }

        public function insertActivity($nameActivity,$indexMET,$timeActivity,$tags,$note,$measureTime,$kCal,$userID){

            $result=mysqli_query($this->con, "INSERT INTO activities VALUES ('','$nameActivity','$indexMET','$timeActivity','$tags','$note','$measureTime','$kCal','$userID')");
            return $result;
        }

        
        public function updateActivity($id,$nameActivity,$indexMET,$timeActivity,$tags,$note,$measureTime,$kCal){
            $query = "UPDATE activities SET nameActivity='$nameActivity', indexMET='$indexMET', timeActivity='$timeActivity', tags='$tags', note='$note', measureTime='$measureTime', kCal='$kCal'  WHERE id='$id'";
            $result=mysqli_query($this->con, $query);
            return $result;
        }
    }
?>