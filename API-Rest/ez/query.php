 <?php
    include('conexiondb.class.php');

    $action = strtolower($_GET['action']);
        switch ($action) {
            case "get":
                get();
                break;
            case "update":
                update();
                break;
            case "getofflinemoney":
                GetOffLineMoney();
                break;
            case "getusr":
                getusr();
                break;
            case "gettop":
                getTop();
                break;
            case "test":
                test();
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
            $query = "INSERT INTO `ez_users` (`nickname`, `experience`, `money`, `act_round`, 
            `VidaMax`, `DmgMele`, `DmgRange`,`Suerte`) 
            VALUES ('$Mail', '0', '0', '0', '10', '10', '10','1');";
            $result = $conexion->query($query);
            get();
        }
    }

    function update(){
        $json = $_GET['json'];
        $str = json_decode($json, true);
        //player
        $id = $str['id'];
        $experience = $str['experience'];
        $money = $str['money'];
        $act_round = $str['act_round'];
        //Stats
        $vidaMax = $str['VidaMax'];
        $DmgMele = $str['DmgMele'];
        $Torreta = $str['Torreta'];
        $Suerte = $str['Suerte'];
        $DmgRange = $str['DmgRange'];
        $conexion = new conexiondb();
        $query = "UPDATE `ez_users` SET `LastConection` = NOW(),`experience` = $experience, `act_round` = $act_round, `VidaMax` = $vidaMax,
        `DmgMele` = $DmgMele, `Torreta` = $Torreta, `DmgRange` = $DmgRange,`money` = $money WHERE `id`= $id";
        $result = $conexion->query($query);
        $conexion->desconectar();
        echo $result;
    }

    function GetDateAct(){
        $conexion = new conexiondb();
        $query = "SELECT now();";
        $result = $conexion->query($query);
        $conexion->desconectar();
        $Lastdate = null;
        if(mysqli_num_rows($result)>0){
            while($r = mysqli_fetch_assoc($result)) {
                $Lastdate = new DateTime($r["now()"]);
             }
        }
        return $Lastdate;
    }

    function GetOffLineMoney(){
        $json = $_GET['json'];
        $str = json_decode($json, true);
        $Mail = $str['id'];
        $conexion = new conexiondb();
        $query = "SELECT * FROM ez_users WHERE id = '$Mail';";
        $result = $conexion->query($query);
        $conexion->desconectar();
        
        $actdate = GetDateAct();
        $Lastdate = null;
        if(mysqli_num_rows($result)>0){
            while($r = mysqli_fetch_assoc($result)) {
                $Lastdate = new DateTime($r['LastConection']);
             }
        }
        $interval = $Lastdate->diff($actdate);
		$minutes = $interval->days;
		$minutes += $interval->h * 60;
		$minutes += $interval->i;
		echo $minutes;
    }
    function getusr(){
        $json = $_GET['json'];
        $str = json_decode($json, true);
        $Mail = $str['username'];
        $conexion = new conexiondb();
        $query = "SELECT VidaMax, money, DmgRange, act_round, experience FROM ez_users WHERE nickname = '$Mail';";
        $result = $conexion->query($query);
        $conexion->desconectar();
        if(mysqli_num_rows($result)>0){
            while($r = mysqli_fetch_assoc($result)) {
                echo json_encode($r);
            }
        }else{
            echo '{"VidaMax":"No disponible", "money":"No disponible","DmgRange":"No disponible","act_round":"No disponible","experience":"No disponible"}';
        }
    }

    function getTop(){
        $News = array();
        $conexion = new conexiondb();
        $query = "SELECT nickname, experience, act_round FROM ez_users ORDER BY act_round DESC LIMIT 10;";
        $result = $conexion->query($query);
        $conexion->desconectar();
        $i =1;
        if(mysqli_num_rows($result)>0){
            while($r = mysqli_fetch_assoc($result)) {
                $r["position"] = $i;
                array_push($News, $r);
                $i++;
            }
        }//No te olvides de poner el where en el deleted from
         echo '{"error":false, "global":' . json_encode($News) . '}';
        
    }
    function test(){
        echo '{"error":false, "player":{"money":"No disponible","DmgRange":"No disponible","act_round":"No disponible","experience":"No disponible"}}';
    }
?>