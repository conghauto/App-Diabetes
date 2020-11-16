<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Glycemic.php");

    $userID = $_POST['userID'];
    $query="SELECT *FROM glycemics WHERE userID='".$userID."'";
    
    $data= mysqli_query($con,$query);

    $result=array();

    while($row=mysqli_fetch_assoc($data)){
        array_push($result,new Glycemic(
            $row['id'],
            $row['indexG'],
            $row['tags'],
            $row['note'],
            $row['measureTime'],
            $row['userID'],
        ));
    }

    echo json_encode($result);
?>