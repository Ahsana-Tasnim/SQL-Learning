-- 12
SELECT
	FirstName,
	LastName,
	OrderNumber
FROM
	Customer
		INNER JOIN Orders ON Customer.CustomerId = Orders.CustomerId
ORDER BY
	FirstName,
	LastName,
	OrderNumber

-- 13
SELECT
	FirstName,
	LastName,
	OrderNumber
FROM
	Customer
		LEFT JOIN Orders ON Customer.CustomerId = Orders.CustomerId

-- 14
SELECT
	OrderNumber,
	ProductName,
	Quantity,
	OI.UnitPrice
FROM
	Product AS P
		INNER JOIN OrderItem AS OI ON P.ProductId = OI.ProductId
		INNER JOIN Orders AS O ON OI.OrderId = O.OrderId
ORDER BY
	ProductName DESC

-- 15
SELECT
	'Customer' AS 'Contact Type',
	FirstName + ' ' + LastName AS 'Name',
	City,
	Phone
FROM
	Customer
UNION
	SELECT
	'Supplier' AS 'Contact Type',
	ContactName,
	City,
	Phone
FROM
	Supplier
ORDER BY
	'Contact Type'
