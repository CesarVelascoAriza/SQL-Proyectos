-- SQL Server DDL for users_app
CREATE DATABASE users_app;
GO
USE users_app;
GO

CREATE TABLE perfiles (
  id INT IDENTITY(1,1) PRIMARY KEY,
  nombre NVARCHAR(100) NOT NULL UNIQUE,
  descripcion NVARCHAR(MAX)
);

CREATE TABLE personas (
  id INT IDENTITY(1,1) PRIMARY KEY,
  nombre NVARCHAR(200) NOT NULL,
  apellido NVARCHAR(200),
  tipo_documento NVARCHAR(20),
  numero_documento NVARCHAR(50) UNIQUE,
  fecha_nacimiento DATE,
  correo NVARCHAR(255) UNIQUE,
  telefono NVARCHAR(50),
  direccion NVARCHAR(255),
  perfil_id INT NOT NULL,
  created_at DATETIME2 DEFAULT SYSUTCDATETIME(),
  CONSTRAINT FK_Personas_Perfil FOREIGN KEY (perfil_id) REFERENCES perfiles(id) ON DELETE NO ACTION
);

CREATE TABLE usuarios (
  id INT IDENTITY(1,1) PRIMARY KEY,
  persona_id INT NOT NULL,
  username NVARCHAR(150) NOT NULL UNIQUE,
  password_hash NVARCHAR(512) NOT NULL,
  activo BIT DEFAULT 1,
  created_at DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

ALTER TABLE usuarios ADD CONSTRAINT FK_Usuarios_Persona FOREIGN KEY (persona_id) REFERENCES personas(id) ON DELETE CASCADE;

CREATE TABLE menus (
  id INT IDENTITY(1,1) PRIMARY KEY,
  modulo NVARCHAR(150) NOT NULL,
  nombre NVARCHAR(150) NOT NULL,
  parent_id INT,
  orden INT DEFAULT 0
);
GO

ALTER TABLE menus ADD CONSTRAINT FK_Menus_Parent FOREIGN KEY (parent_id) REFERENCES menus(id);

CREATE UNIQUE INDEX UX_Menus_Modulo_Nombre ON menus(modulo, nombre);

CREATE TABLE pantallas (
  id INT IDENTITY(1,1) PRIMARY KEY,
  menu_id INT,
  nombre NVARCHAR(150) NOT NULL,
  ruta NVARCHAR(255) NOT NULL
);
GO

ALTER TABLE pantallas ADD CONSTRAINT FK_Pantallas_Menus FOREIGN KEY (menu_id) REFERENCES menus(id) ON DELETE CASCADE;

CREATE UNIQUE INDEX UX_Pantallas_Ruta ON pantallas(ruta);

-- Eliminada: permisos por pantalla. Consolidamos permisos en perfiles_menus.

CREATE TABLE perfiles_menus (
  perfil_id INT,
  menu_id INT,
  puede_ver BIT DEFAULT 1,
  puede_editar BIT DEFAULT 0,
  CONSTRAINT PK_PerfilesMenus PRIMARY KEY (perfil_id, menu_id)
);

ALTER TABLE perfiles_menus ADD CONSTRAINT FK_PerfilesMenus_Perfil FOREIGN KEY (perfil_id) REFERENCES perfiles(id);
ALTER TABLE perfiles_menus ADD CONSTRAINT FK_PerfilesMenus_Menu FOREIGN KEY (menu_id) REFERENCES menus(id);

-- Insertar perfil por defecto
IF NOT EXISTS (SELECT 1 FROM perfiles WHERE nombre = 'usuario')
  INSERT INTO perfiles (nombre, descripcion) VALUES ('usuario', 'Perfil por defecto');
