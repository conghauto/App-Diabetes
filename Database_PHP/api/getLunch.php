<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");

    $userID = $_POST['userID'];
    $intensity = "light";
    $row = mysqli_query($con,"SELECT height, gender FROM personalinfos WHERE userID='".$userID."' LIMIT 1");
    $r1 = mysqli_fetch_assoc($row);
    $height = $r1['height'];
    $gender = $r1['gender'];

    // get type of activity from user
    $day = date("j");
    $month = date("n");
    $year = date("Y");
    $rowactivity = mysqli_query($con,"SELECT indexMET FROM activities WHERE userID ='".$userID."' and DAY(measureTime) ='".$day."' AND MONTH(measureTime) ='".$month."' and YEAR(measureTime) ='".$year."' LIMIT 1");
    $resultActivity = mysqli_fetch_assoc($rowactivity);
    if ($resultActivity != null) {
        $indexMet = $resultActivity['indexMET'];
        if ($indexMet > 3 && $indexMet < 6) {
            $intensity = "moderate";
        }
        if ($indexMet >= 6) {
            $intensity = "vigorous";
        }
    }
    // Tính cân nặng lý tưởng: CNLT = (chieu cao - 100)*0.9
    if($height!=null&&$gender!=null){
        $idealWeight = ($height*100 -100)*0.9;
        // Lượng calo cần: 
        // light: nhẹ, moderate: vừa phải, vigorous: mạnh
        if($gender==1){
            switch($intensity){
                case "light":
                    $calo = 30 * $idealWeight;
                    break;
                case "moderate":
                    $calo = 35 * $idealWeight;
                    break;
                case "vigorous":
                    $calo = 45 * $idealWeight;
                    break;
                default:
                    $calo = 30 * $idealWeight; 
            }
        }else{
            switch($intensity){
                case "light":
                    $calo = 25 * $idealWeight;
                    break;
                case "moderate":
                    $calo = 30* $idealWeight;
                    break;
                case "vigorous":
                    $calo = 40 * $idealWeight;
                    break;
                default:
                    $calo = 25 * $idealWeight; 
            }
        }
    }



    $result = array();

    //bữa trưa chiếm 25% lượng calo
    $lunch = $calo*25;

    $queryBreakfast="SELECT *FROM foods WHERE meal='lunch' and calo<'".$lunch."' ";
    $data = mysqli_query($con,$queryBreakfast);
    
    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new Food(
            $row['id'],
            $row['name'],
            $row['amount'],
            $row['unit'],
            $row['calo'],
            $row['protein'],
            $row['lipid'],
            $row['carb'],
            $row['cellulose'],
            $row['meal'],
            $row['stateBG'],
            $row['image']
            )    
        );
    }

    echo json_encode($result);

    class Food{
        public function Food($id,$name,$amount,$unit,$calo,$protein,$lipid,$carb,$cellulose,$meal,$stateBG, $image){
            $this->id=$id;
            $this->name=$name;
            $this->amount=$amount;
            $this->unit=$unit;
            $this->calo=$calo;
            $this->protein=$protein;
            $this->lipid=$lipid;
            $this->carb=$carb;
            $this->cellulose=$cellulose;
            $this->meal=$meal;
            $this->stateBG=$stateBG;
            $this->image = $image;
        }
    }


?>