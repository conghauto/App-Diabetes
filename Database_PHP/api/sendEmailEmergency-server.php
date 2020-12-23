<?php
    header("Content-type: text/html;charset=UTF-8");
    require 'PHPMailer/PHPMailerAutoload.php';
    require 'PHPMailer/class.phpmailer.php';
    require 'PHPMailer/class.smtp.php';
    
    $fullname = $_POST['fullname'];
    $emailRelative= $_POST['emailRelative'];

    date_default_timezone_set('Etc/UTC');



    //Create a new PHPMailer instance
    $mail = new PHPMailer;
    
    //Tell PHPMailer to use SMTP
    // $mail->isSMTP();
    
    //Enable SMTP debugging
    // 0 = off (for production use)
    // 1 = client messages
    // 2 = client and server messages
    $mail->SMTPDebug = 2;
    $mail->SMTPSecure = 'tls';  
    $mail->Host = 'smtp.gmail.com';  // Specify main and backup SMTP servers
    $mail->SMTPAuth = true;                               // Enable SMTP authentication
    $mail->Username = 'ducphoqn2020@gmail.com';                 // SMTP username
    $mail->Password = 'toanhau2020';                           // SMTP password
                          // Enable TLS encryption, `ssl` also accepted
    $mail->Port = 587;


    $mail->setFrom('ducphoqn2020@gmail.com', 'Admin');
    // $mail->addAddress('joe@example.net', 'Joe User');     // Add a recipient
    $mail->addAddress($emailRelative);               // Name is optional
    $mail->addReplyTo('ducphoqn2020@gmail.com', 'Information');
    // $mail->addCC('cc@example.com');
    // $mail->addBCC('bcc@example.com');
    $mail->WordWrap = 50;							//Sets word wrapping on the body of the message to a given number of characters
    $mail->IsHTML(true);							//Sets message type to HTML				
    $mail->Subject = "=?UTF-8?B?".base64_encode("TIN NHẮN KHẨN CẤP TỪ HỆ THỐNG APP-DIATEBES")."?=";				//Sets the Subject of the message
    // $mail->Body = "Hệ thống APP-DIATEBES cảnh báo với bạn rằng.<br> Chỉ số đường của bệnh nhân: ".$fullname.", ngày: ".$formatDate." là: <b style='color:red'>".$indexG." mg/dl</b>, vượt quá giới hạn đảm bảo. <br><br>Bạn cần phải chú ý theo dõi !";

    $mail->Body = "<b style='color:red'>".$fullname."</b>, người thân của bạn đã yêu cầu gửi liên hệ KHẨN CẤP về tình trạng sức khỏe bệnh tiểu đường.'>"."<br><br>Hãy liên hệ nhanh chóng !";

    if(!$mail->Send()) {
        echo "Mailer Error:".$mail->ErrorInfo;
    } else {
        echo "Success";
    }
?>