CREATE TABLE [LegalRepresentatives]
(
    RepresentativeID INT PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    SecondName NVARCHAR(50),
    Particle NVARCHAR(10),
    LastName NVARCHAR(50) NOT NULL,
    SecondLastName NVARCHAR(50),
    DocumentType NVARCHAR(20) NOT NULL,
    DocumentNumber NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100),
    Phone NVARCHAR(20)
)
