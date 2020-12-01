<?php
    class Sport{

        public function __construct($con)
        {
            $this->con=$con;
        }

        public function insertSport($name,$image, $technique, $benefit, $note){

            $result=mysqli_query($this->con, "INSERT INTO sports VALUES ('','$name','$image','$technique','$benefit','$note')");
            return $result;
        }

        public function updateSport($id, $name,$image, $technique, $benefit, $note){
            $query = "UPDATE sports SET name='$name', image='$image', technique='$technique', benefit='$benefit', note='$note' WHERE id='$id'";
            $result=mysqli_query($this->con, $query);
            return $result;
        }

        public function deleteSport($id){
            $query = "DELETE FROM sports WHERE id='$id'";
            $result=mysqli_query($this->con, $query);
            return $result;
        }
    }
?>