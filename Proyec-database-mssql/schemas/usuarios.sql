-- Write your own SQL object definition here, and it'll be included in your package.
-- Crear el esquema usuarios para separarlo del esquema dbo
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'usuarios')
BEGIN
    EXEC('CREATE SCHEMA usuarios')
END
GO
