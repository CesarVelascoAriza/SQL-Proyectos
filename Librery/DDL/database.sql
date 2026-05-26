-- ============================================
-- Script de creación de la base de datos Library
-- Autor: Cesar Velasco Ariza
-- Fecha: 2026-05-25
-- ============================================

PRINT '🔧 Verificando base de datos Library...';
GO

-- Crear la base de datos solo si no existe
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'Library')
BEGIN
    CREATE DATABASE Library;
    PRINT '✅ Base de datos Library creada.';
END
ELSE
    PRINT 'ℹ️ La base de datos Library ya existe, no se creó.';
GO

-- Usar la base de datos
USE Library;
GO
