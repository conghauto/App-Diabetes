<?php
    class Weight{
        public function __construct1($id,$weight,$tags,$note,$measureTime,$userID){
            $this->id=$id;
            $this->weight=$weight;
            $this->tags=$tags;
            $this->note=$note;
            $this->measureTime=$measureTime;
            $this->userID=$userID;
        }

        public function __construct($con)
        {
            $this->con=$con;
        }

        public function insertWeight($weight,$tags,$note,$measureTime,$userID){

            $result=mysqli_query($this->con, "INSERT INTO weight VALUES ('','$userID','$tags','$note','$weight','$measureTime')");
            return $result;
        }
    }
?>