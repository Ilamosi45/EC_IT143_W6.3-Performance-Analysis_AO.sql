-- =================================================================================
-- Script Name: SQL_Performance_Analysis.sql
-- Description: Triggers and resolves missing index recommendations for W6.4 assignment.
-- Course: 6.3 Performance Analysis
-- =================================================================================

USE AdventureWorks2019;

-- =================================================================================
-- ACTIVITY 1: Person.Person Table Performance Analysis
-- =================================================================================

-- 1. Run this query with 'Actual Execution Plan' enabled (Ctrl + M)
--    This triggers a missing index recommendation on the unindexed 'Title' column.
SELECT BusinessEntityID, FirstName, LastName, Title
FROM Person.Person
WHERE Title = 'Ms.';

-- 2. Execute the generated index creation script below:
CREATE NONCLUSTERED INDEX IX_Person_Title
ON [Person].[Person] ([Title])
INCLUDE ([BusinessEntityID], [FirstName], [LastName]);

-- 3. Re-run the query above to confirm the performance improvement (Index Seek).
SELECT BusinessEntityID, FirstName, LastName, Title
FROM Person.Person
WHERE Title = 'Ms.';


-- =================================================================================
-- ACTIVITY 2: Sales.SalesOrderDetail Table Performance Analysis
-- =================================================================================

-- 1. Run this query with 'Actual Execution Plan' enabled (Ctrl + M)
--    This triggers a missing index recommendation on the 'CarrierTrackingNumber' column.
SELECT SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, LineTotal
FROM Sales.SalesOrderDetail
WHERE CarrierTrackingNumber = '4E0A-4F89-AE';

-- 2. Execute the generated index creation script below:
CREATE NONCLUSTERED INDEX IX_SalesOrderDetail_CarrierTrackingNumber
ON [Sales].[SalesOrderDetail] ([CarrierTrackingNumber])
INCLUDE ([SalesOrderID], [SalesOrderDetailID], [LineTotal]);

-- 3. Re-run the query above to confirm the performance improvement (Index Seek).
SELECT SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, LineTotal
FROM Sales.SalesOrderDetail
WHERE CarrierTrackingNumber = '4E0A-4F89-AE';
