<?php
    include "connect.php";
    $query="SELECT *FROM  loaisp";
    $data= mysqli_query($conn,$query);
    $mangloaisp=array();
    while($row=mysqli_fetch_assoc($data)){
        array_push($mangloaisp,new Loaisp(
            $row['id'],
            $row['tenloaisanpham'],
            $row['hinhanhloaisanpham']
        ));
    }

    echo json_encode($mangloaisp);

    class Loaisp{
        function Loaisp($id,$tenloaisp,$hinhanhloaisp){
            $this->id=$id;
            $this->tenloaisp=$tenloaisp;
            $this->hinhanhloaisp=$hinhanhloaisp;
        }
    }


?>