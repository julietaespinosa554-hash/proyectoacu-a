<?php

$conexion = new mysqli(
    "127.0.0.1",
    "root",
    "",
    "eventia",
    3307
);

if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

$conexion->set_charset("utf8mb4");

?>