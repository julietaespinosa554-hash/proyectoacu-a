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

// Recibir datos del formulario
$nombre = trim($_POST["nombre"] ?? "");
$apellido = trim($_POST["apellido"] ?? "");
$email = trim($_POST["email"] ?? "");
$telefono = trim($_POST["telefono"] ?? "");
$password = $_POST["password"] ?? "";

// Validar campos
if ($nombre === "" || $apellido === "" || $email === "" || $password === "") {
    http_response_code(400);
    echo json_encode([
        "ok" => false,
        "mensaje" => "Completá todos los campos obligatorios"
    ]);
    exit;
}

// Validar correo
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode([
        "ok" => false,
        "mensaje" => "El correo no es válido"
    ]);
    exit;
}

try {

    // Buscar si el correo ya existe
    $consulta = $conexion->prepare(
        "SELECT id_usuario FROM usuarios WHERE email = ?"
    );

    $consulta->bind_param("s", $email);
    $consulta->execute();
    $resultado = $consulta->get_result();

    if ($resultado->num_rows > 0) {
        http_response_code(409);
        echo json_encode([
            "ok" => false,
            "mensaje" => "Ese correo ya está registrado"
        ]);
        exit;
    }

    // Buscar el rol cliente
    $consultaRol = $conexion->prepare(
        "SELECT id_rol FROM roles WHERE nombre = 'cliente'"
    );

    $consultaRol->execute();
    $resultadoRol = $consultaRol->get_result();

    if ($resultadoRol->num_rows === 0) {
        throw new Exception("No se encontró el rol cliente");
    }

    $rol = $resultadoRol->fetch_assoc();
    $id_rol = $rol["id_rol"];

    // Encriptar contraseña
    $passwordHash = password_hash($password, PASSWORD_DEFAULT);

    // Iniciar transacción
    $conexion->begin_transaction();

    // Guardar usuario
    $insertarUsuario = $conexion->prepare(
        "INSERT INTO usuarios (id_rol, email, `contraseña`)
         VALUES (?, ?, ?)"
    );

    $insertarUsuario->bind_param(
        "iss",
        $id_rol,
        $email,
        $passwordHash
    );

    $insertarUsuario->execute();

    // Obtener ID del usuario creado
    $id_usuario = $conexion->insert_id;

    // Guardar datos del cliente
    $insertarCliente = $conexion->prepare(
        "INSERT INTO clientes
        (id_usuario, nombre, apellido, telefono)
        VALUES (?, ?, ?, ?)"
    );

    $insertarCliente->bind_param(
        "isss",
        $id_usuario,
        $nombre,
        $apellido,
        $telefono
    );

    $insertarCliente->execute();

    // Confirmar guardado
    $conexion->commit();

    echo json_encode([
        "ok" => true,
        "mensaje" => "Cuenta creada correctamente"
    ]);

} catch (Exception $e) {

    $conexion->rollback();

    http_response_code(500);

    echo json_encode([
        "ok" => false,
        "mensaje" => "No se pudo crear la cuenta. Revisá los datos y volvé a intentar."
    ]);

}

?>