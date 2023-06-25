/*
***************************************
* creacion de usuarios  para oracle
***************************************
*/

/*
Crear data base 
*/

CREATE DATABASE LIBRERIA;
USE LIBRERIA;
/**/
CREATE TABLE roles (
    id_rol INTEGER PRIMARY KEY,
    rol NVARCHAR(60)
);
CREATE TABLE tipo_documentos(
  id_tipo INTEGER PRIMARY KEY,
  nom_tipo_corto NVARCHAR(6),
  nom_tipo_largo NVARCHAR(100)
);

CREATE TABLE usuarios (
    id_usuario INTEGER IDENTITY,
    tipo_doc INTEGER  REFERENCES  tipo_documentos (id_tipo),
    documento INTEGER,
    nombre NVARCHAR(100),
    apellido NVARCHAR(100),
    fecha_nacimiento TIMESTAMP,
    correo_electronico NVARCHAR(100),
    direccion NVARCHAR(60),
    PRIMARY key  (id_usuario, tipo_doc, documento) 
);

create table Roles_Usuarios(
	 rol     INTEGER NOT NULL ,
    usuario INTEGER NOT NULL 
);


/*Drop taable*/
drop table roles ;
drop table usuarios ;
drop table tipo_documentos ;
