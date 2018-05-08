<?php

    function format($result){
        $posts = array();
        while($r = mysqli_fetch_assoc($result)) {
            $rows[] = $r;
        }
        $string =  json_encode($rows);
        $rest = substr($string, 1, -1);
        echo $rest;
    }
?>