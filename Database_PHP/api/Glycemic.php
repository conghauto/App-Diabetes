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

        public function updateGlycemic($id,$indexG,$tags,$note,$measureTime){
            $query = "UPDATE glycemics SET indexG='$indexG', tags='$tags', note='$note', measureTime='$measureTime' WHERE id='$id'";
            $result=mysqli_query($this->con, $query);
            return $result;
        }

        public function deleteGlycemic($id){
            $query = "DELETE FROM glycemics WHERE id='$id'";
            $result=mysqli_query($this->con, $query);
            return $result;
        }
    }
?>