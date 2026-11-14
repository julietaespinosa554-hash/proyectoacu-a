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

$nombre = trim($_POST["nombre"] ?? "");
$email = trim($_POST["email"] ?? "");
$telefono = trim($_POST["telefono"] ?? "");
$password = $_POST["password"] ?? "";

if ($nombre === "" || $email === "" || $telefono === "" || $password === "") {
    http_response_code(400);
    echo json_encode([
        "ok" => false,
        "mensaje" => "Completá todos los campos"
    ]);
    exit;
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode([
        "ok" => false,
        "mensaje" => "El correo no es válido"
    ]);
    exit;
}

echo json_encode([
    "ok" => false,
    "mensaje" => "Datos recibidos. Falta conectar con las tablas definitivas."
]);

?>