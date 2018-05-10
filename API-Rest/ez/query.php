<?php
    include('conexiondb.class.php');

    $action = strtolower($_GET['action']);
        switch ($action) {
            case "get":
                get();
                break;
        }   

    function get(){
        $json = $_GET['json'];
        $str = json_decode($json, true);
        $Mail = $str['username'];
        $conexion = new conexiondb();
        $query = "SELECT * FROM ez_users WHERE nickname = '$Mail';";
        $result = $conexion->query($query);
        $conexion->desconectar();
        if(mysqli_num_rows($result)>0){
            while($r = mysqli_fetch_assoc($result)) {
                echo json_encode($r);
             }
        }else{
            $query = "INSERT INTO `epidemic-zombiedb`.`ez_users` (`nickname`, `experience`, `money`, `act_round`, 
            `VidaMax`, `DmgMele`, `DmgRange`, `GeneracionOnline`, `Suerte`) 
            VALUES ('$Mail', '0', '100', '1', '100', '10', '10', '3', '1');";
            $result = $conexion->query($query);
            get();
        }
    }
?>