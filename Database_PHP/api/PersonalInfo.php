<?php
    class PersonalInfo{
        public function __construct($con)
        {
            $this->con=$con;
        }
        public function registerInfoUser($birthday,$gender,$height,$weight,
                    $typeDiabete, $userID){

            $result=mysqli_query($this->con, "INSERT INTO personalinfos VALUES ('','$birthday',
            '$gender','$height','$weight','$typeDiabete','$userID')");
            return $result;
        }
    }
?>