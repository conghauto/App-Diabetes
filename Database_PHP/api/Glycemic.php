<?php
    class Glycemic{
        public function __construct1($id,$indexG,$tags,$note,$measureTime,$userID){
            $this->id=$id;
            $this->indexG=$indexG;
            $this->tags=$tags;
            $this->note=$note;
            $this->measureTime=$measureTime;
            $this->userID=$userID;
        }

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