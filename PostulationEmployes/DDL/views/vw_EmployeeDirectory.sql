CREATE VIEW [vw_EmployeeDirectory] AS
SELECT 
    e.EmployeeID,
    LTRIM(RTRIM(
        e.FirstName + 
        ISNULL(' ' + e.SecondName, '') + 
        ISNULL(' ' + e.Particle, '') + 
        ' ' + e.LastName + 
        ISNULL(' ' + e.SecondLastName, '')
    )) AS FullName,
    e.Email AS EmployeeEmail,
    e.Position,
    e.Salary,
    e.HireDate,
    c.Name AS CompanyName,
    c.Sector AS CompanySector
FROM Employes e
INNER JOIN Companies c ON e.CompanyID = c.CompanyID;