-- 16
SELECT
	AVG(UnitPrice) AS 'Average Unit Price'
FROM	
	Product

-- 17
SELECT
	MAX(OrderDate) AS 'Date of the last order'
FROM	
	Product
		INNER JOIN OrderItem ON Product.ProductId = OrderItem.ProductId
		INNER JOIN Orders ON OrderItem.OrderId = Orders.OrderId
WHERE
	Quantity * Product.UnitPrice < 100

-- 18
SELECT
	LastName AS 'Last Name',
	FirstName AS 'First Name',
	SUM(Quantity * UnitPrice) AS 'Order Total'
FROM
	OrderItem
		INNER JOIN Orders ON OrderItem.OrderId = Orders.OrderId
		INNER JOIN Customer ON Orders.CustomerId = Customer.CustomerId
GROUP BY
	LastName,
	FirstName
ORDER BY
	'Order Total' DESC

-- 19
SELECT
	Country,
	COUNT(*) AS '# of Customers'
FROM	
	Customer
GROUP BY
	Country
HAVING
	COUNT(*) > 4

