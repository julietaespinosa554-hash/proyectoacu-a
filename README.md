# 🎉 Eventia — Sistema de Gestión de Salones de Eventos

**Eventia** es una aplicación web diseñada para administrar y gestionar un negocio de salones de eventos con múltiples sucursales. Su objetivo es centralizar las reservas, organizar los espacios disponibles y facilitar la administración del negocio mediante una plataforma intuitiva.

El sistema permite que los clientes consulten salones, conozcan los tipos de eventos que se ofrecen y verifiquen la disponibilidad antes de realizar una reserva. Además, cuenta con paneles de gestión diferenciados según el rol de cada usuario.

---

## ✨ Funcionalidades principales

### 👤 Gestión de usuarios y roles

Eventia cuenta con cuatro niveles de acceso:

- **Cliente:** puede consultar sucursales, salones y disponibilidad. Puede registrarse para realizar reservas y consultar sus propias reservas.
- **Empleado:** administra las operaciones y reservas correspondientes a su sucursal.
- **Administrador:** gestiona una sucursal, incluyendo sus salones, empleados y reservas.
- **Superadministrador:** tiene acceso global al sistema y puede administrar todas las sucursales y sus respectivos administradores.

### 📅 Sistema de reservas

- Consulta de disponibilidad de salones.
- Selección del tipo de evento.
- Registro y gestión de reservas.
- Seguimiento del estado de cada reserva.
- Consulta de reservas personales por parte de los clientes.
- Gestión de bloqueos de disponibilidad de los salones.

### 🏢 Administración de sucursales

- Gestión de múltiples sucursales.
- Administración de salones por sucursal.
- Asignación de empleados y administradores.
- Control independiente de las operaciones de cada sucursal.

### 🔐 Control de acceso

- Acceso diferenciado según el rol del usuario.
- Protección de las operaciones administrativas.
- Registro de empleados mediante códigos de invitación.
- Restricción de información según los permisos correspondientes.

---

## 🛠️ Tecnologías utilizadas

| Tecnología | Utilización |
|---|---|
| HTML5 | Estructura de las páginas |
| CSS3 | Diseño y estilos |
| JavaScript | Interactividad del sitio |
| PHP | Lógica del servidor |
| MySQL | Gestión de la base de datos |
| XAMPP | Entorno de desarrollo local |
| phpMyAdmin | Administración de la base de datos |

---

## 🗄️ Base de datos

El sistema utiliza una base de datos relacional MySQL.

La estructura contempla las siguientes tablas:

- `Roles`: definición de los roles del sistema.
- `Sucursales`: información de cada sucursal.
- `Usuarios`: datos de acceso de los usuarios.
- `Invitaciones`: códigos de invitación para empleados.
- `Empleados`: información y asignación de empleados.
- `Clientes`: información de los clientes.
- `Salones`: espacios disponibles en cada sucursal.
- `Bloqueos_Salon`: períodos en los que un salón no está disponible.
- `Reservas`: registro y seguimiento de las reservas.

Las relaciones entre las tablas permiten mantener organizada la información y controlar el acceso a los datos según los permisos de cada usuario.

---

## ⚙️ Instalación y ejecución

Para ejecutar el proyecto en un entorno local:

1. Instalar [XAMPP](https://www.apachefriends.org/).
2. Iniciar los servicios Apache y MySQL.
3. Clonar o descargar este repositorio.
4. Colocar la carpeta del proyecto dentro de `htdocs`.
5. Acceder a phpMyAdmin desde `http://localhost/phpmyadmin`.
6. Crear la base de datos e importar el archivo SQL del proyecto cuando esté disponible.
7. Configurar la conexión a MySQL desde el proyecto.
8. Abrir la aplicación desde el navegador:

   `http://localhost/nombre-del-proyecto`

---

## 🚧 Estado del proyecto

**En desarrollo.**

Actualmente se está trabajando en la estructura de la base de datos, el sistema de usuarios y roles, la gestión de sucursales y el módulo de reservas.

### Próximas implementaciones

- [ ] Finalizar la estructura de la base de datos.
- [ ] Implementar el registro e inicio de sesión.
- [ ] Desarrollar los paneles según los roles.
- [ ] Implementar la gestión de sucursales y salones.
- [ ] Desarrollar el sistema de reservas.
- [ ] Incorporar validaciones y controles de permisos.
- [ ] Integrar los módulos del sistema.

---

## 🎯 Objetivo del proyecto

Desarrollar una plataforma web integral que permita optimizar la administración de un negocio de salones de eventos, centralizando sus operaciones y mejorando la experiencia tanto de los clientes como del personal administrativo.

---

**Eventia** — Gestión de eventos, reservas y sucursales en un solo lugar. 🎊
