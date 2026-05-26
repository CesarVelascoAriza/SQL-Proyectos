CREATE TABLE [Employes]
(
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    SecondName NVARCHAR(50),
    Particle NVARCHAR(10), -- Ej: "de", "del", "von"
    LastName NVARCHAR(50) NOT NULL,
    SecondLastName NVARCHAR(50),
    Email NVARCHAR(100) UNIQUE,
    BirthDate DATE,
    HireDate DATE,
    Position NVARCHAR(100),
    Salary DECIMAL(18, 2),
    CompanyID INT,
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
)
