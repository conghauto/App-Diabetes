<?php
    class Account{
        public function __construct($con)
        {
            $this->con=$con;
        }

        public function register($fullname,$email,$phone,$password){
            $encryptedPw = md5($password);
            $date=date("Y-m-d");
            $username='';

            $result=mysqli_query($this->con, "INSERT INTO users VALUES ('','$fullname','$username','$email','$phone','$encryptedPw','$date')");
            return $result;
        }

        public function login($email,$password){
            $encryptedPw = md5($password);
        }
    }
?>