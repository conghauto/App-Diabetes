<?php
    header("Content-type: application/json; charset=utf-8");
    include("config.php");

    // $userID = $_POST['userID'];
    $fullname= $_POST['fullname'];
    $emailRelative= $_POST['emailRelative'];


    $url = 'https://server-app-diatebes.000webhostapp.com/sendEmailEmergency-server.php';
    $data = array('fullname' => $fullname,'emailRelative'=>$emailRelative);

    $options = array(
        'http' => array(
            'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
            'method'  => 'POST',
            'content' => http_build_query($data)
        )
    );
    $context  = stream_context_create($options);
    $result = file_get_contents($url, false, $context);
?>