-- SQL Server initialization for LIBRERIA
CREATE DATABASE LIBRERIA;
GO
USE LIBRERIA;
GO

CREATE TABLE roles (
    id_rol INT PRIMARY KEY,
    rol NVARCHAR(60)
);

CREATE TABLE tipo_documentos(
  id_tipo INT PRIMARY KEY,
  nom_tipo_corto NVARCHAR(6),
  nom_tipo_largo NVARCHAR(100)
);

CREATE TABLE usuarios (
    id_usuario INT IDENTITY PRIMARY KEY,
    tipo_doc INT REFERENCES tipo_documentos (id_tipo),
    documento INT,
    nombre NVARCHAR(100),
    apellido NVARCHAR(100),
    fecha_nacimiento DATETIME2,
    correo_electronico NVARCHAR(100),
    direccion NVARCHAR(60)
);

CREATE TABLE Roles_Usuarios(
    rol INT NOT NULL,
    usuario INT NOT NULL
);
