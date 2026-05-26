CREATE TABLE [Cities]
(
    CityID INT PRIMARY KEY,
    CityName NVARCHAR(100) NOT NULL,
    CountryID INT,
    AreaCode NVARCHAR(10),
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
)
