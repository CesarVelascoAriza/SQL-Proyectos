-- ============================================
-- Script de consultas de prueba
-- Autor: Cesar Velasco Ariza
-- Fecha: 2026-05-25
-- ============================================

PRINT '📙 Ejecutando consultas de prueba...';
GO

-- 1. Listar todos los libros con su autor y género
SELECT b.title, a.name + ' ' + a.last_name AS Autor, g.name AS Género, b.price, b.available
FROM BOOKS b
JOIN AUTHORS a ON b.author = a.id
JOIN GENRES g ON b.genre = g.id;

-- 2. Consultar libros disponibles
SELECT title, isbn, price
FROM BOOKS
WHERE available = 1;

-- 3. Buscar libros por autor específico
SELECT b.title, g.name AS Género
FROM BOOKS b
JOIN GENRES g ON b.genre = g.id
WHERE b.author = (SELECT id FROM AUTHORS WHERE name='Gabriel' AND last_name='García Márquez');

-- 4. Actualizar disponibilidad de un libro (ejemplo)
UPDATE BOOKS
SET available = 0
WHERE isbn = '9780307474728';

-- 5. Eliminar un género (ejemplo)
DELETE FROM GENRES
WHERE name = 'Ciencia Ficción';

-- 6. Contar cuántos libros hay por género
SELECT g.name AS Género, COUNT(*) AS TotalLibros
FROM BOOKS b
JOIN GENRES g ON b.genre = g.id
GROUP BY g.name;

PRINT '✅ Consultas de prueba ejecutadas correctamente.';
GO
