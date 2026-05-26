/*
 Pre-Deployment Script Template
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.
 Use SQLCMD syntax to include a file in the pre-deployment script.
 Example:      :r .\myfile.sql
 Use SQLCMD syntax to reference a variable in the pre-deployment script.
 Example:      :setvar TableName MyTable
               SELECT * FROM [$(TableName)]
--------------------------------------------------------------------------------------

*/
PRINT '🔧 Verificando base de datos Elecciones...';
GO

-- Crear la base de datos solo si no existe
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'Elecciones')
BEGIN
    CREATE DATABASE Elecciones;
    PRINT '✅ Base de datos Elecciones creada.';
END
ELSE
    PRINT 'ℹ️ La base de datos Elecciones ya existe, no se creó.';
GO

-- Usar la base de datos
USE Elecciones;
GO
