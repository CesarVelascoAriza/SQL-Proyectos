CREATE TABLE [Branches]
(
    BranchID INT PRIMARY KEY,
    CompanyID INT,
    BranchName NVARCHAR(150) NOT NULL,
    Address NVARCHAR(255),
    CityID INT,
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID),
    FOREIGN KEY (CityID) REFERENCES Cities(CityID)
)
