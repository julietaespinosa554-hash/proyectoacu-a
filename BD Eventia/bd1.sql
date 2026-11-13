
CREATE DATABASE eventia
CHARACTER SET utf8mb4 /*para que funke ñ y acentos*/
COLLATE utf8mb4_unicode_ci;--para q le de igual mayus o no

USE eventia;

CREATE TABLE Roles(
 `Id Rol`   int AUTO_INCREMENT PRIMARY KEY,
  nombre varchar(40) NOT null UNIQUE
);

CREATE TABLE sucursales(
`Id sucursal` int AUTO_INCREMENT PRIMARY KEY,
    nombre varchar (40)NOT null,
    dirección varchar(50) NOT null,
    telefono varchar(30),
    activa bool DEFAULT true
);

CREATE TABLE usuarios(
`Id usuario` int AUTO_INCREMENT PRIMARY key,
    `id rol` int not null,
    email varchar(80) NOT null UNIQUE,
    contraseña varchar (30)NOT null,
    estado enum('activo','inactivo') DEFAULT 'activo',/*permite almacenar un valor elegido entre una lista de opciones predefinidas.*/
    `fechar registro` DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (`id rol`) REFERENCES Roles(`id rol`)
);
