<?php
    class Note{
        // public function __construct($id,$title,$description,$eventStartDate,$eventEndDate){
        //     $this->id=$id;
        //     $this->title=$title;
        //     $this->description=$description;
        //     $this->eventStartDate=$eventStartDate;
        //     $this->eventEndDate=$eventEndDate;
        // }

        public function __construct($con)
        {
            $this->con=$con;
        }

        public function insertNote($title,$description,$eventStartDate,$eventEndDate){

            $result=mysqli_query($this->con, "INSERT INTO notes VALUES ('','$title','$description','$eventStartDate','$eventEndDate')");
            return $result;
        }

        // public function getNotes(){
        //     $result = "SELECT * FROM notes";
        //     return $result;
        // }
    }

    // class Note{
    //     function Note($id,$title,$description,$eventStartDate,$eventEndDate){
    //         $this->id=$id;
    //         $this->title=$title;
    //         $this->description=$description;
    //         $this->eventStartDate=$eventStartDate;
    //         $this->eventEndDate=$eventEndDate;
    //     }

    //     public function __construct($con)
    //     {
    //         $this->con=$con;
    //     }
    // }
?>