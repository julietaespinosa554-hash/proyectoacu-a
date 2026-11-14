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

$email = trim($_POST["email"] ?? "");
$password = $_POST["password"] ?? "";

if ($email === "" || $password === "") {
    http_response_code(400);
    echo json_encode([
        "ok" => false,
        "mensaje" => "Completá todos los campos"
    ]);
    exit;
}

// La consulta a la base de datos se agrega
// cuando tengamos las tablas definitivas.

echo json_encode([
    "ok" => false,
    "mensaje" => "Formulario recibido. Falta conectar la consulta de usuarios."
]);

?>