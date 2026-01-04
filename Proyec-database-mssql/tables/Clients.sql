CREATE TABLE [dbo].[Clients]
(
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100),
    Telefono NVARCHAR(20),
    FechaRegistro DATETIME DEFAULT GETDATE()
)
