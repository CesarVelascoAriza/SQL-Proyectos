-- ============================================
-- Script DDL: Definición de tablas del sistema de biblioteca
-- Autor: Cesar Velasco Ariza
-- Fecha: 2026-05-25
-- ============================================

PRINT '📘 Verificando y creando tablas si no existen...';
GO

-- Tabla de autores
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AUTHORS' AND xtype='U')
BEGIN
    CREATE TABLE AUTHORS (
        id INT IDENTITY(1,1) PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        last_name VARCHAR(100) NOT NULL
    );
    PRINT '✅ Tabla AUTHORS creada.';
END
ELSE
    PRINT 'ℹ️ Tabla AUTHORS ya existe, no se creó.';
GO

-- Tabla de géneros
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='GENRES' AND xtype='U')
BEGIN
    CREATE TABLE GENRES (
        id INT IDENTITY(1,1) PRIMARY KEY,
        name VARCHAR(50) NOT NULL
    );
    PRINT '✅ Tabla GENRES creada.';
END
ELSE
    PRINT 'ℹ️ Tabla GENRES ya existe, no se creó.';
GO

-- Tabla de libros
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='BOOKS' AND xtype='U')
BEGIN
    CREATE TABLE BOOKS (
        id INT IDENTITY(1,1) PRIMARY KEY,
        title VARCHAR(200) NOT NULL,
        author INT NOT NULL,
        genre INT NOT NULL,
        available BIT DEFAULT 1,
        isbn VARCHAR(20),
        price DECIMAL(10,2),
        FOREIGN KEY (author) REFERENCES AUTHORS(id),
        FOREIGN KEY (genre) REFERENCES GENRES(id)
    );
    PRINT '✅ Tabla BOOKS creada.';
END
ELSE
    PRINT 'ℹ️ Tabla BOOKS ya existe, no se creó.';
GO
