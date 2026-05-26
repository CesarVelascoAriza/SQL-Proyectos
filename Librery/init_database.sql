-- ============================================
-- Script maestro para inicializar la base de datos
-- Autor: Cesar Velasco Ariza
-- Fecha: 2026-05-25
-- Descripción: Ejecuta los scripts DDL y DML en orden
-- ============================================

PRINT '🔧 Iniciando proceso de inicialización de la base de datos...';
GO

BEGIN TRY
    BEGIN TRANSACTION;

    PRINT '📘 Ejecutando definición de tablas (DDL)...';
    :r   C:\Users\cesar\source\repos\CesarVelascoAriza\SQL-Proyectos\Librery\DDL\database.sql
    PRINT '✅ Tablas creadas correctamente.';
    GO

    PRINT '📘 Ejecutando definición de tablas (DDL)...';
    :r  C:\Users\cesar\source\repos\CesarVelascoAriza\SQL-Proyectos\Librery\DDL\tables.sql
    PRINT '✅ Tablas creadas correctamente.';
    GO

    PRINT '📗 Ejecutando inserción de datos iniciales (DML)...';
    :r  C:\Users\cesar\source\repos\CesarVelascoAriza\SQL-Proyectos\Librery\DML\data.sql
    PRINT '✅ Datos insertados correctamente.';
    GO

    PRINT '📙 Ejecutando consultas de prueba...';
    :r  C:\Users\cesar\source\repos\CesarVelascoAriza\SQL-Proyectos\Librery\DML\queries.sql
    PRINT '✅ Consultas ejecutadas correctamente.';
    GO

    COMMIT TRANSACTION;
    PRINT '🎉 Inicialización completada exitosamente.';
END TRY
BEGIN CATCH
    PRINT '❌ Error durante la inicialización.';
    PRINT ERROR_MESSAGE();
    ROLLBACK TRANSACTION;
END CATCH;
GO
