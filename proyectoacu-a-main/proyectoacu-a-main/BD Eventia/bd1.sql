CREATE DATABASE IF NOT EXISTS eventia
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE eventia;

-- 1. ROLES
CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL UNIQUE
) ENGINE=InnoDB;

INSERT INTO roles (nombre) VALUES
('cliente'),
('empleado'),
('administrador'),
('superadmin');


-- 2. SUCURSALES
CREATE TABLE sucursales (
    id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(30),
    activa BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;


-- 3. USUARIOS
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_rol INT NOT NULL,
    id_sucursal INT NULL,
    email VARCHAR(80) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    estado ENUM('activo','inactivo') DEFAULT 'activo',
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_rol)
        REFERENCES roles(id_rol),

    FOREIGN KEY (id_sucursal)
        REFERENCES sucursales(id_sucursal)
) ENGINE=InnoDB;


-- 4. INVITACIONES
CREATE TABLE invitaciones (
    id_invitacion INT AUTO_INCREMENT PRIMARY KEY,
    id_sucursal INT NOT NULL,
    id_creador INT NOT NULL,
    codigo VARCHAR(100) NOT NULL UNIQUE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_vencimiento DATETIME NOT NULL,
    fecha_uso DATETIME NULL,
    utilizada BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (id_sucursal)
        REFERENCES sucursales(id_sucursal),

    FOREIGN KEY (id_creador)
        REFERENCES usuarios(id_usuario)
) ENGINE=InnoDB;


-- 5. EMPLEADOS
CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    id_invitacion INT NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(30),

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario),

    FOREIGN KEY (id_invitacion)
        REFERENCES invitaciones(id_invitacion)
) ENGINE=InnoDB;


-- 6. CLIENTES
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    telefono VARCHAR(30),

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
) ENGINE=InnoDB;


-- 7. SALONES
CREATE TABLE salones (
    id_salon INT AUTO_INCREMENT PRIMARY KEY,
    id_sucursal INT NOT NULL UNIQUE,
    nombre VARCHAR(60) NOT NULL,
    capacidad INT NOT NULL,
    descripcion TEXT,
    precio_base DECIMAL(10,2) NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (id_sucursal)
        REFERENCES sucursales(id_sucursal)
) ENGINE=InnoDB;


-- 8. BLOQUEOS DE SALONES
CREATE TABLE bloqueos_salon (
    id_bloqueo INT AUTO_INCREMENT PRIMARY KEY,
    id_salon INT NOT NULL,
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    motivo TEXT,

    FOREIGN KEY (id_salon)
        REFERENCES salones(id_salon)
) ENGINE=InnoDB;


-- 9. RESERVAS
CREATE TABLE reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_salon INT NOT NULL,
    id_empleado INT NULL,
    tipo_evento VARCHAR(100) NOT NULL,
    estado_reserva ENUM(
        'pendiente',
        'confirmada',
        'cancelada',
        'finalizada'
    ) DEFAULT 'pendiente',
    nombre_evento VARCHAR(100),
    fecha_evento DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    cantidad_invitados INT NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    FOREIGN KEY (id_salon)
        REFERENCES salones(id_salon),

    FOREIGN KEY (id_empleado)
        REFERENCES empleados(id_empleado)
) ENGINE=InnoDB;