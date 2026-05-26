/*
Post-Deployment Script Template
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.
 Use SQLCMD syntax to include a file in the post-deployment script.
 Example:      :r .\myfile.sql
 Use SQLCMD syntax to reference a variable in the post-deployment script.
 Example:      :setvar TableName MyTable
               SELECT * FROM [$(TableName)]
--------------------------------------------------------------------------------------
*/


/*
Contenido recomendado para tu PostDeploymentScript.sql
Este formato evita errores si el script se ejecuta más de una vez.
*/

-- 1. Países
IF NOT EXISTS (SELECT 1 FROM dbo.Countries WHERE CountryID = 1)
BEGIN
    INSERT INTO dbo.Countries (CountryID, CountryName, CountryCode) VALUES
    (1, 'Colombia', 'COL'), (2, 'México', 'MEX'), (3, 'España', 'ESP');
END

-- 2. Ciudades
IF NOT EXISTS (SELECT 1 FROM dbo.Cities WHERE CityID = 1)
BEGIN
    INSERT INTO dbo.Cities (CityID, CityName, CountryID, AreaCode) VALUES
    (1, 'Bogotá', 1, '1'), (2, 'Medellín', 1, '4'), (3, 'Ciudad de México', 2, '55'), (4, 'Madrid', 3, '91');
END

-- 3. Tipos de Empresa
IF NOT EXISTS (SELECT 1 FROM dbo.CompanyTypes WHERE TypeID = 1)
BEGIN
    INSERT INTO dbo.CompanyTypes (TypeID, TypeName, Description) VALUES
    (1, 'Tecnología', 'Empresas de software'), (2, 'Financiero', 'Bancos y fintech'), (3, 'Salud', 'Clínicas y hospitales');
END

-- 4. Tipos Legales
IF NOT EXISTS (SELECT 1 FROM dbo.CompanyLegalTypes WHERE LegalTypeID = 1)
BEGIN
    INSERT INTO dbo.CompanyLegalTypes (LegalTypeID, LegalTypeName, Description) VALUES
    (1, 'S.A.S.', 'Sociedad por Acciones Simplificada'), (2, 'S.A.', 'Sociedad Anónima'), (3, 'L.T.D.A.', 'Responsabilidad Limitada');
END

-- 5. Empresas
IF NOT EXISTS (SELECT 1 FROM dbo.Companies WHERE CompanyID = 10)
BEGIN
    INSERT INTO dbo.Companies (CompanyID, Name, Sector, Headquarters, FoundedYear, TypeID, LegalTypeID) VALUES
    (10, 'TechSolutions Global', 'Software', 'Bogotá', 2015, 1, 1),
    (20, 'Finova Bank', 'Banca', 'Ciudad de México', 2010, 2, 2),
    (30, 'Medica Group', 'Salud', 'Madrid', 2018, 3, 3);
END

-- 6. Sucursales
IF NOT EXISTS (SELECT 1 FROM dbo.Branches WHERE BranchID = 101)
BEGIN
    INSERT INTO dbo.Branches (BranchID, CompanyID, BranchName, Address, CityID) VALUES
    (101, 10, 'Sede Principal Bogotá', 'Calle 100 #15-20', 1),
    (102, 10, 'Sucursal Medellín', 'Av. El Poblado #45-10', 2),
    (201, 20, 'HQ CDMX', 'Paseo de la Reforma 250', 3),
    (301, 30, 'Central Madrid', 'Gran Vía 45', 4);
END

-- 7. Representantes Legales
IF NOT EXISTS (SELECT 1 FROM dbo.LegalRepresentatives WHERE RepresentativeID = 501)
BEGIN
    INSERT INTO dbo.LegalRepresentatives (RepresentativeID, FirstName, SecondName, Particle, LastName, SecondLastName, DocumentType, DocumentNumber, Email, Phone) VALUES
    (501, 'Carlos', 'Alberto', NULL, 'Gómez', 'Restrepo', 'CC', '10203040', 'carlos.gomez@mail.com', '+573001234567'),
    (502, 'Ana', 'María', 'de', 'la', 'Rosa', 'RFC', 'ROSAAM850101', 'ana.delarosa@mail.com', '+525512345678'),
    (503, 'Jean', NULL, 'von', 'Arcken', NULL, 'NIE', 'E9876543Z', 'jean.von@mail.com', '+34600123456');
END

-- 8. Relación Empresa - Representantes
IF NOT EXISTS (SELECT 1 FROM dbo.CompanyRepresentatives WHERE CompanyID = 10 AND RepresentativeID = 501)
BEGIN
    INSERT INTO dbo.CompanyRepresentatives (CompanyID, RepresentativeID, StartDate, EndDate) VALUES
    (10, 501, '2015-01-15', NULL),
    (20, 502, '2010-03-01', '2022-12-31'),
    (20, 501, '2023-01-01', NULL),
    (30, 503, '2018-06-20', NULL);
END

-- 9. Empleados
IF NOT EXISTS (SELECT 1 FROM dbo.Employes WHERE EmployeeID = 1001)
BEGIN
    INSERT INTO dbo.Employes (EmployeeID, FirstName, SecondName, Particle, LastName, SecondLastName, Email, BirthDate, HireDate, Position, Salary, CompanyID) VALUES
    (1001, 'Juan', 'Pablo', NULL, 'Pérez', 'Castro', 'juan.perez@techsolutions.com', '1990-05-12', '2018-10-01', 'Senior Developer', 4500.00, 10),
    (1002, 'Luisa', NULL, 'de', 'Zubiría', 'Martínez', 'luisa.zubiria@techsolutions.com', '1993-08-22', '2021-02-15', 'QA Analyst', 2800.00, 10),
    (1003, 'Andrés', 'Felipe', NULL, 'Mendoza', 'Sánchez', 'andres.mendoza@finovabank.com', '1985-03-30', '2012-07-01', 'Branch Manager', 6200.00, 20),
    (1004, 'Sofia', 'Elena', NULL, 'Casas', 'Diego', 'sofia.casas@medicagroup.com', '1988-11-05', '2019-04-16', 'Coordinadora Médica', 3900.00, 30);
END
USE master;
GO