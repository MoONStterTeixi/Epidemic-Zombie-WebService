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
            case "getnews":
                GetNews();
            break;
            case "getgames":
                GetGames();
            break;
            case "update":
                Update();
            break;
            /*case "test":
                test();
            break;*/
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
        $exist1 = MailExist($Mail);
        $exist2 = UserExist($username);
		if($exist1 and $exist2){
			echo '3'; //All used
		}
        elseif($exist1){
            echo '1'; //Username Take
        }
        elseif($exist2){
            echo '2'; //Mail Take
        }else{
            $query = "INSERT INTO `sn_users` (`username`, `email`, `genre`, `password`, `sub`)
            VALUES ('$username', '$Mail', '$genre', '$Passw', '$sub');";
            $result = $conexion->query($query);
            echo '0'; //Todo Ok
        }
    }

    function MailExist($Mail){
        $conexion = new conexiondb();
        $query = "SELECT * FROM sn_users WHERE email = '$Mail';";
        $result = $conexion->query($query);
        $conexion->desconectar();
        if(mysqli_num_rows($result)>0){
            return true;
        }else{
            return false;
        }
    }
    function UserExist($username){
        $conexion = new conexiondb();
        $query = "SELECT * FROM sn_users WHERE username = '$username';";
        $result = $conexion->query($query);
        $conexion->desconectar();
        if(mysqli_num_rows($result)>0){
            return true;
        }else{
            return false;
        }
    }

    function GetNews(){ //localhost/Epidemic-Zombie-WebService/API-Rest/sn/query.php?action=getnews&
        $News = array();
        $conexion = new conexiondb();
        $query = "SELECT * FROM sn_news;";
        $result = $conexion->query($query);
        $conexion->desconectar();
        if(mysqli_num_rows($result)>0){
            while($r = mysqli_fetch_assoc($result)) {
                array_push($News, $r);
            }
        }//No te olvides de poner el where en el deleted from
         echo '{"error":false, "news":' . json_encode($News) . '}';
    }

    function GetGames(){ //localhost/Epidemic-Zombie-WebService/API-Rest/sn/query.php?action=getnews&
        $Games = array();
        $conexion = new conexiondb();
        $query = "SELECT * FROM sn_games;";
        $result = $conexion->query($query);
        $conexion->desconectar();
        if(mysqli_num_rows($result)>0){
            while($r = mysqli_fetch_assoc($result)) {
                array_push($Games, $r);
            }
        }
        echo '{"error":false, "games":' . json_encode($Games) . '}';
    }

    function Update(){
        $json = $_GET['json'];
        $str = json_decode($json, true);
        //player
        $username = $str['username'];
        $email = $str['email'];
        $genre = $str['genre'];
        $password = $str['password'];
        $sub = $str['sub'];
        $conexion = new conexiondb();
        $query = "UPDATE `u133117db1`.`sn_users` SET `email`='$email', `genre`='$genre', `password`='$password', `sub`='$sub' WHERE `username`='$username';";
        $result = $conexion->query($query);
        $conexion->desconectar();
        echo $result;
    }
    /*function test(){
        echo '{
            "error": false,
            "global":[
                {
                    "nicknamed": "Yo",
                    "experience": "10000",
                    "act_round": "1", 
                }
            ]
        }';
    }*/
?>