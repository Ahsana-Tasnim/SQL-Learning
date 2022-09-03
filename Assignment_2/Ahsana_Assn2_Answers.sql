-- ********* Task 1 *********
USE MyGuitarShop;
GO
SELECT
	ProductCode,
	ProductName,
	ListPrice,
	DiscountPercent
FROM 
	Products
ORDER BY 
	ListPrice DESC;

-- ********* Task 2 *********
SELECT
	LastName + ', ' + FirstName AS FullName
FROM	
	Customers
WHERE 
	LastName > 'M'
ORDER BY 
	LastName;

-- ********* Task 3 *********
SELECT
	ProductName,
	ListPrice,
	DateAdded
FROM	
	Products
WHERE
	ListPrice > '500'
	AND ListPrice < '2000'
ORDER BY
	DateAdded DESC;

-- ********* Task 4 *********
SELECT
	ProductName AS 'Product Name',
	ListPrice AS 'List Price',
	DiscountPercent AS 'Discount Percent',
	(ListPrice * DiscountPercent)/100 AS 'Discount Amount',
	ListPrice - ((ListPrice * DiscountPercent)/100) AS 'Discount Price'
FROM	
	Products
ORDER BY
	'Discount Price' DESC;


-- ********* Task 5 *********
SELECT
	ItemID,
	ItemPrice,
	DiscountAmount,
	Quantity,
	(ItemID * Quantity) AS TotalPrice,
	(DiscountAmount * Quantity) AS TotalDiscount,
	(ItemPrice - DiscountAmount) * Quantity AS ItemTotal
FROM 
	OrderItems
WHERE
	((ItemPrice - DiscountAmount) * Quantity) > 500
ORDER BY
	ItemTotal DESC 


-- ********* Task 6 *********
SELECT
	OrderID AS 'Order ID',
	OrderDate AS 'Order Date',
	ShipDate AS 'Ship Date'
FROM	
	Orders
WHERE
	ShipDate IS NULL


-- ********* Task 7 *********
SELECT
	100 AS Price,
	0.07 AS TaxRate,
	100 * 0.07 AS TaxAmount,
	100 + (100 * 0.07) AS Total


-- ********* Task 8 - PASTE IN THE CREATE TABLE Statement *********
CREATE TABLE 
	Albums(
	Id int,
	Title nvarchar(50),
	Artist nvarchar(50),
	Label nvarchar(50),
	Released smalldatetime
);

-- ********* Task 9 *********
INSERT INTO Albums
VALUES('Two Men with the Blues', 'Willie Nelson and Wynton Marsalis',
    'Blue Note', '2008-07-08'),
	('Hendrix in the West', 'Jimi Hendrix', 'Polydor', '1972-01-01'),
	('Rubber Soul', 'The Beatles', 'Parlophone', '1965-12-03'),
	('Apostrophe', 'Frank Zappa', 'Discreet', '1974-04-22'),
	('Birds of Fire', 'Mahavishnu Orchestra', 'Columbia', '1973-03-01');


-- ********* Task 10 *********
DELETE FROM
	Albums
WHERE
	[Label] = 'Columbia';


-- ********* Task 11 *********
UPDATE 
	Albums
SET 
	Artist = 'John McLaughlin and the Mahavishnu Orchestra'
WHERE
	Artist = 'Mahavishnu Orchestra';
