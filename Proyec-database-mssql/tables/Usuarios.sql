-- Tabla de usuarios de la aplicación (NO usuarios de SQL Server)
CREATE TABLE usuarios.Usuarios (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1),
    NombreUsuario NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Nombre NVARCHAR(100),
    Apellido NVARCHAR(100),
    Activo BIT DEFAULT 1,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaUltimoAcceso DATETIME,
    CONSTRAINT CK_Email CHECK (Email LIKE '%@%')
);
GO