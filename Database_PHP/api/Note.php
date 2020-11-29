<?php
    class Note{

        public function __construct($con)
        {
            $this->con=$con;
        }

        public function insertNote($title,$description,$eventStartDate,$eventEndDate,$userID){

            $result=mysqli_query($this->con, "INSERT INTO notes VALUES ('','$title','$description','$eventStartDate','$eventEndDate','$userID')");
            return $result;
        }
    }
?>