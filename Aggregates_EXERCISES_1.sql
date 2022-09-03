USE MurachCollege;
GO
/*
1. Using the MurachCollege database,
Write a SELECT statement that returns these columns:
The count of the number of instructors in the Instructors table
The average of the AnnualSalary column in the Instructors table
Include only those rows where the Status column is equal to “F” (Fulltime).
*/
SELECT
	COUNT(*) AS InstructorCount,
	AVG(AnnualSalary) AS AverageSalary
FROM
	Instructors
WHERE
	Status = 'F'

/*
2. Using the Nortwind Database,
Write a query that will return the Minimum UnitsInStock, the Maximum UnitsOnOrder
from the products table.  Give your columns good alias names.
*/
USE Northwind;
GO

SELECT
	MIN(UnitsInStock) AS 'Minimum Units in Stock',
	MAX(UnitsOnOrder) AS 'Maximum Units on Order'
FROM
	Products

/*
3. Using the Nortwind Database,
Write a query that will return the total of all orders 
for customers in Germany 
An orders total is calculated by Unit Price * Quantity * (1 - Discount)
(Hint: requires the use of 3 tables to get this information)
*/
USE Northwind;
GO

SELECT
	SUM(UnitPrice - Quantity * (1 - Discount)) AS 'Total'
FROM
	Customers
		INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
		INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
WHERE
	UPPER(Customers.Country) = 'GERMANY'
 
