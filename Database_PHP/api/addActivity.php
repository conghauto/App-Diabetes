<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Activity.php");

    $activity = new Activity($con);

    $nameActivity = $_POST['nameActivity'];
    $indexMET = $_POST['indexMET'];
    $timeActivity = $_POST['timeActivity'];
    $tags = $_POST['tags'];
    $note = $_POST['note'];
    $activityTime = $_POST['activityTime'];
    $userID = $_POST['userID'];

    $result=mysqli_query($con,"SELECT weight FROM weights WHERE userID='".$userID."' ORDER BY measureTime DESC LIMIT 1");
    $r1 = mysqli_fetch_assoc($result);
    $weight=$r1['weight'];

    if (!$weight){
        $r2=mysqli_query($con,"SELECT weight FROM personalinfos WHERE userID='".$userID."'");
        $w2 = mysqli_fetch_assoc($result);
        $weight = $w2['weight'];
    }

    // Công thức tính lượng kCal: Total calories burned = minutes × (MET × 3.5 × your weight in kg) / 200
    if($weight){
        $calo = $timeActivity*($indexMET*3.5*$weight)/200;
    }


    $query = $activity->insertActivity($nameActivity,$indexMET,$timeActivity,$tags,$note,$activityTime,$calo,$userID);

    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
?>