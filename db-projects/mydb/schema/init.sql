-- MySQL initialization for mydb
DROP DATABASE IF EXISTS `mydb`;
CREATE DATABASE IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb4;
USE `mydb`;

CREATE TABLE IF NOT EXISTS `Cliente` (
  `id` INT AUTO_INCREMENT,
  `identificacion` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `edad` DATETIME NULL,
  `tipo_ident` INT NOT NULL,
  `correo` VARCHAR(100) NULL,
  PRIMARY KEY (`id`)
 ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `Roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `Tipo_Identificacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_corto` VARCHAR(5) NULL,
  `tipo_largo` VARCHAR(45) NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
