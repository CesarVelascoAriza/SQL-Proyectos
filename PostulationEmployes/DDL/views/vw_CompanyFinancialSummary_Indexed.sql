-- Primero creamos la vista con Schema Binding (requerido)
CREATE VIEW [vw_CompanyFinancialSummary_Indexed] 
WITH SCHEMABINDING 
AS
SELECT 
    c.CompanyID,
    c.Name AS CompanyName,
    COUNT_BIG(*) AS TotalEmployees, -- SQL Server exige COUNT_BIG para vistas indexadas
    SUM(ISNULL(e.Salary, 0)) AS TotalPayroll
FROM dbo.Companies c
INNER JOIN dbo.Employes e ON c.CompanyID = e.CompanyID
GROUP BY c.CompanyID, c.Name;
GO

-- Al crearle un índice clúster único, la vista se "materializa" en disco automáticamente
CREATE UNIQUE CLUSTERED INDEX IX_vw_CompanyFinancialSummary_Indexed 
ON dbo.vw_CompanyFinancialSummary_Indexed (CompanyID);
GO