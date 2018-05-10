<?php
    include('conexiondb.class.php');

    $action = strtolower($_GET['action']);
        switch ($action) {
            case "login":
                Login();
            break;
            case "register":
                Register();
            break;
            case "loginname":
                Loginname();
            break;
        }   

    function Login(){ //localhost/Epidemic-Zombie-WebService/API-Rest/sn/query.php?action=login&json={"email":%20"a","passw""":"asd"}
        $json = $_GET['json'];
        $str = json_decode($json, true);
        $Mail = $str['email'];
        $Passw = $str['password'];
        $conexion = new conexiondb();
        $query = "SELECT * FROM sn_users WHERE email = '$Mail';";
        $result = $conexion->query($query);
        $conexion->desconectar();
        if(mysqli_num_rows($result)>0){
            while($r = mysqli_fetch_assoc($result)) {
                if($Passw === $r['password']){
                    echo json_encode($r);
                }else{
                    echo "0";
                }
             }
        }else{
            echo "1";
        }
    }

    function Register(){//localhost/Epidemic-Zombie-WebService/API-Rest/sn/query.php?action=register&json={"username":"c","email":"c","genre":"0","password":"21","sub":"1"}
        $json = $_GET['json'];
        $str = json_decode($json, true);
        $conexion = new conexiondb();
        $username = $str['username'];
        $Mail = $str['email'];
        $genre = $str['genre'];
        $Passw = $str['password'];
        $sub = $str['sub'];
        $query = "INSERT INTO `social-network`.`sn_users` (`username`, `email`, `genre`, `password`, `sub`, `img`)
        VALUES ('$username', '$Mail', '$genre', '$Passw', '$sub', null);";
        $result = $conexion->query($query);
    }
    function Loginname(){ //localhost/Epidemic-Zombie-WebService/API-Rest/sn/query.php?action=login&json={"email":%20"a","passw""":"asd"}
    $json = $_GET['json'];
    $str = json_decode($json, true);
    $Mail = $str['username'];
    $Passw = $str['password'];
    $conexion = new conexiondb();
    $query = "SELECT * FROM sn_users WHERE username = '$Mail';";
    $result = $conexion->query($query);
    $conexion->desconectar();
    if(mysqli_num_rows($result)>0){
        while($r = mysqli_fetch_assoc($result)) {
            if($Passw === $r['password']){
                echo $r['username'];
            }else{
                echo "";
            }
         }
    }else{
        echo "";
    }
}
?>