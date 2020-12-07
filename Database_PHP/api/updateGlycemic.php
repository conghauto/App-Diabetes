<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");
    include("Glycemic.php");

    $glycemic = new Glycemic($con);

    $indexG = $_POST['indexG'];
    $tags = $_POST['tags'];
    $note = $_POST['note'];
    $measureTime = $_POST['measureTime'];
    $id = $_POST['id'];
    $fullname= $_POST['fullname'];
    $emailRelative= $_POST['emailRelative'];


    $query = $glycemic->updateGlycemic($id, $indexG,$tags,$note,$measureTime);

    if($query){
        echo json_encode("Success");
        $float_value_of_indexG = floatval($indexG);
        if($float_value_of_indexG>180){
            $url = 'https://server-app-diatebes.000webhostapp.com/sendEmail.php';
            $data = array('fullname' => $fullname, 'measureTime' => $measureTime,'indexG'=>$indexG,'emailRelative'=>$emailRelative);

            // use key 'http' even if you send the request to https://...
            $options = array(
                'http' => array(
                    'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
                    'method'  => 'POST',
                    'content' => http_build_query($data)
                )
            );
            $context  = stream_context_create($options);
            $result = file_get_contents($url, false, $context);
            if ($result === FALSE) { 
                echo "Error";
            }else{
                $id = $con->insert_id;
                echo json_encode($id);
            }
            // var_dump($result);
        }else{
            $id = $con->insert_id;
            echo json_encode($id);
        }
    }else{
        echo json_encode("Error");
    }
?>