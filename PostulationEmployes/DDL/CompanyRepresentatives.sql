CREATE TABLE [CompanyRepresentatives]
(
    CompanyID INT,
    RepresentativeID INT,
    StartDate DATE NOT NULL,
    EndDate DATE,
    PRIMARY KEY (CompanyID, RepresentativeID), -- Llave primaria compuesta
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID),
    FOREIGN KEY (RepresentativeID) REFERENCES LegalRepresentatives(RepresentativeID)
)
