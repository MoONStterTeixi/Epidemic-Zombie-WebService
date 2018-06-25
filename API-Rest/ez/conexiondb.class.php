<?php

    class conexiondb {
        private $servidor;
        private $puerto;
        private $user;
        private $pass;
        private $db;
        private $conexion;

        function __construct(){
            $this->servidor = "localhost";
            $this->puerto = "3306";
            $this->user = "id5753920_usr";
            $this->pass = "RamonJamon";
            $this->db = "id5753920_epidemic_zombiedb";
            if(isset($puerto)){
                $this->servidor = $this->Servidor . ":" . $this->puerto;
            }
            $this->conectar();
        }

        function __destruct() {
            $this->desconectar();
        }

        function conectar(){
            $this->conexion = mysqli_connect($this->servidor, $this->user, $this->pass, $this->db);
            if(mysqli_connect_errno()){
                echo 'Error: ' . mysqli_connect_errno();
            }
            return $this->conexion;
        }

        function desconectar(){
        }

        function query($query){
            $resultado = $this->conexion->query($query);
                return $resultado;
        }
    }
?>