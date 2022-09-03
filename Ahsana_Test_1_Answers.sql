USE Data1025Test;
GO

/*
My name is Ahsana Tasnim and I certify that this assignment represents
my own work and is in accordance with the NBCC Policy 1111 - Academic Integrity
*/


---- Question 1 ----
SELECT
	OrderId,
	OrderDate,
	OrderNumber
FROM	
	Orders
WHERE 
	CustomerId IN(
	SELECT
		CustomerId
	FROM
		Customer
	WHERE
		Country = 'United States'
		AND Orders.CustomerId = Customer.CustomerId)

---- Question 2 ----
SELECT
	ProductName
FROM
	Product
WHERE
	UnitPrice > (
		SELECT
			AVG(UnitPrice)
		FROM
			Product
		WHERE
			Discontinued = 1)
ORDER BY
	UnitPrice

---- Question 3 ----
SELECT
	ContactName
FROM	
	Supplier AS S
WHERE
	EXISTS (
		SELECT
			SupplierId
		FROM
			Product AS P
		WHERE
			UnitPrice > 9
			AND P.SupplierId = S.SupplierId)

---- Question 4 ----
DECLARE @SumOrderTotal AS MONEY
DECLARE @NumOrders AS INT
DECLARE @FirstOrderDate AS DATE

SET @SumOrderTotal = (SELECT SUM(UnitPrice * Quantity) FROM OrderItem)
SET @NumOrders = (SELECT COUNT(*) FROM Orders)
SET @FirstOrderDate = (SELECT MIN(OrderDate) FROM Orders)

SELECT
	@SumOrderTotal AS 'Total Order $',
	@NumOrders AS '# Orders',
	@FirstOrderDate AS 'First Order Date'

---- Question 5 ----
IF OBJECT_ID('tempdb.dbo.#BestCustomers') IS NOT NULL
	DROP TABLE IF EXISTS #BestCustomers

SELECT
	TOP 30 C.CustomerId, 
	C.FirstName,
	C.LastName,
	Email,
	SUM(Quantity * UnitPrice) AS OrderTotal
INTO
	#BestCustomers
FROM
	Customer AS C
		INNER JOIN Orders ON Orders.CustomerId = C.CustomerId
		INNER JOIN OrderItem ON OrderItem.OrderId = Orders.OrderId
GROUP BY
	C.CustomerId, 
	C.FirstName,
	C.LastName,
	C.Email

INSERT INTO #BestCustomers 
	SELECT
		CustomerId
	FROM
		Customer
	WHERE
		Country = 'United States'
		AND NOT EXISTS (
			SELECT
				*
			FROM
				#BestCustomers
			WHERE
				Country = 'United States')

UPDATE #BestCustomers SET
	OrderTotal = 0
	
SELECT 
	* 
FROM 
	#BestCustomers
ORDER BY
	LastName
