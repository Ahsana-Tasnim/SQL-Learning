-- ********* Task 1 *********
SELECT 
	ProductName,
	ListPrice,
	CategoryName
FROM
	Products
		INNER JOIN Categories 
			ON Products.CategoryID = Categories.CategoryID


-- ********* Task 2 *********
SELECT
	FirstName,
	LastName,
	Line1,
	City,
	[State],
	ZipCode
FROM
	Customers
		INNER JOIN Addresses 
			ON Customers.CustomerID = Addresses.CustomerID
WHERE
	EmailAddress = 'allan.sherwood@yahoo.com'
	

-- ********* Task 3 *********
SELECT
	Lastname AS 'Last Name',
	FirstName AS 'First Name',
	OrderDate AS 'Order Date',
	ProductName AS 'Product Name',
	ItemPrice AS 'Item Price',
	DiscountAmount AS 'Discount Amount',
	Quantity
FROM
	Customers 
		INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
		INNER JOIN OrderItems ON Orders.OrderID = OrderItems.OrderID
		INNER JOIN Products ON OrderItems.ProductID = Products.ProductID
ORDER BY
		'Last Name',
		'Order Date',
		'Product Name'

-- ********* Task 4 *********
SELECT
	Product1.ProductName,
	Product2.ListPrice
FROM
	Products AS Product1
	INNER JOIN Products AS Product2 
		ON Product1.ListPrice = Product2.ListPrice
		AND Product1.ProductID <> Product2.ProductID
ORDER BY
	ProductName

-- ********* Task 5 *********
SELECT
	CategoryName,
	ProductId
FROM
	Categories
	LEFT OUTER JOIN Products 
	ON Categories.CategoryID = Products.CategoryID
WHERE
	ProductID IS NULL

-- ********* Task 6 *********
SELECT
    'SHIPPED' AS 'Ship Status',
	OrderId,
	OrderDate
FROM
	Orders
WHERE ShipDate IS NOT NULL
UNION
SELECT
	'NOT SHIPPED' AS 'Ship Status',
	OrderId,
	OrderDate
FROM
	Orders
WHERE ShipDate IS NULL
ORDER BY
	OrderDate

-- ********* Task 9 *********



-- ********* Task 10 *********



-- ********* Task 11 *********

