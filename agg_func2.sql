USE AdventureWorks2019
GO

-- Task 1.1
SELECT COUNT(DISTINCT GroupName) AS AmountOfGroup
FROM HumanResources.Department

-- Task 1.2
SELECT he.BusinessEntityID
    , he.JobTitle
    , MAX(hp.Rate) AS MaxRate
FROM HumanResources.EmployeePayHistory AS hp
JOIN HumanResources.Employee AS he
    ON hp.BusinessEntityID = he.BusinessEntityID
GROUP BY he.BusinessEntityID
    , he.JobTitle
GO

-- Task 1.3 
SELECT sh.ModifiedDate AS LastDateModified
    , MIN(sd.UnitPrice) AS MinUnitPrice
    , ps.Name AS NameSubCategory
FROM Sales.SalesOrderHeader AS sh
JOIN Sales.SalesOrderDetail AS sd
    ON sh.SalesOrderID = sd.SalesOrderID
JOIN Production.Product AS pp
    ON sd.ProductID = pp.ProductID
JOIN Production.ProductSubcategory AS ps
    ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
GROUP BY ps.Name, sh.ModifiedDate

-- Task 1.4
SELECT pc.Name AS NameCategory
    , COUNT(ps.ProductSubcategoryID) AS AmountSubCategory
FROM Production.ProductCategory AS pc
LEFT JOIN Production.ProductSubcategory AS ps
    ON pc.ProductCategoryID = ps.ProductCategoryID
GROUP BY pc.Name
GO

-- Task 1.5
SELECT AVG(sd.LineTotal) AS AvgLineTotal
    , ps.Name AS NameSubCategory
FROM Sales.SalesOrderHeader AS sh
JOIN Sales.SalesOrderDetail AS sd
    ON sh.SalesOrderID = sd.SalesOrderID
JOIN Production.Product AS pp
    ON sd.ProductID = pp.ProductID
JOIN Production.ProductSubcategory AS ps
    ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
GROUP BY ps.Name

-- Task 1.6
SELECT BusinessEntityID
    , RateChangeDate
FROM HumanResources.EmployeePayHistory
WHERE Rate = (
        SELECT MAX(Rate)
        FROM HumanResources.EmployeePayHistory
        )