-- MySQL DDL for users_app
CREATE DATABASE IF NOT EXISTS users_app CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE users_app;

CREATE TABLE IF NOT EXISTS perfiles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL UNIQUE,
  descripcion TEXT
);

CREATE TABLE IF NOT EXISTS personas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(200) NOT NULL,
  apellido VARCHAR(200),
  tipo_documento VARCHAR(20),
  numero_documento VARCHAR(50) UNIQUE,
  fecha_nacimiento DATE,
  correo VARCHAR(255) UNIQUE,
  telefono VARCHAR(50),
  direccion VARCHAR(255),
  perfil_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT FK_Personas_Perfil FOREIGN KEY (perfil_id) REFERENCES perfiles(id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  persona_id INT NOT NULL,
  username VARCHAR(150) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  activo TINYINT(1) DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (persona_id) REFERENCES personas(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS menus (
  id INT AUTO_INCREMENT PRIMARY KEY,
  modulo VARCHAR(150) NOT NULL,
  nombre VARCHAR(150) NOT NULL,
  parent_id INT,
  orden INT DEFAULT 0,
  FOREIGN KEY (parent_id) REFERENCES menus(id),
  UNIQUE KEY ux_modulo_nombre (modulo, nombre)
);

CREATE TABLE IF NOT EXISTS pantallas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  menu_id INT,
  nombre VARCHAR(150) NOT NULL,
  ruta VARCHAR(255) NOT NULL,
  FOREIGN KEY (menu_id) REFERENCES menus(id) ON DELETE CASCADE,
  UNIQUE KEY ux_ruta (ruta)
);

-- Eliminada: permisos por pantalla. Ver `perfiles_menus` para permisos por menú.

CREATE TABLE IF NOT EXISTS perfiles_menus (
  perfil_id INT,
  menu_id INT,
  puede_ver TINYINT(1) DEFAULT 1,
  puede_editar TINYINT(1) DEFAULT 0,
  PRIMARY KEY (perfil_id, menu_id),
  FOREIGN KEY (perfil_id) REFERENCES perfiles(id),
  FOREIGN KEY (menu_id) REFERENCES menus(id)
);

-- ejemplo: crear perfil por defecto
INSERT IGNORE INTO perfiles (nombre, descripcion) VALUES ('usuario', 'Perfil por defecto');
