
CREATE DATABASE eventia
CHARACTER SET utf8mb4 /*para que funke ñ y acentos*/
COLLATE utf8mb4_unicode_ci;--para q le de igual mayus o no

USE eventia;

CREATE TABLE Roles(
 `Id Rol`   int AUTO_INCREMENT PRIMARY KEY,
  nombre varchar(40) NOT null UNIQUE
);--1

CREATE TABLE sucursales(
`Id sucursal` int AUTO_INCREMENT PRIMARY KEY,
    nombre varchar (40)NOT null,
    dirección varchar(50) NOT null,
    telefono varchar(30),
    activa bool DEFAULT true
);--2

CREATE TABLE usuarios(
`Id usuario` int AUTO_INCREMENT PRIMARY key,
    `id rol` int not null,
    email varchar(80) NOT null UNIQUE,
    contraseña varchar (30)NOT null,
    estado enum('activo','inactivo') DEFAULT 'activo',/*permite almacenar un valor elegido entre una lista de opciones predefinidas.*/
    `fechar registro` DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (`id rol`) REFERENCES Roles(`id rol`)
);--3

ALTER TABLE usuarios --ffalto la foranea y que 
ADD COLUMN `Id sucursal` INT NULL AFTER `id rol`,
ADD CONSTRAINT fk_usuarios_sucursales
FOREIGN KEY (`id sucursal`)
REFERENCES Sucursales(`id sucursal`);

CREATE TABLE Invitaciones (
    `id invitacion` INT AUTO_INCREMENT PRIMARY KEY,
    `id sucursal` INT NOT NULL,
    `id creador` INT NOT NULL,
    codigo VARCHAR(100) NOT NULL UNIQUE,
    `fecha creacion` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `fecha vencimiento` DATETIME NOT NULL,
    `fecha uso` DATETIME,
    utilizada BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (`id sucursal`)
        REFERENCES Sucursales(`id sucursal`),

    FOREIGN KEY (`id creador`)
        REFERENCES Usuarios(`id usuario`)
);--4

CREATE TABLE Empleados (
    `id empleado` INT AUTO_INCREMENT PRIMARY KEY,
    `id usuario` INT NOT NULL UNIQUE,
    `id invitacion` INT NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(30),

    FOREIGN KEY (`id usuario`)
        REFERENCES Usuarios(`Id usuario`),

    FOREIGN KEY (`id invitacion`)
        REFERENCES Invitaciones(`id invitacion`)
);--5

CREATE TABLE Clientes (
    `id cliente` INT AUTO_INCREMENT PRIMARY KEY,
    `id usuario` INT NOT NULL UNIQUE,
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    telefono VARCHAR(30),

    FOREIGN KEY (`id usuario`)
        REFERENCES Usuarios(`Id usuario`)
);--6

CREATE TABLE Salones (
    `id salon` INT AUTO_INCREMENT PRIMARY KEY,
    `id sucursal` INT NOT NULL,
    nombre VARCHAR(60) NOT NULL,
    capacidad INT NOT NULL,
    `precio base` DECIMAL(10,2) NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (`id sucursal`)
        REFERENCES Sucursales(`Id sucursal`)
);--7

CREATE TABLE Bloqueos_Salon (
    `id bloqueo` INT AUTO_INCREMENT PRIMARY KEY,
    `id salon` INT NOT NULL,
    fecha DATE NOT NULL,
    `hora inicio` TIME NOT NULL,
    `hora fin` TIME NOT NULL,
    motivo text,

    FOREIGN KEY (`id salon`)
        REFERENCES Salones(`id salon`)
);--8

CREATE TABLE Reservas (
    `id reserva` INT AUTO_INCREMENT PRIMARY KEY,
    `id cliente` INT NOT NULL,
    `id salon` INT NOT NULL,
    `id empleado` INT NULL,

    `tipo evento` TEXT NOT NULL,

    `estado reserva` ENUM(
        'pendiente',
        'confirmada',
        'cancelada',
        'finalizada'
    ) DEFAULT 'pendiente',

    `nombre evento` TEXT,
    `fecha evento` DATE NOT NULL,
    `hora inicio` TIME NOT NULL,
    `hora fin` TIME NOT NULL,
    `cantidad invitados` INT NOT NULL,
    `fecha creacion` DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (`id cliente`)
        REFERENCES Clientes(`id cliente`),

    FOREIGN KEY (`id salon`)
        REFERENCES Salones(`id salon`),

    FOREIGN KEY (`id empleado`)
        REFERENCES Empleados(`id empleado`)
);--9
