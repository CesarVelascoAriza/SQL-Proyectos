CREATE VIEW [vw_ActiveRepresentatives] AS
SELECT 
    c.CompanyID,
    c.Name AS CompanyName,
    r.DocumentType,
    r.DocumentNumber,
    LTRIM(RTRIM(
        r.FirstName + 
        ISNULL(' ' + r.SecondName, '') + 
        ISNULL(' ' + r.Particle, '') + 
        ' ' + r.LastName + 
        ISNULL(' ' + r.SecondLastName, '')
    )) AS RepresentativeName,
    cr.StartDate AS RepresentationStartDate
FROM CompanyRepresentatives cr
INNER JOIN Companies c ON cr.CompanyID = c.CompanyID
INNER JOIN LegalRepresentatives r ON cr.RepresentativeID = r.RepresentativeID
WHERE cr.EndDate IS NULL;