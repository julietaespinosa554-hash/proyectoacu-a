<?php

require_once "conexion.php";

header("Content-Type: application/json; charset=utf-8");

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    http_response_code(405);
    echo json_encode([
        "ok" => false,
        "mensaje" => "Método no permitido"
    ]);
    exit;
}

$id_sucursal = $_POST["id_sucursal"] ?? "";
$fecha = $_POST["fecha"] ?? "";

if ($id_sucursal === "" || $fecha === "") {
    http_response_code(400);
    echo json_encode([
        "ok" => false,
        "mensaje" => "Seleccioná una sucursal y una fecha"
    ]);
    exit;
}

echo json_encode([
    "ok" => false,
    "mensaje" => "Datos recibidos. Falta conectar la consulta con las tablas definitivas."
]);

?>