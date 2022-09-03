USE MyGuitarShop;
GO

-- ********* Question 1 *********
SELECT
	DISTINCT CategoryName
FROM	
	Categories
WHERE
	CategoryID IN (
		SELECT DISTINCT
			CategoryID
		FROM
			Products)
ORDER BY
	CategoryName

-- ********* Question 2 *********
SELECT
	ProductName,
	ListPrice
FROM
	Products
WHERE
	ListPrice > (
		SELECT	
			AVG(ListPrice)
		FROM
			Products)
ORDER BY
	ListPrice DESC

-- ********* Question 3 *********
SELECT
	CategoryName
FROM	
	Categories
WHERE NOT EXISTS (
		SELECT 
			*
		FROM
			Products
		WHERE
			Categories.CategoryID = Products.CategoryID)

-- ********* Question 4 *********
(SELECT
	EmailAddress,
	O.OrderID,
	SUM((ItemPrice - DiscountAmount) * Quantity) AS 'Order Total'
FROM	
	Customers
		INNER JOIN Orders AS O ON Customers.CustomerID = O.CustomerID
			INNER JOIN OrderItems ON O.OrderID = OrderItems.OrderID
GROUP BY
	EmailAddress,
	O.OrderID)

----------------------------------------------------------------------

SELECT
	EmailAddress,
	MAX([Order Total]) AS 'Largest Order'
FROM 
	(SELECT
	EmailAddress,
	O.OrderID,
	SUM((ItemPrice - DiscountAmount) * Quantity) AS 'Order Total'
FROM	
	Customers
		INNER JOIN Orders AS O ON Customers.CustomerID = O.CustomerID
			INNER JOIN OrderItems ON O.OrderID = OrderItems.OrderID
GROUP BY
	EmailAddress,
	O.OrderID) t
GROUP BY
	EmailAddress

-- ********* Question 5 *********
SELECT
	ProductName,
	DiscountPercent
FROM
	Products
WHERE
	DiscountPercent NOT IN (
		SELECT 
			DISTINCT DiscountPercent
		FROM
			Products
		GROUP BY
			DiscountPercent
		HAVING	
			COUNT(DiscountPercent) > 1)
ORDER BY
	ProductName

-- ********* Question 6 *********
SELECT
	EmailAddress,
	OrderID,
	OrderDate
FROM	
	Customers
		INNER JOIN Orders AS o1 ON o1.CustomerID = Customers.CustomerID
WHERE
	OrderDate = (
		SELECT	
			MIN(OrderDate)
		FROM
			Orders AS o2
		WHERE
			CustomerID = o1.CustomerID)

-- ********* Question 7 *********
SELECT
	CategoryID,
	CategoryName
FROM
	Categories
WHERE (
	SELECT
		COUNT(*)
	FROM
		Products
	WHERE
		CategoryID = Categories.CategoryID) > 2
ORDER BY
	CategoryName

-- ********* Question 8 *********
UPDATE 
	Orders
SET
	Orders.ShipAmount = 0
FROM
	Orders,
	Addresses
WHERE
	Orders.CustomerID = Addresses.CustomerID
	AND Addresses.State IN ('CA', 'OH', 'WI')

--------------------------------------------------------------

UPDATE Orders SET
	ShipAmount = 0
WHERE
	CustomerID IN (
		SELECT
			CustomerID
		FROM
			Addresses
		WHERE
			[State] IN ('CA', 'OH','WI'))