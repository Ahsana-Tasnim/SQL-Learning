USE MyGuitarShop;
GO

-- ********* Question 1 *********
SELECT
	ListPrice,
	DiscountPercent,
	ROUND((ListPrice * DiscountPercent),2) AS DiscountAmount
FROM
	Products

-- ********* Question 2 *********
SELECT
	OrderDate,
	YEAR(OrderDate) AS [Year],
	DAY(OrderDate) AS [Day],
	DATEADD(D, 30, OrderDate) AS [Date After Adding 30 days]
FROM	
	Orders

-- ********* Question 3 *********
SELECT
	CardNumber,
	LEN(CardNumber) AS 'Length of CardNumber',
	RIGHT(CardNumber, 4) AS 'Last 4 digit',
	REPLACE(CardNumber, SUBSTRING(CardNumber, 1, 12), 'XXXX-XXXX-XXXX')
FROM
	Orders

-- ********* Question 4 *********
SELECT
	OrderID,
	OrderDate,
	DATEADD(D, 2, OrderDate) AS 'ApproxShipDate',
	ShipDate,
	DATEDIFF(DAY, OrderDate, ShipDate) AS 'DaysToShip'
FROM
	Orders
WHERE
	YEAR(OrderDate) = 2020
	AND MONTH(OrderDate) = 01

