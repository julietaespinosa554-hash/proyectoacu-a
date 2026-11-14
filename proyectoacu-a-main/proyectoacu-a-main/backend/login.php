<?php

session_start();

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

$consulta = $conexion->prepare(
    "SELECT u.id_usuario, u.email, u.`contraseña`,
            u.id_sucursal, r.nombre AS rol
     FROM usuarios u
     INNER JOIN roles r ON u.id_rol = r.id_rol
     WHERE u.email = ? AND u.estado = 'activo'"
);

$consulta->bind_param("s", $email);
$consulta->execute();

$resultado = $consulta->get_result();

if ($resultado->num_rows === 0) {
    http_response_code(401);
    echo json_encode([
        "ok" => false,
        "mensaje" => "Correo o contraseña incorrectos"
    ]);
    exit;
}

$usuario = $resultado->fetch_assoc();

if (!password_verify($password, $usuario["contraseña"])) {
    http_response_code(401);
    echo json_encode([
        "ok" => false,
        "mensaje" => "Correo o contraseña incorrectos"
    ]);
    exit;
}

session_regenerate_id(true);

$_SESSION["id_usuario"] = $usuario["id_usuario"];
$_SESSION["email"] = $usuario["email"];
$_SESSION["rol"] = $usuario["rol"];
$_SESSION["id_sucursal"] = $usuario["id_sucursal"];

$destinos = [
    "cliente" => "../cliente/panel-cliente.html",
    "empleado" => "../empleado/panel-empleado.html",
    "administrador" => "../administrador/panel-admin.html",
    "superadmin" => "../superadmin/panel-superadmin.html"
];

echo json_encode([
    "ok" => true,
    "mensaje" => "Inicio de sesión exitoso",
    "redireccion" => $destinos[$usuario["rol"]] ?? null
]);

?>