-- ============================================
-- Script DML: Inserción de datos iniciales
-- Autor: Cesar Velasco Ariza
-- Fecha: 2026-05-25
-- ============================================

PRINT '📗 Insertando datos iniciales...';
GO

-- Insertar autores solo si no existen
IF NOT EXISTS (SELECT 1 FROM AUTHORS WHERE name='Gabriel' AND last_name='García Márquez')
    INSERT INTO AUTHORS (name, last_name)
    VALUES ('Gabriel', 'García Márquez');

IF NOT EXISTS (SELECT 1 FROM AUTHORS WHERE name='Isabel' AND last_name='Allende')
    INSERT INTO AUTHORS (name, last_name)
    VALUES ('Isabel', 'Allende');
GO

-- Insertar géneros solo si no existen
IF NOT EXISTS (SELECT 1 FROM GENRES WHERE name='Novela')
    INSERT INTO GENRES (name)
    VALUES ('Novela');

IF NOT EXISTS (SELECT 1 FROM GENRES WHERE name='Ciencia Ficción')
    INSERT INTO GENRES (name)
    VALUES ('Ciencia Ficción');
GO

-- Insertar libros solo si no existen (usando ISBN como referencia única)
IF NOT EXISTS (SELECT 1 FROM BOOKS WHERE isbn='9780307474728')
    INSERT INTO BOOKS (title, author, genre, available, isbn, price)
    VALUES ('Cien años de soledad', 
            (SELECT id FROM AUTHORS WHERE name='Gabriel' AND last_name='García Márquez'),
            (SELECT id FROM GENRES WHERE name='Novela'),
            1, '9780307474728', 45000);

IF NOT EXISTS (SELECT 1 FROM BOOKS WHERE isbn='9780553383805')
    INSERT INTO BOOKS (title, author, genre, available, isbn, price)
    VALUES ('La casa de los espíritus', 
            (SELECT id FROM AUTHORS WHERE name='Isabel' AND last_name='Allende'),
            (SELECT id FROM GENRES WHERE name='Novela'),
            1, '9780553383805', 38000);
GO

PRINT '✅ Datos iniciales insertados correctamente.';
