-- ********* Task 1 *********
SELECT
	COUNT(*) AS 'Order Count',
	SUM(TaxAmount) AS 'Tax Total'
FROM
	Orders

-- ********* Task 2 *********
SELECT
	CategoryName,
	COUNT(*) AS 'Product Count',
	MAX(ListPrice) AS 'Most Expensive Product'
FROM	
	Products
	INNER JOIN Categories ON Categories.CategoryID = Products.CategoryID
GROUP BY
	CategoryName
ORDER BY
	'Product Count' DESC	

-- ********* Task 3 *********
SELECT
	EmailAddress,
	SUM(ItemPrice * Quantity) AS 'Item Price Total',
	SUM(DiscountAmount * Quantity) AS 'Discount Amount Total'
FROM	
	Customers
		INNER JOIN OrderItems ON Customers.CustomerID = OrderItems.OrderID
GROUP BY
	EmailAddress
ORDER BY
	'Item Price Total' DESC

-- ********* Task 4 *********
SELECT
	EmailAddress,
	COUNT(*) AS 'Order Count',
	(ItemPrice - DiscountAmount) * Quantity AS 'Order Total'
FROM
	OrderItems
		INNER JOIN Orders ON OrderItems.OrderID = Orders.OrderID
		INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY
	EmailAddress,
	(ItemPrice - DiscountAmount) * Quantity
HAVING
	COUNT(*) > 1
ORDER BY
	SUM((ItemPrice - DiscountAmount) * Quantity) DESC

-- ********* Task 5 *********
SELECT
	EmailAddress,
	COUNT(*) AS 'Order Count',
	(ItemPrice - DiscountAmount) * Quantity AS 'Order Total'
FROM
	OrderItems
		INNER JOIN Orders ON OrderItems.OrderID = Orders.OrderID
		INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE
	ItemPrice > 400
GROUP BY
	EmailAddress,
	(ItemPrice - DiscountAmount) * Quantity
HAVING
	COUNT(*) > 1
ORDER BY
	SUM((ItemPrice - DiscountAmount) * Quantity) DESC

-- ********* Task 6 *********
SELECT
	EmailAddress,
	COUNT(*) AS 'Number of Products'
FROM	
	Products
		INNER JOIN OrderItems ON OrderItems.ProductID = Products.ProductID
		INNER JOIN Orders ON OrderItems.OrderID = Orders.OrderID
		INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY
	EmailAddress
HAVING
	COUNT(*) > 1

