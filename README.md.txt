# Sistema de Gestión y Distribución de Activos TI - UGEL 04

Sistema web institucional desarrollado bajo arquitectura MVC para la administración, asignación, monitoreo y control del ciclo de vida de los activos tecnológicos distribuidos en las Instituciones Educativas de la jurisdicción de UGEL 04 (Comas, Carabayllo, Puente Piedra, Ancón, Santa Rosa).

## 🛠️ Tecnologías Utilizadas

- **Lenguaje:** Java 21 (LTS)
- **Especificación Empresarial:** Jakarta EE 10 (Servlets, JSP, JSTL)
- **Servidor de Aplicaciones:** Eclipse GlassFish 7.0.25
- **Base de Datos:** MySQL 8.0 (Conector JDBC `mysql-connector-j`)
- **Gestor de Dependencias:** Apache Maven
- **Frontend:** HTML5, CSS3 (GovTech Design System), JavaScript vanilla, Bootstrap Icons

## 📋 Estructura de la Base de Datos

El script de inicialización de base de datos se encuentra en la raíz del proyecto (`database.sql` o `schema.sql`) e implementa:
- `ugel04_activos_db`
- Tablas relacionales: `activos`, `instituciones_educativas`.
- Integridad referencial con claves foráneas y disparadores para auditoría de estados.

## 🚀 Despliegue Local

1. Clonar el repositorio:
   ```bash
   git clone [https://github.com/TU_USUARIO/ugel04-activos-web.git](https://github.com/TU_USUARIO/ugel04-activos-web.git)