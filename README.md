# Sistema de Gestión de Activos TI - UGEL 04

Proyecto web para el registro, asignación y control de equipos tecnológicos (laptops, PCs, proyectores, redes) distribuidos en los colegios de la jurisdicción de UGEL 04 (Comas, Carabayllo, Puente Piedra, Ancón y Santa Rosa).

Desarrollado bajo el patrón MVC con Java Web y conexión a base de datos relacional.

## Entorno y Tecnologías
* Lenguaje: Java 21
* Plataforma: Jakarta EE 10 (Servlets, JSP, JSTL)
* Servidor: GlassFish 7.0.x
* Base de datos: MySQL 8.0
* IDE: Apache NetBeans 29
* Frontend: HTML5, CSS3, JavaScript nativo

## Puesta en marcha local
1. Abrir MySQL Workbench y ejecutar el script `database.sql` para crear la base de datos `ugel04_activos_db` y sus tablas.
2. Comprobar los datos de acceso (usuario `root` y contraseña) en la clase `ConexionDB.java`.
3. Abrir el proyecto en Apache NetBeans.
4. Iniciar el servidor GlassFish 7 desde la pestaña Services.
5. Hacer clic derecho en el proyecto > **Clean and Build**, y luego **Run**.
6. La aplicación cargará en: `http://localhost:8080/ugel04-activos-web/activos`

## Estructura del Proyecto
* `ugel04.modelo`: Clases entidad y objetos de transferencia (DTO).
* `ugel04.dao`: Acceso a datos y consultas SQL (CRUD).
* `ugel04.controlador`: Servlets encargados de recibir peticiones y redireccionar vistas.
* `ugel04.config`: Manejo de conexión JDBC Singleton.
* `Web Pages`: Vistas JSP (`header`, `footer`, tabla central) y recursos estáticos (`css`, `imagen`, `js`).