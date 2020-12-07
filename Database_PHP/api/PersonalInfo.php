<?php
    class PersonalInfo{
        public function __construct($con)
        {
            $this->con=$con;
        }
        public function registerInfoUser($birthday,$gender,$height,$weight,
                    $typeDiabete, $userID,$emailRelative){

            $result=mysqli_query($this->con, "INSERT INTO personalinfos VALUES ('','$birthday',
            '$gender','$height','$weight','$typeDiabete','$userID','$emailRelative')");
            return $result;
        }
        public function updateInfoUser($userID, $birthday,$gender,$height,$weight,$typeDiabete,$emailRelative){
            $query = "UPDATE personalinfos SET birthday='$birthday', gender='$gender', height='$height', weight='$weight', typeDiabete='$typeDiabete', emailRelative='$emailRelative' WHERE userID='$userID'";
            $result=mysqli_query($this->con, $query);
            return $result;
        }
    }
?>