CREATE TABLE Companies
(
    CompanyID INT PRIMARY KEY,
    Name NVARCHAR(150) NOT NULL,
    Sector NVARCHAR(100),
    Headquarters NVARCHAR(150),
    FoundedYear INT,
    TypeID INT,
    LegalTypeID INT,
    FOREIGN KEY (TypeID) REFERENCES CompanyTypes(TypeID),
    FOREIGN KEY (LegalTypeID) REFERENCES CompanyLegalTypes(LegalTypeID)
)
